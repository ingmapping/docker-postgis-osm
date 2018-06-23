# docker-postgis-osm
PostGIS in docker for importing OpenStreetMap data. This postgis docker container is based on the [official postgres docker image](https://hub.docker.com/_/postgres/) version 9.3. It creates a template database 'gis' owned by user 'postgres' and installs the extensions of postgis and hstore. It is intented to be used with [docker-osm2pqsql](https://github.com/ingmapping/docker-osm2pgsql).

## docker-postgis-osm set up

Can be built from the Dockerfile:

```
    docker build -t ingmapping/postgis-osm github.com/ingmapping/docker-postgis-osm.git
```

or pulled from Docker Hub:

```
docker pull ingmapping/postgis-osm
```

## docker-postgis-osm run

To run docker-postgis-osm, launch the container:

    # docker run -d --name postgis-osm ingmapping/postgis-osm

By default, a database `gis` will be created with postgres user/owner `postgres`. These can be changed with environment variables in the RUN command:

    # docker run -d --name postgis-osm -e "POSTGRES_USER=ingmapping" -e "POSTGRES_DB=osm_custom_database" ingmapping/postgis-osm

These variables can be accessed from linked containers. Consider the link alias `pg`:

    PG_ENV_POSTGRES_USER=postgres
    PG_ENV_POSTGRES_DB=gis

These can then be passed into import scripts or clients in other containers.
