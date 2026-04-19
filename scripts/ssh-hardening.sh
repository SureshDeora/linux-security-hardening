#!/bin/bash
# SSH Security Hardening Script for RHEL/CentOS
# Author: Suresh Deora | RHCE Certified

echo "[*] Starting SSH Hardening..."

# Backup original config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Disable root login
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password auth (use keys only)
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Change default port
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Disable empty passwords
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Set max auth tries
sudo sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config

# Disable X11 Forwarding
sudo sed -i 's/X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config

# Set login grace time
sudo sed -i 's/#LoginGraceTime 2m/LoginGraceTime 60/' /etc/ssh/sshd_config

# Restart SSH
sudo systemctl restart sshd

echo "[✓] SSH Hardening Complete!"
echo "[!] Make sure you have key-based access before logging out!"
