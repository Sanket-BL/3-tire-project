# 3-tire-project
1. Add a README.md
Explain:
- Project overview (what the 3‑tier architecture does)
- Technologies used (Terraform, AWS EC2, S3, etc.)
- Setup instructions (how someone can clone and run it)
- Architecture diagram (optional but powerful)

2. Add a .gitignore
Keep sensitive files out of GitHub:
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
*.tfvars.json
.terraform.lock.hcl

3. Use Branches
- Keep main clean and stable.
- Create feature branches for experiments or new modules.

4. Add Tags or Releases
- Tag versions like v1.0 when you reach stable points.
- Helps track progress and rollback if needed.
