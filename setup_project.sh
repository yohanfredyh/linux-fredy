#!/bin/bash
# ==============================================
# Script d'automatisation de création de projet IA
# ==============================================

echo "=========================="
echo "Configuration du projet"
echo "=========================="

# Demander le nom du projet
read -p "Nom du projet : " PROJECT_NAME

BASE_DIR=~/$PROJECT_NAME

# Créer l'arborescence
mkdir -p "$BASE_DIR"/datasets/brut
mkdir -p "$BASE_DIR"/datasets/clean
mkdir -p "$BASE_DIR"/config
mkdir -p "$BASE_DIR"/logs
mkdir -p "$BASE_DIR"/scripts
mkdir -p "$BASE_DIR"/models
mkdir -p "$BASE_DIR"/backup
ARBO_STATUS="OK"

# Créer un fichier de configuration
cat > "$BASE_DIR"/config/settings.conf << EOF
PROJECT_NAME=$PROJECT_NAME
DATA_PATH=datasets/brut
MODEL_PATH=models
LOG_LEVEL=INFO
EOF
CONFIG_STATUS="OK"

# Installer les outils nécessaires
sudo apt update -y > /dev/null 2>&1
sudo apt install -y git curl wget htop tree python3 python3-pip unzip > /dev/null 2>&1
SOFT_STATUS="OK"

# Télécharger le dataset
wget -q https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv \
    -P "$BASE_DIR"/datasets/brut/
if [ -f "$BASE_DIR/datasets/brut/iris.csv" ]; then
    DATASET_STATUS="OK"
else
    DATASET_STATUS="ECHEC"
fi

# Compresser le projet
tar -czf "$BASE_DIR"/backup/"$PROJECT_NAME".tar.gz -C ~ "$PROJECT_NAME"
ARCHIVE_PATH="backup/$PROJECT_NAME.tar.gz"

# Afficher le résumé
echo "=========================="
echo "Projet créé"
echo "Nom : $PROJECT_NAME"
echo "Arborescence : $ARBO_STATUS"
echo "Fichier de config : $CONFIG_STATUS"
echo "Logiciels : $SOFT_STATUS"
echo "Datasets : $DATASET_STATUS"
echo "Archive : $ARCHIVE_PATH"
echo ""
echo "Installation terminée."
echo "=========================="
