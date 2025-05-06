#!/bin/bash

# basic configuration
CATALOG="/"
THRESHOLD=85                        # Min amount of free space in %
TARGET_EMAIL="gromaks000@gmail.com"
SMTP_CONFIG="${1:-./smtp.conf}"     # Config file path as parameter, defaults to ./smtp.conf

# Check config file presence
if [ ! -f "$SMTP_CONFIG" ]; then
    echo "Error: smtp configuration file not found." >&2
    exit 1
fi

# Get usage info -> extract 'Use%' value -> remove '%' 
DISK_USAGE=$(df "$CATALOG" | awk 'NR==2 {print $5}' | sed 's/%//')

if (( 100 - DISK_USAGE < THRESHOLD )); then
    # configure smtp
    source "$SMTP_CONFIG"

    # Compose the message
    SUBJECT="[WARNING] Free disk space is less than $THRESHOLD%"
    MESSAGE="The amount of free disk space at catalog '$CATALOG' has fallen under the threshold of $THRESHOLD%. Take actions."

    # Create a temp file with the message in MIME format
    TEMP_FILE=$(mktemp)
    cat > "$TEMP_FILE" << EOF
Subject: $SUBJECT
From: Disk Monitoring <$SMTP_USER>
To: $TARGET_EMAIL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

$MESSAGE
EOF

    curl --url "smtp://$SMTP_SERVER:$SMTP_PORT" \
        --ssl-reqd \
        --mail-from "$SMTP_USER" \
        --mail-rcpt "$TARGET_EMAIL" \
        --user "$SMTP_USER:$SMTP_PASSWORD" \
        --upload-file "$TEMP_FILE" \
        --silent
    
    rm -f "$TEMP_FILE"
fi
