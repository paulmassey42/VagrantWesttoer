# SYSTEM
# 
# VERSION				0.0.1

FROM mariadb:latest
MAINTAINER pma
RUN apt-get update && apt-get install -y wget
RUN mkdir -p /scripts
RUN cd /scripts && \
    /usr/bin/wget https://raw.githubusercontent.com/UnifiedViews/Core/UV_Core_v2.1.0/db/mysql/schema.sql && \
    wget https://raw.githubusercontent.com/UnifiedViews/Core/UV_Core_v2.1.0/db/mysql/data-core.sql && \
    wget https://raw.githubusercontent.com/UnifiedViews/Core/UV_Core_v2.1.0/db/mysql/data-permissions.sql

RUN /bin/bash -c "/usr/bin/mysqld_safe &" && sleep 30 && \
    mysql --user=unified_views --password=WestAccUV unified_views < /scripts/schema.sql && \
    mysql --user=unified_views --password=WestAccUV unified_views < /scripts/data-core.sql && \
    mysql --user=unified_views --password=WestAccUV unified_views < /scripts/data-permissions.sql

EXPOSE 3306
