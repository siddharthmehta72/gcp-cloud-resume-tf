locals {
  cdn_domain = "siddharthmehta.in" # Change this to your domain. You’ll be able to access CDN on this hostname.
}

# ------------------------------------------------------------------------------
# CREATE A STORAGE BUCKET
# ------------------------------------------------------------------------------
 
resource "google_storage_bucket" "cdn_bucket" {
  name          = "cdn-bucket-sidd1212"
  storage_class = "REGIONAL"
  location      = "asia-south2" # You might pass this as a variable
  project       = "firm-catalyst-327616"
}
 
# ------------------------------------------------------------------------------
# CREATE A BACKEND CDN BUCKET
# ------------------------------------------------------------------------------
 
resource "google_compute_backend_bucket" "cdn_backend_bucket" {
  name        = "cdn-backend-bucket"
  description = "Backend bucket for serving static content through CDN"
  bucket_name = google_storage_bucket.cdn_bucket.name
  enable_cdn  = true
  project     = "firm-catalyst-327616"
}

# ------------------------------------------------------------------------------
# CREATE A URL MAP
# ------------------------------------------------------------------------------
 
resource "google_compute_url_map" "cdn_url_map" {
  name            = "cdn-url-map"
  description     = "CDN URL map to cdn_backend_bucket"
  default_service = google_compute_backend_bucket.cdn_backend_bucket.self_link
  project         = "firm-catalyst-327616"
}

# ------------------------------------------------------------------------------
# CREATE A GOOGLE COMPUTE MANAGED CERTIFICATE
# ------------------------------------------------------------------------------
resource "google_compute_managed_ssl_certificate" "cdn_certificate" {
  provider = google-beta
  project  = "firm-catalyst-327616"
 
  name = "cdn-managed-certificate"
 
  managed {
    domains = [local.cdn_domain]
  }
}
 
# ------------------------------------------------------------------------------
# CREATE HTTPS PROXY
# ------------------------------------------------------------------------------
 
resource "google_compute_target_https_proxy" "cdn_https_proxy" {
  name             = "cdn-https-proxy"
  url_map          = google_compute_url_map.cdn_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.cdn_certificate.self_link]
  project          = "firm-catalyst-327616"
}

# ------------------------------------------------------------------------------
# CREATE A GLOBAL PUBLIC IP ADDRESS
# ------------------------------------------------------------------------------
 
resource "google_compute_global_address" "cdn_public_address" {
  name         = "cdn-public-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
  project      =  "firm-catalyst-327616"
}
 
# ------------------------------------------------------------------------------
# CREATE A GLOBAL FORWARDING RULE
# ------------------------------------------------------------------------------
 
resource "google_compute_global_forwarding_rule" "cdn_global_forwarding_rule" {
  name       = "cdn-global-forwarding-https-rule"
  target     = google_compute_target_https_proxy.cdn_https_proxy.self_link
  ip_address = google_compute_global_address.cdn_public_address.address
  port_range = "443"
  project    = "firm-catalyst-327616"
}