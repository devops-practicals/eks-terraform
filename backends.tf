# terraform {
#   backend "s3" {
#     bucket = "aws-devops-testbucket"
#     key    = "terraformstates/dev.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "terraform-lock"
#     use_lockfile = "true"
#   }
# }