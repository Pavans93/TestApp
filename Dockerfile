# Use the official Node.js image as the base image
FROM node:14 as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app
RUN npm run build -- --prod

# Use a smaller base image for the production build
FROM nginx:1.21-alpine

# Copy the built app from the builder stage to the nginx directory
COPY --from=builder /app/dist/test-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run the nginx server
CMD ["nginx", "-g", "daemon off;"]
