### Deploying Elastic Stack on a Single Node with Custom FortiDragon Logstash Configurations

This project sets up a single-node Elastic Stack installation, where Elasticsearch, Kibana, and Logstash are installed on a single VM using Ansible. This configuration does not include Filebeat or Metricbeat for Elasticsearch logs and health monitoring in order to save CPU and RAM resources.

The implementation also includes Fleet Server configuration with agent policy creation. Additionally, built-in and Sigma rules are uploaded to the security solution. The Sigma rule upload may take a while due to incorrect Sigma syntax in the official repository. The tool sigma-cli converts and saves each rule.

Special thanks to enotspe’s FortiDragon (https://github.com/enotspe/fortinet-2-elasticsearch) project, which provides custom Logstash pipelines and templates to help parse FortiGate syslogs. There are two log parsing methods available. If you wish to implement the older, deprecated version based on FortiDragon’s project, simply run this Ansible playbook as is. If you prefer to use the new method with a custom UDP log collector, comment out "Setup Logstash" and uncomment "Setup FortiDragon pipelines" in roles/elk_vm/tasks/main.yml.
For updates to the FortiDragon project, you can test them by updating the repo in roles/elk_vm/tasks/setup/setup_fortidragon_pipelines.yml — note that the implementation is based on FortiDragon fork with some changes.

Make changes to the roles/elk_vm/vars/main.yml config file to modify the VM interface and network information.

### Acknowledgment

The Logstash implementation with custom FortiDragon pipelines, ILM, template components, and index templates was developed by enotspe (https://github.com/enotspe/fortinet-2-elasticsearch), licensed under the Apache 2.0 License. The configurations of these components are saved in this repo to simplify the implementation.
