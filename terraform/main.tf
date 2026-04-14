terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0" 
    }
  }
}

provider "google" {
  # For local runs
   #credentials = file("credentials.json") 
  project = var.project_id
  region  = var.region
}

# THE DATA LAKE
resource "google_storage_bucket" "data-lake-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true 

  lifecycle_rule {
    condition {
      age = 30 # Files deleted after 30 days 
    }
    action {
      type = "Delete"
    }
  }
}

# THE DATA WAREHOUSE
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.bq_dataset_name
  project    = var.project_id
  location   = var.location
}
