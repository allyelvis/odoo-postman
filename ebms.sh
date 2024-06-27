#!/bin/bash

# Replace with your desired module name and Odoo addons path
MODULE_NAME="my_module"
ODOO_ADDONS_PATH="/path/to/odoo/addons"

# Step 1: Create module directory
MODULE_PATH="${ODOO_ADDONS_PATH}/${MODULE_NAME}"
mkdir -p "${MODULE_PATH}"

# Step 2: Create __init__.py file
touch "${MODULE_PATH}/__init__.py"

# Step 3: Create manifest file (__manifest__.py)
cat << EOF > "${MODULE_PATH}/__manifest__.py"
{
    'name': '${MODULE_NAME}',
    'version': '1.0',
    'category': 'Custom',
    'depends': ['base'],  # Add dependencies if needed
    'data': [
        'views/views.xml',
        'views/menu.xml',
    ],
    'installable': True,
    'application': True,
    'auto_install': False,
}
EOF

# Step 4: Create models directory and __init__.py
MODELS_PATH="${MODULE_PATH}/models"
mkdir -p "${MODELS_PATH}"
touch "${MODELS_PATH}/__init__.py"

# Step 5: Create models.py file with basic model example
cat << EOF > "${MODELS_PATH}/models.py"
from odoo import models, fields, api

class Invoice(models.Model):
    _name = '${MODULE_NAME}.invoice'
    _description = 'Invoice'

    name = fields.Char(string='Name')
    amount_total = fields.Float(string='Total Amount')

    def sync_invoices(self):
        # Replace with your API integration logic
        pass
EOF

# Step 6: Create views directory and views.xml file
VIEWS_PATH="${MODULE_PATH}/views"
mkdir -p "${VIEWS_PATH}"

cat << EOF > "${VIEWS_PATH}/views.xml"
<?xml version="1.0"?>
<odoo>
    <data>
        <!-- Define your views here -->
    </data>
</odoo>
EOF

# Step 7: Create menu.xml file for module menu items
cat << EOF > "${VIEWS_PATH}/menu.xml"
<?xml version="1.0"?>
<odoo>
    <data>
        <!-- Define your menu items here -->
    </data>
</odoo>
EOF

# Step 8: Create __init__.py for views directory
touch "${VIEWS_PATH}/__init__.py"

echo "Module ${MODULE_NAME} created successfully at ${MODULE_PATH}"
