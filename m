Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BE30D4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhBCINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhBCIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:12:23 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC903C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:11:43 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e132so3338095ybh.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUW6cgsXf2s6Tfa7ZBwWDiC0Ybs+CZP4Y/WyzJM6xdE=;
        b=e4o9+Iyhhng61ZUBiTQVSh0YIC0WX0YQgbFG2JnC5OgJOmU1TEsv8rXj6O2YpEGlCM
         9qIibJPLK6Q9+r61vBxCXm6ocA0gA97OT91LTSX/cL2XFjDlSKMsm1NK1Rh+BRRuUwNX
         5c1vyQTmzKRfILyNQ1haSJBHeeaKqEy40Ke8vM0IWFqYWiJEIEESlqqeXj2OB3LiXZe2
         RGFgc0S89nCMKyRBrba7gM9N2+ltBHH8H7HzAetoBmDDbumeWOL8sLe5ZcHsipLYZefD
         7CKAk6Ztd9GpYKhL0vw8Q2XaK83O0lSyg3vXi51F1Ittn+v7Qs6xJIno+8rmrHdbA5E1
         PwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUW6cgsXf2s6Tfa7ZBwWDiC0Ybs+CZP4Y/WyzJM6xdE=;
        b=ko+DUwsVuQ3/T3D9J4q4z5RY+lZdD+u5UyFJAOOmijJAQTJTzfKF2O+tSaJlSLJkZ8
         7HAnVSykdFSPBHHqAH1/zDe2y4+j7oM/iIOCqg5KOIBSIaIW6tkdX1e3Lb908UUwQzv+
         BMzjvxdugYnLCCw4zp5/VMrSzFrHpzMGaGv7GF/kFNczIpClr2lX8NzVVCZZ88+ijdM4
         ElIZO1O/EN/mYByHxN2HIhNNnnXguwHY+8E5pHjLd0FUYJRJgS9zJBG6ipbBtTLmDMJf
         VPaw7J058bEq6nM8YqaAe1mSgh/4IKlDhugHkY7odFr4w/cebkkBKEOhxeRBzguT0Emn
         sZdA==
X-Gm-Message-State: AOAM531J2Pn7NwawW8KqoXONdhXLp6YRkqocex509uWTg9RoPNqDD0nC
        SFUO3w9BT1PjMSTsQJ6xJSg7cbJqB5pYUuoO2RaCFw==
X-Google-Smtp-Source: ABdhPJxG0tdpeOwp+/0CnIheHpmshoirdWiOvrrQQqDY3qUnb995QukB+klHmqncq/Osq2uTrFf3VxC9z/v7/ADpl/4=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr2735437ybf.346.1612339902716;
 Wed, 03 Feb 2021 00:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx> <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
 <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Feb 2021 00:11:06 -0800
Message-ID: <CAGETcx8Yai=q+sHiixcv=D=T9r0+X1GZ8LRBc98SX_omYVhavQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 11:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Feb 2, 2021 at 11:44 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 2, 2021 at 1:22 PM Martin Kaiser <martin@kaiser.cx> wrote:
> > > Thus wrote Saravana Kannan (saravanak@google.com):
> > > All of those drivers have a gpio in
> > > their device-tree node, such as
> > >
> > > my_driver {
> > >    gpio_test1 = <&gpio1 0 0>;
> > >    ...
> > > };
> > >
> > > with gpio1 from arch/arm/boot/dts/imx25.dtsi.
> > >
> > > The probe function calls
> > >
> > > of_get_named_gpio(np, "gpio_test1", 0);
> > >
> > > to get the gpio. This fails with -EINVAL.
> >
> > And you didn't see this issue with the fsl,avic patch?
> >
> > The property you are using is not a standard GPIO binding (-gpios,
> > gpio, gpios) and I'm not surprised it's not working. The gpio1 is
> > probably getting probe deferred and ends up running after "my_driver".
>
> So my_driver doesn't support deferred probe, as of_get_named_gpio()
> returns -EINVAL instead of -EPROBE_DEFER?
> Converting my_driver from of_get_named_gpio() to the gpiod_*() API
> should at least make the driver support probe deferral, after which I
> expect it to start working again on reprobe?

The way I understood the API/example, you can't just change the code
and have it work. The DT itself isn't using standard bindings. And we
can't make kernel changes that assume the DT has been changed to match
the code. So, the best we could do is have of_get_named_gpio() return
-EPROBE_DEFER if it doesn't find the GPIO -- assuming that doesn't
break other users. Or have this specific driver remap the -EINVAL to
-EPROBE_DEFER.

-Saravana
