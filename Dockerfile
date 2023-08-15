# Stage 1: Build the Angular application
FROM node:latest AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular app using Nginx
FROM nginx:alpine

# Copy the built Angular app from the previous stage
COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html

# Configure Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
