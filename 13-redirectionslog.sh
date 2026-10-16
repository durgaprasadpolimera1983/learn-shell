
#!/bin/bash

user_id=$(id -u)
logs_folder="/var/log/shell-practice"
logs_file="${logs_folder}/$(basename "$0").log"

if [ "$user_id" -ne 0 ]; then
    echo "Please run this script with sudo access."
    exit 1
fi

mkdir -p "$logs_folder"

echo "Script started execution at $(date +"%F %T")" | tee -a "$logs_file"

validate() {
    if [ "$1" -ne 0 ]; then
        echo "${2}..FAILED" | tee -a "$logs_file"
        return 1
    else
        echo "${2}..SUCCESS" | tee -a "$logs_file"
    fi
}

dnf install nginx -y &>> "$logs_file"
validate $? "Nginx Installation" || exit 1

dnf install mysql -y &>> "$logs_file"
validate $? "Mysql Installation" || exit 1

echo "Script execution completed at $(date +"%F %T")" | tee -a "$logs_file"
