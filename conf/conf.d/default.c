stream {
    upstream ftp_serve {
        server 0.0.0.0:21 ;
        }
    server {
        listen       8077;
        listen  [::]:8077;
        proxy_pass ftp_serve;
    }
 
 }
