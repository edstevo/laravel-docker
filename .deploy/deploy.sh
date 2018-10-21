#!/bin/bash
set -e

### Configuration ###

## INSERT YOUR IPS HERE WITH SPACES BETWEEN
IP_ADDRESSES=(178.62.69.178)

## VARS ##

BRANCH=$(git rev-parse --abbrev-ref HEAD)

## Deploy Script ##

if [[ "$BRANCH" != "master" ]]; then
  echo 'ABORTING DEPLOY: Not on master branch';
  exit 0;
fi

docker-compose push
git push

for ip in ${IP_ADDRESSES[@]}; do

    ssh root@${ip} '
        cd laravel-docker \
        && git pull \
        && docker-compose pull \
        && docker exec laravel-docker_app_1 composer update \
        && docker exec laravel-docker_app_1 php artisan route:clear \
        && docker exec laravel-docker_app_1 php artisan config:clear \
        && docker exec laravel-docker_app_1 php artisan cache:clear \
        && docker-compose restart \
    '

done
exit 0