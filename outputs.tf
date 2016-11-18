/*
 * Module: tf_aws_asg_elb
 *
 * Outputs:
 *   - launch_config_id
 *   - asg_id
 */

# Output the ID of the Launch Config
output "launch_config_id" {
    value = "${aws_launch_configuration.launch_config.id}"
}

# Output the ID of the Launch Config
output "asg_id" {
    value = "${aws_autoscaling_group.main_asg.id}"
}

output "asg_name" {
    value = "${aws_autoscaling_group.main_asg.name}"
}

output "asg_desired_capacity" {
    value = "${aws_autoscaling_group.main_asg.desired_capacity}"
}
