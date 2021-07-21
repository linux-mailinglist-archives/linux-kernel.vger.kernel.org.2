Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC503D0F55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhGUMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGUMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:35:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B09C061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:16:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r135so197618ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKJrexLnW7vtMVtnT0P0NrpurExWWFqAFNKELJtWKt4=;
        b=VcxuuEwbwdsJw2M45kM15U0QwW6FGzNjae+GhnBCC9hT12pjl/dhMYEd43QBL1CrOY
         qzmLSG+XIBN+9e44Y3c5tZkd34CihV3dfLXz49df8VSZCqTKhtka6OtDkvEhy/LUktJG
         H2GSuTC0/OAmoGVC8oqP6LkodfhTepbx7azO4umMAmY+/tw2KJMl2fr/QVdvP6REFrjV
         Km0Q4Wg45n2FHfi0wIdWb3F9Ip9qTDauG8LdTwhUnFAYISPLqjBnjCw/WP9cuhLgzSL2
         7lkGP/HUpT8JHkUOvtGpIBuobZJQrdm4lq+omVmiYiw06s77gC9vLzxQ6RMswkH2vuEE
         E8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKJrexLnW7vtMVtnT0P0NrpurExWWFqAFNKELJtWKt4=;
        b=T3FIAL8jBbYxiyQJ64T0qJOOlv6+62i6e4etobU2Kb8sm9TjSAvOrk4b/nMvz52P8u
         iUFYDYzwBzfmR5+IBZpt8+ryOn+fytS6wvH7PEfD1N4IiC+l5upK1vuAfHc2YVpC3Jmk
         0iYLDT5RbgwpGNYZYP/hGeuczQ7/B/BG+VJ7+KD72cHKOJ9oEWelzcJeMow4LgOm22in
         88jhAGVQs5yHT0V1b/SPF9CPGEtkD3QvjDMhBk12kxf5RbpEVuUDh6TWBKE0kOQqrRCW
         yUb83HnNYdgc3NosRKP3SvRnXsusTNKYPbQxcMdpC4mNDkRmxAo66zIQUHAR3KabFx3O
         P/PA==
X-Gm-Message-State: AOAM530rrXCqf2Tbo1EfLFl49KLLHzUjvC4WMb/keSxOVvSctInRd+tg
        yKl4zmJmYKI2h1Xwbr8xPYdlauJz2ONb++bkQs3sgg==
X-Google-Smtp-Source: ABdhPJz5Tbu0XjYRWiKI458AiUNnaAs8L2Cx+OYYKBjcor1lr5FVIiBgAn+rvGt5qjJQtjnk7eBPJ/y2n42zFtZa46E=
X-Received: by 2002:a25:cc04:: with SMTP id l4mr44007353ybf.312.1626873393677;
 Wed, 21 Jul 2021 06:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210707135144.191567-1-aardelean@deviqon.com>
In-Reply-To: <20210707135144.191567-1-aardelean@deviqon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 21 Jul 2021 15:16:23 +0200
Message-ID: <CAMpxmJVBTqX_e6a7PjdNmwYN-SCgqXQ1WbfzZbRLBGvPSVHTFQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: viperboard: remove platform_set_drvdata() call in probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 3:51 PM Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> The platform_set_drvdata() call is only useful if we need to retrieve back
> the private information.
> Since the driver doesn't do that, it's not useful to have it.
>
> This change removes it.
>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/gpio/gpio-viperboard.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
> index c301c1d56dd2..98ddd6590362 100644
> --- a/drivers/gpio/gpio-viperboard.c
> +++ b/drivers/gpio/gpio-viperboard.c
> @@ -422,12 +422,8 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
>         vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
>         vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;
>         ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpiob, vb_gpio);
> -       if (ret < 0) {
> +       if (ret < 0)
>                 dev_err(vb_gpio->gpiob.parent, "could not add gpio b");
> -               return ret;
> -       }
> -
> -       platform_set_drvdata(pdev, vb_gpio);
>
>         return ret;
>  }
> --
> 2.31.1
>

The log is not really needed, we'll get an error message from gpiolib
core. Can you remove it while you're at it and just return the result
of devm_gpiochip_add_data()?

Bart
