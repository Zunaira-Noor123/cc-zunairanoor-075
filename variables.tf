# VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr_block))
    error_message = "vpc_cidr_block must be a valid CIDR, e.g., 10.0.0.0/16"
  }
}

# Subnet CIDR block
variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.10.0/24"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.subnet_cidr_block))
    error_message = "subnet_cidr_block must be a valid CIDR, e.g., 10.0.10.0/24"
  }
}

# Availability Zone
variable "availability_zone" {
  description = "AWS Availability Zone"
  type        = string
  default     = "me-central-1a"
}

# Environment prefix
variable "env_prefix" {
  description = "Environment prefix (e.g., prod, dev)"
  type        = string
  default     = "prod"
}

# Instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# SSH Public Key
variable "public_key" {
  description = "Path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

# SSH Private Key
variable "private_key" {
  description = "Path to the private SSH key"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

# Backend servers
variable "backend_servers" {
  description = "List of backend servers with name and setup script path"
  type = list(object({
    name        = string
    script_path = string
  }))
  default = [
    { name = "web-1", script_path = "./scripts/apache-setup.sh" },
    { name = "web-2", script_path = "./scripts/apache-setup.sh" },
    { name = "web-3", script_path = "./scripts/apache-setup.sh" }
  ]
}
variable "my_ip" {
  description = "Your public IP for SSH access"
  type        = string
}

