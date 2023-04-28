# Use the official Node.js image as the base image
FROM node:19-alpine

ARG NODE_ENV

ENV NODE_ENV=$NODE_ENV

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm ci

# Set necessary environment variables
ENV DATABASE_URL=<your_database_url>
ENV NEXTAUTH_SECRET=<your_nextauth_secret>
ENV NEXTAUTH_URL=<your_nextauth_url>
ENV OPENAI_API_KEY=<your_openai_api_key>

# Copy the rest of the application code
COPY . .

# Build the Next.js app
RUN npm run build

# Expose the port the app will run on
EXPOSE 3000

# Set the entrypoint script and make it executable
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]

# Start the application
CMD ["npm", "start"]

