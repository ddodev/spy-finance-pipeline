variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "extended-bongo-493113-m0"
}

variable "region" {
  description = "Region for GCP resources"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  type        = string
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  type        = string
  default     = "market_data_raw"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  type        = string
  default     = "finance_data_lake_daniel_2026"
}
