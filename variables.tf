variable "aws_emr_creator_policy_name" {
  type        = string
  description = "The name to give to the policy regarding EMR permissions"
  default     = "emrCreatorMinimalPolicy"
}

variable "aws_role_name" {
  type        = string
  description = "IAM Role to create, and to which the policies will be attached"
}

variable "aws_instance_profile_name" {
  type        = string
  description = "IAM Instance Profile to create"
}

variable "s3_policy_arns" {
  type        = list(string)
  description = "[DEPRECATED] List of S3 policy ARNs to attach to Tamr role. Use 'additional_policy_arns' instead."
  default     = []
}

variable "additional_policy_arns" {
  type        = list(string)
  description = "List of policy ARNs to be attached to Tamr VM IAM role."
  default     = []
}

variable "ami" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to use for the EC2 instance"
  default     = "us-east-1a"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the EC2 instance"
  default     = "c5.9xlarge"
}

variable "volume_type" {
  type        = string
  description = "The type of root block volume to attach to the EC2 instance"
  default     = "gp2"
}

variable "volume_size" {
  type        = number
  description = "The size of the root block volume to attach to the EC2 instance"
  default     = 100
}

variable "enable_volume_encryption" {
  type        = bool
  description = "Whether to encrypt the root block device"
  default     = true
}

variable "tamr_instance_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the Tamr EC2 instance"
  default     = { Author : "Tamr", Name : "Tamr VM" }
}

variable "key_name" {
  type        = string
  description = "The key name to attach to the EC2 instance for SSH access"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups to associate with the ec2 instance"
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "The subnet to create the EC2 instance in"
}

variable "bootstrap_scripts" {
  type        = list(string)
  default     = []
  description = "List of body content of bootstrap shell scripts."
}

variable "tamr_emr_cluster_ids" {
  type        = list(string)
  default     = []
  description = "List of IDs for Static EMR clusters"
}

variable "tamr_emr_role_arns" {
  type        = list(string)
  default     = []
  description = "List of ARNs for EMR Service and EMR EC2 roles"
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the policy that will be used to set the permissions boundary for the IAM Role"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "emr_abac_valid_tags" {
  type        = map(list(string))
  description = "A map of valid tags for maintaining EMR resources when using ABAC IAM Policies with Tag Conditions. Make sure your tamr-config.yml file specifies tags key values. Refer to tamr-config module examples for more info."
  default     = {}
}

variable "private_ips" {
  type        = list(string)
  description = "List of private IPs to assign to the ENI attached to the Tamr EC2 Instance"
  default     = null
}

variable "require_http_tokens" {
  type        = bool
  description = "Whether to enable IMDSv2 on the Tamr EC2 Instance"
  default     = true
}


#
# Startup Script
#
variable "tamr_config_file" {
  type        = string
  description = "Override generated tamr configuration. The tamr configuration is specified using a yaml file, in the format that is documented (https://docs.tamr.com/previous/docs/configuration-configuring-unify#section-setting-configuration-variables) for configuring “many variables” at once."
}

variable "pre_install_bash" {
  default     = ""
  type        = string
  description = <<EOF
  Bash to be run before Tamr is installed.
  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )
   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent.
  EOF
}

variable "tamr_zip_uri" {
  type        = string
  description = "gcs location to download tamr zip from"
}

variable "tamr_instance_install_directory" {
  # Get it?, DataTamer :p
  default     = "/data/tamr"
  type        = string
  description = "directory to install tamr into"
}

#
# file system
#
variable "tamr_filesystem_bucket" {
  type        = string
  description = "S3 bucket to use for the tamr default file system"
}
