Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6B38DC6E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhEWSct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhEWScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 14:32:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 11:31:21 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h202so14281288ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoKj2+lP83dFN1Xj+nF6z+/9kXVQORuKRo4UmR66iBQ=;
        b=ucAgl6PLh5+NQYAGsG4hYMtEQSwA12FtTFU4rjsj3BqTUaGKncJxbZvmSscZv16Zig
         Tv642nWuXX+b8ScXNi4paL9Bd4oLroZ3c7EXIFaBFYApitSDhjuAd1T7xe9j+3WlCD8y
         3xr2myRyHc+0l+gV7qk6rSs0hr/GoIaVlTdsKA1Cm0C81SSllDm6QtWezKknSA5QbG97
         ntqN+zH5BlaHIj4TonqvgG7Cj/gDOk4F9AQqX21XBuhMMV29fVeRUN73W05GOuBevrJs
         TTw6c7VtqHg2/gOgUvnZcdBoNaOS2CzbjKFR50BgME77oF9JdL1FmaOPjEnd0RYBODr+
         yrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoKj2+lP83dFN1Xj+nF6z+/9kXVQORuKRo4UmR66iBQ=;
        b=Xcz92ltdHlnrxDeqIfB88fCIdqUSNV9NHl0r5GiRA3za1HKW/Z6vBL32DN/RhPip9k
         X41YAZit9qjouL0ZY9CTSpkIpwIgR5bU+9Aw/vWNTO1LgAJGHytKcVENsK/wzz6yO51w
         XExoxrEZMtJrGlClEuO4Q43YTlBX4LgJCMm8+4mSvgqMbfhJSNqNuSBbSK85stvKlGbx
         v8wZ6lAam0gs07GzZmH4e0yFrj5bOvY/uhEuIxMJ4jCcfTO3t9lE6UY3D+DLiQJTUq2V
         aUU25DF9Mw5yCng1f8Hbs3iOsxcxaPuqktB45ki3tV/ZGa44nip+oPtkxn33JikMTTQE
         ugow==
X-Gm-Message-State: AOAM533rU97g4ND/lqL1DW1FNzECxoD9ksH4YvSSJuucL5/dnZ4JeH6m
        2MX0oYRTelj/m4LSwCgbfn5yBsDswvdKYOpIG7VZVxR1sTg=
X-Google-Smtp-Source: ABdhPJznHZLraTDjzGymQbEzUGUE/T0sGF9sKDufxt2HML2dD/ZopaCG75J8/yGHHHnshJlKmhWRx4J/cAJQApbV7Rg=
X-Received: by 2002:a25:9d86:: with SMTP id v6mr28724828ybp.366.1621794680999;
 Sun, 23 May 2021 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210521181042.7726-1-aardelean@deviqon.com>
In-Reply-To: <20210521181042.7726-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 23 May 2021 20:31:10 +0200
Message-ID: <CAMpxmJW1Q-m_W+n28V9sEqvnb4ZVTGq_55DedhuJxu5icuD9sQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xgene: simplify probe, return
 devm_gpiochip_add_data() directly
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 8:10 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> The handling of the return value from devm_gpiochip_add_data() is a bit
> redundant. It prints messages on error and success cases.
> While the success message may be useful, it is more in the area of log
> spam, and these can be printed with other forms of kernel logging.
>
> This change does a direct return with devm_gpiochip_add_data() in the probe
> function.
>
> The platform_set_drvdata() is needed, as this driver uses the stored
> private date in the PM suspend/resume routines.
>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/gpio/gpio-xgene.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
> index 532b0df8a1f2..fb4b0c67aeef 100644
> --- a/drivers/gpio/gpio-xgene.c
> +++ b/drivers/gpio/gpio-xgene.c
> @@ -159,7 +159,6 @@ static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
>  static int xgene_gpio_probe(struct platform_device *pdev)
>  {
>         struct xgene_gpio *gpio;
> -       int err = 0;
>
>         gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>         if (!gpio)
> @@ -183,15 +182,7 @@ static int xgene_gpio_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, gpio);
>
> -       err = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> -       if (err) {
> -               dev_err(&pdev->dev,
> -                       "failed to register gpiochip.\n");
> -               return err;
> -       }
> -
> -       dev_info(&pdev->dev, "X-Gene GPIO driver registered.\n");
> -       return 0;
> +       return devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
>  }
>
>  static const struct of_device_id xgene_gpio_of_match[] = {
> --
> 2.31.1
>

Applied, thanks.

For the future: the subject should be: "gpio: xgene: ..." here and
everywhere else.

Bart
