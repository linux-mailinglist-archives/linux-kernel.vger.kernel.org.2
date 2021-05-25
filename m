Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45F390402
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhEYOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhEYOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:36:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16882C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:34:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y197so1624795ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J87R9tGiD9qctV4x8vijaWhBzZTCCpwwEZSuP/rj7yI=;
        b=DfjIbrccGsOONpshpqpgyzHXUeXlDTIb7+n07hF3C0K/Apkws/U7vq7MUssKfyYbH4
         JW/GkEuWU2SM+e7WQiaS653ngRi3Z/6jrRH2ViGAzBE3WHJwqjsrOgpghCryNo+Xn8Qw
         Eokvd9R0RPYI5oiOKUp/cB6GPP1IsWJIuVVTF5OoujB/V+BoXVSeEL8dsmjhiUIo4ShC
         wFMwPVGNicErpOLVuK3ARe9OyR+R0J3aOkaVbMqKNuwKet6OldMiDKoWMVTXE1CQwAQY
         ZnNhPiFRzBAFPSnS4g06SABRAdYAQ/17sKxg+IRjOJnQbfR0+Y+tvATRlDHPKmWJOQw5
         g0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J87R9tGiD9qctV4x8vijaWhBzZTCCpwwEZSuP/rj7yI=;
        b=R4kw7hzOeg2Qy6SzHOEEfEMAC0c+2V05neikOp1pH351Ql/eFXSc15a1ul0X15VZha
         QipwGC5PfsQ8jhD0I8tL3yBG2ExQj2/+ovpYdZgJis+qtWIEwyiNv5Xog1ABzxOS0uBI
         KwF9z+siDErVHS3dbuw+IPkEmnBExA2Df4Cul3hJG2RSUz8gQGHtFJfEM9y+Lvzi5qtd
         T9vAWzHC78uMp2YyYMVxCM38kfacmh7R1oe/3fL+Wz8e0nbL+/rkPc6gw8tAQLQ5SDAb
         Nl6M8YiszEPlavmkja9gluHzd+aZxIGsId9prw2UYERVD9R2b2TsbsvJqPlNoDPliVZy
         dP/g==
X-Gm-Message-State: AOAM533cmj26r2YNu68wTGMm5Mt/5M7whdMDOZix13Fahh7boI8KGomA
        u7pkFvJoAxzk+waCT5W5SuLAAZJvqFPjagnkoATJIw==
X-Google-Smtp-Source: ABdhPJzBzcqbICD0tyi3BQmP2SWh0dbpw78j3Ea6Tcpet57GoI8yzQRqi9jzWtt6VAa829lWWXNvS//+ayHLxDrZkXM=
X-Received: by 2002:a25:9d86:: with SMTP id v6mr41609806ybp.366.1621953264969;
 Tue, 25 May 2021 07:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210516062315.10832-1-aardelean@deviqon.com>
In-Reply-To: <20210516062315.10832-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 25 May 2021 16:34:14 +0200
Message-ID: <CAMpxmJXJOnEfMrDf5krOAOydEui6fAHGqUx8Ub7iWZxMEOqT5Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-sta2x11: remove platform_set_drvdata() +
 cleanup probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 8:23 AM Alexandru Ardelean
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
>  drivers/gpio/gpio-sta2x11.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
> index a74bb97a41e2..392fcab06ab8 100644
> --- a/drivers/gpio/gpio-sta2x11.c
> +++ b/drivers/gpio/gpio-sta2x11.c
> @@ -398,15 +398,7 @@ static int gsta_probe(struct platform_device *dev)
>                 return err;
>         }
>
> -       err = devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
> -       if (err < 0) {
> -               dev_err(&dev->dev, "sta2x11 gpio: Can't register (%i)\n",
> -                       -err);
> -               return err;
> -       }
> -
> -       platform_set_drvdata(dev, chip);
> -       return 0;
> +       return devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
>  }
>
>  static struct platform_driver sta2x11_gpio_platform_driver = {
> --
> 2.31.1
>

Applied, thanks!

Bart
