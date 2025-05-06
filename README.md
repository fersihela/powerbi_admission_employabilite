Power BI Admission Dashboard
Overview
This Power BI project, developed for the Business Intelligence course at Esprit School of Engineering, visualizes key performance indicators (KPIs) for student admissions using data from a PostgreSQL database (ADMISSION_DW_NEW). It leverages DAX and M queries to create interactive dashboards. Esprit School of Engineering.
Features

Interactive KPIs for admission success rates
Data transformations with M queries
Custom calculations with DAX
Versioned with Git LFS for efficient .pbix management

Tech Stack

Power BI Desktop: Visualization tool
DAX: Data Analysis Expressions
M: Query language
PostgreSQL: Data source
GitHub: Version control

Directory Structure
powerbi_project/
- reports/: Power BI files (.pbix)
- scripts/dax/: DAX measures
- scripts/m/: M queries
- docs/: Documentation
- tests/: Validation scripts

Getting Started

Clone the repository: git clone https://github.com/yourusername/powerbi_project
Install Git LFS: git lfs install
Pull LFS files: git lfs pull
Open reports/admission_dashboard.pbix in Power BI Desktop
Configure PostgreSQL connection using .env

Security

Database credentials are stored in .env (not versioned).
Repository access is restricted to authorized collaborators.

Backup

Local backups are created weekly to ~/Backups/.
GitHub serves as a cloud backup.

Acknowledgments
Developed under the supervision of Professor Name at Esprit School of Engineering. Presented at the Esprit Data Summit 2025.
