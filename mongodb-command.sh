#!/bin/bash
set -e
MONGO_JOURNAL=--journal
if [ "$CIKL_ENV" = "development" ]; then
  MONGO_JOURNAL=--nojournal
fi
exec /usr/bin/mongod $MONGO_JOURNAL --dbpath=/data/db "$@"
