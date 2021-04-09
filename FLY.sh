#!/bin/bash

function installdocker {
      sudo yum install -y yum-utils device-mapper-persistent-data lvm2 &&  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && sudo yum install docker-ce -y && sudo systemctl start docker && sudo systemctl enable docker
}

which dock

if [ $? -eq 0 ]
then
    docker --version | grep "Docker version"
    if [ $? -eq 0 ]
    then
        echo "docker was already installed. Exiting the script"
    else
            installdocker
    fi
else
    installdocker
fi

sudo docker build -t devops .
docker run -d -v /var/lib/mysql/:/var/lib/mysql -v /BATCAVE:/BATCAVE  --name ALFRED -e MYSQL_ROOT_PASSWORD=password -u root -p $(cat .secret) devops

docker ps | grep ALFRED
if [ $? -eq 0 ]
then
echo "ALFRED - Container is UP"
else
docker run -d -v /var/lib/mysql/:/var/lib/mysql -v /BATCAVE:/BATCAVE  --name ALFRED -e MYSQL_ROOT_PASSWORD=password -u root -p $(cat .secret)devops
fi

