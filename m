Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950613EBBA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHMRpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhHMRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:45:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E763C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:45:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k65so20182047yba.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IrzNo1b/3dS2SIE27GgVGBVi7cKXwHutKwdyiCoWpXA=;
        b=WDie7uGVkKQkyl8uiEr0P4SvTm/CXRsjrhfKVivyYYwZeJmiACa2GSy56TEITv8W/i
         xijAdd/QwaJp45dWjO1tTu84nD+5X3oJXunUthSE6NZ297GroeYGN2ZahPKgXHJ46eqb
         5pEhaGL+oNrG+Jle/gcBWa9K7fdUsttukJ0ShqhzlHJmDOtNkeYI0bE1IrrkLW8FiYQR
         MFKDJ3RgY0AjxMQappd3cRVzr0hxHfAm+EBlAkU9S1t/lujQW1BwBnqpbt4I+uMI86Il
         4ep4X/7/M90flSjQrY0b5LvLLhbYqjelN1nRSVrk7xuIdZyjmAuiX9jTY2F73tb2tvLA
         if6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IrzNo1b/3dS2SIE27GgVGBVi7cKXwHutKwdyiCoWpXA=;
        b=ATs9DyP87VaNLfUn45Hl6/4dnFdrFSKIWdFOWqAjCrtw+0EwYSc4NCMuDNRa/RIF+4
         xNv1wlPrWbPQJ79DNgxtjTA0bYalBSfTnHI825b0R0mCr04mHA9WdE/GtMGz6NYAlQxY
         tX6XBYJKoiAiVrtzOchBxJx4vgCgHSbBworYRYnDS3GA/QILQhf5seAMrFwqPVfDoJ5K
         gXoRegmDlaZj7bmHZ9vKENuaOOcVEmRAlq2WLk4E98a/vL7ycyVoGMrWaEaqiMBFQ3E6
         GP4E/DG5NhTnMHtdySyChaEIup7IP9DpZTHg84dAnhqSeo/y54go7WCz+uomC3IClnt0
         Q3yQ==
X-Gm-Message-State: AOAM5312wt82kB3nnIlED6QBSKM4taA6VDmhVWUucSBeEWobIP+qYuY/
        oU9LgVCGaOgE6eBOhwQ7/4QgeyZY3+qscplrBzSp4A==
X-Google-Smtp-Source: ABdhPJx9c27Ch4N1S75GP9VnbBk6dpUpSZt9DFmvMWA5DIx4gGaPz5rtnMpg9NLCKDzYT8ucIgRRRz6ccRXaoeH8GZk=
X-Received: by 2002:a25:804:: with SMTP id 4mr4335433ybi.346.1628876718633;
 Fri, 13 Aug 2021 10:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210715065455.392923-1-zhang.lyra@gmail.com> <20210715065455.392923-4-zhang.lyra@gmail.com>
 <47dcce5a-f438-9f12-5b60-651dc5f2b92c@linaro.org>
In-Reply-To: <47dcce5a-f438-9f12-5b60-651dc5f2b92c@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 Aug 2021 10:44:42 -0700
Message-ID: <CAGETcx9h-WV+zYzjtyMZ9SCQJiihP4O-1UapBQ=ur-oH4bncLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clocksource/drivers/sprd: Add module support to
 Unisoc timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 9:00 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
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

Wrt BEGIN/END macros, Chunyan is just trying to be consistent with
what was done for similar macros for IRQ. If you want two separate
drivers being registered for this case, that's ok, but the macros
should support having multiple compatible strings handled by the same
driver. And to do that, you'd need the BEGIN/END variants.

-Saravana

> The module description could be the first argument of the timer platform
> declaration.
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
