# Nohost Docker

## Getting Started

### Installing

```
docker pull kaiye/nohost
```

### Running

Use the `-d` to run the image in a detached mode, and use the `-p` to map your host port to the docker container's port.

```
docker run -d -p 8080:8080 kaiye/nohost
```

If you want to custom the service's name and domain, follow the example below.

```
docker run -d -p 8080:8080 kaiye/nohost -h bugle.yekai.net -n Bugle
```

### Entrypoint Arguments

All arguments are optional, please check the default value.

- `-n` Nohost service name, default name is `Nohost`
- `-u` Admin username, default value is `admin`
- `-p` Admin password, default `admin123`
- `-h` Nohost server domain
- `-e` Extra Data pass to the whistle proccess, for guest account setting
- `-l` Print the command string at starting
- `-d` Disable the guest account

### SSL Certificate

If you have the SSL certificate key files for some domains, you can put them together in a directory and mount the directory into the docker container by the volumes command. For example, rename your `.key` and `.crt` files as the same base name by domain, and put them into the directory `/www/ssl`, use the `-v` option as below.

```
docker run -d -p 8080:8080 -v /www/ssl:/data/ssl kaiye/nohost
```

Nohost service will load all the SSL Certificates in `/data/ssl` of the docker container automatically when docker start.

As a result, Whistle can decode all the requests in the SSL connection of the domain.



### Set the Guest Account

Guest account is setup for browsering all the requests which captured by nohost. The default guest account's username and password are `guest`.

If you want to disable the guest account use the `-d` flag when running docker.

For setting a new guest account, for example, username `guest` and password `123456`, get the escaped string by JavaScript as below:

```javascript
encodeURIComponent(JSON.stringify({
  nohost: {
    guestName: 'guest',
    guestPassword: '123456'
  }
}))
```

And use the `-e` options to pass the configuration into the docker container.

```
docker run -d kaiye/nohost -e %7B%22nohost%22%3A%7B%22guestName%22%3A%22guest%22%2C%22guestPassword%22%3A%22123456%22%7D%7D 
```

## Docs

### Whistle

Nohost is built on whistle, for more details, please check out [Whistle Docs](https://wproxy.org/whistle/). 


### Nohost

Nohost has it's own rules. Such as, use the `@` rule to reuse all the rules between different Nohost account.

There is a Nohost Environment Select Panel, use the following rule to inject the Panel into all the HTML pages under the domain.

```
whistle.nohost:// example.com
```



## Contributing

Please feel free to open an issue at the [Github repository](http://github.com/kaiye/dockerfile) when you meet some problem or have any suggestion about this docker service.

If you have any question about Whistle, please join the Whistle QQ Group, the group number is: 462558941



## License

This project is licensed under the MIT License.



## Acknowledgments

- [Avwo](https://github.com/avwo/whistle), author of Whistle.
- [IMweb team](https://imweb.io/), maintainer of [whistle.nohost](https://www.npmjs.com/package/whistle.nohost) plugin.