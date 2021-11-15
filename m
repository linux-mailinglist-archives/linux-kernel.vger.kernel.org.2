Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB06450560
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhKON3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhKON2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:28:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D48C061204
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:25:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z10so45386919edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6SA1RRfPRQsyPoxGMHruqyhNm/ud8FtPEsb7q99xAA=;
        b=HsTLOFEHoVqdXzo2g9yYpRz3UHtI7vR6zXlVLrnfleNah5CX6l3Oj2fXz2YhS0id2i
         Vi0yZiNiQgz8v3OHGlMItd4JY7+XmfCX6mTiHICp1eCimqLgfbL5EA/AcLCJHJZmVFuI
         VtJDZXuSLTtE50Wl76NGyauY9WiP4OWTYZW9oJsofjFap8MqCwNNtLJ4gdhLpR+Q3GF/
         vCOZP9nbUeUP7pxXG/Nfg7HVlwYBdlyqilCE2tF7PyAHZc4Fui3XZoHsRxwV2aJjHMHK
         li8rZWPJOoAFC3NEkQU1fmMXdy54f3Dy5xEdh7/KiuqgJBe/CRPLxs7JMiKnvVDUg+bV
         gu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6SA1RRfPRQsyPoxGMHruqyhNm/ud8FtPEsb7q99xAA=;
        b=O4e/pWXdONmFeO3mLo7Ce+Jq+GW9wRTRIA+8+dxM2Uo4g8z1f6OsZv52mXBaSgGN84
         1UlpxVPP8W0dGqYWadz1QUUzHcZA/WazHFEdEPQLmNMh9INJv+YjscdPZoWbz92bQUfr
         VnCrjGeATAw8p7k1FRgKylmNA5iAdbVKL0RCd7nqkvw0B9BWJ88+yTYHWJYDkUtxqFuk
         Eai2vmFzH4T3a+baU9vKYlp+WKE/nu+TQR5S2TV4UVYaaY3bxhrjucfjw73uFlQQUlQy
         2AxcE2GovpbccHKEV1JfUOFi5hxskHYkRnLypnu9YEQ5B4+Uu2/ArGqVy7ZFGHN9TijV
         +pMw==
X-Gm-Message-State: AOAM5328ne/j9R7v0kUxXFdPj+6uOp7MlLtKazZmygQVr5iiu6rlT05X
        z08h1tHWrRYemcRB0wGeINCHa5xKC7RMadvP+VIXHw==
X-Google-Smtp-Source: ABdhPJyaC521tT2BTB8Z5L9QDooodl4iPZm2LpVpGe626jrcmpdc+jZsnaeDMKL14AYvz/H5qbzuqPgs9WbCslaAVqk=
X-Received: by 2002:a17:907:1deb:: with SMTP id og43mr48620799ejc.189.1636982733866;
 Mon, 15 Nov 2021 05:25:33 -0800 (PST)
MIME-Version: 1.0
References: <1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Nov 2021 14:25:23 +0100
Message-ID: <CAMRc=Mess=fKf7ez=0eAAzG8e7iwCC4CJgQorzVDu7LBBPOXbw@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: virtio: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 5:04 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/gpio/gpio-virtio.c:437:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpio/gpio-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index aeec4bf..84f96b7 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -434,7 +434,7 @@ static void virtio_gpio_event_vq(struct virtqueue *vq)
>                 ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
>                 if (ret)
>                         dev_err(dev, "failed to handle interrupt: %d\n", ret);
> -       };
> +       }
>  }
>
>  static void virtio_gpio_request_vq(struct virtqueue *vq)
> --
> 1.8.3.1
>

Queued for fixes, thanks!

Bart
