Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0823D76CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhG0Ncq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhG0Nco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:32:44 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C20C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:32:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z18so20672022ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuNLF/hIFVpE5Kuxn2Ih4pguqmnjzDTXsTLZdpYok7M=;
        b=JzOwSMnGvT+lU5wWVLjtCZsqfG6nwqN/XBWXhmH7SuwiNtcpGYeG47MaSa4osh5uKE
         ZERo29MAoUNhPF+JpO5MEdiywCl5dMsAPxAu68g0TlAA1laiQn89k4cFZmkQebzznfsR
         EMo3qEQ3CGS52+m4i6esXvcfUsz+dZFYmHh5JF+XW0ouK+YPV/eWy4V2vE/ghJ1QtRAD
         sL54U5rcVkwo+oHyu8wL+SIJ0EFMUxz16hxNVCJt8bj+yyiVPDxzgaHEObNIvg5g8E8I
         nwfWWPlwDwnZ09earemYPRt8r5c0uu3CuTizVXo9NCKQluAhZ/sKS6dYoC03l1+qwWGH
         jEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuNLF/hIFVpE5Kuxn2Ih4pguqmnjzDTXsTLZdpYok7M=;
        b=FnXqMKwJwuGAXKu1ptM+3H1V+nG65LfugJH82ocJiX/H35BY/w4nvgIWWJqqBvWDlr
         RaiIsRSvmLjvPUB3ouN+7A6sECUvhqTclgjcR98Nt2152Ce9Lt1GyEEg1yKLSEAvd3Nm
         XnyJSRcdt7XGxCG+qXxhT2k3p9DDXI7moFtSvsRfyuz4GHW9LqSG3neX/HvpJbWQIuXa
         rwxETc8Y7V0PaerhHYOhQTaMeTv991sfFlh+/D/ZPylzFJlKj+npDy0BKCmbcB8ByZMg
         mwaap1cewrHEx6aHRfhc/oHWWRFrc8I1t/iY5bz5hyCQq3sktNfyRPUj1s+a9phcomVf
         4UMQ==
X-Gm-Message-State: AOAM530Fdc6wi0ZpHQAfaDyrmurLWAgPH3W/EIPAFYTs7IjmgtxlmAzq
        ImFv+XIQv6JhWMoKX0RjhaPzdcTePVqVF10CTXiNKg==
X-Google-Smtp-Source: ABdhPJyq0//4vSyuyv0LjRqqC6GBfHjzNmaoPYGrzptTdsAHO1LLEhOxRWmgZRXt7OpjG82iGAgwevU75Qg2hUlb3C8=
X-Received: by 2002:a25:48c7:: with SMTP id v190mr21292996yba.312.1627392763659;
 Tue, 27 Jul 2021 06:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210707135144.191567-1-aardelean@deviqon.com>
 <CAMpxmJVBTqX_e6a7PjdNmwYN-SCgqXQ1WbfzZbRLBGvPSVHTFQ@mail.gmail.com> <CAASAkoYhg2VQB5En8=pybeHngnApaYoStg3ZB9=J-ZMofD7Rkg@mail.gmail.com>
In-Reply-To: <CAASAkoYhg2VQB5En8=pybeHngnApaYoStg3ZB9=J-ZMofD7Rkg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 27 Jul 2021 15:32:32 +0200
Message-ID: <CAMpxmJX-ZuoYerdL-EOOb7TKLcuj++jmbUcda-Dg2nnomLfmfw@mail.gmail.com>
Subject: Re: [PATCH] gpio: viperboard: remove platform_set_drvdata() call in probe
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 4:13 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> On Wed, 21 Jul 2021 at 16:16, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > On Wed, Jul 7, 2021 at 3:51 PM Alexandru Ardelean <aardelean@deviqon.com> wrote:
> > >
> > > The platform_set_drvdata() call is only useful if we need to retrieve back
> > > the private information.
> > > Since the driver doesn't do that, it's not useful to have it.
> > >
> > > This change removes it.
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > > ---
> > >  drivers/gpio/gpio-viperboard.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
> > > index c301c1d56dd2..98ddd6590362 100644
> > > --- a/drivers/gpio/gpio-viperboard.c
> > > +++ b/drivers/gpio/gpio-viperboard.c
> > > @@ -422,12 +422,8 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
> > >         vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
> > >         vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;
> > >         ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpiob, vb_gpio);
> > > -       if (ret < 0) {
> > > +       if (ret < 0)
> > >                 dev_err(vb_gpio->gpiob.parent, "could not add gpio b");
> > > -               return ret;
> > > -       }
> > > -
> > > -       platform_set_drvdata(pdev, vb_gpio);
> > >
> > >         return ret;
> > >  }
> > > --
> > > 2.31.1
> > >
> >
> > The log is not really needed, we'll get an error message from gpiolib
> > core. Can you remove it while you're at it and just return the result
> > of devm_gpiochip_add_data()?
>
> I thought about removing it, but in this driver there are 2
> devm_gpiochip_add_data() calls.
> It registers 2 GPIOchip instances.
> Which is not so easy to see in this patch.
>
> First one says "could not add gpio a"  and this one says "could not add gpio b".
> I hesitated to remove either of these.
>
> In this case, it may be a little helpful to know which GPIOchip failed
> to be registered.
>
> But I don't mind removing them both.
> Whatever you prefer. I'm undecided.
>

The core code will still use the label for the error message which
says 'a' or 'b' already. I think we can remove it.
