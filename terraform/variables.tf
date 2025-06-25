variable "key_name" {
  description = "Name of the existing AWS key pair to SSH"
  type        = string
  default     = "jenkins-invento" # <-- your actual key pair name
}
