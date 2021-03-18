Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBB341130
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhCRXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhCRXr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:47:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6F6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:47:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 184so9690645ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOFK5Z7x4fmSXU/29sCiVdnLRxv/rCSizhMtxsSM0ic=;
        b=P6QwJa4XF7QWertR1ymaP42lo6q2WBJHeii4PFGGUWFMQqvd1wOPil5mu5KHEvkaQ6
         n0R5lguHof7KOZKhpAxoFibZHdjRW/3JwWG+c1c99dZbNDKzDvG9O7kV3EZlVxLMx2RV
         uPNbAvo5IB4liP9/Z8wmfHukmYuvDslpUWBEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOFK5Z7x4fmSXU/29sCiVdnLRxv/rCSizhMtxsSM0ic=;
        b=nUhYFQ/o2NR4D+Ef610cqPf4tV4w57o+IV9RjRVbHDKJ03Uc/fBr1RhqD58J0KmRhF
         ApHbuNcZsEmyRTphA0eqnD65nLFBK/8KbhvzqJ3eNhFHMXgEVW4MMUekHGBkeDUIiB3i
         2zCljOFSQBwW8IFyklkIy/wobufqEHc0mlTbmle/83EqyJ044knjV6WNTSHBnrrM81RS
         EcV/SKorHp2VHOckJhelkzOi6x8AFMsVDHIWiT0FK1FzxaiOFoYklKZuSZ0+KzMJwg63
         kntEzjZ658Po/gF7kbdc4pd0keOLcTw5JBExkqh9ejBAqn3hu9QbmAPb3JyvC4ah7gse
         sGlw==
X-Gm-Message-State: AOAM530T4hvZKqfJnAE5Q+CnBbrkJYCU/RnNNyYZ1gEAAwPAk5Mgg7KQ
        ZkC7Jt4Oz6xxTC8Dsa5GnmYCPYFGAz6dFg==
X-Google-Smtp-Source: ABdhPJzidvd8TLbea0kcar7Um0ouFhr/FThhGN2js4f2KzbZf5h4cWRyH8ke5cEsJD9m6K51opVG7A==
X-Received: by 2002:a2e:b0f2:: with SMTP id h18mr6478168ljl.396.1616111243782;
        Thu, 18 Mar 2021 16:47:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d13sm405478lfi.247.2021.03.18.16.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 16:47:23 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id m17so7249260lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:47:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba3:: with SMTP id g35mr2989780lfv.606.1616111242075;
 Thu, 18 Mar 2021 16:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
 <20210318160414.2.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
In-Reply-To: <20210318160414.2.I1d9917047de06715da16e1620759f703fcfdcbcb@changeid>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Fri, 19 Mar 2021 10:46:55 +1100
X-Gmail-Original-Message-ID: <CAKz_xw1BYap=igtp0V8Wdo6vW+3=jvsVDJtukmMoPhvDVeMpRA@mail.gmail.com>
Message-ID: <CAKz_xw1BYap=igtp0V8Wdo6vW+3=jvsVDJtukmMoPhvDVeMpRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/clocksource/mediatek: Ack and disable
 interrupts on shutdown
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There is a suspend failure on mt8173 chromebooks that use this timer.
The failure shows as an errno: -95 failure with none device.

I tracked this down to the arm trusted firmware aborting the suspend
due to this timer having a pending IRQ, due to not being disabled
during suspend / clockevents_shutdown.

Also reviewed here vs the 4.19 chromeos kernel branch:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2766504

Thanks

Evan Benn


On Thu, Mar 18, 2021 at 4:05 PM Evan Benn <evanbenn@chromium.org> wrote:
>
> set_state_shutdown is called during system suspend after interrupts have
> been disabled. If the timer has fired in the meantime, there will be
> a pending IRQ. So we ack that now and disable the timer. Without this
> ARM trusted firmware will abort the suspend due to the pending
> interrupt.
>
> Now always disable the IRQ in state transitions, and re-enable in
> set_periodic and next_event.
>
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
>
>  drivers/clocksource/timer-mediatek-mt6577.c | 49 +++++++++++++--------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/clocksource/timer-mediatek-mt6577.c b/drivers/clocksource/timer-mediatek-mt6577.c
> index 9e5241d1876d..44598121585c 100644
> --- a/drivers/clocksource/timer-mediatek-mt6577.c
> +++ b/drivers/clocksource/timer-mediatek-mt6577.c
> @@ -54,13 +54,33 @@ static u64 notrace mtk_gpt_read_sched_clock(void)
>         return readl_relaxed(gpt_sched_reg);
>  }
>
> +static void mtk_gpt_disable_ack_interrupts(struct timer_of *to, u8 timer)
> +{
> +       u32 val;
> +
> +       /* Disable interrupts */
> +       val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> +       writel(val & ~GPT_IRQ_ENABLE(timer), timer_of_base(to) +
> +              GPT_IRQ_EN_REG);
> +
> +       /* Ack interrupts */
> +       writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> +}
> +
>  static void mtk_gpt_clkevt_time_stop(struct timer_of *to, u8 timer)
>  {
>         u32 val;
>
> +       /* Disable timer */
>         val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>         writel(val & ~GPT_CTRL_ENABLE, timer_of_base(to) +
>                GPT_CTRL_REG(timer));
> +
> +       /* This may be called with interrupts disabled,
> +        * so we need to ack any interrupt that is pending
> +        * Or for example ATF will prevent a suspend from completing.
> +        */
> +       mtk_gpt_disable_ack_interrupts(to, timer);
>  }
>
>  static void mtk_gpt_clkevt_time_setup(struct timer_of *to,
> @@ -74,8 +94,10 @@ static void mtk_gpt_clkevt_time_start(struct timer_of *to,
>  {
>         u32 val;
>
> -       /* Acknowledge interrupt */
> -       writel(GPT_IRQ_ACK(timer), timer_of_base(to) + GPT_IRQ_ACK_REG);
> +       /* Enable interrupts */
> +       val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> +       writel(val | GPT_IRQ_ENABLE(timer),
> +              timer_of_base(to) + GPT_IRQ_EN_REG);
>
>         val = readl(timer_of_base(to) + GPT_CTRL_REG(timer));
>
> @@ -148,21 +170,6 @@ __init mtk_gpt_setup(struct timer_of *to, u8 timer, u8 option)
>                timer_of_base(to) + GPT_CTRL_REG(timer));
>  }
>
> -static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
> -{
> -       u32 val;
> -
> -       /* Disable all interrupts */
> -       writel(0x0, timer_of_base(to) + GPT_IRQ_EN_REG);
> -
> -       /* Acknowledge all spurious pending interrupts */
> -       writel(0x3f, timer_of_base(to) + GPT_IRQ_ACK_REG);
> -
> -       val = readl(timer_of_base(to) + GPT_IRQ_EN_REG);
> -       writel(val | GPT_IRQ_ENABLE(timer),
> -              timer_of_base(to) + GPT_IRQ_EN_REG);
> -}
> -
>  static struct timer_of to = {
>         .flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
>
> @@ -193,6 +200,12 @@ static int __init mtk_gpt_init(struct device_node *node)
>         if (ret)
>                 return ret;
>
> +       /* In case the firmware left the interrupts enabled
> +        * disable and ack those now
> +        */
> +       mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_SRC);
> +       mtk_gpt_disable_ack_interrupts(&to, TIMER_CLK_EVT);
> +
>         /* Configure clock source */
>         mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
>         clocksource_mmio_init(timer_of_base(&to) + GPT_CNT_REG(TIMER_CLK_SRC),
> @@ -206,8 +219,6 @@ static int __init mtk_gpt_init(struct device_node *node)
>         clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
>                                         TIMER_SYNC_TICKS, 0xffffffff);
>
> -       mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
> -
>         return 0;
>  }
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
