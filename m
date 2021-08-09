Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761653E467D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhHIN03 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Aug 2021 09:26:29 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:37572 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhHIN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:26:27 -0400
Received: by mail-vs1-f42.google.com with SMTP id a8so10018269vsl.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bb5vDHnenDIwQS7FU/7KReEJ0SSOJsXa1YQK1ADVnf0=;
        b=QR6D8sX1vnCOid55cyxCHSL6700akiucTQ1B5o7xZSgDfukecJuIGrLsDLj0EXT4nQ
         l0tq5Vt/HvEg0uZN/E0xINvRDDojAfrknnOfxCiwxpfHnc7eEBjCZVDsnh8i12QQzmJ/
         jAZchEM4KNajq11lxm0D0r3Bu+rCNxLIh759to6xSjZxEcBZs9mpjQKgJDDOWzZrT4yB
         NtvEXeRTeDZGVm+vK/nAYevVc46TkkNU49YMYF+0SlXHplJrU7GX7uTTp7ZD13ZIHbM1
         DyszZWBzI/WCf3phbJQk+av/6U+2Zl+y07x38sL2cuQJzX150ek1l9zCugW06OfSjjj4
         yUqg==
X-Gm-Message-State: AOAM531cfbn4x/WyS+p+L7Tfz/C/0XlTqvf+4aI1bfS11qC9gM64kb3u
        ATP2UFyNbMuvDa/HV8VslDNko0OqCjOz+7M2Ll8=
X-Google-Smtp-Source: ABdhPJwgTx/pUeAft1dPT5ijyQHqxDE7CG3c2jLJAIXlExXxSK1gELGae1Q/Ka0nRxrKwR5r/2yDWGyQZjdlI/lbnLo=
X-Received: by 2002:a05:6102:d9:: with SMTP id u25mr7147062vsp.42.1628515566662;
 Mon, 09 Aug 2021 06:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de> <20210730191035.1455248-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210730191035.1455248-5-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 15:25:54 +0200
Message-ID: <CAMuHMdU28k_eAaPoZ8Fzoxv-p=vT6jtuNmGkE79DsLc=-aeRhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] zorro: Drop useless (and hardly used) .driver
 member in struct zorro_dev
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Fri, Jul 30, 2021 at 9:10 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The only actual use is to check in zorro_device_probe() that the device
> isn't already bound. The driver core already ensures this however so the
> check can go away which allows to drop the then assigned-only member
> from struct zorro_dev.
>
> If the value was indeed needed somewhere it can always be calculated by
>
>         to_zorro_driver(z->dev.driver)
>
> .
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your patch!

> --- a/drivers/zorro/zorro-driver.c
> +++ b/drivers/zorro/zorro-driver.c
> @@ -47,16 +47,14 @@ static int zorro_device_probe(struct device *dev)
>         struct zorro_driver *drv = to_zorro_driver(dev->driver);
>         struct zorro_dev *z = to_zorro_dev(dev);
>
> -       if (!z->driver && drv->probe) {
> +       if (drv->probe) {
>                 const struct zorro_device_id *id;
>
>                 id = zorro_match_device(drv->id_table, z);
>                 if (id)
>                         error = drv->probe(z, id);
> -               if (error >= 0) {
> -                       z->driver = drv;
> +               if (error >= 0)

I guess this test can become "> 0" now, but that doesn't matter much.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>                         error = 0;
> -               }
>         }
>         return error;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
