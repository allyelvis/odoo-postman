#!/bin/bash

# Variables
REPO_URL="https://github.com/odoo/enterprise.git"
REPO_DIR="enterprise"
ODOO_DIR="odoo"
ODOO_VERSION="17.0"  # Specify the Odoo version
CONFIG_FILE="odoo.conf"
POSTMAN_COLLECTION_FILE="odoo_enterprise_postman_collection.json"

# Step 1: Clone the Odoo Enterprise repository
echo "Cloning the Odoo Enterprise repository..."
git clone $REPO_URL $REPO_DIR

# Step 2: Clone the Odoo Community repository (since Odoo Enterprise is built on top of Community)
echo "Cloning the Odoo Community repository..."
git clone --branch $ODOO_VERSION https://github.com/odoo/odoo.git $ODOO_DIR

# Step 3: Navigate to the Odoo directory
cd $ODOO_DIR

# Step 4: Set up a Python virtual environment
echo "Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Step 5: Install Python dependencies
echo "Installing Python dependencies..."
pip install wheel
pip install -r requirements.txt

# Step 6: Install PostgreSQL
echo "Installing PostgreSQL..."
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Step 7: Create a PostgreSQL user and database for Odoo
echo "Creating PostgreSQL user and database for Odoo..."
sudo -u postgres createuser -s odoo
sudo -u postgres createdb odoo

# Step 8: Create Odoo configuration file
echo "Creating Odoo configuration file..."
cat <<EOF > $CONFIG_FILE
[options]
; This is the password that allows database operations:
admin_passwd = admin
db_host = False
db_port = False
db_user = odoo
db_password = False
addons_path = $PWD/addons,$PWD/../$REPO_DIR
logfile = $PWD/odoo.log
EOF

# Step 9: Install Node.js and Less (for web assets building)
echo "Installing Node.js and Less..."
sudo apt-get install -y nodejs npm
sudo npm install -g less less-plugin-clean-css

# Step 10: Install Odoo Enterprise dependencies
echo "Installing Odoo Enterprise dependencies..."
pip install -r ../$REPO_DIR/requirements.txt

# Step 11: Start Odoo server
echo "Starting Odoo server..."
./odoo-bin -c $CONFIG_FILE &

# Allow some time for the server to start
sleep 30

# Step 12: Generate Postman collection for real-time streaming endpoints
echo "Generating Postman collection..."
cat <<EOF > $POSTMAN_COLLECTION_FILE
{
    "info": {
        "name": "Odoo Enterprise API - Real-time Streaming",
        "_postman_id": "abcd1234-5678-9101-1121-314151617181",
        "description": "Collection for Odoo Enterprise API with real-time streaming endpoints",
        "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
    },
    "item": [
        {
            "name": "Webhook Endpoint",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": "{\n    \"example\": \"data\"\n}"
                },
                "url": {
                    "raw": "http://localhost:8069/webhook/endpoint",
                    "protocol": "http",
                    "host": [
                        "localhost"
                    ],
                    "port": "8069",
                    "path": [
                        "webhook",
                        "endpoint"
                    ]
                }
            }
        },
        {
            "name": "Long-polling Endpoint",
            "request": {
                "method": "GET",
                "header": [],
                "url": {
                    "raw": "http://localhost:8069/longpolling/endpoint",
                    "protocol": "http",
                    "host": [
                        "localhost"
                    ],
                    "port": "8069",
                    "path": [
                        "longpolling",
                        "endpoint"
                    ]
                }
            }
        }
    ]
}
EOF

# Step 13: Notify user of completion
echo "Postman collection generated: $POSTMAN_COLLECTION_FILE"

# Done
echo "Script completed successfully."
