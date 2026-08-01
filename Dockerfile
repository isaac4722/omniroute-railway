FROM diegosouzapw/omniroute:latest

USER root

WORKDIR /app

RUN mkdir -p /app/data/logs /app/data/db_backups /app/data/tmp && \
    chown -R 1000:1000 /app/data && \
    chmod -R u+rwX /app/data

ENV NODE_ENV=production
ENV PORT=20128
ENV HOSTNAME=0.0.0.0
ENV DATA_DIR=/app/data

USER 1000

CMD ["node", "server.js"]
