# Home Assistant with SSL using nginx as reverse proxy

You can use the ``docker-compose.yml`` file to deploy Home Assistant in Docker. Home Assistant requires network mode to be set to host for device discovery to work properly. You can this container together with an Nginx container to make Home Assistant available over SSL/TLS for secure access.

## Trusted proxies 

In order to allow nginx to set the X-Forwarded-For header you need to add the following lines to configuration.yaml:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.18.0.0/16
```
