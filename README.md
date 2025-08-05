
This project contains a Bash script (`healthcheck.sh`) that performs a basic system health check and logs the output into a file named `healthlog.txt`.

---

## 📌 Features

The script captures and logs the following system information:

- 🕒 Current system date and time
- ⏳ System uptime
- 📊 CPU load average
- 💾 Memory usage (`free -m`)
- 🗂️ Disk usage (`df -h`)
- 🔥 Top 5 memory-consuming processes
- 🔍 Status of key services (e.g. `nginx`, `ssh`)
