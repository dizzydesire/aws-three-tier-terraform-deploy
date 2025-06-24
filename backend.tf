terraform {
  backend "s3" {
    bucket = "dizzytech"
    key    = "terraform.tfstate"  # or something like "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
