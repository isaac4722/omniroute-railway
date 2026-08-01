# OmniRoute Railway Dockerfile - Versión corregida
FROM diegosouzapw/omniroute:latest-web

# Trabajar como root para preparar permisos
USER root

WORKDIR /app

# Crear directorios necesarios DURANTE EL BUILD (esto es clave)
RUN mkdir -p /app/data/logs /app/data/db_backups /app/data/tmp && \
    chown -R 1000:1000 /app/data && \
    chmod -R u+rwX /app/data && \
    chmod 755 /app

# Variables de entorno explícitas
ENV NODE_ENV=production
ENV PORT=20128
ENV HOSTNAME=0.0.0.0
ENV DATA_DIR=/app/data
ENV APPDATA=/app/data

# Cambiar al usuario de la app
USER 1000

# Healthcheck CORRECTO (override del endpoint roto original)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD node -e "fetch('http://localhost:20128/v1/health').then(r => { if (r.ok) process.exit(0); else process.exit(1); }).catch(() => process.exit(1))"

# Comando de arranque
CMD ["node", "server.js"]
