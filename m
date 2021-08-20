Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896C23F27D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhHTHrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbhHTHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:47:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BFC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:47:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so6638452wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X/2GAbppTE9OSGgG1A1OZF+8Y2MWWqsdhY6crguMTvk=;
        b=CFe6IR04cSEVT71m9OhQvtAcEVOF9HPMr0lcoCrj7+uJezaF1xBQ4Cr0vhTx1zwlDU
         bFub2fwS9IDgxdWr+NJKV49JCpAxKUy0rbHhw6qtKcUXWpb0xqYU2KD1hKLTIFgrZRFJ
         GN6pkJC88ywRlbT6e1IldahGq4Z7/H4prQkaUP/WqDmaq5fZcjbWm+Eh3b2s6aGaeL2F
         4bVaOaXn0+oopjvnHyYA7WJuaex0PReqxAwRuPb+zZARaUyo/Nhr3eBVFvHE/q+RhvaZ
         x0KIgA7S1Hi8mpe6jZzIvE6KELkSIGMYpgVRQepBtlRjwGAXMTzSxjUATRz3BJnlcg+0
         1sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X/2GAbppTE9OSGgG1A1OZF+8Y2MWWqsdhY6crguMTvk=;
        b=QOELNpjjcBQI/GdsSRqXZm3SYOLUTGiRJfGZhWD7cfAVSWD8APJYOkE5iqgW/aUad3
         NVmpUpufCg5fIemJdjB5tUeBxElvXTJE6L5QgudUvmSVftPv4nYVntJTlzTFROkGOpdE
         vVqiwg/Wyru4ykeriHGWUlSewBj6L8CI9GN4woD3vrowhupxi2Y1jM2EYyl7+xj+SADn
         d5LKEkVQZUuKQ/xn/symgU+KKDVmwCvxYlzL+vH2I6XSZKmtFXfzVTFIK5b0260BTiBi
         HvjK8eHx/zguR83AOeO/UibVniNb4Ag8hBq7lFvZ/881bAgcHdFigEbT2NfNZS3NmnUD
         MzRg==
X-Gm-Message-State: AOAM530aKCTdaXOu1fwAKqLAAykvkrOl0qYLIAhHLM5Refgkt08C5AdJ
        o2YXjBPmoQGI9x8PAD/jhwQzKt9YVCr1gYfXrpw=
X-Google-Smtp-Source: ABdhPJwGezXtxlKMN5JtHuEYfDMuLQU7OpjO2DAvMHPT7RyS+4oXMa1lZ3k3MtLwnxRH+flf1TyUCaoer7lEf51G7Fg=
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr2422502wmc.3.1629445618481;
 Fri, 20 Aug 2021 00:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210715065455.392923-1-zhang.lyra@gmail.com> <20210715065455.392923-4-zhang.lyra@gmail.com>
 <47dcce5a-f438-9f12-5b60-651dc5f2b92c@linaro.org>
In-Reply-To: <47dcce5a-f438-9f12-5b60-651dc5f2b92c@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 20 Aug 2021 15:46:22 +0800
Message-ID: <CAAfSe-sf7U96rL1Pyotggr6S2j5hH7YAYHWtLgLh65PsH5Ba8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clocksource/drivers/sprd: Add module support to
 Unisoc timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sat, 14 Aug 2021 at 00:00, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 15/07/2021 08:54, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Timers still have devices created for them. So, when compiling a timer
> > driver as a module, implement it as a normal platform device driver.
> >
> > Original-by: Baolin Wang <baolin.wang7@gmail.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/clocksource/Kconfig      |  2 +-
> >  drivers/clocksource/timer-sprd.c | 15 ++++++++++-----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index eb661b539a3e..a5a5b7c883ec 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -461,7 +461,7 @@ config MTK_TIMER
> >         Support for Mediatek timer driver.
> >
> >  config SPRD_TIMER
> > -     bool "Spreadtrum timer driver" if EXPERT
> > +     tristate "Spreadtrum timer driver" if EXPERT
> >       depends on HAS_IOMEM
> >       depends on (ARCH_SPRD || COMPILE_TEST)
> >       default ARCH_SPRD
> > diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/tim=
er-sprd.c
> > index 430cb99d8d79..a8a7d3ea3464 100644
> > --- a/drivers/clocksource/timer-sprd.c
> > +++ b/drivers/clocksource/timer-sprd.c
> > @@ -5,6 +5,8 @@
> >
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> >
> >  #include "timer-of.h"
> >
> > @@ -141,7 +143,7 @@ static struct timer_of to =3D {
> >       },
> >  };
> >
> > -static int __init sprd_timer_init(struct device_node *np)
> > +static int sprd_timer_init(struct device_node *np)
>
> Does the __init annotation really need to be removed ?

Yes, since sprd_timer_init() would be invoked by
platform_timer_probe() which seems not able to be marked as __init.

>
> >  {
> >       int ret;
> >
> > @@ -190,7 +192,7 @@ static struct clocksource suspend_clocksource =3D {
> >       .flags  =3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NON=
STOP,
> >  };
> >
> > -static int __init sprd_suspend_timer_init(struct device_node *np)
> > +static int sprd_suspend_timer_init(struct device_node *np)
> >  {
> >       int ret;
> >
> > @@ -204,6 +206,9 @@ static int __init sprd_suspend_timer_init(struct de=
vice_node *np)
> >       return 0;
> >  }
> >
> > -TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
> > -TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
> > -              sprd_suspend_timer_init);
> > +TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
> > +TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
> > +TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
> > +TIMER_PLATFORM_DRIVER_END(sprd_timer);
>
> Please replace the above by something like:
>
> TIMER_PLATFORM_DECLARE(sc9860_timer,
>                         "sprd,sc9860-timer",
>                         sprd_timer_init);
>
> TIMER_PLATFORM_DECLARE(sc9860_persistent_timer,
>                         "sprd,sc9860-suspend-timer",
>                         sprd_suspend_timer_init);
>
> Without TIMER_PLATFORM_DRIVER_BEGIN/END, and if possible the
> MODULE_DESCRIPTION/LICENSE in the TIMER_PLATFORM_DECLARE macro itself.
> The module description could be the first argument of the timer platform
> declaration.

I hope I got your point, will address this in the next version.
Let's see if changes are what you want then.

Thanks for your review,
Chunyan


>
> > +MODULE_DESCRIPTION("Unisoc broadcast timer module");
> > +MODULE_LICENSE("GPL");
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
