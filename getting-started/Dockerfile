FROM eclipse-temurin:17-ubi10-minimal
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY --chown=1001:root --chmod=0755 target/*-runner /work/application

COPY agent.yaml /etc/agent.yaml

USER root
RUN microdnf install -y curl unzip \
    && curl -L -o grafana-agent.zip https://github.com/grafana/agent/releases/tag/v0.44.2/grafana-agent-linux-amd64.zip \
    && unzip grafana-agent.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/grafana-agent \
    && rm grafana-agent.zip \
    && microdnf clean all
USER 1001

COPY start.sh /work/start.sh
RUN chmod +x /work/start.sh

EXPOSE 8080
USER 1001

ENTRYPOINT ["/work/start.sh"]
