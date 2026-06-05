#!/bin/bash

echo "=============================="
echo "   SYSTEM MONITORING TOOL"
echo "=============================="

# Thresholds
DISK_THRESHOLD=1
MEM_THRESHOLD=80
LOG_FILE="system_alert.log"

echo ""
echo "🔍 Checking Disk Usage..."

disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage: $disk_usage%"

if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    echo "⚠️ ALERT: Disk usage is high!"
    echo "$(date) - Disk usage: $disk_usage%" >> $LOG_FILE
fi

echo ""
echo "🔍 Checking Memory Usage..."

mem_usage=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

echo "Memory Usage: $mem_usage%"

if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    echo "⚠️ ALERT: Memory usage is high!"
    echo "$(date) - Memory usage: $mem_usage%" >> $LOG_FILE
fi

echo ""
echo "🔍 Top CPU Processes:"
ps -eo pid,cmd,%cpu --sort=-%cpu | head -5

echo ""
echo "🔍 Top Memory Processes:"
ps -eo pid,cmd,%mem --sort=-%mem | head -5

echo ""
echo "=============================="
echo "Monitoring Completed"
echo "=============================="
