FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Create a secure non-root user
RUN useradd -m -u 1000 user

# Set working directory AND grant full ownership to our user
WORKDIR /app
RUN chown -R user:user /app

# Copy requirements file with correct user permissions
COPY --chown=user:user requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -U -r requirements.txt

# --- HUGGING FACE SECURITY CONSTRAINTS ---
ENV PORT=7860
EXPOSE 7860

# Switch to our safe user environment
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
# ----------------------------------------

# Copy the remaining bot files with proper user permissions
COPY --chown=user:user . .

# Command to run the bot
CMD ["python3", "main.py"]
