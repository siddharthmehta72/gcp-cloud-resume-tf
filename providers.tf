provider "google" {
    project = "	firm-catalyst-327616"
    region = "asia-south2"
    credentials = file("terraform-creds.json")
}
provider "google-beta" {
    project = "	firm-catalyst-327616"
    region = "asia-south2"
    credentials = file("terraform-creds.json")
}