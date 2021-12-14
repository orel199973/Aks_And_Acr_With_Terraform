variable "resource_group_name" {
  type        = string
  default     = "k8s-TestOrel"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "cluster_name" {
  type        = string
  default = "k8s-TestOrel"
}

variable "kubernetes_version" {
  type        = string
  default = "1.19.13"
}


variable "vm_size" {
  type        = string
  default = "Standard_B2s"
}

variable "acr_name" {
  type    = string
  default = "ACRTestOrel"
}

variable "sku" {
  type    = string
  default = "Standard"
}