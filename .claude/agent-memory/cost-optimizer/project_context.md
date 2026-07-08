---
name: portfolio-terraform-context
description: Infrastructure for static DMI portfolio site (S3+CloudFront in ap-south-1)
metadata:
  type: project
---

**Project:** DMI Portfolio Website static site on AWS
**Region:** ap-south-1 (Asia Pacific)
**Components:** S3 bucket + CloudFront distribution
**State:** Terraform backend commented out (not yet enabled)

Key configuration notes:
- S3 versioning enabled (cost optimization target)
- CloudFront PriceClass_200 (medium edge location coverage)
- CachingOptimized managed policy in use
- No access logging configured
- Terraform state backend S3+DynamoDB not yet active
