# SOC Alert Triage and Incident Investigation Lab

## Overview

This project demonstrates a beginner-level Security Operations Centre (SOC) workflow using simulated authentication events.

A Bash script uses AWK to identify repeated failed logons, flag accounts for review, detect successful logons following earlier failures, and summarise failed logons by source IP.

The project focuses on evidence-based triage and documentation rather than automatically declaring an incident.

## Objectives

- Analyse simulated authentication events.
- Identify repeated failed logons by account.
- Flag accounts meeting a configurable review threshold.
- Identify successful logons following earlier failures.
- Summarise failed logons by source IP address.
- Document findings, limitations, and recommended investigative actions.

## Tools and Technologies

- Kali Linux
- Bash
- AWK
- Linux command-line utilities
- Git and GitHub

## Project Files

| File | Purpose |
|---|---|
| `soc_events.csv` | Simulated authentication-event dataset |
| `soc_triage.sh` | Script that analyses the event records |
| `triage_report.txt` | Saved output from the script |
| `investigation_findings.md` | Investigation findings and recommended actions |

## How to Run

Clone or download this repository, then open a terminal in the project directory.

Run the analysis script:

```bash
bash soc_triage.sh
```

To save and display the output simultaneously:

```bash
bash soc_triage.sh | tee triage_report.txt
```

The script uses a threshold of four failed logons to assign a high review priority. This is a configurable demonstration rule, not a universal security standard.

## Sample Findings

The simulated dataset contains:

- Four failed logons for `alex`, followed by a successful logon from the same source IP.
- Five failed logons for `james`, with no subsequent success shown in the sample.
- Five failed logons for `admin`, with no subsequent success shown in the sample.

These patterns warrant review in the context of the exercise but do not establish malicious activity.

## Limitations and Responsible Use

- All events are simulated and intended for educational use.
- The IP address `203.0.113.45` is reserved for documentation and is not evidence of a real attacker.
- The script relies on the supplied records and their order.
- A successful logon following failures does not prove that an account was compromised.
- The script does not connect to a live SIEM, perform threat-intelligence lookups, or take automated response actions.

## Learning Outcomes

This project demonstrates foundational skills in log analysis, Bash scripting, pattern identification, alert triage, evidence documentation, and communicating uncertainty during an investigation.
