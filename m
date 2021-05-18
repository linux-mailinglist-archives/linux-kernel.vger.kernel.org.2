Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB97387E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351017AbhERRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhERRCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:02:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68E4B611CE;
        Tue, 18 May 2021 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621357289;
        bh=uB99eMOXVJVNC+us46Cu6NT371ZIqNz7soRcpBC1kn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iZeX0FS1nrbI0Zmr/w2+0/g6PyC2t3qu/H2AmL0y/JQ03dv0o9axPdeYJ1HGDwTv3
         d+kXV9XmJsLELGIWmjKuhLw50vF/LXH0Fufc2XVl02ZZ8FDfD1ntqsVDQwOh+HTcrI
         Qml/FvaCbQW7c07lL49RfosCEc6wIPaTlXDEtv7LBJClzECLmdOKa2mav5ji1kfPhs
         JOde1VMzFNqRm188+okWQf/f4lyZXbvYDfsyUzttUmkX8AyRia9IzEOG12jSxzS7pd
         Kqvley3r2K/EB7h48N8QErWSVG0uQytjYjmAK6CmXG8cuoggWMQoq6FUoNaqunBMtX
         2keGqLkeeD68w==
Received: by mail-ed1-f49.google.com with SMTP id b17so12098615ede.0;
        Tue, 18 May 2021 10:01:29 -0700 (PDT)
X-Gm-Message-State: AOAM533diTIYteIhoRJ4OykscP6+l5WqwwMqQ4Ttk7wmiXFJ1jd2V1Kp
        pg8jPJMsP7t3Nv3CIh0l3Amq5Exc5ZdFk67JmQ==
X-Google-Smtp-Source: ABdhPJymiFn+zTZgtyn8O3RdwQYyrhfTFds93sFwydQeVx9T9Yvkhf21nM/szw6yd228g8Fa0obWxgXZZl3w7qUPvgU=
X-Received: by 2002:aa7:d893:: with SMTP id u19mr8355852edq.258.1621357288051;
 Tue, 18 May 2021 10:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210518060725.1984-1-zuoqilin1@163.com>
In-Reply-To: <20210518060725.1984-1-zuoqilin1@163.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 May 2021 12:01:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJ6WEbuxWN4hq_OW-hymEP7XfOcJ3p=n=ebZ7TE5N8aw@mail.gmail.com>
Message-ID: <CAL_JsqJJ6WEbuxWN4hq_OW-hymEP7XfOcJ3p=n=ebZ7TE5N8aw@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Assign value when defining variables
To:     zuoqilin1@163.com
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        zuoqilin <zuoqilin@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:07 AM <zuoqilin1@163.com> wrote:
>
> From: zuoqilin <zuoqilin@yulong.com>

We don't take patches against the kernel copy of dtc. They need to go
upstream and to the devicetree-compiler list.

> When defining variables and assigning values can be done at the same time.
>
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  scripts/dtc/util.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
> index 40274fb..d1f7608 100644
> --- a/scripts/dtc/util.c
> +++ b/scripts/dtc/util.c
> @@ -292,7 +292,7 @@ int utilfdt_write_err(const char *filename, const void *blob)
>  {
>         int fd = 1;     /* assume stdout */
>         int totalsize;
> -       int offset;
> +       int offset = 0;
>         int ret = 0;
>         const char *ptr = blob;
>
> @@ -303,7 +303,6 @@ int utilfdt_write_err(const char *filename, const void *blob)
>         }
>
>         totalsize = fdt_totalsize(blob);
> -       offset = 0;

It is possible to exit before this point and the assignment is not
necessary if you do.

>
>         while (offset < totalsize) {
>                 ret = write(fd, ptr + offset, totalsize - offset);
> @@ -421,7 +420,7 @@ void NORETURN util_usage(const char *errmsg, const char *synopsis,
>         const char a_arg[] = "<arg>";
>         size_t a_arg_len = strlen(a_arg) + 1;
>         size_t i;
> -       int optlen;
> +       int optlen = 0;
>
>         fprintf(fp,
>                 "Usage: %s\n"
> @@ -429,7 +428,6 @@ void NORETURN util_usage(const char *errmsg, const char *synopsis,
>                 "Options: -[%s]\n", synopsis, short_opts);
>
>         /* prescan the --long opt length to auto-align */
> -       optlen = 0;

In keeping with doing the assignment as late as possible and just
before needing it, this was correct as is.

>         for (i = 0; long_opts[i].name; ++i) {
>                 /* +1 is for space between --opt and help text */
>                 int l = strlen(long_opts[i].name) + 1;
> --
> 1.9.1
>
>
