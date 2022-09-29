# Configure the LaunchDarkly provider
terraform {
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "~> 2.0"
    }
  }
}

# Create a new project
resource "launchdarkly_project" "orlando-codecamp" {
    key  = "orlando-codecamp"
    name = "Orlando Code Camp"
}

# Create a new feature flag
resource "launchdarkly_feature_flag" "killswitch-agenda" {
    project_key = launchdarkly_project.orlando-codecamp.key
    key         = "killswitch-agenda"
    name        = "Killswitch for Agenda"

    variation_type = "boolean"
    variations {
        value = true
    }
    variations {
        value = false
    }
}

# Turn on feature flag for production (100%)
resource "launchdarkly_feature_flag_environment" "killswitch-production-value" {
  flag_id = launchdarkly_feature_flag.killswitch-agenda.id
  env_key = "production"

  targeting_enabled = false
}
