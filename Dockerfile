FROM python:3.14-slim

ENV POETRY_VERSION=2.2.1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Copy poetry files
COPY pyproject.toml poetry.lock ./

# Install Poetry
RUN pip install --upgrade pip && pip install --no-cache-dir poetry==$POETRY_VERSION

# Install dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-cache --no-interaction --no-ansi --without dev

# Copy project files
COPY src/ ./src/

# Expose port
EXPOSE 8080

# Run FastAPI app with uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080"]
