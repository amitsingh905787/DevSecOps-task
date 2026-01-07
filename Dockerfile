# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

# ---------- Runtime stage ----------
FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app

COPY --from=builder /app /app

# Run as non-root user (distroless default)
USER nonroot

EXPOSE 3000
CMD ["index.js"]

