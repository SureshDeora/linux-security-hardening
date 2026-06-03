#!/bin/bash
# SSH Security Hardening Script for RHEL/CentOS
# Author: Suresh Deora | RHCE Certified
# Standalone script version (use Ansible playbooks for production)

echo "[*] Starting SSH Hardening..."

# Backup original config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Disable root login
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password auth (use keys only)
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Change default port
sudo sed -i 's/^#\?Port.*/Port 2222/' /etc/ssh/sshd_config

# Set idle timeout
sudo sed -i 's/^#\?ClientAliveInterval.*/ClientAliveInterval 300/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?ClientAliveCountMax.*/ClientAliveCountMax 2/' /etc/ssh/sshd_config

# Limit max auth tries
sudo sed -i 's/^#\?MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config

# Disable empty passwords
sudo sed -i 's/^#\?PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Restart SSH
sudo systemctl restart sshd

echo "[✓] SSH Hardening Complete"
echo "[!] SSH is now on port 2222 — update your firewall rules"
