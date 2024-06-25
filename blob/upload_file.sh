# Load environment variables from .env file
set -o allexport
source .env
set +o allexport

# Variables
FILE_PATH="/Users/charles/Desktop/github_logo.png"
BLOB_NAME="photo.png"

# Charger le fichier
az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY \
    --container-name $CONTAINER_NAME \
    --name $BLOB_NAME \
    --file $FILE_PATH