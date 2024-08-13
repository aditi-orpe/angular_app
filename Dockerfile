# Step 1: Build the Angular app
FROM node:18 AS build

WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Build the Angular app
RUN npm run build --prod

# Step 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the Angular build output to Nginx's HTML directory
COPY --from=build /app/dist/ang-app /usr/share/nginx/html

# Copy a custom Nginx configuration file if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port Nginx is using
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
