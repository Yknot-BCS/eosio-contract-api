FROM node:16-alpine

# Create application user first
RUN adduser --disabled-password application

# Set working directory
WORKDIR /home/application/app

# Copy package files first
COPY package.json yarn.lock ./

# Copy the rest of the application
COPY . .

# Set correct permissions for the entire app directory
RUN chown -R application:application /home/application/app

# Switch to application user
USER application

# Install dependencies
RUN yarn install

ENV NODE_ENV production
EXPOSE 9000