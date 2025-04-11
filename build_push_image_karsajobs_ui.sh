#!/bin/bash

# Hentikan eksekusi jika terjadi error saat eksekusi
set -e

# Username GitHub
GITHUB_USERNAME="sunuilhamp"

# Nama aplikasi dan tag
IMAGE_NAME="karsajobs-ui"
TAG="latest"

# Build Docker image
echo "🚀 Membuat Docker image..."
docker build -t $IMAGE_NAME:$TAG .

# Melihat daftar image yang ada di lokal
echo "📜 Daftar image lokal:"
docker images

# Ubah nama image agar sesuai dengan format GitHub Packages
echo "🔄 Menyesuaikan nama image untuk GitHub Packages..."
docker tag $IMAGE_NAME:$TAG ghcr.io/$GITHUB_USERNAME/$IMAGE_NAME:$TAG

# Login ke GitHub Container Registry (GitHub Packages)
echo "🔑 Login ke GitHub Packages..."
echo "$GHCR_PAT" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin

# Push image ke GitHub Packages
echo "☁️ Mengunggah image ke GitHub Packages..."
docker push ghcr.io/$GITHUB_USERNAME/$IMAGE_NAME:$TAG

echo "✅ Selesai! Image berhasil diunggah ke GHCR: ghcr.io/$GITHUB_USERNAME/$IMAGE_NAME:$TAG"
