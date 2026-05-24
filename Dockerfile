# Stage 1: Build the application
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies using pnpm
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN pnpm run build

# Stage 2: Serve the application
FROM node:20-alpine

WORKDIR /app

# Install pnpm globally for running preview
RUN npm install -g pnpm

# Copy only necessary files from builder
COPY --from=builder /app/dist ./dist
COPY package.json pnpm-lock.yaml ./

# Install all dependencies (including dev deps needed for vite preview)
RUN pnpm install --frozen-lockfile

# Expose port
EXPOSE 3000

# Start the application using vite preview
CMD ["pnpm", "run", "preview"]
