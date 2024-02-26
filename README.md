# Overview

 This project provides automation scripts and an Ansible playbook to deploy PostgreSQL, Pgweb (a web-based PostgreSQL database browser), Prometheus, and Grafana for monitoring purposes. By using these tools, you can gain insights into your PostgreSQL database's performance, query execution, and resource utilization.

## Features

    - Automated deployment of PostgreSQL database.
    - Installation and configuration of Pgweb for easy database browsing.
    - Setup of Prometheus for collecting database metrics.
    - Integration with Grafana for visualizing PostgreSQL performance metrics.
    - test database and data for  debugging

## Getting Started

You can run the project using the provided automate.sh script or the Ansible playbook.

``` git clone https://github.com/yourusername/postgresql-pgweb.git ```


``` cd postgresql-pgweb ```

``` ./automate.sh ```


## Using Ansible Playbook

``` ansible-playbook ansible-playbook.yml ```
