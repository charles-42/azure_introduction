# Load environment variables from .env file
set -o allexport
source .env
set +o allexport

pipelineName="pythonpipeline"


# Creation du storage linked service

StorageServiceName="storageLinkedService"
StorageServiceContent="{\"type\":\"AzureStorage\",\"typeProperties\":{\"connectionString\":{\"type\":\"SecureString\",\"value\":\"DefaultEndpointsProtocol=https;AccountName=${STORAGE_ACCOUNT};AccountKey=${STORAGE_KEY}\"}}}"

az datafactory linked-service create --factory-name $DATAFACTORYNAME --properties $StorageServiceContent --name $StorageServiceName --resource-group $RESOURCE_GROUP


# Création du Batch linked service

BatchLinkedServiceName="batchLinkedService"
BatchLinkedServiceContent="{\"type\":\"AzureBatch\",\"typeProperties\":{\"accountName\":\"$BATCHACCOUNTNAME\",\"batchUri\":\"$BATCHACCOUNTURL\",\"accessKey\":{\"type\":\"SecureString\",\"value\":\"$BATCHACCOUNTKEY\"}}}"

# Créer le linked service pour Azure Batch
az datafactory linked-service create --resource-group $RESOURCE_GROUP --factory-name $DATAFACTORYNAME --name $BatchLinkedServiceName --properties $BatchLinkedServiceContent


# # Définition JSON du pipeline avec l'activité batch custom et le service lié
# pipelineContent='{
#     "properties": {
#         "activities": [
#             {
#                 "name": "yourBatchActivityName",
#                 "type": "AzureBatch",
#                 "typeProperties": {
#                     "pool": {
#                         "linkedServiceName": {
#                             "referenceName": "'"$linkedServiceName"'",
#                             "type": "LinkedServiceReference"
#                         },
#                         "poolName": "yourPoolName"
#                     },
#                     "job": {
#                         "id": "yourJobId",
#                         "task": {
#                             "id": "yourTaskId",
#                             "commandLine": "python hello_script.py"
#                         }
#                     }
#                 }
#             }
#         ],
#         "parameters": {},
#         "annotations": []
#     }
# }'

# # Créer le pipeline avec l'activité batch custom et le service lié
# az datafactory pipeline create --resource-group $resourceGroup --factory-name $dataFactoryName --name $pipelineName --pipeline "$pipelineContent"
