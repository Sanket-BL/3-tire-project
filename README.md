
# 3-Tier Architecture Project using Terraform & AWS

This repository contains Infrastructure-as-Code (IaC) for deploying a **3-Tier Architecture** on AWS using Terraform.  
The 3-Tier design separates the application into:

1. **Web Tier** – Handles user traffic (public EC2 instance or ALB + EC2)
2. **Application Tier** – Processes business logic (private EC2)
3. **Database Tier** – Stores application data (EC2-based DB since RDS is not used)

This architecture improves **scalability, security, modularity, and maintainability**.


- 🏗️ Architecture Diagram 

 diagram :

              Internet
                  │
           ┌────────────┐
           │  Web Tier  │ (Public EC2 / ALB)
           └────────────┘
                  │
           ┌────────────┐
           │  App Tier  │ (Private EC2)
           └────────────┘
                  │
           ┌────────────┐
           │  DB Tier   │ (EC2 Database)
           └────────────┘

---

## 📌 Project Overview

This project builds a fully functional 3-tier setup on AWS using Terraform.  
It includes:

- A **VPC** with public and private subnets  
- **Web EC2 instance(s)** placed in public subnet  
- **App EC2 instance(s)** placed in private subnet  
- **Database EC2 instance** (MySQL/Postgres installed manually or via user_data)  
- **S3 bucket** for storing database backups  
- **Security Groups** ensuring proper isolation:
  - Web Tier allowed from internet
  - App Tier allowed only from Web Tier
  - DB Tier allowed only from App Tier

This setup gives you a production-style environment using only EC2, S3, VPC.

---

## 🧰 Technologies Used

| Technology | Purpose |
|-----------|---------|
| **Terraform** | Infrastructure as code (IaC) |
| **AWS EC2** | Web, App, and DB servers |
| **AWS VPC** | Networking across tiers |
| **AWS S3** | DB backups, storage |
| **IAM** | Access management for EC2 → S3 |
| **Security Groups** | Firewall rules for each tier |


# *3-tier-project/*

```
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf # Optional: S3 + DynamoDB for remote state
├── modules/
│ ├── vpc/
│ ├── web_tier/
│ ├── app_tier/
│ └── db_tier/
├── scripts/
│ └── db_backup.sh # Optional: backup script for EC2 DB
├── README.md
```
        
---

# **1. Initialize Terraform**
```
terraform init
```
# **2. Review and validate**
```
terraform fmt -recursive
terraform validate
```
# **4. Preview the deployment**
```
terraform plan
```
# **5. Deploy the infrastructure**
```
terraform apply
```
# **6. Destroy environment (optional)**
```
terraform destroy
```

# **Conclusion**

This 3-Tier Architecture project demonstrates how to design and deploy a scalable, secure, and modular cloud environment on AWS using Terraform. By separating the infrastructure into Web, Application, and Database tiers, the system becomes easier to manage, update, and scale. The project follows Infrastructure-as-Code principles, ensuring that environments can be reproduced consistently and maintained in a controlled, versioned workflow.
