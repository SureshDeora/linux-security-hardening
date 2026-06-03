# Linux Security Hardening with Ansible

Automated CIS Benchmark hardening for RHEL 9 servers using Ansible. Covers SSH security, SELinux enforcement, firewall configuration, audit logging, service minimization, and Fail2Ban setup.

Reduced manual hardening time from **4 hours to 15 minutes** per server.

## What It Does

Applies security hardening across 6 domains in a single command:

| Playbook | CIS Controls Covered |
|---|---|
| `ssh-hardening.yml` | Disable root login, key-only auth, custom port, idle timeout |
| `selinux.yml` | Enforce SELinux, set targeted policy |
| `firewall.yml` | Enable firewalld, allow only required services |
| `auditd.yml` | Enable audit logging, monitor auth/file changes |
| `service-minimization.yml` | Disable unnecessary services and daemons |
| `fail2ban.yml` | Install and configure Fail2Ban for brute-force protection |

## Architecture

```
Control Node (Ansible)
    │
    ├── site.yml (master playbook — runs everything)
    │
    ├── ansible/ssh-hardening.yml
    ├── ansible/selinux.yml
    ├── ansible/firewall.yml
    ├── ansible/auditd.yml
    ├── ansible/service-minimization.yml
    ├── ansible/fail2ban.yml
    │
    └── Target: RHEL 9 Servers (inventory)
```

## Setup

### Prerequisites
- Ansible installed on control node (`pip install ansible`)
- SSH key-based access to target servers
- RHEL 9 / CentOS Stream 9 target hosts

### Inventory

Edit `inventory.ini` with your target servers:
```ini
[servers]
192.168.1.10
192.168.1.11
```

## Run

```bash
# Run ALL hardening playbooks at once
ansible-playbook -i inventory.ini site.yml

# Run individual playbooks
ansible-playbook -i inventory.ini ansible/ssh-hardening.yml
ansible-playbook -i inventory.ini ansible/firewall.yml
```

## Hardening Checklist

### SSH Security
- [x] Disable root login (`PermitRootLogin no`)
- [x] Key-only authentication (`PasswordAuthentication no`)
- [x] Custom SSH port
- [x] Idle session timeout
- [x] Max authentication attempts limited

### SELinux
- [x] Set to enforcing mode
- [x] Targeted policy applied

### Firewall
- [x] firewalld enabled and running
- [x] Only SSH and HTTPS allowed
- [x] Default zone set to drop

### Audit Logging
- [x] auditd service enabled
- [x] Monitor authentication events
- [x] Monitor file permission changes
- [x] Monitor sudoers modifications

### Service Minimization
- [x] Disable unused services (cups, avahi, postfix, rpcbind)
- [x] Remove unnecessary packages

### Fail2Ban
- [x] Installed and enabled
- [x] SSH jail configured
- [x] Ban time: 1 hour
- [x] Max retries: 3

## CIS Benchmark Alignment

These playbooks align with [CIS RHEL 9 Benchmark v1.0](https://www.cisecurity.org/benchmark/red_hat_linux):

| CIS Section | Control | Playbook |
|---|---|---|
| 5.2 | Configure SSH Server | `ssh-hardening.yml` |
| 1.6 | Configure SELinux | `selinux.yml` |
| 3.4 | Configure firewalld | `firewall.yml` |
| 4.1 | Configure auditd | `auditd.yml` |
| 2.2 | Remove unnecessary services | `service-minimization.yml` |
| — | Brute-force protection | `fail2ban.yml` |

## Tech Stack

- **Ansible** — Configuration management and automation
- **RHEL 9** — Target operating system
- **CIS Benchmarks** — Security baseline standard
- **SELinux** — Mandatory access control
- **auditd** — Linux audit framework
- **firewalld** — Dynamic firewall management
- **Fail2Ban** — Intrusion prevention
