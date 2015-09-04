#!/bin/sh

docker ps
docker stop uv-core ; docker rm uv-core
docker stop wt-virtuoso ; docker rm wt-virtuoso
docker stop uv-mysql ; docker rm uv-mysql

docker run --name wt-virtuoso \
       -p 8890:8890 -p 1111:1111 \
       -e DBA_PASSWORD=WestAccVirt \
       -v /vagrant/data/virtuoso:/var/lib/virtuoso/db \
       -d tenforce/virtuoso:virtuoso-v7.2.0-latest

docker build -t wtdb WtDb

docker run --name uv-mysql \
       -p 3306:3306 \
       -e MYSQL_ROOT_PASSWORD=password \
       -e MYSQL_USER=unified_views \
       -e MYSQL_PASSWORD=WestAccUV \
       -e MYSQL_DATABASE=unified_views \
       -d wtdb

docker run --name uv-core \
       -p 8080:8080 \
       --link wt-virtuoso:virtuoso \
       --link uv-mysql:mysql \
       -e UV_DATABASE_SQL_URL=jdbc:mysql://mysql:3306/unified_views?characterEncoding=utf8 \
       -e UV_DATABASE_SQL_USER=unified_views \
       -e UV_DATABASE_SQL_PASSWORD=WestAccUV \
       -v /vagrant/unified-views/lib/:/unified-views/lib \
       -v /vagrant/unified-views/dpus/:/dpus \
       -v /vagrant/data/feeds:/feeds \
       -d tenforce/unified-views
