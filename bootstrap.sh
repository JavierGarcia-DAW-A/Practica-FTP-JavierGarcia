#!/bin/bash
set -e

apt update -y

apt install -y vsftpd openssl

sudo useradd -m luis
sudo passwd luis

sudo useradd -m maria
sudo passwd maria

sudo useradd -m javi
sudo passwd javi

sudo mkdir /home/luis/ftp
sudo chown nobody:nogroup /home/luis
sudo chmod a-w /home/luis
sudo touch /home/luis/ftp/holaluis.txt

sudo mkdir /home/maria
touch /home/maria/maria.txt
chown maria:maria /home/maria/holamaria.txt

mkdir -p /etc/ssl/private /etc/ssl/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/javier.test.pem

mkdir -p /home/vagrant/config
cp /vagrant/config/vsftpd.conf /etc/vsftpd.conf
cp /vagrant/config/vsftpd.chroot_list /etc/vsftpd.chroot_list
cp /vagrant/config/* /home/vagrant/config/


systemctl restart vsftpd
systemctl status vsftpd 


