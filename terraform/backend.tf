# Terraform State Backend Configuration
#
# IMPORTANT: Follow these steps to set up the remote state backend:
#
# 1. First Run (WITHOUT backend configured):
#    - Uncomment the backend block below
#    - Run: terraform init (WITHOUT the backend block)
#    - Run: terraform apply
#    - This creates the S3 bucket and DynamoDB table for state management
#
# 2. Enable Remote State:
#    - Uncomment the entire terraform block below (all lines including backend)
#    - Run: terraform init -migrate-state
#    - Terraform will migrate your local state to the S3 backend
#
# 3. Subsequent Runs:
#    - The backend will be used automatically for all terraform operations
#
# Backend Resources Required:
#    - S3 bucket for state (created by initial apply)
#    - DynamoDB table for state locking (created by initial apply)
#
# See main.tf for the backend infrastructure definition (terraform-backend resources)

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-${account_id}"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }
