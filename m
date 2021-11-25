Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0445D80D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbhKYKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbhKYKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:15:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE082C06175E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:10:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r11so23227135edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uY1320pfARFP0aqCxH2XJgkIqC5MefeMwkvkI1jomHM=;
        b=1LvqB7ZzUTj0dRExAAGL9FsbK5F16YizN76SGabC9iuEkGBzMErW86CEyEd5exphPf
         n0mdPUY1gSdp1zx78M39z89pBt+aUdvUm+p4ow0eqgjBJL8s0MD6Noi523q3M/00AmBD
         uoa7WNSrW7cbHG5AkF1Gr1yspFZngpw7KRxXcR+AQ3a51sIaaswP7LR6CsJpgOpJv6Gy
         RJNRPwcWSFklJ3mw9+GDo2sELhk9Jya+DKKyLe5iEmLBBKLKXubyqNQW+JjdCV7ct53H
         k3pjarOa/wKJJzfve2C0n/5ZwrZPFVCV0x+qOseHklOHHpPfCd0qad39s14MdgRSCWEF
         zymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uY1320pfARFP0aqCxH2XJgkIqC5MefeMwkvkI1jomHM=;
        b=sDfHXTmURx+eWo3XpzCor/leeWbJkSEQPyPWPnVRy39MDf8T1ZF9DZvWhV28eJSJXd
         x49j74fSahzkpSDfZSsX7vz34PHjrMubiV7wowfGIXkoj2Ws2i5WOb9GzKLSQtMlMMgT
         DSLUps08C5UZlmA+xvKjwVsy0z93adZ5Q/Lian7dEVvt4i6JwVDo+O4pm28yFy+CjPBj
         bYwtkqotD3ixbJhxu20I7dqkWczWYti6MwfngavA5yLxl+Shz5jBEYcu5lrAZK92N/Ym
         cUgmDhaRD8VnA8j9Guca0ShoIrG+Jx6B67zc1mvC+Cogq38Wdr0YPrKIFHwcwG0g1/s0
         DhVA==
X-Gm-Message-State: AOAM533RKnqU5Rt9R4NOqeu2JKrpp6plnbyxMU6oivIrF0alnAnX5sn9
        PPx6Ak8c6bmmlYL1EHAYJT5zaHwAh6KDhk7cf0BX8vF0Cigrlzti
X-Google-Smtp-Source: ABdhPJxcJWKIiC3o+XJYDTa3abClgRQH1270vQEYzDAfENegSLf/yPfu1BI9/wyfxb0PX544PQ7+DWzsNcrIM6K6UVU=
X-Received: by 2002:a17:906:5343:: with SMTP id j3mr29879323ejo.538.1637835018828;
 Thu, 25 Nov 2021 02:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20211124122850.7095-1-brgl@bgdev.pl> <20211124122850.7095-2-brgl@bgdev.pl>
 <YZ5QYsu2ed5FiSWE@smile.fi.intel.com>
In-Reply-To: <YZ5QYsu2ed5FiSWE@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 25 Nov 2021 11:10:08 +0100
Message-ID: <CAMRc=Mfcph_YPryowhtGtb9G_GOveRm+27BJYyznjxc=BK-jWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 3:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 24, 2021 at 01:28:50PM +0100, Bartosz Golaszewski wrote:
> > Several drivers read the 'ngpios' device property on their own, but
> > since it's defined as a standard GPIO property in the device tree bindings
> > anyway, it's a good candidate for generalization. If the driver didn't
> > set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> > device's firmware node before bailing out.
>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > v1 -> v2:
> > - use device_property_read_u32() instead of fwnode_property_read_u32()
> > - reverse the error check logic
> >
> > v2 -> v3:
> > - don't shadow errors other than -ENODATA in device_property_read_u32()
> >
> >  drivers/gpio/gpiolib.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index ede8b8a7aa18..f79fd2551cf7 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -599,6 +599,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> >       int base = gc->base;
> >       unsigned int i;
> >       int ret = 0;
> > +     u32 ngpios;
> >
> >       /*
> >        * First: allocate and populate the internal stat container, and
> > @@ -647,9 +648,17 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> >       }
>
> >       if (gc->ngpio == 0) {
> > -             chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > -             ret = -EINVAL;
> > -             goto err_free_descs;
> > +             ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> > +             if (ret) {
> > +                     if (ret == -ENODATA) {
> > +                             chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > +                             ret = -EINVAL;
> > +                     }
> > +
> > +                     goto err_free_descs;
> > +             }
>
> And if the property returns 0 in ngpios?
>
> What about the modified suggestion from previous version:
>
>         if (gc->ngpio == 0) {
>                 ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);

The comment is a good idea but other than that - it's overcomplicating things.

>                 if (ret == -ENODATA)
>                         ngpios = 0;
>                 else if (ret)
>                         return ret;

You still need to goto err_free_descs here.

>
>                 gc->ngpio = ngpios;
>         }
>
>         if (gc->ngpio == 0) {

Why check that again? We already know the driver set it to 0, we
checked it a couple lines before. If we can't get the setting from the
properties then it won't be non 0 here right?

>                 chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>                 ret = -EINVAL;
>                 goto err_free_descs;
>         }
>
> ?
>
> > +             gc->ngpio = ngpios;
> >       }
> >
> >       if (gc->ngpio > FASTPATH_NGPIO)
> > --
> > 2.25.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I suggest the following:

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ede8b8a7aa18..08c1e8fc0dfa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -599,6 +599,7 @@ int gpiochip_add_data_with_key(struct gpio_chip
*gc, void *data,
     int base = gc->base;
     unsigned int i;
     int ret = 0;
+    u32 ngpios;

     /*
      * First: allocate and populate the internal stat container, and
@@ -647,9 +648,23 @@ int gpiochip_add_data_with_key(struct gpio_chip
*gc, void *data,
     }

     if (gc->ngpio == 0) {
-        chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
-        ret = -EINVAL;
-        goto err_free_descs;
+        /*
+         * If the driver didn't specify the number of GPIOs, try to
+         * get this value from the device properties as a fall-back.
+         */
+        ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
+        if (ret) {
+            /*
+             * -ENODATA means that there is no property found and
+             * we want to issue the error message to the user.
+             * Besides that, we want to return different error code
+             * to state that supplied value is not valid.
+             * */
+            if (ret == -ENODATA) {
+                chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
+                ret = -EINVAL;
+            }
+
+            goto err_free_descs;
+        }
+
+        gc->ngpio = ngpios;
     }

     if (gc->ngpio > FASTPATH_NGPIO)
