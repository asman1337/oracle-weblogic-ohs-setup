---

# Setting Up Oracle HTTP Server with Oracle WebLogic Server

## Introduction
This guide provides detailed steps for installing Oracle HTTP Server (OHS) and configuring it to work with Oracle WebLogic Server. This setup is particularly useful for managing web applications and services using Oracle's robust infrastructure.

**Note:** This guide assumes the use of the `opc` system username and the Oracle Home directory at `/home/opc/Oracle/Middleware/Oracle_Home`. These paths may vary based on your specific installation and system setup. `The procedure is tested with Oracle Linux 7.9.`

## Prerequisites
- Linux-based operating system (preferably Oracle Linux, openSUSE, Fedora, RHEL, or Ubuntu/Debian)
- Sudo or root access on the machine

## Step 1: Preparing the Operating System
Execute the `prepare_os.sh` script to install the required dependencies. This script identifies your Linux distribution and installs the appropriate packages.

## Step 2: Installing Java Development Kit (JDK)
1. **Check Java Installation:** The `setup.sh` script checks if Java is installed on the system.
2. **Automatic JDK Installation:** If Java is not found, and the OS is openSUSE or RHEL, the script will download and install JDK 8 automatically.

## Step 3: Downloading and Installing Middleware Components
1. **Middleware Infrastructure:**
   - Run `setup.sh --in` to install the Middleware Infrastructure.
   - The script manages downloading, unzipping, and installation.
2. **Oracle HTTP Server (OHS):**
   - Install OHS by running `setup.sh --ohs`.
   - The script takes care of the download, unzipping, and installation process.

## Step 4: Configuring the Environment
After installing both Middleware Infrastructure and OHS in collocated mode:

1. **Set QS_TEMPLATES Environment Variable:**
   ```bash
   export QS_TEMPLATES=/home/opc/Oracle/Middleware/Oracle_Home/wlserver/common/templates/wls/wls_jrf.jar
   ```
2. **Run Configuration Scripts:**
   - Navigate to `/home/opc/Oracle/Middleware/Oracle_Home/oracle_common/common/bin`.
   - Execute `qs_config.sh` followed by `config.sh`.
   - During the `config.sh` execution, create an OHS system component and add it to a Unix machine as part of the domain configuration.

## Step 5: Starting the Services
1. **Start Node Manager:**
   - Navigate to `/home/opc/Oracle/Middleware/Oracle_Home/user_projects/domains/base_domain/bin`.
   - Run `./startNodeManager.sh > node.out 2>&1 &`.
2. **Start WebLogic Server:**
   - Execute `./startWebLogic.sh > web.out 2>&1 &`.
3. **Access the Enterprise Manager (EM) Console:**
   - Once WebLogic Server is up, manage your domain through the EM console.
4. **Start Oracle HTTP Server:**
   - Start OHS using either `./startComponent.sh ohsName` or from the EM console.

## Conclusion
Following these instructions will successfully set up Oracle HTTP Server with Oracle WebLogic Server on a Linux-based system. This environment is ideal for deploying and managing web applications using Oracle's technologies.

---

## Contact
- **Developer:** Asman Mirza
- **Email:** rambo007.am@gmail.com
- **Date:** 29 January, 2024

---
