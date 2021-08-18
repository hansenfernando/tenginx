#!/bin/bash

#Update ubuntu repo
sudo apt-get update

#Change timedate
sudo timedatectl set-timezone Asia/Jakarta

#Install docker
echo "###Install docker###"
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
#Configure docker
sudo usermod -aG docker $USER

#Install nginx on container
docker pull nginx
docker run -itd --name nginx_webserver -p 80:80 nginx