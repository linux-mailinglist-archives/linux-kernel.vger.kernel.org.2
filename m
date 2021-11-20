Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1B457F99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhKTQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhKTQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:50:40 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB33C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:47:36 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id l24so27697927uak.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcCNsIIRQmi9fqIEvnMibk8k3koK5l2JssJUcrk+fw4=;
        b=jMk5slXa/4KsCJddpQLCmcV5tk5cSqKLefCLDfjzI/NDwf1rfs467yGH8LzJI13EnG
         ou24tQkfC8FUptGLaI7Mv0/gS+5lrhA0lwpRXZvBp+6B2GDkypFjqhvrMdeMHvxb0pf0
         wmI+uGEOJ6J1gkZrHuHMrhLQ7Jo41cT0Ur7Hmh1O7grj68xAG1iuOvg8542unhEcOcXT
         sIRSn0rjUDcWzdjWIi0MPtUq9rXWthBb435o6cw8lBiYO+59j5blge+qFHQFNkODtyLK
         CHKmkFpAu/bsVOLVx99VhHrzBqSzEOYi0mHhByEGx6uTUYTX1QWZ0IEtznKUTDCdKOCn
         rjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcCNsIIRQmi9fqIEvnMibk8k3koK5l2JssJUcrk+fw4=;
        b=qeKEtZ6EJ5Vr/mjPy5Bs5oz4101+WQEcUgGLLOfqA/Vy/LanV/16+7zg4xiZJRnnep
         ymmQhn7/6NwiSWuli+BesZK+gjs3uonp2WYEUT6jJM//o6j5vWiqV41sh8sx5z6b43ZP
         5rMWG1hmWD2NZqHM+v1T28J94lb9un5a9ZbGS6KOKAoNjDTz9fG5o9BdKbcV4KanUYit
         20G7fJH9x5jHwV+c2q6Np1eB3sTrt0jV3tC49cmXB4d3AQ55EFPWRwtvZNwxNcHOERWd
         whctXXBIY02WprWpqlF3ETbPV6Hx3IWkKZ67l5V8ovY+5kpgokw+EGext2wQZCsXmBvL
         9G6g==
X-Gm-Message-State: AOAM533MMKUTQKx0xLdkWrCriyv1D4PmQS7JJ/TcE9EnedSsm8J4JuSi
        8HDQJuSl/hushgLPGCOjeOmgSWGrYnNJ71srEVum4A==
X-Google-Smtp-Source: ABdhPJxDXdWLh4LgDoWZMOBx3ThJIN505varR1lJarijd9Ge+2680HEjBOkIgO6Pe4uBcHT+uXO6sYbVvra2L+6tbq0=
X-Received: by 2002:a05:6102:4192:: with SMTP id cd18mr109091338vsb.35.1637426854968;
 Sat, 20 Nov 2021 08:47:34 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211025161302eucas1p2f50ef29a0bba69c13deaf1ad31a8439c@eucas1p2.samsung.com>
 <20211025161254.5575-1-semen.protsenko@linaro.org> <fcc939e6-50b4-1847-c738-db940d0c5bd4@samsung.com>
In-Reply-To: <fcc939e6-50b4-1847-c738-db940d0c5bd4@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 20 Nov 2021 18:47:23 +0200
Message-ID: <CAPLW+4nnyPAMRcAzDjJ-uygm8bjncNp_rTLKdY5cywcpf5vg=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clk: samsung: exynos850: Register clocks early
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021 at 14:49, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 25.10.2021 18:12, Sam Protsenko wrote:
> > Some clocks must be registered before init calls. For example MCT clock
> > (from CMU_PERI) is needed for MCT timer driver, which is registered
> > with TIMER_OF_DECLARE(). By the time we get to core_initcall() used for
> > clk-exynos850 platform driver init, it's already too late. Inability to
> > get "mct" clock in MCT driver leads to kernel panic, as functions
> > registered with *_OF_DECLARE() can't do deferred calls. MCT timer driver
> > can't be fixed either, as it's acting as a clock source and it's
> > essential to register it in start_kernel() -> time_init().
> >
> > Let's register CMU_PERI clocks early, using CLK_OF_DECLARE_DRIVER(), and
> > do all stuff relying on "struct dev" object (like runtime PM and
> > enabling bus clock) later in platform driver probe. Basically
> > CLK_OF_DECLARE_DRIVER() matches CMU compatible, but clears OF_POPULATED
> > flag, which allows the same device to be matched again later.
>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> >  drivers/clk/samsung/clk-exynos850.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> > index 95e373d17b42..ecffa5c7a081 100644
> > --- a/drivers/clk/samsung/clk-exynos850.c
> > +++ b/drivers/clk/samsung/clk-exynos850.c
> > @@ -753,6 +753,15 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
> >       .clk_name               = "dout_peri_bus",
> >  };
> >
> > +static void __init exynos850_cmu_peri_init(struct device_node *np)
> > +{
> > +     exynos850_init_clocks(np, peri_clk_regs, ARRAY_SIZE(peri_clk_regs));
> > +     samsung_cmu_register_one(np, &peri_cmu_info);
> > +}
> > +
> > +CLK_OF_DECLARE_DRIVER(exynos850_cmu_peri, "samsung,exynos850-cmu-peri",
> > +                   exynos850_cmu_peri_init);
> > +
> >  /* ---- CMU_CORE ------------------------------------------------------------ */
> >
> >  /* Register Offset definitions for CMU_CORE (0x12000000) */
> > @@ -920,8 +929,12 @@ static int __init exynos850_cmu_probe(struct platform_device *pdev)
> >       struct device_node *np = dev->of_node;
> >
> >       info = of_device_get_match_data(dev);
> > -     exynos850_init_clocks(np, info->clk_regs, info->nr_clk_regs);
> > -     samsung_cmu_register_one(np, info);
> > +
> > +     /* Early clocks are already registered using CLK_OF_DECLARE_DRIVER() */
> > +     if (info != &peri_cmu_info) {
> > +             exynos850_init_clocks(np, info->clk_regs, info->nr_clk_regs);
> > +             samsung_cmu_register_one(np, info);
> > +     }
>
> Don't you also need to register early CMU_TOP, which provides clocks
> for CMU_PERI? I'm afraid it might not work properly when you register
> CMU_PERI clocks early and only later in probe() you enable parent clock
> required for the already registered clocks to be usable.

Good point, I'll do that in v2. Not sure how I missed that dependency
point, but thank you for noticing that. Guess it only works for me
because clocks are already enabled in bootloader, and I'm using
"clk_ignore_unused" param for now.

> How about registering also CMU_TOP early and enabling parent clock
> also in OF_CLK_DECLARE init callback, i.e. using either OF_CLK_DECLARE
> or platform driver for a CMU?
>

If you mean doing clk_prepare_enable() for "dout_peri_bus" clock in
exynos850_cmu_peri_init(), I don't think it's possible. clk_get()
needs "struct device *dev", and we only have that in platform driver
probe. Trying to pass dev=NULL won't work, so that's why I'm enabling
parent clocks in platform driver probe.

I'm going to submit new patch series soon. It'll include all my recent
patches, addressing all your comments. We can continue discussion
there, in case I misunderstood you and those patches are still not
correct.

Thanks!

> --
> Regards,
> Sylwester
