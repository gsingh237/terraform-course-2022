variable "ami" {
	type        = string
	description = "AMI for ec2"
}

variable "ec2_name" {
	type = string
}

variable "vpc_tags" {
	type = object({
		Name = string
		foo  = string
		baz  = number
	})
}

# variable "vpc_tags" {
# 	type = map
# }

variable "foo" {
	type = list(number)
	default = [1, 5, 9]
}