Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A23E4A52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhHIQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhHIQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:52:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354EBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:52:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h17so13243814ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nkkh1U3atW0wFVblUAUwz3U6Ysfi6ZmHN/6NdKcARm4=;
        b=pHWG3hQ+DEQyjCLGz2fOy2JMERLzEblQQqDyvFDangUkSAxp3k9kcdK3iusdgP6nBt
         Sn8LoukVuT52IPewW/qKmMcsFoIGl2N3tg073MuOXFsnupnRm/s4nYVPCjs7qOP1fd15
         TcKEuoSokdoSzIakTYwHc9A1BZCSkS/A/ry5jQ/YVy9gVmDGfjTEFFWu1CvlovaVVEm0
         8uvIRskkYFcsIUlAEULIH6htlvBifD26BHIo9wTyCvCcdcTPWYQ1Yjsmz7KTCr20q4T/
         LrkhLN0B+UqM+BfIJ6WAbWZsIrsVQMydlQAjcZD+M8bq7dNMwf+4Ih7zHvtxk+n1kUv9
         pE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nkkh1U3atW0wFVblUAUwz3U6Ysfi6ZmHN/6NdKcARm4=;
        b=OYGpThaUQpg639Y7Exzj0UZfxyiI/uB5J7a2swLaFjVfRELMwO7ntioiiEGFsQ/stC
         eoZfaubg7gZBa6nrcysMEzgXcla96yUF7yiMArjBVSmkm4UFtfhDaRWmgEw+Mdq4OtSx
         Qmhxo9dSL/PXPVQDj+O7llSD9S1gJWHm4Kd2k404Zi6v2TNzRVQI1CXphYu7e0aB5RaR
         5kmpTX1+hPhxhlhjY95epGJZD21RieDbuwBf8LHWE+9u1snbvA+vFCDPzgKDlNcYcAeL
         mFGSMcfsL+isRMdSQ5lbDlXDHdINua0r6bTAiiDfXEDaWX2RqTXCzoFy2bsrUwVXkpLt
         QzOw==
X-Gm-Message-State: AOAM533d2YWXxWxniwEN9LJyFKacs15ax9D6Xf3jf48Uvil3vVognvy/
        HlCaV6onWHuj48SaPuETve3oRlasMykTawhoAYkJGg==
X-Google-Smtp-Source: ABdhPJzH7lNLYUcTONIii6FuBGA164RglZr+32bu0cdXLF3d7jJH0tiV28ElCACZthwIOBX5Wqk/km0Eg40BQqAKVw8=
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr13863999ljp.388.1628527931302;
 Mon, 09 Aug 2021 09:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-6-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-6-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:52:00 -0700
Message-ID: <CAOQ_QsjATdRRFdiG5kR+Ni7X-_kMaF+V_XQx3uuxivk0t4xt_w@mail.gmail.com>
Subject: Re: [PATCH 05/13] clocksource/arm_arch_timer: Fix MMIO base address
 vs callback ordering issue
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 8:27 AM Marc Zyngier <maz@kernel.org> wrote:
>
> The MMIO timer base address gets published after we have registered
> the callbacks and the interrupt handler, which is... a bit dangerous.
>
> Fix this by moving the base address publication to the point where
> we register the timer, and expose a pointer to the timer structure
> itself rather than a naked value.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Is this patch stable-worthy? I take it there haven't been any reports
of issues, though this seems rather perilous.

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  drivers/clocksource/arm_arch_timer.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 160464f75017..ca7761d8459a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -54,13 +54,13 @@
>
>  static unsigned arch_timers_present __initdata;
>
> -static void __iomem *arch_counter_base __ro_after_init;
> -
>  struct arch_timer {
>         void __iomem *base;
>         struct clock_event_device evt;
>  };
>
> +static struct arch_timer *arch_timer_mem __ro_after_init;
> +
>  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
>
>  static u32 arch_timer_rate __ro_after_init;
> @@ -975,9 +975,9 @@ static u64 arch_counter_get_cntvct_mem(void)
>         u32 vct_lo, vct_hi, tmp_hi;
>
>         do {
> -               vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> -               vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> -               tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> +               vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
> +               vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
> +               tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
>         } while (vct_hi != tmp_hi);
>
>         return ((u64) vct_hi << 32) | vct_lo;
> @@ -1168,25 +1168,25 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
>  {
>         int ret;
>         irq_handler_t func;
> -       struct arch_timer *t;
>
> -       t = kzalloc(sizeof(*t), GFP_KERNEL);
> -       if (!t)
> +       arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
> +       if (!arch_timer_mem)
>                 return -ENOMEM;
>
> -       t->base = base;
> -       t->evt.irq = irq;
> -       __arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
> +       arch_timer_mem->base = base;
> +       arch_timer_mem->evt.irq = irq;
> +       __arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
>
>         if (arch_timer_mem_use_virtual)
>                 func = arch_timer_handler_virt_mem;
>         else
>                 func = arch_timer_handler_phys_mem;
>
> -       ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
> +       ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
>         if (ret) {
>                 pr_err("Failed to request mem timer irq\n");
> -               kfree(t);
> +               kfree(arch_timer_mem);
> +               arch_timer_mem = NULL;
>         }
>
>         return ret;
> @@ -1444,7 +1444,6 @@ arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
>                 return ret;
>         }
>
> -       arch_counter_base = base;
>         arch_timers_present |= ARCH_TIMER_TYPE_MEM;
>
>         return 0;
> --
> 2.30.2
>
