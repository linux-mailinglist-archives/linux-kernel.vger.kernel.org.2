Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E538DC76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEWSiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhEWSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 14:38:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E90C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 11:36:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r7so12837456ybs.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03XYmR5CIbTeND39uiNb/fz/ALEdrry0SrBAAirnu9o=;
        b=mNTE0RFjqqmZCZFp4yf2PcAQKkogc085XMLdio/Z5rdaFwsG9/f70jSnAsEmdYp9UX
         Mbmfh2w2Vklydh4m3frt4mDuu6kdw9A2dD5jY1MUvvsSc6aoX3lOWJ6149ZkVPSyYtsd
         f+5kryFaHDTjPA4Mmm1coLG0pYe8FueRms2nwA0J+IYzeSb9v6cXjkOMHrkpGJMTrzGh
         BYTX+uC13PXiOE8OXr2Ydt4S2UloPKkhZFysHwqC0qUAhabcOf1ABHDChbdVpT41qHOH
         YVNpB/m8ZtUnartSI8XftXT311jqh/+GeUzzKgVrsxpWklqEEhXIjqoaiMAf+R4yq9D1
         OMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03XYmR5CIbTeND39uiNb/fz/ALEdrry0SrBAAirnu9o=;
        b=pby2bUC4pjgpIbGdtdXjdmiWgfKPH37pZ8BnCg/1FlOUuM4/QTsd5y5NVVLW3dSBSn
         b5vUoKP8Zn+Gy2yyY6xw36o/Zat8WQBlLHCX3f328YcxFqmBy8Ysu4A4DtHb81vfHhYa
         VSLskC5sa1EenGgHa39nwV3H4w5L8dwk8w98J27eKVmIqONUxAXoWe9Z0FPcamZUNBQy
         D3/W8QS5Qd+NChHTTgQgepDXSmR/Qe6VYhNGPFikVl6A20FD4Q4hPD882OZHOXzYIkaL
         lpuE/4XgZ05W+JSdH2CZpaa9XhMsAEWT0JJNiOgLny64t6fI9eaiivh0rOsBMuD93H0w
         8pUg==
X-Gm-Message-State: AOAM530OmOuumUMfGUfCIWaSuU35rVx8BBxavsj71/jS+EQo3S9XTAuw
        WjLtFh5TA2HzN17SBCdCLm8w3ZjmPPwEtDm6kK46NA==
X-Google-Smtp-Source: ABdhPJym5FPAFCyPy70aI0BZWqYKWDSIhgkZPrxRi5TAaOCTRZVLKdjlCCYI2vqEA8HQLW4jTf88D5N9GeWzFmC1DC4=
X-Received: by 2002:a25:8804:: with SMTP id c4mr30091433ybl.469.1621794993362;
 Sun, 23 May 2021 11:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210515075905.12150-1-aardelean@deviqon.com> <20210515075905.12150-2-aardelean@deviqon.com>
In-Reply-To: <20210515075905.12150-2-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 23 May 2021 20:36:22 +0200
Message-ID: <CAMpxmJVpUx-wu2oJ0QMVDN16coh=Dd7H_Oi5NCrvBXC6xunr-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpio-tegra186: remove platform_set_drvdata() +
 cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 9:59 AM Alexandru Ardelean
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
>  drivers/gpio/gpio-tegra186.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 10d3597e9ac2..f54ae9d4254a 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -741,13 +741,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>                 offset += port->pins;
>         }
>
> -       platform_set_drvdata(pdev, gpio);
> -
> -       err = devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
> -       if (err < 0)
> -               return err;
> -
> -       return 0;
> +       return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
>  }
>
>  #define TEGRA186_MAIN_GPIO_PORT(_name, _bank, _port, _pins)    \
> --
> 2.31.1
>

Normally I'd wait for Thierry's Ack but this cleanup is pretty
straightforward so I applied both patches.

Bart
