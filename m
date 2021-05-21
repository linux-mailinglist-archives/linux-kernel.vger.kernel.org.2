Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25338C6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhEUMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhEUMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:47:58 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA39C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:46:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d14so19356633ybe.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJtv8tO+srMCLhjCuMBBHQBC6gQTo/DB8dTOrmtQwz0=;
        b=u3Q+sm3on6BmPGIfpRvuXdbC9eMKxaBuvgYy1JWnnzsycj2cZfrZU371lePTA11gtu
         +SE8wjEYS/h6moT8fj80cqELiBU9lIcOjUu7wN1poP1BOvEYLD52cImhNzreVJApnRJZ
         vXk7Vg5oXpnj/qUiaAThRHYJKPqPnKCtpTsVzsVPSdISWQaTzxIupYxa5U2p9c+9+6QA
         c9MU/drup9paSSjoteh8IbFJHeOpLLKGCboKFwNUAObbMrxoJiBTL5xWl9eioou7ZmbE
         XEJuZZsBZzzA/SY7dj8PcotdPEIfLOSA4uxuLMReaUCNlChAvXgK3qEry3bnmfIW4CyC
         DsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJtv8tO+srMCLhjCuMBBHQBC6gQTo/DB8dTOrmtQwz0=;
        b=B7zM+GcLFYo1RSC548/qoyouzOSQEmJcRoGiTk0s2fFHPTuJfzaA2iPmWFPFRbj40G
         k6243QB0pTEa2lxYaNFkINSsGtlnHLwyWxLYj2BsfE9vU99RNq0PklUNe6o5qy0AeRFq
         PafTX+U3fG9QSbANlZ/7JxtC1HeGE40e1s8yb5KtKiEmBsk0CnjRnYuoRf6G0lcTL/+w
         3ZOsft3UG334XOPRlB+JxIJQtRSZR9Xibku4Wjv/AfDlubLq65mn3iLdfrhaEzVHxWoA
         Mw7CWLqMlDdjvNd1dWl79wQ2Lx23uJJofZ2KsJKkscW1qGKIzheHy9OL4xOiGNhX3Yhn
         wbUA==
X-Gm-Message-State: AOAM530aJXHO3KNFMauPgya5WReZpgN0QBAA+RTZ/jRsWgswyQxW5oyc
        DYwdVPq3izcr3Gy6BEh8JU0IoJ7uB1rG0Wv2rAvflQ==
X-Google-Smtp-Source: ABdhPJwo1Fd1OhhBBCEBsJ5ei5vOtm0WPuwFHnpGY6cC1UHbm4x8mSHDgVoSMHyd+1f34eFkkO5eRsYDpPANBBfQc/o=
X-Received: by 2002:a05:6902:1026:: with SMTP id x6mr13499261ybt.23.1621601191892;
 Fri, 21 May 2021 05:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092332.19966-1-aardelean@deviqon.com>
In-Reply-To: <20210514092332.19966-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 21 May 2021 14:46:21 +0200
Message-ID: <CAMpxmJX=nrx6FQ2XVONf+mQWa_HsnQkEk4S-beqgTpxXi80FMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-da9055: remove platform_set_drvdata() +
 cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:23 AM Alexandru Ardelean
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
>  drivers/gpio/gpio-da9055.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
> index 6ad0c37b862e..49446a030f10 100644
> --- a/drivers/gpio/gpio-da9055.c
> +++ b/drivers/gpio/gpio-da9055.c
> @@ -133,7 +133,6 @@ static int da9055_gpio_probe(struct platform_device *pdev)
>  {
>         struct da9055_gpio *gpio;
>         struct da9055_pdata *pdata;
> -       int ret;
>
>         gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>         if (!gpio)
> @@ -146,15 +145,7 @@ static int da9055_gpio_probe(struct platform_device *pdev)
>         if (pdata && pdata->gpio_base)
>                 gpio->gp.base = pdata->gpio_base;
>
> -       ret = devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
> -               return ret;
> -       }
> -
> -       platform_set_drvdata(pdev, gpio);
> -
> -       return 0;
> +       return devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
>  }
>
>  static struct platform_driver da9055_gpio_driver = {
> --
> 2.31.1
>

Patch applied, thanks!

Bart
