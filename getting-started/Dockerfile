FROM quay.io/quarkus/ubi9-quarkus-micro-image:2.0
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY --chown=1001:root --chmod=0755 target/*-runner /work/application

RUN curl -L -o /usr/local/bin/grafana-agent https://github.com/grafana/agent/releases/download/v0.36.0/grafana-agent-linux-amd64 \
    && chmod +x /usr/local/bin/grafana-agent
COPY agent.yaml /etc/agent.yaml

COPY start.sh /work/start.sh
RUN chmod +x /work/start.sh

EXPOSE 8080
USER 1001

ENTRYPOINT ["/work/start.sh"]
