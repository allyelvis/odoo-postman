# Odoo Enterprise 17 Setup and Postman Collection

This guide provides step-by-step instructions to set up Odoo Enterprise 17, generate a Postman collection, and use it for real-time streaming endpoints.

## Prerequisites

Ensure you have the following installed on your system:
- Git
- Python 3
- Node.js and npm
- PostgreSQL
- Postman

## Setup Script

The provided `setup_odoo_with_postman.sh` script automates the setup of Odoo Enterprise 17 and the generation of a Postman collection.

### Script Overview

1. Clone the Odoo Enterprise and Community repositories.
2. Set up a Python virtual environment and install dependencies.
3. Install PostgreSQL and create a user and database.
4. Configure and start the Odoo server.
5. Generate a Postman collection for real-time streaming endpoints.

### Running the Script

1. Clone this repository:

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Make the setup script executable:

    ```bash
    chmod +x setup_odoo_with_postman.sh
    ```

3. Run the setup script:

    ```bash
    ./setup_odoo_with_postman.sh
    ```

The script will:
- Clone the necessary repositories.
- Set up the environment.
- Start the Odoo server.
- Generate a Postman collection.

### Postman Collection

The generated Postman collection includes endpoints for real-time streaming:
- Webhook Endpoint: `http://localhost:8069/webhook/endpoint`
- Long-polling Endpoint: `http://localhost:8069/longpolling/endpoint`

You can find the Postman collection file named `odoo_enterprise_postman_collection.json` in the root directory.

#### Importing the Collection

1. Open Postman.
2. Click on `Import` in the top left corner.
3. Select `Upload Files` and choose the `odoo_enterprise_postman_collection.json` file.
4. Click `Import`.

#### Using the Collection

1. Ensure your Odoo server is running.
2. Navigate to the imported collection in Postman.
3. Execute the requests to interact with the real-time streaming endpoints.

## Customization

You may need to customize the webhook and long-polling endpoints in the Postman collection based on your specific Odoo instance configuration.

## Troubleshooting

### Common Issues

1. **Port Conflicts**: Ensure no other services are running on port `8069`.
2. **Database Connection**: Verify PostgreSQL is running and the user/database configurations are correct.

### Logs

Check the `odoo.log` file in the Odoo directory for detailed logs if you encounter any issues.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
