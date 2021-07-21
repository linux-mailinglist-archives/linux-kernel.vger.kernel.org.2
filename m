Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50B3D10F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhGUNdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGUNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:33:09 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB764C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:13:43 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id a22so1512139vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZfNzgsD7J2Mjt1wMPXQg6aTS+MDAP37E7oHrwgMTDE=;
        b=RiHimWEdJ/RGZ9gofssOFkx+Wfty76jxVPgU8sJf9GNjIeUy02HWR2f3yFqLtn3aZV
         Res00d+d7X+xgbJYJtPOOOpG5ZKAXeDFChxnAVN3kC+ktsv2ZUZ/jI+Y1lS7f9Z/MlM4
         N2+ApXcedGuK0ZsphtpBKRo7TX5qVD/mt8fxkr0u2VlANdNkGSXKd2ysAW/NsBQUqY0E
         d2oziHVdEUbdxu5CW8fbxGW9O3zSiDp0O1cHtYX/H7CUFYxa1NzCVrMiFG6atT4/l6/y
         GxUutU9oArsohXQYkoqOUXQ0GBPE9rC9x3CDbu5oVMJKUBHqix4yKMQRUXHlGa+w93b9
         c1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZfNzgsD7J2Mjt1wMPXQg6aTS+MDAP37E7oHrwgMTDE=;
        b=EMzugkeQblsX6jZf7W20hMVWYZB+kuFUnf3BFARidTbWulI39OFfBtOYs4+qA7X2ly
         aC9mY361Sqenk+FtSIMDr3pXjI8dqeF1FGoTD5LFh+h/eKEEC4vL8h6Y/iqXrZJVzsur
         Smh0rZZ1YCmTVbFOp3Dn3XO5d86fcJchLI9lOGz92WM95iX3c1kH8uFdn/64PLEfjrFe
         dtutzIDfL8SIa/XSmu7m5f10RAQsRrtvFmAxZtQh3ttRYxN/XvZQg4G7+btvEDurp78c
         Zu0EiCjrVKm+wMK6s6ALR9rxK740KGppz+1KRmxuwdsNZOrhyhPAHMTZPappZqvs27li
         TlNA==
X-Gm-Message-State: AOAM530lDF4mC1ffbQB+o92jZ1UZiid+Jir8CbgowLyYHwMRcs7I1ywT
        Imqh2qk+6b8aJbp72a67AY/rbCSgEnwP5TLO1EYvuQ==
X-Google-Smtp-Source: ABdhPJzDzZiF5vXCGP5mkzRnVr4i3jpCUZGt6JzyAJTJuPHcvtQTM87aLzJv4GnqrDPGagqH5nK/n18oBDQ0LIAiPEw=
X-Received: by 2002:a67:c009:: with SMTP id v9mr12696459vsi.47.1626876822371;
 Wed, 21 Jul 2021 07:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210707135144.191567-1-aardelean@deviqon.com> <CAMpxmJVBTqX_e6a7PjdNmwYN-SCgqXQ1WbfzZbRLBGvPSVHTFQ@mail.gmail.com>
In-Reply-To: <CAMpxmJVBTqX_e6a7PjdNmwYN-SCgqXQ1WbfzZbRLBGvPSVHTFQ@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Wed, 21 Jul 2021 17:13:30 +0300
Message-ID: <CAASAkoYhg2VQB5En8=pybeHngnApaYoStg3ZB9=J-ZMofD7Rkg@mail.gmail.com>
Subject: Re: [PATCH] gpio: viperboard: remove platform_set_drvdata() call in probe
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 at 16:16, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Wed, Jul 7, 2021 at 3:51 PM Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >
> > The platform_set_drvdata() call is only useful if we need to retrieve back
> > the private information.
> > Since the driver doesn't do that, it's not useful to have it.
> >
> > This change removes it.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >  drivers/gpio/gpio-viperboard.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
> > index c301c1d56dd2..98ddd6590362 100644
> > --- a/drivers/gpio/gpio-viperboard.c
> > +++ b/drivers/gpio/gpio-viperboard.c
> > @@ -422,12 +422,8 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
> >         vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
> >         vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;
> >         ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpiob, vb_gpio);
> > -       if (ret < 0) {
> > +       if (ret < 0)
> >                 dev_err(vb_gpio->gpiob.parent, "could not add gpio b");
> > -               return ret;
> > -       }
> > -
> > -       platform_set_drvdata(pdev, vb_gpio);
> >
> >         return ret;
> >  }
> > --
> > 2.31.1
> >
>
> The log is not really needed, we'll get an error message from gpiolib
> core. Can you remove it while you're at it and just return the result
> of devm_gpiochip_add_data()?

I thought about removing it, but in this driver there are 2
devm_gpiochip_add_data() calls.
It registers 2 GPIOchip instances.
Which is not so easy to see in this patch.

First one says "could not add gpio a"  and this one says "could not add gpio b".
I hesitated to remove either of these.

In this case, it may be a little helpful to know which GPIOchip failed
to be registered.

But I don't mind removing them both.
Whatever you prefer. I'm undecided.

>
> Bart
