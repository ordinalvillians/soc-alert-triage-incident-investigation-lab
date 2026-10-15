#!/bin/bash

set -euo pipefail

LOG_FILE="soc_events.csv"
THRESHOLD=4

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: $LOG_FILE not found."
    exit 1
fi

echo "======================================"
echo " SOC ALERT TRIAGE REPORT"
echo "======================================"
echo

echo "1. FAILED LOGONS BY ACCOUNT"
echo "--------------------------------------"

awk -F',' -v threshold="$THRESHOLD" '
    NR > 1 && $2 == 4625 {
        failures[$3]++
    }
    END {
        for (user in failures) {
            priority = (failures[user] >= threshold) ? "HIGH REVIEW" : "LOW REVIEW"
            printf "%-12s %2d failures  %s\n", user, failures[user], priority
        }
    }
' "$LOG_FILE" | sort

echo
echo "2. ACCOUNTS WITH FAILED LOGONS FOLLOWED BY SUCCESS"
echo "--------------------------------------"

awk -F',' '
    NR > 1 {
        user = $3

        if ($2 == 4625) {
            failures[user]++
        }

        if ($2 == 4624 && failures[user] > 0) {
            printf "%-12s %d prior failures; later success recorded\n", user, failures[user]
            failures[user] = 0
        }
    }
' "$LOG_FILE"

echo
echo "3. FAILED LOGONS BY SOURCE IP"
echo "--------------------------------------"

awk -F',' '
    NR > 1 && $2 == 4625 {
        failures[$4]++
    }
    END {
        for (ip in failures) {
            printf "%-18s %2d failures\n", ip, failures[ip]
        }
    }
' "$LOG_FILE" | sort -k2,2nr

echo
echo "Triage complete."
echo "Review priority is a rule-based indicator, not proof of malicious activity."
