Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC0441D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhKAPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhKAPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635780159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQZUXEVknM1x6gD034o1wJaC0m0owlPWAjH/V8D3Rf4=;
        b=HvPMYqQI9zDBTenKUcbzhtCmEu4MHwXQn+U+Os6gpQ6NtmzN1gy516l75n88VAYlMJdLs1
        y3sLd2lDtY3tgozw83TVP8d1nSzghvzBSj03xMqvkAyTLyQLIwDOJknophELQerA7EFO8D
        jNFgWKlDuIB0jPg8qHe7MEtx37gMdeg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-1vbceUUeNdiTlIsyXJPTnA-1; Mon, 01 Nov 2021 11:22:38 -0400
X-MC-Unique: 1vbceUUeNdiTlIsyXJPTnA-1
Received: by mail-ed1-f69.google.com with SMTP id q6-20020a056402518600b003e28d92bb85so2487541edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQZUXEVknM1x6gD034o1wJaC0m0owlPWAjH/V8D3Rf4=;
        b=7FBYaJ6KK0PP6FGLnaIcl8kw7tITtE4XVnZKzBXMhlxtft7xiubXho+b+twwO6FAJy
         xlrHi+2yBfsqQqETYjiZCxOqVdW5ylsN+QCWew6zzvHaMaCRKn1+vp41GKcu6Prkx7YC
         2ylLEjlIbizSva7Pj2OIP8KtvbYsmhaxVy8ASC4Q8eTCvvN/RTWNDdhz4X3iizMDWe0L
         PNw+6SmFzVdlCQDAWijfElnH3TX1SRR327ma5SyjJG79Zkq/vOpgcgbgkyCH7y52JDly
         EIanTsuxifOSuO0iZmGXJN54EAeRPWfXkOTpVB4riup9VTJPi7etrqVN5JZkbdVKVVqV
         HU1w==
X-Gm-Message-State: AOAM532gdxTnJlLXmjvckexvDEiSai9ooJ1EDpDNqsJWNsnUReJEvV+W
        AOIFQZo6iHZ/kqfHhiV/zgJ5vpz6tftO54LoF/JfH+hgl52H1g6hQuiN2dr/YyD97DbAjmx1YNu
        74XjAwcjx34feCwh4fUXRk4Fl/0porTtiJ2npYOlh
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr41863980edb.362.1635780156584;
        Mon, 01 Nov 2021 08:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9/8bBy+bfKsQhX7AWrOKUXtx84RuYwNZOIswboO7NXs9kV/VhVh+l9BKSNs4hSyYi4RtoRSelAfV3r+1ObYU=
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr41863947edb.362.1635780156358;
 Mon, 01 Nov 2021 08:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
In-Reply-To: <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 1 Nov 2021 12:22:25 -0300
Message-ID: <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     wander@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em s=C3=A1b., 30 de out. de 2021 04:41, Andy Shevchenko
<andy.shevchenko@gmail.com> escreveu:
>
>
>
> On Friday, October 29, 2021, <wander@redhat.com> wrote:
>>
>> From: Wander Lairson Costa <wander@redhat.com>
>>
>> Note: I am using a small test app + driver located at [0] for the
>
>
> I don't see any links.

Oops, sorry about that. I must have accidentally deleted it while
editing the commit message.
Here it is https://github.com/walac/serial-console-test.
I will update the patch with the link.

> While at it, why can't you integrate your changes to [1], for example?
>
> [1]: https://github.com/cbrake/linux-serial-test
>
First of all, I was not aware of it, but afaik, /dev/ttyS doesn't
follow the same code path as
printk, which was my main goal here (I should have made this clear in
the commit message, my bad).


>

[snip]

>>
>
>
> On how many different UARTs have you tested this? Have you tested oops an=
d NMI contexts?
>
I only tested in a half dozen machines that I have available. I tried
it in panic, warnings, IRQ contexts, etc. Theoretically, this change
should not be affected by the context. Theoretically...

> What I would like to say here is that the code is being used on zillions =
of different 8250 implementations here and I would be rather skeptical abou=
t enabling the feature for everyone.
>
I did my homework and studied the 16550 datasheets, but yes, there is
always this risk. Maybe people more experienced with PC serial ports
than me might think the patch is not worth the risk of breaking some
unknown number of devices out there, and I am ok with that. It is a
valid point.


>>
>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>> ---
>>  drivers/tty/serial/8250/8250_port.c | 61 ++++++++++++++++++++++++++---
>>  1 file changed, 55 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/82=
50/8250_port.c
>> index 66374704747e..edf88a8338a2 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2063,10 +2063,7 @@ static void serial8250_break_ctl(struct uart_port=
 *port, int break_state)
>>         serial8250_rpm_put(up);
>>  }
>>
>> -/*
>> - *     Wait for transmitter & holding register to empty
>> - */
>> -static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>> +static void wait_for_lsr(struct uart_8250_port *up, int bits)
>>  {
>>         unsigned int status, tmout =3D 10000;
>>
>> @@ -2083,6 +2080,16 @@ static void wait_for_xmitr(struct uart_8250_port =
*up, int bits)
>>                 udelay(1);
>>                 touch_nmi_watchdog();
>>         }
>> +}
>> +
>> +/*
>> + *     Wait for transmitter & holding register to empty
>> + */
>> +static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>> +{
>> +       unsigned int tmout;
>> +
>> +       wait_for_lsr(up, bits);
>>
>>         /* Wait up to 1s for flow control if necessary */
>>         if (up->port.flags & UPF_CONS_FLOW) {
>> @@ -3319,6 +3326,35 @@ static void serial8250_console_restore(struct uar=
t_8250_port *up)
>>         serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
>>  }
>>
>> +/*
>> + * Print a string to the serial port using the device FIFO
>> + *
>> + * It sends fifosize bytes and then waits for the fifo
>> + * to get empty.
>> + */
>> +static void serial8250_console_fifo_write(struct uart_8250_port *up,
>> +               const char *s, unsigned int count)
>> +{
>> +       int i;
>> +       const char *end =3D s + count;
>> +       unsigned int fifosize =3D up->port.fifosize;
>> +       bool cr_sent =3D false;
>> +
>> +       while (s !=3D end) {
>> +               wait_for_lsr(up, UART_LSR_THRE);
>> +
>> +               for (i =3D 0; i < fifosize && s !=3D end; ++i) {
>> +                       if (*s =3D=3D '\n' && !cr_sent) {
>> +                               serial_out(up, UART_TX, '\r');
>> +                               cr_sent =3D true;
>> +                       } else {
>> +                               serial_out(up, UART_TX, *s++);
>> +                               cr_sent =3D false;
>> +                       }
>> +               }
>> +       }
>> +}
>> +
>>  /*
>>   *     Print a string to the serial port trying not to disturb
>>   *     any possible real use of the port...
>> @@ -3334,7 +3370,7 @@ void serial8250_console_write(struct uart_8250_por=
t *up, const char *s,
>>         struct uart_8250_em485 *em485 =3D up->em485;
>>         struct uart_port *port =3D &up->port;
>>         unsigned long flags;
>> -       unsigned int ier;
>> +       unsigned int ier, use_fifo;
>>         int locked =3D 1;
>>
>>         touch_nmi_watchdog();
>> @@ -3366,7 +3402,20 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
>>                 mdelay(port->rs485.delay_rts_before_send);
>>         }
>>
>> -       uart_console_write(port, s, count, serial8250_console_putchar);
>> +       use_fifo =3D (up->capabilities & UART_CAP_FIFO)
>> +               && port->fifosize > 1
>> +               && (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIF=
O)
>> +               /*
>> +                * After we put a data in the fifo, the controller will =
send
>> +                * it regardless of the CTS state. Therefore, only use f=
ifo
>> +                * if we don't use control flow.
>> +                */
>> +               && !(up->port.flags & UPF_CONS_FLOW);
>> +
>> +       if (likely(use_fifo))
>> +               serial8250_console_fifo_write(up, s, count);
>> +       else
>> +               uart_console_write(port, s, count, serial8250_console_pu=
tchar);
>>
>>         /*
>>          *      Finally, wait for transmitter to become empty
>> --
>> 2.27.0
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

