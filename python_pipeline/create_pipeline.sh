# Load environment variables from .env file
set -o allexport
source .env
set +o allexport

# Creation du storage linked service

StorageServiceName="storageLinkedService"
Storagejsonpath="python_pipeline/json/real_storage_properties.json"

# Attention jq doit être installé sur votre machine
StorageServiceContent=$(cat $Storagejsonpath | jq -c '.')

# Créer le linked service
az datafactory linked-service create \
    --factory-name $DATAFACTORYNAME \
    --properties "$StorageServiceContent" \
    --name $StorageServiceName \
    --resource-group $RESOURCE_GROUP

# Création du Batch linked service

BatchLinkedServiceName="batchLinkedService"
Batchjsonpath="python_pipeline/json/real_batch_properties.json"

# Attention jq doit être installé sur votre machine
BatchServiceContent=$(cat $Batchjsonpath | jq -c '.')

# Créer le linked service
az datafactory linked-service create \
    --factory-name $DATAFACTORYNAME \
    --properties "$BatchServiceContent" \
    --name $BatchLinkedServiceName \
    --resource-group $RESOURCE_GROUP


# Création du Pipeline

PipelineName="PythonPipeline"
Pipelinejsonpath="python_pipeline/json/pipeline_properties.json"

# Attention jq doit être installé sur votre machine
PipelineContent=$(cat $Pipelinejsonpath | jq -c '.')

# Créer le linked service
az datafactory pipeline create \
    --factory-name $DATAFACTORYNAME \
    --pipeline "$PipelineContent" \
    --name $PipelineName \
    --resource-group $RESOURCE_GROUP

# Création du Trigger

TriggerName="TriggerPythonPipeline"
Triggerjsonpath="python_pipeline/json/trigger_properties.json"

# Attention jq doit être installé sur votre machine
TriggerContent=$(cat $Triggerjsonpath | jq -c '.')

# Créer le Trigger
az datafactory trigger create \
    --factory-name $DATAFACTORYNAME \
    --properties "$TriggerContent" \
    --name $TriggerName \
    --resource-group $RESOURCE_GROUP

# Start the trigger
az datafactory trigger start \
    --resource-group $RESOURCE_GROUP \
    --factory-name $DATAFACTORYNAME \
    --name $TriggerName