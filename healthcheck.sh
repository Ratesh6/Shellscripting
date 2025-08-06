#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="healthlog.txt"

{
  echo "======================================"
  echo " System Health Check – $TIMESTAMP"
  echo "======================================"

  echo ""
  echo " Date & Time:"
  date

  echo ""
  echo " Uptime:"
  uptime 2>/dev/null || echo "Uptime not available"

  echo ""
  echo " CPU Load:"
  uptime | awk -F'load average:' '{ print $2 }' 2>/dev/null || echo "CPU load info not available"

  echo ""
  echo " Memory Usage (MB):"
  free -m 2>/dev/null || echo "free command not available"

  echo ""
  echo " Disk Usage:"
  df -h

  echo ""
  echo " Top 5 Memory‑Consuming Processes:"
  ps aux --sort=-%mem | head -n 6 2>/dev/null || echo "Process info not available"

  echo ""
  echo " Service Status:"
  if [ "$#" -eq 0 ]; then
    echo "No services were specified to check."
  else
    for SERVICE in "$@"; do
      if ps aux | grep -v grep | grep -w "$SERVICE" &> /dev/null; then
        echo "$SERVICE: running"
      else
        echo "$SERVICE: not running or not found"
      fi
    done
  fi

  echo "======================================"
  echo ""
} >> "$LOGFILE"

echo " Health check complete. Logged to $LOGFILE"
