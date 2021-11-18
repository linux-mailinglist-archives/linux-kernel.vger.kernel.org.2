Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8E4563E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhKRUQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhKRUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:16:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B35C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:13:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so32153566edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfcsLQEcPV0JsHfU07qVfuDHJqM7i+iltNgLWRiMg1k=;
        b=V+OPyhSoe08YXVkmR0afneubAhjj4VTbYsUYS6WjhUYlL5V5lrlsb4or67/Yt1Wfi0
         BkxJXUSgV57M5ivu/ve/JqtD+1qA5VjSjfJO8QaOO0R4d0eFgBD8z2r32uKOSK9d5Gth
         Ha3znWTChGPXe2b35gBDuBnr57IFKXUw4WlUmBg1sf/v6Ul8dmege3Oiu34TxpinrLb0
         SsG3uELtvJ1x6W2Izy41mza7SK6aIgNEwQsT0UdS4b7NeL+wfJWmyzzQdgvtiKtxfjCY
         T1UEjIJu1JMs1IKRIWN45T1sPxH2x70Ol4TU++JBdPaH3MwPh1IhUWCwCdr9wMon6wsu
         p4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfcsLQEcPV0JsHfU07qVfuDHJqM7i+iltNgLWRiMg1k=;
        b=zvBFcTAyMHbayqi5ZAd4Q6P3UsldoISX9cn79xCe4gqp6V5nHI+tUlasFcwMek5ViL
         A7Ad5rDKpePk/Ksv7fDKZ6juohJoN4XRYmaP1NeO9aOtjZl5eydpx3WBeCtxNyZbG4fC
         KHnBTtSGvUw16BRd//iOespYoCaoLuPkyWu4Q0aU4zZwmVRpiX/UhVM5TixggxMLEpNS
         Y2aYd5VBpYinhdS9maWIuDGFsgMeFvdGR23MhYzhZAolFLQf/jT5PiESy7E+BdGJODvc
         n9X9KPWR/dPWPFpXL+kV4SJckQWLZibjbqx6OyD3LVdw6goCBKsktUN+NuA9qsLFoBlu
         b17A==
X-Gm-Message-State: AOAM533rlYVzCWwVSQT5N/IHz8o7iYKBL1HKJOqhih+SoabByTimNg7n
        CfDoy/A6gjUOmnrYs28ujDvpeU9ZQOmEjvwA21c9bw==
X-Google-Smtp-Source: ABdhPJwbsk04yDg2oy2nZQBz4ntMPLkjIiBSDg0HUVJOTKiMfZVegj6KLZxBktPZRtv5A8GmD4IuDZfIk8vem0tjYXs=
X-Received: by 2002:a17:907:9847:: with SMTP id jj7mr213116ejc.508.1637266390138;
 Thu, 18 Nov 2021 12:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20211118132317.15898-1-brgl@bgdev.pl> <20211118132317.15898-2-brgl@bgdev.pl>
 <YZaH8rsMyUztOX/r@smile.fi.intel.com>
In-Reply-To: <YZaH8rsMyUztOX/r@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 18 Nov 2021 21:12:59 +0100
Message-ID: <CAMRc=MdR_RGLLPJ5Hqetj5_7ZQfUXOijEoVp3uR7cgEDHKnchA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 6:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 18, 2021 at 02:23:17PM +0100, Bartosz Golaszewski wrote:
> > Several drivers read the 'ngpios' device property on their own, but
> > since it's defined as a standard GPIO property in the device tree bindings
> > anyway, it's a good candidate for generalization. If the driver didn't
> > set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> > device's firmware node before bailing out.
>
> ...
>
> >       if (gc->ngpio == 0) {
> > -             chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > -             ret = -EINVAL;
> > -             goto err_free_descs;
> > +             ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> > +             if (ret) {
> > +                     chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > +                     ret = -EINVAL;
> > +                     goto err_free_descs;
> > +             }
> > +
> > +             gc->ngpio = ngpios;
> >       }
>
> This should be
>
>         if (gc->ngpio == 0) {
>                 ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
>                 if (ret)
>                         return ret;

But device_property_read_u32() returning -ENODATA means there's no
such property, which should actually be converted to -EINVAL as the
caller wanting to create the chip provided invalid configuration - in
this case: a chip with 0 lines. In case of the non-array variant of
read_u32 that's also the only error that can be returned so this bit
looks right to me.

Bart

>
>                 gc->ngpio = ngpios;
>         }
>
>         if (gc->ngpio == 0) {
>                 chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>                 ret = -EINVAL;
>                 goto err_free_descs;
>         }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
