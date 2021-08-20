Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7323F27CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhHTHql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbhHTHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:46:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC895C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:46:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso5493907wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wrh5aTHFw1rDGV2LUmxrOJzfsOn3grMx5hf1y0ucAAA=;
        b=tpxs+IEWmXP0TcWAQUzwXnlouoWAii35SszoWv1AMJrhp5gZ8tfJpapBmI1OXR1IA6
         Z0E4ZL9m33jVt4VY2AGOq2j9lIGvcgrqioiYrYdNyTNC+HokbmTskLsTpw0hMlVtqNOK
         Y5fRNV0qnbZdftioNn3JlmmSmLckG443NL7167gq2lOyRKCfltotPWW4ubo0IocbH+sU
         z0bLXsedsAZGp21aXLwj1tHJlt0q9dLf3/stSySQl4NwOm2ThzIEhwww2/qEm3FYHCkP
         nK4R4z1hEznEk5rZQk7/BXByKZc6gNuNG55wqxEhpP5DrBeIRrHokRZJr7MSaIn9BXwx
         MBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wrh5aTHFw1rDGV2LUmxrOJzfsOn3grMx5hf1y0ucAAA=;
        b=EReTL3mcmYnKrWHXTEgBQXEtOsv1s/ctJ9X565eSJ4jMMqJ8tuZu6LVW0IejJRXfk5
         ZAIhiBBeKrxkhMYrgDL1SDa7rGKbPG1IuwhXZURSkpEzfyED85IF7UwUcmXdZiPU+g0X
         h3NpLv90i12XGBIKoYk/GWCuUZZTx8aDSzh33Wd/kDm5+dCETGk4SsogUQqTWaEGmL31
         vITIR7OBs8hcQgHYAYu4ETQXKOtOycdz4+fTfg73Vf7mk/f7q62+1Fv4xf4ccGSeZXlr
         hr57y4jKUrjxtSA/p/ETXuPSbfTa7PB+bpVULM7PRyQgzjJpDFgbOOvg0gDkNhfY6JBL
         UI5A==
X-Gm-Message-State: AOAM530KMm6+AxIiNKb/eH+EJBPxmDL2XwX4b6LXnZaTZ66fqBHdmFR9
        9TcgiYuWS0IrjT3wSBrp+KasosZ/u4ym0EacOAc=
X-Google-Smtp-Source: ABdhPJz0ZN9sHi7KA1xXiZ5QMRL7HwPLqh2pjXmX3YNtP29lByclmH10CrykmQ2EeYJpTkrk26u9tgqwxp0z18745MY=
X-Received: by 2002:a05:600c:1906:: with SMTP id j6mr2454966wmq.166.1629445559399;
 Fri, 20 Aug 2021 00:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210715065455.392923-1-zhang.lyra@gmail.com> <20210715065455.392923-2-zhang.lyra@gmail.com>
 <3a173a51-2abe-c1bf-41a5-d0be15290452@linaro.org>
In-Reply-To: <3a173a51-2abe-c1bf-41a5-d0be15290452@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 20 Aug 2021 15:45:22 +0800
Message-ID: <CAAfSe-t9k1j_-XObnEhL93q3oZJs0bq3=7czrXfBO0ja=ndYTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init markings
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

On Fri, 13 Aug 2021 at 21:34, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 15/07/2021 08:54, Chunyan Zhang wrote:
> > From: Saravana Kannan <saravanak@google.com>
> >
> > This allows timer drivers to be compiled as modules.
>
> Why ?
>
> These changes will create a precedence with the timers being loaded as
> modules. A longer description is important.
>
> Also, loading the timers may be fine but unloading them is not supported
> AFAICT from the time framework. That should be described also and the
> code should make sure the unloading will be never supported in any
> module conversion.

Ok, I will change to use builtin_platform_driver() to replace
module_platform_driver(), that can make sure to support loading only.
And will add a description for that in the next version patch-2.

Thanks,
Chunyan

>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/clocksource/timer-of.c | 17 +++++++++--------
> >  drivers/clocksource/timer-of.h |  4 ++--
> >  2 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer=
-of.c
> > index 529cc6a51cdb..7f108978fd51 100644
> > --- a/drivers/clocksource/timer-of.c
> > +++ b/drivers/clocksource/timer-of.c
> > @@ -19,7 +19,7 @@
> >   *
> >   * Free the irq resource
> >   */
> > -static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
> > +static void timer_of_irq_exit(struct of_timer_irq *of_irq)
> >  {
> >       struct timer_of *to =3D container_of(of_irq, struct timer_of, of_=
irq);
> >
> > @@ -47,7 +47,7 @@ static __init void timer_of_irq_exit(struct of_timer_=
irq *of_irq)
> >   *
> >   * Returns 0 on success, < 0 otherwise
> >   */
> > -static __init int timer_of_irq_init(struct device_node *np,
> > +static int timer_of_irq_init(struct device_node *np,
> >                                   struct of_timer_irq *of_irq)
> >  {
> >       int ret;
> > @@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_nod=
e *np,
> >   *
> >   * Disables and releases the refcount on the clk
> >   */
> > -static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
> > +static void timer_of_clk_exit(struct of_timer_clk *of_clk)
> >  {
> >       of_clk->rate =3D 0;
> >       clk_disable_unprepare(of_clk->clk);
> > @@ -107,7 +107,7 @@ static __init void timer_of_clk_exit(struct of_time=
r_clk *of_clk)
> >   *
> >   * Returns 0 on success, < 0 otherwise
> >   */
> > -static __init int timer_of_clk_init(struct device_node *np,
> > +static int timer_of_clk_init(struct device_node *np,
> >                                   struct of_timer_clk *of_clk)
> >  {
> >       int ret;
> > @@ -146,12 +146,12 @@ static __init int timer_of_clk_init(struct device=
_node *np,
> >       goto out;
> >  }
> >
> > -static __init void timer_of_base_exit(struct of_timer_base *of_base)
> > +static void timer_of_base_exit(struct of_timer_base *of_base)
> >  {
> >       iounmap(of_base->base);
> >  }
> >
> > -static __init int timer_of_base_init(struct device_node *np,
> > +static int timer_of_base_init(struct device_node *np,
> >                                    struct of_timer_base *of_base)
> >  {
> >       of_base->base =3D of_base->name ?
> > @@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_=
node *np,
> >       return 0;
> >  }
> >
> > -int __init timer_of_init(struct device_node *np, struct timer_of *to)
> > +int timer_of_init(struct device_node *np, struct timer_of *to)
> >  {
> >       int ret =3D -EINVAL;
> >       int flags =3D 0;
> > @@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, st=
ruct timer_of *to)
> >               timer_of_base_exit(&to->of_base);
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(timer_of_init);
> >
> >  /**
> >   * timer_of_cleanup - release timer_of resources
> > @@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, st=
ruct timer_of *to)
> >   * Release the resources that has been used in timer_of_init().
> >   * This function should be called in init error cases
> >   */
> > -void __init timer_of_cleanup(struct timer_of *to)
> > +void timer_of_cleanup(struct timer_of *to)
> >  {
> >       if (to->flags & TIMER_OF_IRQ)
> >               timer_of_irq_exit(&to->of_irq);
> > diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer=
-of.h
> > index a5478f3e8589..1b8cfac5900a 100644
> > --- a/drivers/clocksource/timer-of.h
> > +++ b/drivers/clocksource/timer-of.h
> > @@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct ti=
mer_of *to)
> >       return to->of_clk.period;
> >  }
> >
> > -extern int __init timer_of_init(struct device_node *np,
> > +extern int timer_of_init(struct device_node *np,
> >                               struct timer_of *to);
> >
> > -extern void __init timer_of_cleanup(struct timer_of *to);
> > +extern void timer_of_cleanup(struct timer_of *to);
> >
> >  #endif
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
