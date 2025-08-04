#!/bin/sh

# Wait for database to be ready
# This uses netcat to wait for the db service to be available
while ! nc -z $DB_HOST $DB_PORT; do
  echo "Waiting for database..."
  sleep 1

done

# Run migrations
python manage.py migrate --no-input

# Collect static files
python manage.py collectstatic --no-input

# Start Gunicorn
exec "$@"
