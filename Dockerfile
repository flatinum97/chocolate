FROM alpine:latest as builder

RUN apk add --update --no-cache mingw-w64-gcc && \
      mkdir /usr/local/build

COPY . /usr/local/src

WORKDIR /usr/local/src

RUN x86_64-w64-mingw32-gcc -Wall -Wextra -e efi_main -nostdinc -nostdlib \
      -fno-builtin -Wl,--subsystem,10 -o /usr/local/build/main.efi main.c

FROM alpine:latest

RUN mkdir /usr/local/efi

COPY --from=builder /usr/local/build /usr/local/efi

CMD ["/bin/true"]
