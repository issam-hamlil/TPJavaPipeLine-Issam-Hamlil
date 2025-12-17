FROM maven:3.9.6-eclipse-temurin-17
# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
# Verify installations
RUN mvn -version && git --version