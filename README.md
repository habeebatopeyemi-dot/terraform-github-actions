This repository contains an automated CI/CD pipeline that provisions cloud infrastructure on AWS using Terraform and GitHub Actions

## What is CI/CD?
**CI/CD** stands for Continuous Integration and Continuous Deployment. 
 
 **Continuous Integration (CI):** The practice of automating the integration of code changes from contributors into a single software project. It automatically builds, tests, and validates code changes before they are merged.
 
 **Continuous Deployment (CD):** The process of automatically deploying those validated code changes to a production or staging environment, ensuring that the infrastructure or application is always updated without manual intervention.

## What is GitHub Actions?
**GitHub Actions** is a native CI/CD platform built directly into GitHub. It allows developers to automate, customize, and execute software development workflows right inside a repository. Workflows are defined using YAML files and are triggered by specific events, such as pushing code to a branch or opening a pull request.


##  What the Workflow Does

The GitHub Actions workflow configured in this repository automates the lifecycle of the Terraform configuration. Whenever a change is made, it performs the following steps sequentially:

1. **Checkout Code:** Pulls the latest code from the repository into the GitHub runner environment.

2. **Setup Terraform:** Configures the specific version of the Terraform CLI on the runner.

3. **Initialize Terraform (`terraform init`):** Initializes the working directory, downloads the required AWS provider plugins, and connects to the remote S3 backend to manage the state file (`.tfstate`).

4. **Validate Terraform (`terraform validate`):** Checks the configuration files for syntax errors and internal consistency.

5. **Plan Terraform (`terraform plan`):** Generates an execution plan showing exactly what AWS resources will be created, modified, or destroyed without making changes.

6. **Apply Terraform (`terraform apply`):** Executes the plan to provision the resources on AWS, including the VPC, Subnets, Security Groups, S3 Buckets, and the EC2 Instance.
   
The workflow is completely automated and can be triggered using the following methods. 

1.  Automatic Trigger (Push to Main): Any time infrastructure code is modified (e.g., updating `main.tf` or `variables.tf`) and push those changes to the main branch, the pipeline will kick off automatically.

-bash-

git add .

git commit -m "feat: update infrastructure configuration"

git push origin main

2.  Opening the Actions tab in the GitHub repository to watch the active runner validate and deploy infrastructure in real time.

The resources provisioned are:

1.  EC2 Instance: A scalable Amazon Linux virtual machine (`t3.micro`) hosted inside `us-east-1`.

2.  S3 Bucket: A secure object storage bucket with unique global name.


