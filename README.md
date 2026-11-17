
# ☁️ Automated Cloud Infrastructure & Telemetry: Terraform, GitHub Actions, & AWS CloudWatch

An end-to-end Infrastructure-as-Code (IaC) and automated monitoring pipeline. Provisioned and validated completely in the cloud using GitHub Actions and AWS, eliminating local machine resource constraints.

---

## 🏗️ Architecture & Tech Stack
* **Infrastructure as Code (IaC):** Terraform (`>= 1.0.0`)
* **CI/CD Automation:** GitHub Actions
* **Cloud Provider:** AWS (EC2)
* **Monitoring & Alerting:** AWS CloudWatch Metrics & Alarms

---

## 🔄 Project Workflow & Execution

1. **Automated CI/CD Provisioning (GitHub Actions + Terraform):**
   Pushing changes to the `main` branch automatically triggers a GitHub Actions workflow (`terraform.yml`). Using encrypted GitHub Secrets for AWS authentication, the runner executes `terraform init` and `terraform apply` to build the infrastructure remotely.

   <img width="932" height="642" alt="Screenshot 2026-11-17 212321" src="https://github.com/user-attachments/assets/3ea91245-d458-42c3-b723-05566f0594a7" />

   *Title Card:* `GitHub Actions Automated Terraform Apply`

2. **Cloud Server Provisioning (AWS EC2):**
   Terraform automatically provisions a `t2.micro` Ubuntu instance (`Terraform-DevOps-Server`) in `us-east-1` and outputs its public IP address.

  <img width="1743" height="710" alt="Screenshot 2026-11-17 212418" src="https://github.com/user-attachments/assets/2c6658c9-cf42-4537-af4a-d5eb3004ec75" />

   *Title Card:* `Provisioned AWS EC2 Instance`

3. **Proactive Monitoring & Stress Testing (AWS CloudWatch):**
   Alongside the server, Terraform deploys a CloudWatch Metric Alarm (`high-cpu-utilization`) configured to trigger when average CPU usage exceeds 80% across two consecutive 2-minute periods. tress` utility until the alarm actively fired.

  <img width="1851" height="863" alt="Screenshot 2026-11-17 212557" src="https://github.com/user-attachments/assets/fab472e8-5d7d-4c82-a4dc-11593e3f717f" />

   *Title Card:* `CloudWatch High-CPU Alarm`

---

## 🐛 Real-World Challenges & Solutions Faced

* **Region-Specific AMI Mismatches (`InvalidAMIID.NotFound`):**
  * *Challenge:* Initially encountered a deployment failure because Amazon Machine Image (AMI) IDs are strictly tied to specific AWS regions, causing an API lookup failure during `terraform apply`.
  * *Solution:* Aligned the AWS provider region (`us-east-1`) with the exact Ubuntu AMI registry so Terraform could reliably locate and launch the instance.
* **Zero-Local-Compute Execution:**
  * *Challenge:* Running Terraform state operations and cloud CLI tools locally strained low-spec laptop hardware.
  * *Solution:* Offloaded 100% of execution to GitHub-hosted cloud runners via `.github/workflows/terraform.yml`, keeping the local workflow completely lightweight.

---

## 🧹 Cleanup
After validating the deployment and capturing telemetry metrics, cloud resources were terminated to maintain zero idle cloud spend.
