# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------
locals {
  environment_vars     = read_terragrunt_config("${path_relative_from_include()}/environment.hcl")
  account_id           = local.environment_vars.locals.account_id
  region               = local.environment_vars.locals.region
  app_name             = local.environment_vars.locals.app_name
  env                  = local.environment_vars.locals.env
  aws_profile          = local.environment_vars.locals.aws_profile
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents  = <<EOF
  provider "aws" {
    region = "${local.region}"
    profile        = "${local.aws_profile}"
  }
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.app_name}-${local.env}-${local.region}-terragrunt0"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    dynamodb_table = "${local.app_name}-${local.env}-${local.region}-terragrunt0"
    profile        = local.aws_profile
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

inputs = local.environment_vars.locals