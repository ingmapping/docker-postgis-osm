FROM postgres:9.3.6
MAINTAINER ingmapping <contact@ingmapping.com>

ENV PG_MAJOR 9.3

RUN apt-get update && apt-get install -y -q postgresql-${PG_MAJOR}-postgis-2.1 postgresql-contrib postgresql-server-dev-${PG_MAJOR}

ENV POSTGRES_USER postgres
ENV POSTGRES_DB gis

RUN mkdir -p /docker-entrypoint-initdb.d
ADD ./docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh
RUN chmod +x /docker-entrypoint-initdb.d/*.sh


