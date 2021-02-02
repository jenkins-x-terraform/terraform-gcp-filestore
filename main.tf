variable "project" {
  type = string
}

BAD THING

variable "location" {
  type    = string
  default = "us-central1"
}

variable "fs-name" {
  type    = string
  default = "flow-plugins"
}

variable "tier" {
  type = string
  default = "STANDARD"
}

variable "capacity" {
  type = string
  default = "1024"
}

variable "filestore" {
  type = string
  default = "filestore"
}

variable "fs-network" {
  type    = string
  default = "default"
}


provider "google" {
  project     = var.project
  region      = var.location
}
resource "google_filestore_instance" "instance" {
  name = var.fs-name
  zone = "${var.location}-b"
  tier = var.tier

  file_shares {
    capacity_gb = var.capacity
    name        = var.filestore
  }

  networks {
    network = var.fs-network
    modes   = ["MODE_IPV4"]
  }
}


output "fs_ip" {
  value = google_filestore_instance.instance.networks.0.ip_addresses.0
}
