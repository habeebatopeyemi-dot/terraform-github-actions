output "bucket_name" {
    value = aws_s3_bucket.my_bucket.id
    description = "the name of the S3 bucket"
}

output "instance_public_ip" {
    value = aws_instance.EC2Instance.public_ip
    description = "the public IP of the EC2 instance"
}