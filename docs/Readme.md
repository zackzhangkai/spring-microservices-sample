# 关于本项目

1. 使用Zuul网关，gateway-service
2. 使用Eureka做服务发现，可以发现平台所有的服务，discovery-service


# 关于微服务SpringCloud

Springcloud Netfix 最流行的SpringCloud框架，服务发现Eureka，熔断器Hystrix，风关Zuul，负载均衡Ribbon 

SpringCloud Alibaba也开源了一套微服务框架，可以替换SpringCloud Netfix，但并不能完全替换，如负载均衡仍然使用Ribbon。但是Netfix的注册中心Eureka可以被Nacos替换。 

Nacos (Dynamic Naming and Configuration Service) is an easy-to-use platform designed for dynamic service discovery and configuration and service management

Nacos的作用：服务发现、分布式配置、动态DNS 

SpringCloud Alibaba还开源了Sentinel组件，负责流量控制、并发、熔断、过载保护。

OpenFeign rest 客户端

GraphQL  API查询语言，支持多种开发语言，自动将string查询语句转换成与你语言相适应的API格式


