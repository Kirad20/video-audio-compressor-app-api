# Pull official base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc python3-dev libmagic1 libffi-dev ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY app/requirements /requirements
RUN pip install --upgrade pip \
    && pip install -r /requirements/base.txt

# Copy entrypoint script
COPY ./docker/prod/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy application code (manage.py, core, compressor, etc.)
COPY app /app

# Collect static files
RUN python manage.py collectstatic --no-input

# Entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
