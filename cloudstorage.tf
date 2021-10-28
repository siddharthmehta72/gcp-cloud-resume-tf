module "static-assets_cloud-storage-static-website" {
  source  = "gruntwork-io/static-assets/google//modules/cloud-storage-static-website"
  version = "0.6.0"
  # insert the 2 required variables here
  project = "firm-catalyst-327616"
  website_domain_name = "sidd-cloud-resume-static"
}