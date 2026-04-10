# 🌍 Multi-Cloud Terraform DevOps Platform (AWS + Azure)

## 👨‍💻 Author

**Shashi Vashisht**
🔗 GitHub: https://github.com/devopsgeek1979

🔗 LinkedIn: https://www.linkedin.com/in/shashi-pal1979/

---

# 📌 Project Overview

This project demonstrates a **production-style multi-cloud infrastructure deployment using Terraform** across:

* ☁️ **AWS** → VPC, Subnet, EC2
* ☁️ **Azure** → Resource Group, VNet, Subnet

It also includes:

* Remote backend (state management)
* State locking (DynamoDB)
* CI/CD pipeline using GitHub Actions
* Clean Git workflow for deployment

---

# 🏗️ Architecture

```
Terraform
   │
   ├── AWS (VPC + EC2)
   │      └── Remote State → S3 + DynamoDB
   │
   └── Azure (VNet + Subnet)
          └── Remote State → Azure Storage
```

---

# 📁 Repository Structure

```
multi-cloud-terraform-devops-platform/
│
├── terraform/
│   ├── aws/
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── main.tf
│   │   └── variables.tf
│   │
│   ├── azure/
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── main.tf
│   │   └── variables.tf
│
├── .github/workflows/
│   └── terraform.yml
│
├── .gitignore
└── README.md
```

---

# ⚙️ Prerequisites

Ensure the following tools are installed:

* Terraform ≥ 1.3
* AWS CLI
* Azure CLI
* Git

---

# 🔐 Step 1: Configure Cloud Credentials

## ✅ AWS Authentication

```bash
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
export AWS_DEFAULT_REGION=ap-south-1
```

Verify:

```bash
aws sts get-caller-identity
```

---

## ✅ Azure Authentication

```bash
az login
```

Verify:

```bash
az account show
```

---

# 🧱 Step 2: Create Remote Backend Infrastructure

⚠️ **Mandatory before running Terraform**

---

## ☁️ AWS Backend Setup

```bash
aws s3api create-bucket \
  --bucket my-terraform-state-bucket \
  --region ap-south-1

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

---

## ☁️ Azure Backend Setup

```bash
az group create --name tf-rg --location centralindia

az storage account create \
  --name tfstateaccount \
  --resource-group tf-rg \
  --location centralindia \
  --sku Standard_LRS

az storage container create \
  --name tfstate \
  --account-name tfstateaccount
```

---

# ☁️ Step 3: Deploy AWS Infrastructure

```bash
cd terraform/aws

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## 📦 AWS Resources Created

* VPC
* Subnet
* EC2 Instance

---

## ⚠️ AMI Fix (If Required)

```bash
aws ec2 describe-images --owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*" \
--query 'Images[*].[ImageId,Name]' \
--output table
```

Update AMI in `main.tf` if needed.

---

# ☁️ Step 4: Deploy Azure Infrastructure

```bash
cd terraform/azure

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## 📦 Azure Resources Created

* Resource Group
* Virtual Network
* Subnet

---

# 🤖 Step 5: CI/CD Pipeline (GitHub Actions)

Workflow file:

```
.github/workflows/terraform.yml
```

## 🔹 What It Does

* Runs on push to `main`
* Initializes Terraform for AWS & Azure
* Validates configuration

## 🔹 How to Enable

1. Push repo to GitHub
2. Go to **Actions tab**
3. Workflow runs automatically

---

# 🚀 Step 6: Upload This Project to GitHub

```bash
rm -rf .git

git init
git add .
git commit -m "Initial commit - multi-cloud terraform with remote backend"

git remote add origin https://github.com/devopsgeek1979/terraform-basic.git

git branch -M main
git push -u origin main --force
```

---

# 🧹 Cleanup (Destroy Infrastructure)

## AWS

```bash
cd terraform/aws
terraform destroy -auto-approve
```

---

## Azure

```bash
cd terraform/azure
terraform destroy -auto-approve
```

---

# 🔒 Security Best Practices

For production environments:

* Use IAM Roles instead of static keys
* Use AWS Secrets Manager / Azure Key Vault
* Enable Terraform remote backend (already done)
* Enable state locking (DynamoDB)
* Avoid committing secrets

---

# 🧠 Key Learning Outcomes

* Multi-cloud Terraform deployment
* Remote state management
* State locking mechanism
* CI/CD pipeline integration
* Infrastructure automation best practices

---

# 🚀 Future Enhancements (Senior DevOps Level)

* Terraform modules (reusable components)
* Workspaces (dev/stage/prod)
* Load Balancers + Auto Scaling
* Kubernetes:

  * EKS (AWS)
  * AKS (Azure)
* Monitoring (Prometheus + Grafana)
* GitOps (ArgoCD)

---

# ⭐ Final Note

This repository demonstrates **real-world DevOps practices** including:

✔ Multi-cloud architecture
✔ Infrastructure as Code
✔ CI/CD automation
✔ Remote state management

It is designed to showcase **hands-on DevOps engineering capability at scale**.

---
