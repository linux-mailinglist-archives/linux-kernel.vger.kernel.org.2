Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218143B9AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 04:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhGBC21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 22:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhGBC20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 22:28:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C9C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 19:25:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u8so10558880wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgZp2/G7A7FZ3D3kSGsnIXoSVq9MV6pnRj1vdyJ2ipU=;
        b=XH8wphDNZn65GjkxOtbqje5LXIPnbr72TWj4nJmOAow3coZeDj2eAW6sZqPxUlv+zb
         GgEY9+FX71D9IcayJEnQ3sBOWepQ5V1dnq+D+ExjDuGkNUIW1WsY3pZi4oE5s59GUu/0
         NYlDQH9sltV8Wy/MlXtFr6aTb32nJBf1IR5zC40cUZ3/UB4ORVMbErE3pmAp0LMyzSyL
         YVPEmKcWcT5cBejX+jGXd+8LD8rx4Z3uPPf7mteYtNbBTitzJuXF4mBngxRtZMWwlqaY
         lOaxIUfUvW4k1r2k7a8j+7i9FQYBTF0cEuY+JWUWkSstw9eV8GT7VnPcsLRpZYD8QXvF
         PMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgZp2/G7A7FZ3D3kSGsnIXoSVq9MV6pnRj1vdyJ2ipU=;
        b=HKfcJLRFkdiM8o1AHjJXcEwb2UwV/MzMw2kcGza8BkdeOTpkASAYSWbaprwqZPX21Y
         Kri0MX0GQvAHJkN1pONkwVchW2+52+LQDZ0AZQ4H6+1wLj7GGmwisbqqoZN6QQ+MnDF4
         GwaG/z6IRNpMWFW6YP54Jep6p4tfgnMROkOFRePqsZfxhy/MAtOTZHEvvxYXcQlF3QFA
         IB9QkZXmxgLXGW5lDLjwhM8Gm/VMXsQ3XWeDWmfEUBGO+4jpMBEu6bh8iAVLwAnh7wGM
         n5Uhc8av6bh6w6DT/dKPVBrTfCux3/rDepqgjX+KwhyVO4T6iNwqsAV4ojPfeHygxG49
         XJ0g==
X-Gm-Message-State: AOAM532Um5R5+asx80y8K98AkOAUuKsAIKDlWUP/LCvbK+8ynK9K+fTS
        AcYwFuegzrjicaZbtWvog4gG0c0KbjcWwEAOhgo=
X-Google-Smtp-Source: ABdhPJxVv+uJQwEUNPAtINkHoFenInVjKUOwyrxy2XXn1OL+ZDpHKBLt7Plk3onSbgDhx/U8Iey0pwSQA1kSdl4lM84=
X-Received: by 2002:adf:f8c5:: with SMTP id f5mr2373852wrq.420.1625192752486;
 Thu, 01 Jul 2021 19:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210701085159.208143-1-zhang.lyra@gmail.com> <20210701085159.208143-4-zhang.lyra@gmail.com>
 <CAGETcx-5Y6g3yO1Xs0=+WEsr5Hw7_6W6XRnseC7u5SfKAXbpCA@mail.gmail.com>
In-Reply-To: <CAGETcx-5Y6g3yO1Xs0=+WEsr5Hw7_6W6XRnseC7u5SfKAXbpCA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 2 Jul 2021 10:25:16 +0800
Message-ID: <CAAfSe-t-qy3smGzMYN_uK+5fMQZeWFKvmp0FJMeVVvg2PBKkLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] clocksource/drivers/sprd: Add module support to
 Unisoc timer
To:     Saravana Kannan <saravanak@google.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 at 03:18, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jul 1, 2021 at 1:52 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Timers still have devices created for them. So, when compiling a timer
> > driver as a module, implement it as a normal platform device driver.
> >
> > Original-by: Baolin Wang <baolin.wang7@gmail.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/clocksource/Kconfig      |  2 +-
> >  drivers/clocksource/timer-sprd.c | 15 +++++++++++++--
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 39aa21d01e05..9f16c2779edb 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -447,7 +447,7 @@ config MTK_TIMER
> >           Support for Mediatek timer driver.
> >
> >  config SPRD_TIMER
> > -       bool "Spreadtrum timer driver" if EXPERT
> > +       tristate "Spreadtrum timer driver" if EXPERT
> >         depends on HAS_IOMEM
> >         depends on (ARCH_SPRD || COMPILE_TEST)
> >         default ARCH_SPRD
> > diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> > index 430cb99d8d79..73c7b3f8c901 100644
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
> > @@ -141,7 +143,7 @@ static struct timer_of to = {
> >         },
> >  };
> >
> > -static int __init sprd_timer_init(struct device_node *np)
> > +static int sprd_timer_init(struct device_node *np)
> >  {
> >         int ret;
> >
> > @@ -190,7 +192,7 @@ static struct clocksource suspend_clocksource = {
> >         .flags  = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
> >  };
> >
> > -static int __init sprd_suspend_timer_init(struct device_node *np)
> > +static int sprd_suspend_timer_init(struct device_node *np)
> >  {
> >         int ret;
> >
> > @@ -204,6 +206,15 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
> >         return 0;
> >  }
> >
> > +#ifdef MODULE
> > +TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
> > +TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
> > +TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
> > +TIMER_PLATFORM_DRIVER_END(sprd_timer);
> > +MODULE_DESCRIPTION("Unisoc broadcast timer module");
> > +MODULE_LICENSE("GPL");
> > +#else
> >  TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
> >  TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
> >                  sprd_suspend_timer_init);
> > +#endif
>
> Would it be a problem if you removed the ifdef and dropped these
> TIMER_OF_DECLARE? Doesn't look like either of these timers are needed
> for the early scheduler timer.

Yes, there seems no problem indeed for now, I will drop them.

Thanks,
Chunyan

>
> -Saravana
