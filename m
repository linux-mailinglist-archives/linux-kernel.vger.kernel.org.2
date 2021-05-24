Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31E638F368
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhEXTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhEXTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:01:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72958C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:00:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id w206so7810790ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCl2405oxq5KUkCKGM+eRztXt4CN2xq0xPJS/JuqGfM=;
        b=zj9nZ6/JuRnHTaDlHlFp+RiJHDPAzagbZtskw955lQ8H8ABQsFQwL3RzPNYhFEIEua
         91GpCQ8b53Xj1Gx9FGJeFu7sb7701CmWHzhtQAN2UD0bwFkIU4r3F6IBwBGRzeny06AT
         aQqDXlfEPtUcU1HLPQfJegmmW4vpKIaCsgeP8e5XOsugBx0opd0wSTttycRI40aT+SRj
         hLHLFOnWwjPKg/xxPlSSojpgPgA06IdjuN9NKI2AGiUNuZaeHoq1Dreum6e2onhcdHei
         EIHQUDNs8xOADWV5ag2asNeDG+2yfA3SU24BHWFlQFAUmKSaB2OImMucQOn9QJyfGEtF
         7fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCl2405oxq5KUkCKGM+eRztXt4CN2xq0xPJS/JuqGfM=;
        b=ZnHesgI/JbPIPn513tmvNn74dgwQOJLjG9VK85F6IzxLbaObWn2C1kEHa5gCxXhw9o
         /Deh3wz36YFPnc/KbyK3rqPVCuHmhycv9oti6b8Gmt07Fb7zbSVrhBNg+ghs8cFLLpRa
         67Yi54gg4Djyd4Brz169Wq4AqE/cQ0mn2/Wa5pIWzQ2dqFmNsLe0BD9sSszS3OtB1dZR
         Y8VFN9CJkuc3/hbZYieU0ras8ApbOd4GFKRHv7DNFJNYfiK66w/EphA+d+dzuUm1KC9U
         wpvk8esCcAvT7G7JL8qJCKFNBcPhEyoDfRVNuIyytWk3tGiBBWKzlQvCTzLU0N5X6lJ6
         LPZw==
X-Gm-Message-State: AOAM533SUDbi/NpRNhDR76XbboBOlUpftXL8hOEBQzDqW3wl/Wf0ORuZ
        PI/TbX4ZmbYLAjzcoLtrPS70UjNUjVHUekVQVvGDCg==
X-Google-Smtp-Source: ABdhPJy8bdhzUaRUmhEBPBRy378KnTQW3q3Z+hxh6rQEPEA4jJVTQLA2JbMZTb8tu2NxGwm1v/w3/r9gUKwE7A8En3M=
X-Received: by 2002:a25:e08e:: with SMTP id x136mr33361771ybg.0.1621882817789;
 Mon, 24 May 2021 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210515075444.9210-1-aardelean@deviqon.com>
In-Reply-To: <20210515075444.9210-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 24 May 2021 21:00:06 +0200
Message-ID: <CAMpxmJUoEU=yKw68G0MquVCJoCZteTaAvfvgLqD0tXGW-d5nhQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-tps65218: remove platform_set_drvdata() +
 cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 9:55 AM Alexandru Ardelean
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
>  drivers/gpio/gpio-tps65218.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
> index 43a1150055ce..66461ed192d7 100644
> --- a/drivers/gpio/gpio-tps65218.c
> +++ b/drivers/gpio/gpio-tps65218.c
> @@ -187,7 +187,6 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
>  {
>         struct tps65218 *tps65218 = dev_get_drvdata(pdev->dev.parent);
>         struct tps65218_gpio *tps65218_gpio;
> -       int ret;
>
>         tps65218_gpio = devm_kzalloc(&pdev->dev, sizeof(*tps65218_gpio),
>                                      GFP_KERNEL);
> @@ -201,16 +200,7 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
>         tps65218_gpio->gpio_chip.of_node = pdev->dev.of_node;
>  #endif
>
> -       ret = devm_gpiochip_add_data(&pdev->dev, &tps65218_gpio->gpio_chip,
> -                                    tps65218_gpio);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Failed to register gpiochip, %d\n", ret);
> -               return ret;
> -       }
> -
> -       platform_set_drvdata(pdev, tps65218_gpio);
> -
> -       return ret;
> +       return devm_gpiochip_add_data(&pdev->dev, &tps65218_gpio->gpio_chip, tps65218_gpio);
>  }
>
>  static const struct of_device_id tps65218_dt_match[] = {
> --
> 2.31.1
>

Applied, thanks!

Bart
