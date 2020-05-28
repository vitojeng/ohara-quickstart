#!/bin/bash
containerSize=$(docker ps -aq | wc -l)
if [[ $containerSize > 0 ]];
then	
  while true; do
    read -p "The all image and running container will remove, Please confirm [yes/no]?" yn
    case $yn in
      [Yy]* )
        docker rm -f $(docker ps -aq);
        docker rmi $(docker images -q);
        break;;
      [Nn]* ) exit;;
        * ) echo "Please input yes or no.";;
    esac
  done
fi
