
#!/bin/bash

team_name="$1"
server_ip="$2"
alert_type="$3"
message="$4"
to_address="$5"
subject="$6"

if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <team_name> <server_ip> <alert_type> <message> <to_address> <subject>"
    exit 1
fi

if [ -z "$to_address" ]; then
    echo "ERROR: Recipient email address is missing"
    exit 1
fi

if [ ! -f template.html ]; then
    echo "ERROR: template.html not found"
    exit 1
fi

final_body=$(sed \
    -e "s|TO_TEAM|$team_name|g" \
    -e "s|ALERT_TYPE|$alert_type|g" \
    -e "s|SERVER_IP|$server_ip|g" \
    -e "s|MESSAGE_BODY|$message|g" \
    template.html)

{
    echo "To: $to_address"
    echo "Subject: $subject"
    echo "MIME-Version: 1.0"
    echo "Content-Type: text/html; charset=UTF-8"
    echo ""
    echo "$final_body"
} | msmtp "$to_address"

if [ "$?" -eq 0 ]; then
    echo "Email sent successfully to $to_address"
else
    echo "ERROR: Failed to send email"
    exit 1
fi
