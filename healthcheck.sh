#!/bin/bash

LOG_FILE="healthlog.txt"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

SERVICES=("sshd.exe" "nginx.exe")  # Adjust names to actual processes on Windows

{
    echo "=============================================="
    echo "System Health Check - $TIMESTAMP"
    echo "=============================================="

    echo -e "\n🕒 Date & Time:"
    date

    echo -e "\n🔁 Last Reboot Time:"
    who -b 2>/dev/null || echo "Not available"

    echo -e "\n📊 CPU Load:"
    cat /proc/loadavg 2>/dev/null || echo "Load info not available"

    echo -e "\n💾 Memory Usage:"
    grep -E 'Mem|Swap' /proc/meminfo 2>/dev/null || echo "Memory info not available"

    echo -e "\n🗃️ Disk Usage:"
    df -h

    echo -e "\n🔥 Top Memory-Consuming Processes:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem 2>/dev/null | head -n 6 || ps -e

    echo -e "\n🔍 Service Status:"
    for service in "${SERVICES[@]}"; do
        if ps aux | grep -i "[${service:0:1}]${service:1}" > /dev/null; then
            echo "$service is running"
        else
            echo "$service is NOT running"
        fi
    done

    echo -e "\n==============================================\n"

} >> "$LOG_FILE"
