Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713339040D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhEYOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhEYOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:36:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC4C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:35:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f9so43338691ybo.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukaK5XhZy2D/ZioTjRK5YPe6DCYHdOPpOGaEW9dEUZ4=;
        b=JH2fHeK4pOIzBfAPJ+ejA4h7tU9NvCfs+WsJ5pMklwU7umE7Kyq6hjjpiQrth8Y/O6
         TVat1jFIS90S57SXbaYPu8y/Ue5bEmCj7QZYAOgVxRSCosNkkk1C6D7r6Ndm+w1+68gi
         ICN5pMFME+Uph8+zOU0m3winfvayDtFHY8gbFkJzv3ztRWL9OBXDD8MvD8hwiaBZNw52
         CdadXy430upUpScXFiDcRk9xqDfp3KjF1iR+G7iL+bSVBHtVgFCd2NA7NjRzEKXbiNHV
         2iDhYZjmRoCbpG9dpTiGJfZxeRGwD3eVu7JEOnNNMNBleRZYh6Ywi6LXEUL+Ioa1R4RZ
         m0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukaK5XhZy2D/ZioTjRK5YPe6DCYHdOPpOGaEW9dEUZ4=;
        b=nCb61Ivqjcvs639N8SeonfpDBU6ZzTEU31grcFc027Mm2xq9Rmmto2ugzygyoe2kBi
         zI/WkYR2OMFQx8qBXwXPCLQ81toAb1hDq8g7ZQq7mrYVYlM8XsW6nQqmVReunZGiCi84
         ccIZ4mI65Q9MfapTneJcZ6nbl3YZPNRPgn3iKbgaU8eycbdRaZfDhyD/L9LnD7wLP1kl
         uv4597rLzHJqIXaI+cCcn1dGFxbuG8scxHc31oXIxDWTKzb/UwHPnu95ppWtMMuIErf/
         S7Vf6VhVXHtPzLFLVxxd5GOJTt71sxSNrcmXr+KfQZiF7mbWQFtu/UHeOjKJ8aPhLPnt
         Akfw==
X-Gm-Message-State: AOAM533fkGvzuGqr3WgCamdQgwye+mB8s9dI6ZOm/nKOHtvEmb5Nn3eM
        6J//z/7VTo6E8Sr8+EyU3RQjkEW/BRob5CR1Yn4LmA==
X-Google-Smtp-Source: ABdhPJwBdA0oL97r/dwogyfVStu7efF6kKKAAw0HZ430evVWnLfQulJFW6pFs65Fu2mz413oD6sPCCLwYfsaT8nUoo4=
X-Received: by 2002:a25:9d86:: with SMTP id v6mr41613992ybp.366.1621953303520;
 Tue, 25 May 2021 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210517113707.238011-1-aardelean@deviqon.com>
In-Reply-To: <20210517113707.238011-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 25 May 2021 16:34:52 +0200
Message-ID: <CAMpxmJUafFpcFeVH6ScOMeoRFyY67aJMNk8Yxrnb1XdAucE-gw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-ath79: remove platform_set_drvdata() + cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alban Bedel <albeu@free.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 1:37 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> The platform_set_drvdata() call is only useful if we need to retrieve back
> the private information.
> Since the driver doesn't do that, it's not useful to have it.
>
> If this is removed, we can also just do a direct return on
> devm_gpiochip_add_data(). We don't need to print that this call failed as
> there are other ways to log/see this during probe.
>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/gpio/gpio-ath79.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
> index 678ddd375891..9b780dc5d390 100644
> --- a/drivers/gpio/gpio-ath79.c
> +++ b/drivers/gpio/gpio-ath79.c
> @@ -234,7 +234,6 @@ static int ath79_gpio_probe(struct platform_device *pdev)
>         ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
>         if (!ctrl)
>                 return -ENOMEM;
> -       platform_set_drvdata(pdev, ctrl);
>
>         if (np) {
>                 err = of_property_read_u32(np, "ngpios", &ath79_gpio_count);
> @@ -290,13 +289,7 @@ static int ath79_gpio_probe(struct platform_device *pdev)
>                 girq->handler = handle_simple_irq;
>         }
>
> -       err = devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
> -       if (err) {
> -               dev_err(dev,
> -                       "cannot add AR71xx GPIO chip, error=%d", err);
> -               return err;
> -       }
> -       return 0;
> +       return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
>  }
>
>  static struct platform_driver ath79_gpio_driver = {
> --
> 2.31.1
>

Applied, thanks!

Bart
