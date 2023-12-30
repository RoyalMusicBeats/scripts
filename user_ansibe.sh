#!/bin/bash

# Create Ansible account
sudo useradd -m ansible

# Add Ansible account to sudoers group
sudo usermod -aG sudo ansible

# Set the default shell to bash for the ansible user
sudo usermod -s /bin/bash ansible

# Configure sudo to allow ansible user to run sudo without password
echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/ansible

# Disable SSH password login for Ansible account
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Create .ssh directory if it doesn't exist
sudo mkdir -p /home/ansible/.ssh

# Add RSA public key for Ansible account
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUK+PLCJd+r85hi/U4/xSfJE5raRWySFJ3AKJfzQAyBRWm5FyTBec5v7iXGraxffndXT5TnBNyJ92HDVDBfdVdHCG7h2kQUguqkeR4F+IqWORllfVAH9ZWyWDeVwJUkaksL2P91lMHQz/EUhsoiVDOtMaxYJeBQeNzToHAD8OPXvVsrgdd9TKtW2GQtbLQ7/N+s1FPNoeETF9J6HaJy12Bgvi/J4nOfg/PDgVwCWOQzZJrxac6uKME9DRdU7N48ygLXCSbgFeUODeJbdjSoXYHUd3Br1mzsEX2+VVoL2rtyJF0Qr+7hbpzLNzsVVCcF+4aoO+hyUZnGjpZ6CCAavcuOo+FUEU+/1EwCYCUbpl8udgunad6/6kgS70rao8XH8o6NTUxx1nHkhsCrk/i87TahdeRL+sW4qm7bb8/MZBtnjV5ySNYTTfp80Dup3mIxXdOVfOiubKmagtWX73wH2yolqrGV0E0Mt36yTfAF/6IHLa6G2NId6k+LwGUokV7QJk= root@buildkitsandbox" | sudo tee -a /home/ansible/.ssh/authorized_keys

# Set correct permissions for the authorized_keys file
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys