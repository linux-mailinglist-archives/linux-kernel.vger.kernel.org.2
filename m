Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF038F361
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhEXTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhEXTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:01:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:59:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i4so39537596ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2E51jDJjGt+nt4Ntdtc54cO0ilON4XWr1Ti/oWq2TA=;
        b=mHeJj5KGN7eFFLKOTHPmPXvDIoE43xcHxsSx1z40uYjR1885p6SVK9UqPm7N64p2su
         Uu9F7bDmq+K/4si2yrkDx+DIm9PoHcyZUDfsPBZrarkkzWBOpMppDJXzcWKg9Q5eH0Db
         ZudFjOoGSGJbWNRl0r6QTsNozT0GA6V4rx4clz6alb4K0vQcjeBMOS9OLa5PowJ6EQch
         zlgCYER5BFswyWkuWAGS3/PaFzJdgr/B2JiCM0/JwCIwylILNSO4ati142yqyQA9+VpI
         VcFu0bwoWGuFwJfUoyaxiLTxONx45RyUw2lrDt4JF/FSQ1+ULuAgpOHMjcejI3x1zG8c
         1iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2E51jDJjGt+nt4Ntdtc54cO0ilON4XWr1Ti/oWq2TA=;
        b=fsHv8fT0DA5AM7/0t+4eIAjaf1qX0rQaZGUFUXrkEybmdT3h82zLp12UqjSkNtMBKM
         Nki3kUI5ME2/TVClC6ku6I3mEgT01TftNRsDQlypNyt9u8fb+QF3PRWxIA3nb12U/4an
         o7nYb5bL1CBYaU3AB2JAOUTYRwsF3VtoC2jbCdHvEW89N8LK7nr2xUAoEJ2bgG7uCKBf
         6Li2gdjkEv5KsPihswGCcH+w1RIQa3uhdB/Q8D2nVsUh0BfwCKXy8+iBMtNppkgod/tw
         4OjFMsGyAZkGjUpZcxBX0Ugcd4oFsU36pLx1kWQn4lQRfUqjWg6FbZag6vztezkfWOzc
         cWpw==
X-Gm-Message-State: AOAM531P+WAhuANtCOeyVReMI/sbOUInEhHWJYM05G6cB0ubzU2+rjZQ
        hwR1kL4x+YdMqNTYwhwxTsXeKe0U+5dTadgY+T72Ew==
X-Google-Smtp-Source: ABdhPJzDOMyn1Xn+t87Flm/tFDEubUonaZTtyGfWsZGozub3JQzHJZM+ezKGo2LeGc7CpiOTsgUPJIyhAdfsgNtdLPU=
X-Received: by 2002:a05:6902:1026:: with SMTP id x6mr34341874ybt.23.1621882781830;
 Mon, 24 May 2021 11:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210515075233.7594-1-aardelean@deviqon.com>
In-Reply-To: <20210515075233.7594-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 24 May 2021 20:59:31 +0200
Message-ID: <CAMpxmJUuFHucwOZ6Y0VCTgppfYLDcSGR-URUrMkFMsXfYmmaLg@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-tps6586x: remove platform_set_drvdata() +
 cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 9:52 AM Alexandru Ardelean
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
>  drivers/gpio/gpio-tps6586x.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
> index 9b6cc74f47c8..20c4f96f42f0 100644
> --- a/drivers/gpio/gpio-tps6586x.c
> +++ b/drivers/gpio/gpio-tps6586x.c
> @@ -76,7 +76,6 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
>  {
>         struct tps6586x_platform_data *pdata;
>         struct tps6586x_gpio *tps6586x_gpio;
> -       int ret;
>
>         pdata = dev_get_platdata(pdev->dev.parent);
>         tps6586x_gpio = devm_kzalloc(&pdev->dev,
> @@ -106,16 +105,7 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
>         else
>                 tps6586x_gpio->gpio_chip.base = -1;
>
> -       ret = devm_gpiochip_add_data(&pdev->dev, &tps6586x_gpio->gpio_chip,
> -                                    tps6586x_gpio);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
> -               return ret;
> -       }
> -
> -       platform_set_drvdata(pdev, tps6586x_gpio);
> -
> -       return ret;
> +       return devm_gpiochip_add_data(&pdev->dev, &tps6586x_gpio->gpio_chip, tps6586x_gpio);
>  }
>
>  static struct platform_driver tps6586x_gpio_driver = {
> --
> 2.31.1
>

Applied, thanks!

Bart
