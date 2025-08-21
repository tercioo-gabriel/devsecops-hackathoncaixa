#!/bin/bash
# Inicia Quarkus
./application -Dquarkus.http.host=0.0.0.0 &

# Inicia Grafana Agent
grafana-agent -config.file=/etc/agent.yaml &

# Espera os processos terminarem
wait
