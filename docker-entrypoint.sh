#!/bin/bash
set -e

gosu postgres postgres --single -jE <<-EOL
  CREATE USER "$POSTGRES_USER";
EOL

gosu postgres postgres --single -jE <<-EOL
  CREATE DATABASE "$POSTGRES_DB";
EOL

gosu postgres postgres --single -jE <<-EOL
  GRANT ALL ON DATABASE "$POSTGRES_DB" TO "$POSTGRES_USER";
EOL

# Postgis extension cannot be created in single user mode.
# So we will do it the kludge way by starting the server,
# updating the DB, then shutting down the server so the
# rest of the docker-postgres init scripts can finish.

gosu postgres pg_ctl -w start
gosu postgres psql "$POSTGRES_DB" <<-EOL
  CREATE EXTENSION postgis;
  CREATE EXTENSION hstore;
  ALTER TABLE geometry_columns OWNER TO "$POSTGRES_USER";
  ALTER TABLE spatial_ref_seys OWNER TO "$POSTGRES_USER";
EOL
gosu postgres pg_ctl stop
