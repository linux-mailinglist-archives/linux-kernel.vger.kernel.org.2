Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31135AD8F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhDJNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhDJNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:23:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F894C061764
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:23:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so12851368ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PdA0UuqWQoeEPsKIWyk3Pcejd5KccgDqF4NOvvDI6w=;
        b=ybV9d2jfDhqr2oeSfKvcxqfe3AaiOgNiaQ8EoGJQNTSA8EN9PrTxcln0mr6wVepO8U
         yP0GHeAjsM0QhAbHLJ5HKQVeKb0ZzpP/IuZI9c4PsK1BUKStIsmiQhA4UUXacfn8tqSL
         fGKlRguTcewxO1cSVkxrJBw+X1rYH1+GTyXNnqMvV2lbepvxPg3mtFPFcnvzFHBKWRTw
         esgWVoZUb+qg6vaqIq8lATZpZLpAe9FCmYdrMeLEleASP+Q2jkexumhgx/f/cdOkXTyq
         MUFvYNKLdnzUkoszvcQRF/Af4iU/94HxayzEz6MoN2V4fjAzyUCL7RSAkg/T8g0iCMw0
         rywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PdA0UuqWQoeEPsKIWyk3Pcejd5KccgDqF4NOvvDI6w=;
        b=JjYjFdvwH0+01ySK3dncMnC/pup/+/O174K78/q3j6mLQx6NbTIznSAoXfPzXTrbcc
         8kBFKjIO3hreSwl/K0jVl9daA+XmX06KDeMpc37ritsxaaTbzYzNTYYn93H35+ReNaIS
         ufkUWKHyhN0IWqV5zGCOWgkZVHsrjpsesphPpTx9aPsufFAmj6l4gJgxhzt9/YMKUQFv
         Wnqc0x/R8WUxOY2H+Gb1cd3EUiYQPhbhZbCBE/hyXTnyG5bhxMC357qQUp4fpbXoAGXr
         e6L+U7YhDy0zsalUD6zmUL3l5RzmFlC/eSPVH2/HpZLA9ZChbSCt84sPOtidQNW3B/ti
         DpKw==
X-Gm-Message-State: AOAM531DWkk+1VXJbE48gbJ/zDV9ENBWx/Poe5QfJW7H6sV+eb3T1DEn
        /qT6tRYNdxEccvFX11N0o5NgOkR1QFQtDheKpuuemw==
X-Google-Smtp-Source: ABdhPJyoRg1dNz6w14NDu6Q8vTQrviY4JvFA48xLHpQHgVivel7QhBkhgKEn4Umq1nwGw0FzCQzQ0Gt1GYYn7LnTYbY=
X-Received: by 2002:a17:906:b7ce:: with SMTP id fy14mr610738ejb.261.1618061022692;
 Sat, 10 Apr 2021 06:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210410090919.3157-1-brgl@bgdev.pl> <YHGVE1hMDUiK0P2A@kroah.com>
In-Reply-To: <YHGVE1hMDUiK0P2A@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 10 Apr 2021 15:23:31 +0200
Message-ID: <CAMRc=McDf9+0G49SOoNccb5ie2c2CT=_RieFRFbGp6HfmFf4Lg@mail.gmail.com>
Subject: Re: [PATCH stable] gpiolib: Read "gpio-line-names" from a firmware node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable <stable@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Roman Guskov <rguskov@dh-electronics.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 2:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Apr 10, 2021 at 11:09:19AM +0200, Bartosz Golaszewski wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > On STM32MP1, the GPIO banks are subnodes of pin-controller@50002000,
> > see arch/arm/boot/dts/stm32mp151.dtsi. The driver for
> > pin-controller@50002000 is in drivers/pinctrl/stm32/pinctrl-stm32.c
> > and iterates over all of its DT subnodes when registering each GPIO
> > bank gpiochip. Each gpiochip has:
> >
> >   - gpio_chip.parent = dev,
> >     where dev is the device node of the pin controller
> >   - gpio_chip.of_node = np,
> >     which is the OF node of the GPIO bank
> >
> > Therefore, dev_fwnode(chip->parent) != of_fwnode_handle(chip.of_node),
> > i.e. pin-controller@50002000 != pin-controller@50002000/gpio@5000*000.
> >
> > The original code behaved correctly, as it extracted the "gpio-line-names"
> > from of_fwnode_handle(chip.of_node) = pin-controller@50002000/gpio@5000*000.
> >
> > To achieve the same behaviour, read property from the firmware node.
> >
> > Fixes: 7cba1a4d5e162 ("gpiolib: generalize devprop_gpiochip_set_names() for device properties")
> > Cc: stable@vger.kernel.org
> > Reported-by: Marek Vasut <marex@denx.de>
> > Reported-by: Roman Guskov <rguskov@dh-electronics.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Marek Vasut <marex@denx.de>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > Hi Greg,
> >
> > This patch somehow got lost and never made its way into stable. Could you
> > please apply it?
>
> This has been added and removed more times than I can remember already.
>
> Are you all _SURE_ this is safe for a stable kernel release?  Look in
> the archives for complaints when we added this in the past.
>
> thanks,
>
> greg k-h

IIRC it fixed the stm32mp1 problem but exposed a different problem
breaking other users until Andy fixed the deeper issue elsewhere.

It's now fine to apply it.

Bartosz
