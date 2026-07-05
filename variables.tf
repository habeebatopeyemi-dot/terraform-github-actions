variable "bucket_name" {
    type = string
    description = "the name of the S3 bucket"
}

variable "instance_type" {
    description = "EC2 instance type"
    type        =  string
    default     = "t2.micro"
}

variable "aws_ami_id" {
    description = "aws ami id to deploy EC2 instance"
    type        = string
    default     = "ami-06067086cf86c58e6" 
}