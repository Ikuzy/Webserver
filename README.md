# Webserver
Custom HTTP/1.1 web server in C++98 — non-blocking I/O, multiplexing &amp; CGI support

*This project has been created as part of the 42 curriculum by ikuzy, iliassovic2003, Qattami.*
 
---
 
## Description
 
A fully functional **HTTP/1.1 compliant web server** written in **C++98 from scratch**, inspired by the architecture of NGINX. This project dives deep into the fundamentals of network programming, non-blocking I/O, and the HTTP protocol — giving us a real understanding of how the web works under the hood.
 
The server handles real browser requests, supports multiple simultaneous clients, executes CGI scripts, and manages file uploads — all without any external libraries.
 
### Performance
Benchmarked with **Siege** under high load:
- ✅ **95,564 successful transactions**
- ✅ **1,000 concurrent clients**
- ✅ **100% availability**
- ✅ **3,188 requests/sec throughput**
- ✅ **0.31s average response time**
---
 
## Features
 
### Core
- HTTP/1.1 compliant request parsing and response handling
- Non-blocking I/O using `epoll` (with `select`/`poll` support)
- Single `poll()`-equivalent for all I/O operations (clients + listen socket)
- Support for **GET**, **POST**, and **DELETE** methods
- Accurate HTTP response status codes
- Default error pages (400, 403, 404, 405, 413, 500...)
- Static website serving
- File upload support
- Multiple ports and virtual hosts via configuration file
- NGINX-inspired configuration file format
- Directory listing (configurable)
- HTTP redirections
- CGI execution based on file extension (Python, PHP)
### Bonus
- 🍪 Cookie support and session management
- 🔁 Multiple CGI type handling
---
 
## Configuration File
 
The server is configured via a `.conf` file passed as a command-line argument (or a default path if none is provided). Inspired by NGINX's `server` block syntax.
 
Example configuration:
 
```nginx
server {
    listen 8080;
    server_name localhost;
    root ./www;
    index index.html;
    client_max_body_size 10M;
 
    error_page 404 /errors/404.html;
    error_page 500 /errors/500.html;
 
    location / {
        methods GET POST DELETE;
        autoindex off;
    }
 
    location /upload {
        methods POST;
        upload_store ./uploads;
    }
 
    location /cgi-bin {
        methods GET POST;
        cgi_extension .py /usr/bin/python3;
        cgi_extension .php /usr/bin/php-cgi;
    }
}
```
 
---
 
## Installation & Usage
 
### Requirements
- Linux or macOS
- `c++` compiler with C++98 support
- `make`
### Build
 
```bash
git clone https://github.com/ikuzy/webserv.git
cd webserv
make
```
 
### Run
 
```bash
./webserv [configuration_file]
```
 
Example:
 
```bash
./webserv config/default.conf
```
 
### Test in browser
 
```
http://localhost:8080
```
 
### Makefile rules
 
| Rule | Description |
|------|-------------|
| `make` / `make all` | Compile the project |
| `make clean` | Remove object files |
| `make fclean` | Remove object files + binary |
| `make re` | Full recompile |
 
---
 
## Technical Highlights
 
- **No blocking I/O** — every socket operation goes through `epoll`/`poll`/`select`
- **No external libraries** — pure C++98, no Boost
- **No fork** except for CGI execution
- **Chunked transfer decoding** — properly un-chunks requests before passing to CGI
- **Stress-tested** with Siege under 1,000 concurrent clients — 100% availability
---
 
## Resources
 
### HTTP Protocol
- [RFC 2616 — HTTP/1.1](https://www.rfc-editor.org/rfc/rfc2616)
- [RFC 7230 — Message Syntax and Routing](https://www.rfc-editor.org/rfc/rfc7230)
- [MDN Web Docs — HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP)
### Non-blocking I/O & Multiplexing
- [Beej's Guide to Network Programming](https://beej.us/guide/bgnet/)
- [epoll man page](https://man7.org/linux/man-pages/man7/epoll.7.html)
- [The C10K Problem](http://www.kegel.com/c10k.html)
### CGI
- [CGI RFC 3875](https://www.rfc-editor.org/rfc/rfc3875)
### Testing Tools
- [Siege HTTP load testing](https://github.com/JoeDog/siege)
- [curl documentation](https://curl.se/docs/)
 
---
 
## Authors
 
| Login | GitHub |
|-------|--------|
| ikuzy | [@ikuzy](https://github.com/ikuzy) |
| iliassovic2003 | [@iliassovic2003](https://github.com/iliassovic2003) |
| Qattami | [@Qattami](https://github.com/Qattami) |
 
---
 
*42 Network — 1337 School Morocco*
