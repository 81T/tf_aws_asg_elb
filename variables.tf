/*
 * Module: tf_aws_asg_elb
 */

#
# Launch Configuration Variables
#
variable "lc_name" {}
variable "ami_id" {
  description = "The AMI to use with the launch configuration"
}
variable "instance_type" {}
variable "iam_instance_profile" {
  description = "The IAM role the launched instance will use"
}
variable "key_name" {
  description = "The SSH public key name (in EC2 key-pairs) to be injected into instances"
}
variable "security_groups" {
  description = "IDs of SG the launched instance will use"
  type = "list"
}
variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

#
# Auto-Scaling Group
#
variable "asg_name" {}

/* We use this to populate the following ASG settings
 * - max_size
 * - desired_capacity
 */
variable "asg_number_of_instances" {
  description = "The number of instances we want in the ASG"
}

/*
 * Can be set to 0 if you never want the ASG to replace failed instances
 */
variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default = 1
}
variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default = 300
}
/*
 * Types available are:
 *   - ELB
 *   - EC2
 *
 *   @see-also: http://docs.aws.amazon.com/cli/latest/reference/autoscaling/create-auto-scaling-group.html#options
 */
variable "health_check_type" {
  description = "The health check used by the ASG to determine health"
  default = "ELB"
}

variable "load_balancer_names" {
  description = "A list of ELB names the ASG should associate instances with"
  type = "list"
}

variable "availability_zones" {
  description = "A list of AZs the ASG will be associated with"
  type = "list"
}

variable "vpc_zone_subnets" {
  description = "A list of VPC subnets to associate with ASG, should correspond with var.availability_zones zones"
  type = "list"
}

variable "tag_name" {}

variable "instance_monitoring" {
  description = "Enable/Disable detailed instance monitoring"
  default = false
}

variable "asg_metrics" {
  // See link for metrics: http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/as-metricscollected.html
  description = "A list of metrics to collect"
  type = "list"
  default = []
}
