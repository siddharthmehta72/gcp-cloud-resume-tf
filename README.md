# gcp-cloud-resume-tf
This repo contains the terraform manifest files to create resources for Cloud Resume Challenge in GCP.
We'll be creating the following resources basically:

1) Cloud Storage bucket to host the Static Website
2) Public IP address
3) https certificate
4) load balancer
5) association of lb with https certificate
6) Cloud Storage bucket to host Cloud function Code
7) Cloud function and its public execution