/*
 * Module: tf_aws_asg_elb
 *
 * This template creates the following resources
 *   - A launch configuration
 *   - A auto-scaling group
 *
 * It requires you create an ELB instance before you use it.
 */

resource "aws_launch_configuration" "launch_config" {
  name = "${var.lc_name}"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_groups}"]
  user_data = "${file(var.user_data)}"
  enable_monitoring = "${var.instance_monitoring}"
}

resource "aws_autoscaling_group" "main_asg" {
  # We want this to explicitly depend on the launch config above
  depends_on = ["aws_launch_configuration.launch_config"]

  name = "${var.asg_name}"

  # The chosen availability zones *must* match the AZs the VPC subnets are tied to.
  availability_zones = ["${var.availability_zones}"]
  vpc_zone_identifier = ["${var.vpc_zone_subnets}"]

  # Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size = "${var.asg_number_of_instances}"
  min_size = "${var.asg_minimum_number_of_instances}"
  desired_capacity = "${var.asg_number_of_instances}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"

  enabled_metrics = ["${var.asg_metrics}"]

  load_balancers = ["${var.load_balancer_names}"]

  tag = {
    key = "Name"
    value = "${var.tag_name}"
    propagate_at_launch = true
  }
}
