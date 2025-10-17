FROM python:3.13.9-slim

ENV UV_VERSION=0.9.3
ENV UV_PROJECT_ENVIRONMENT="/usr/local/"

# Set work directory
WORKDIR /app

# Copy poetry files
COPY pyproject.toml uv.lock ./

# Install UV
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir uv==$UV_VERSION

# Install dependencies
RUN uv sync

# Copy project files
COPY src/ ./src/

# Expose port
EXPOSE 8080

# Run FastAPI app with uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080"]
