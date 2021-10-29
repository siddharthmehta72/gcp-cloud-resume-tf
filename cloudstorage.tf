module "static-assets_cloud-storage-static-website" {
  source  = "gruntwork-io/static-assets/google//modules/cloud-storage-static-website"
  version = "0.6.0"
  # insert the 2 required variables here
  project = "firm-catalyst-327616"
  website_domain_name = "siddharthmehta.in"
  website_storage_class = "REGIONAL"
  website_location = "asia-south2"
  force_destroy_access_logs_bucket = true
  force_destroy_website = true
}