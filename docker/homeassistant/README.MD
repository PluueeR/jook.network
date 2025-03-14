# Home Assistant in Docker with SSL using Nginx

You can use the ``docker-compose.yml`` file to deploy Home Assistant in Docker. Home Assistant requires network mode to be set to host for device discovery to work properly. You can this container together with an [Nginx](https://github.com/PluueeR/jook.network/tree/main/docker/nginx) container to make Home Assistant available over SSL/TLS for secure access.

## Trusted proxies 

When using SSL/TLS, you need to allow Nginx to set the X-Forwarded-For header. Therefore, you need to add the following lines to ``configuration.yaml``:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - <your_subnet_here>
```
Note: Nginx is running in a container with a custom bridge network. You need to insert the subnet of this bridge network, which can be found using ``docker network inspect <your_network>``.
