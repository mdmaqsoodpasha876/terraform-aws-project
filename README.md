Terraform AWS Infrastructure

This project uses Terraform to provision a basic AWS web infrastructure consisting of a VPC, public subnets, EC2 instances, an Application Load Balancer, Security Group, Internet Gateway, Route Table, and an S3 bucket.

The project is created for learning and demonstrating Infrastructure as Code (IaC) with Terraform and AWS.

Architecture

                         Internet
                            |
                            v
                            
                  +-------------------+
                  | Application       |
                  | Load Balancer     |
                  +---------+---------+
                  
                            |
                            
                 +----------+----------+
                 
                 |                     |
                 v                     v
                 
          +-------------+       +-------------+
          | EC2 Server 1|       | EC2 Server 2|
          |   Subnet 1  |       |   Subnet 2  |
          | ap-south-1a |       | ap-south-1b |
          +-------------+       +-------------+
          
                 |                     |
                 
                 +----------+----------+
                            |
                            
                     +-------------+
                     |     VPC     |
                     | 10.0.0.0/16 |
                     +-------------+
                     
                     +-------------+
                     |     S3      |
                     |    Bucket   |
                     +-------------+

AWS Resources

This project creates the following AWS resources:

Networking
VPC
Two public subnets
Internet Gateway
Route Table
Route Table Associations
Default route to the Internet
Security
Security Group
HTTP access on port 80
SSH access on port 22
All outbound traffic allowed
Compute
Two EC2 instances
Instance type: t3.micro
EC2 instances deployed in separate Availability Zones
User data scripts used to configure the web servers
Load Balancing
Application Load Balancer
Target Group
Two Target Group attachments
HTTP Listener on port 80
Health check configured on /
Storage
S3 bucket
S3 public access block configuration
Project Structure
terraform-aws-project/
|
├── main.tf
├── provider.tf
├── variable.tf
├── userdata.sh
├── userdata1.sh
├── .gitignore
├── .terraform.lock.hcl
└── README.md


Terraform state files and the .terraform directory are excluded from Git using .gitignore.

Prerequisites

Before using this project, install the following:

Terraform
AWS CLI
Git
An AWS account

Verify Terraform:

terraform version


Verify AWS CLI:

aws --version


Verify your AWS credentials:

aws sts get-caller-identity

AWS Region

This project uses the AWS Mumbai region:

ap-south-1


The configuration uses Availability Zones:

ap-south-1a
ap-south-1b

Getting Started
1. Clone the repository
git clone https://github.com/mdmaqsoodpasha876/terraform-aws-project.git


Move into the project directory:

cd terraform-aws-project

2. Initialize Terraform
terraform init


This downloads the required providers and initializes the Terraform working directory.

3. Format the configuration
terraform fmt

4. Validate the configuration
terraform validate

5. Review the execution plan
terraform plan


Review the resources Terraform plans to create.

6. Deploy the infrastructure
terraform apply


Enter:

yes


when Terraform asks for confirmation.

Access the Application

After deployment, Terraform displays the Application Load Balancer DNS name using the following output:

loadbalancer = <ALB-DNS-NAME>


Open the DNS name in a browser:

http://<ALB-DNS-NAME>


The Application Load Balancer distributes incoming HTTP requests between the two EC2 instances.

Traffic Flow
Client
  |
  | HTTP :80
  v
Application Load Balancer
  |
  +-------------------+
  |                   |
  v                   v
EC2 Instance 1    EC2 Instance 2
  |                   |
  +---------+---------+
            |
         Target Group


The ALB forwards traffic to the EC2 instances registered with the Target Group.

The instances are configured using:

userdata.sh
userdata1.sh

Terraform Variables

The project uses Terraform variables for configurable values such as the VPC CIDR, subnet CIDR, and Availability Zone.

Example:

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "cidr_sub" {
  default = "10.0.0.0/24"
}

variable "az" {
  default = "ap-south-1a"
}


These values can be modified according to your requirements.

Destroy Infrastructure

To delete all infrastructure created by Terraform:

terraform destroy


Review the resources that Terraform plans to delete and enter:

yes


Warning: terraform destroy permanently deletes the resources managed by this Terraform configuration.

Security Considerations

This project is primarily intended for learning and demonstration purposes.

The current configuration allows:

HTTP :80  ->  0.0.0.0/0
SSH  :22  ->  0.0.0.0/0


Allowing SSH from 0.0.0.0/0 means that SSH is accessible from anywhere on the Internet.

For a production environment, SSH should be restricted to a trusted IP address or replaced with a more secure access method such as AWS Systems Manager Session Manager.

The current S3 configuration also disables the S3 public access blocking features. This should be reviewed before using the configuration in a production environment.

Terraform State

Terraform state files should not normally be committed to GitHub because they can contain sensitive infrastructure information.

This project excludes the following files and directories:

.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json


For production environments, consider using a remote Terraform backend with appropriate security and access controls.

Technologies Used
Terraform
AWS VPC
AWS EC2
AWS Application Load Balancer
AWS Security Groups
AWS S3
AWS Internet Gateway
AWS Route Tables
What I Learned

This project helped me understand and practice:

Infrastructure as Code
Terraform configuration
Terraform resources
Terraform variables
Terraform outputs
Terraform dependencies
AWS VPC networking
Public subnets
Internet Gateway
Route Tables
Security Groups
EC2 instances
EC2 User Data
Application Load Balancer
Target Groups
Load Balancer Listeners
S3
Terraform state management
Git and GitHub
Future Improvements

The following improvements can be added to make the infrastructure more production-ready:

Create separate public and private subnets
Deploy EC2 instances in private subnets
Use separate Security Groups for ALB and EC2
Restrict SSH access
Add HTTPS using AWS Certificate Manager
Add Auto Scaling Group
Add NAT Gateway
Use remote Terraform state
Enable S3 encryption and versioning
Replace hard-coded AMI IDs with variables or data sources
Create reusable Terraform modules
Add GitHub Actions for Terraform CI/CD
Add CloudWatch monitoring and logging
Author

Md Maqsood Pasha

This project was created as a hands-on learning project for AWS, Terraform, and Infrastructure as Code.

