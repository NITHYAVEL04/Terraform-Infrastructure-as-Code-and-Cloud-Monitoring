
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

   *[📸 SCREENSHOT 1: Insert<img width="932" height="642" alt="Screenshot 2026-11-17 212321" src="https://github.com/user-attachments/assets/f2c43b50-84aa-4632-a5bb-cacfedae7b81" />
 screenshot of GitHub Actions workflow showing green checkmarks and `Apply complete! Resources: 2 added` with the output `instance_ip`]*
   *Title Card:* `GitHub Actions Automated Terraform Apply`

2. **Cloud Server Provisioning (AWS EC2):**
   Terraform automatically provisions a `t2.micro` Ubuntu instance (`Terraform-DevOps-Server`) in `us-east-1` and outputs its public IP address.

   *[📸 SCREENSHOT 2: Insert screenshot of AWS EC2 Console showing `Terraform-DevOps-Server` in `Running` state]*
   *Title Card:* `Provisioned AWS EC2 Instance`

3. **Proactive Monitoring & Stress Testing (AWS CloudWatch):**
   Alongside the server, Terraform deploys a CloudWatch Metric Alarm (`high-cpu-utilization`) configured to trigger when average CPU usage exceeds 80% across two consecutive 2-minute periods. To validate the setup, the instance was stress-tested using the Linux `stress` utility until the alarm actively fired.

   *[📸 SCREENSHOT 3: Insert screenshot of AWS CloudWatch Alarm in the red `In alarm` state with the CPU graph spiking above the 80% threshold]*
   *Title Card:* `Triggered CloudWatch High-CPU Alarm`

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
