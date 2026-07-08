---
name: project-dmi-portfolio-stack
description: Structure and recurring security gaps in the DMI Portfolio Website terraform/ stack (S3 + CloudFront OAC static site)
metadata:
  type: project
---

The `terraform/` directory in this repo (Ultimate-Agentic-DevOps-with-Claude-Code) provisions a
minimal static-site stack: `aws_s3_bucket.website` (private, OAC-fronted) +
`aws_cloudfront_distribution.website` + `aws_cloudfront_origin_access_control.s3_oac`. Only 5 files:
`main.tf`, `providers.tf`, `variables.tf`, `outputs.tf`, `backend.tf`. No IAM, no VPC, no WAF resources
exist anywhere in the repo (confirmed via repo-wide `**/*.tf` glob, not just terraform/) — this is a
DMI cohort teaching scaffold, not a full production stack.

**Why:** This is a training project (see CLAUDE.md "DMI Deployment Requirement" — students add
ownership-proof footers for Week 1 submissions). The terraform scaffold is intentionally minimal and
`backend.tf` ships with its S3/DynamoDB backend block commented out on purpose (instructions in the
file tell students to uncomment it after a bootstrap apply). `.gitignore` already excludes `*.tfstate`,
so local-state usage is a real but lower-urgency finding here (no state leaked to git), not a
"student forgot .gitignore" issue.

**How to apply:** On repeat audits of this repo, expect (and re-check, don't assume still true) these
recurring gaps discovered on 2026-07-08 audit of main.tf:
- S3 bucket policy for CloudFront OAC access has no `Condition.StringEquals."AWS:SourceArn"` scoping
  to the specific distribution ARN — confused-deputy risk, flag as CRITICAL/HIGH.
- No `aws_s3_bucket_server_side_encryption_configuration` resource for the website bucket.
- No CloudFront `logging_config` block and no `aws_s3_bucket_logging` for the website bucket.
- No `aws_cloudfront_response_headers_policy` attached — no CSP/X-Frame-Options/HSTS.
- `viewer_certificate { cloudfront_default_certificate = true }` — no custom domain/ACM cert, so
  `minimum_protocol_version` cannot be pinned to TLSv1.2_2021 (forced to support old TLS for
  *.cloudfront.net compatibility). `domain_name` variable exists but is unused (dead code, matches
  no custom domain being wired up yet).
- No WAFv2 web ACL associated with the distribution.
- Bucket name embeds `data.aws_caller_identity.current.account_id` directly — minor info-disclosure
  if bucket name is ever exposed.
- No IAM resources anywhere in the repo — if a GitHub Actions OIDC deploy role exists, it is defined
  outside `terraform/` (not found as of this audit) and needs separate review whenever it appears.

Positives worth preserving in fixes (don't regress these): public access block fully enabled,
versioning enabled, OAC (not legacy OAI) used correctly, `viewer_protocol_policy = redirect-to-https`
already set, bucket policy already scoped to `cloudfront.amazonaws.com` service principal (just
missing the SourceArn condition).
