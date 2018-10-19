FROM nginx:1.10

ADD .docker/app.conf /etc/nginx/conf.d/default.conf
