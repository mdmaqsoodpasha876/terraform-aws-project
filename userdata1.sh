#!/bin/bash

echo "🔄 Updating package repositories..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get upgrade -y

echo "🌐 Installing Apache2..."
apt-get install apache2 -y

echo "🛡️ Configuring UFW Firewall to allow web traffic..."
# Allows both HTTP (80) and HTTPS (443) traffic
ufw allow 'Apache Full'

echo "🚀 Ensuring Apache starts automatically on system boot..."
systemctl enable apache2
systemctl start apache2

echo "📝 Creating a template index.html landing page..."
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apache Web Server</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 10%; background-color: #f4f4f9; }
        h1 { color: #333; }
        p { color: #666; }
    </style>
</head>
<body>
    <h1>🎉 Success! Apache is successfully running on Ubuntu.</h1>
    <p>WELL-------------------------------------------------DONE.</p>
</body>
</html>
EOF

echo "✅ Verification: Checking Apache Service status..."
systemctl is-active --quiet apache2 && echo "🟢 Apache is RUNNING." || echo "🔴 Apache failed to start."

echo "🌐 You can now access your server at: http://$(hostname -I | awk '{print $1}')"

