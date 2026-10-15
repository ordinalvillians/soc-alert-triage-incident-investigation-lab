# SOC Alert Triage and Incident Investigation Lab

## 1. Objective

Analyse simulated Windows-style authentication events to identify repeated failed logons, accounts with subsequent successful logons, and source IP addresses requiring further review.

## 2. Environment and Data

- Platform: Kali Linux
- Tools: Bash, AWK, and standard Linux utilities
- Dataset: `soc_events.csv`
- Analysis script: `soc_triage.sh`
- Generated output: `triage_report.txt`

All records are simulated for educational purposes. No live systems or real user accounts were investigated.

## 3. Key Findings

### Finding A: Alex — Failed Logons Followed by Success

**Evidence:** Four failed logons for account `alex` from `192.168.1.50`, followed by a successful logon from the same source address.

**Priority:** High review priority under the lab's rule-based threshold.

**Assessment:** The sequence may indicate repeated incorrect password attempts before a successful authentication. It could also result from a legitimate user entering an incorrect password several times.

**Recommended action:** Review the surrounding authentication events, confirm whether the activity was expected, and correlate with available endpoint or identity-provider logs before deciding whether escalation is necessary.

### Finding B: James — Repeated Failed Logons

**Evidence:** Five failed logons for account `james` from `10.0.0.25`. No subsequent successful logon for this account appears in the supplied dataset.

**Priority:** High review priority under the lab's rule-based threshold.

**Assessment:** Repeated failures may indicate a forgotten password, a misconfigured application, or attempted password guessing. The available events do not establish which explanation is correct.

**Recommended action:** Check for additional events, determine whether the source and account activity are expected, and investigate further if the pattern remains unexplained.

### Finding C: Admin — Repeated Failed Logons

**Evidence:** Five failed logons for account `admin` from `203.0.113.45`, with no subsequent successful logon shown in the supplied dataset.

**Priority:** High review priority under the lab's rule-based threshold.

**Assessment:** The repeated failures warrant review in this simulation. The address `203.0.113.45` belongs to a documentation-only IP range and must not be treated as evidence of a real external attacker.

**Recommended action:** In a real investigation, validate the source against the actual environment, check related authentication records, and follow the organisation's escalation procedure if the activity is unexplained.

## 4. Detection Logic

The Bash script uses AWK to:

1. Count failed logons by username.
2. Flag accounts meeting or exceeding a threshold of four failures.
3. identify accounts with a successful logon after previously recorded failures.
4. Count failed logons by source IP address.

The current logic is a basic triage aid. It does not perform identity verification, threat-intelligence lookups, time-window correlation, or automated incident response.

## 5. Limitations

- The dataset is small and simulated.
- Events are processed in file order, so results depend on the records being chronologically arranged.
- The script groups failures by account for its failed-then-success check, rather than proving that every event came from the same source.
- The threshold is configurable and may generate false positives.
- Missing events may affect the conclusions.
- A review priority is not a confirmed incident or proof of malicious intent.

## 6. Conclusion

The lab demonstrates a basic SOC workflow: inspect authentication events, identify patterns, assign review priority, preserve the output, document evidence, and recommend proportionate follow-up.

The findings identify activity for investigation rather than declaring any account compromised.
