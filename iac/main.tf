# Configure the LaunchDarkly provider
terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~> 2.0"
    }
  }
}

provider "launchdarkly" {
  access_token = var.launchdarkly_access_token
}

# Create a new project
resource "launchdarkly_project" "ratelimit-config" {
    key  = "ratelimit-config"
    name = "Ratelimit Config"
    environments {
      name = "dev"
      key = "DEV"
      color="FFFFFF"
    }
}

# Create a new feature flag
resource "launchdarkly_feature_flag" "ratelimit-config-ff" {
    project_key = launchdarkly_project.ratelimit-config.key
    key         = "ratelimit-config-ff"
    name        = "ratelimit config ff"

    variation_type = "json"
    variations {
        name = "dev"
        value = {
            "GET_/test" : {}
        }
    }
}
