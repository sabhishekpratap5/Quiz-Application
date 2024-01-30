# Use an official Node.js runtime as a base image
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application files to the container
COPY . .

# Build the application
RUN npm run build

# Use a smaller image for serving the production build
FROM nginx:alpine

# Copy the build files from the build stage to the production stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port on which Nginx will run
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
