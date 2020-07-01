#!/bin/sh

# Creates new user with same ssh access as the root user
if [ $# -ne 1 ]; then
    echo 'number of arguments must be exactly one'
    exit 1
fi

user_name=$1

sudo adduser $user_name
sudo usermod -aG sudo $user_name

sudo echo AllowUsers $user_name >> /etc/ssh/sshd_config

cp -r ~/.ssh ~/../home/$user_name/.ssh

chmod 700 ~/../home/$user_name/.ssh
chmod 600 ~/../home/$user_name/.ssh/authorized_keys
sudo chown -R $user_name ~/../home/$user_name/.ssh

sudo service sshd reload
sudo su - $user_name
