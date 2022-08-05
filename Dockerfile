FROM yugabytedb/yugabyte:2.15.1.0-b175
LABEL version="2.15"
LABEL maintaner="Godwin peter .O <me@godwin.dev>"
LABEL release-date="2022-06-19"

RUN  yum install -y deltarpm
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
  yum -y update && yum -y upgrade
RUN yum install -y postgresql11-server postgresql11 postgresql11-contrib \
  postgis31_11 postgis31_11-client postgis31_11-contrib
# Install the PostGIS extension
RUN cp -v "$(/usr/pgsql-11/bin/pg_config --pkglibdir)"/*postgis*.so "$(/home/yugabyte/postgres/bin/pg_config --pkglibdir)" && \
  cp -v "$(/usr/pgsql-11/bin/pg_config --sharedir)"/extension/*postgis*.sql "$(/home/yugabyte/postgres/bin/pg_config --sharedir)"/extension && \
  cp -v "$(/usr/pgsql-11/bin/pg_config --sharedir)"/extension/*postgis*.control "$(/home/yugabyte/postgres/bin/pg_config --sharedir)"/extension
# Include uuid-ossp extension
RUN cp -v "$(/usr/pgsql-11/bin/pg_config --pkglibdir)"/*uuid-ossp*.so "$(/home/yugabyte/postgres/bin/pg_config --pkglibdir)" && \
  cp -v "$(/usr/pgsql-11/bin/pg_config --sharedir)"/extension/*uuid-ossp*.sql "$(/home/yugabyte/postgres/bin/pg_config --sharedir)"/extension && \
  cp -v "$(/usr/pgsql-11/bin/pg_config --sharedir)"/extension/*uuid-ossp*.control "$(/home/yugabyte/postgres/bin/pg_config --sharedir)"/extension
# Install the PostGIS && uuid-ossp extension
RUN /home/yugabyte/bin/post_install.sh -e
