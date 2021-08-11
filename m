Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540A73E8AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhHKHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhHKHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:16:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F0C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:16:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w1so3433273lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptI9HsAkH6psbvQLq59qiVCAIoOn3HK/YdpB6ebxNb4=;
        b=NkZ4NKrCdoaLljKqt/XQaQY71fH6LUWFfNWZDnUS7eghZwGdV6k9538wOh3wiRUwcK
         bIX7YMdUvdgxdKzIjFlzqYq6eEgPzhCqlU2FgjGva2QPzW0Sp+fA+u68/XFVPog1dGMU
         3zNW1bBbk1lPwjKsFG8sDsQ5/oTpCLPBqlYPbIWb+xh5PrGz+pjRw6iQn80sUu6imE8g
         oNNw5JqRR17/MbYzkrFUsAXN8cWDYweLFAhIrH0efb68S84sU8GhRlLAeFYNdkLx6Ou2
         l1zbkxUOFpEgZaBqrIcdmozbqFKWVHE3S1H72X9hlUi7CSDOD0+bHIac7sUnojsN8e0f
         ME0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptI9HsAkH6psbvQLq59qiVCAIoOn3HK/YdpB6ebxNb4=;
        b=QUzUMGuQLaf72w6t1+6rFW53nn7f0pxn8DKCN7hg8OHSyAjFKxL0DnzDl90Mr3llar
         GwSCgsAPcNH/M4YOMnQJ6N+768QDazqstosroC4j6vYqcULDVJ0fmGMI5EpkRDuuD0kw
         mEJGcdIZAeNqNAw/pB8j/s+yIY8hlysyMmaHdVCj1C6p6kh4MvRZzcBS3ZBjiYteVu6p
         vIBlMIPDevBoQUUypxWUNvyXqY8SpKTQIPSCzI+MkkvBz9tY+7wExREjsk7Vx5iZ9sJu
         lDoZb/iARN3UQPJ6wMo0kqknjhqIq3Hux+sDPBuITYyUvq9zu06jXTTWc97o6htVmKOc
         JXrw==
X-Gm-Message-State: AOAM532AKo3kmaHuNk4aFfm0FgHor5oCfpZJYa9ok9egfu2t2CtdN+ay
        VAIFmtGNGsLD/U4w4ABbbcM3OhXkbse8DPH1Vm0bCw==
X-Google-Smtp-Source: ABdhPJz2nrzmGKJFLijXW4uDPxLrbXNUrGUi+4MCAaFYjZhXZ/V6TzKayC5y4sFqeNrzOEg2qAZvSzy2z0m03qetf3o=
X-Received: by 2002:a05:6512:4025:: with SMTP id br37mr3383953lfb.23.1628666167338;
 Wed, 11 Aug 2021 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-4-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-4-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Wed, 11 Aug 2021 00:15:56 -0700
Message-ID: <CAOQ_QsiV=RaYMsYou8TcTf2ePtS0g1jgqpAHA7bni8MaPtL8zA@mail.gmail.com>
Subject: Re: [PATCH 03/13] clocksource/arm_arch_timer: Move system register
 timer programming over to CVAL
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
> In order to cope better with high frequency counters, move the
> programming of the timers from the countdown timer (TVAL) over
> to the comparator (CVAL).
>
> The programming model is slightly different, as we now need to
> read the current counter value to have an absolute deadline
> instead of a relative one.
>
> There is a small overhead to this change, which we will address
> in the following patches.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  arch/arm/include/asm/arch_timer.h    | 14 ++++++++----
>  arch/arm64/include/asm/arch_timer.h  | 16 +++++++++-----
>  drivers/clocksource/arm_arch_timer.c | 32 +++++++++++++++++++++++++---
>  include/clocksource/arm_arch_timer.h |  1 +
>  4 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 88075c7f4bfd..b48de9d26f27 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -31,18 +31,22 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>                 case ARCH_TIMER_REG_CTRL:
>                         asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
>                         break;
> -               case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
> +               case ARCH_TIMER_REG_CVAL:
> +                       asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
>                         break;
> +               case ARCH_TIMER_REG_TVAL:
> +                       BUG();
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
>                         asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
>                         break;
> -               case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
> +               case ARCH_TIMER_REG_CVAL:
> +                       asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
>                         break;
> +               case ARCH_TIMER_REG_TVAL:
> +                       BUG();
>                 }
>         }
>
> @@ -60,6 +64,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                         asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         BUG();
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
> @@ -68,6 +73,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                         asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         BUG();
>                 }
>         }
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 107afb721749..6ceb050ae7b9 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -96,18 +96,22 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>                 case ARCH_TIMER_REG_CTRL:
>                         write_sysreg(val, cntp_ctl_el0);
>                         break;
> -               case ARCH_TIMER_REG_TVAL:
> -                       write_sysreg(val, cntp_tval_el0);
> +               case ARCH_TIMER_REG_CVAL:
> +                       write_sysreg(val, cntp_cval_el0);
>                         break;
> +               case ARCH_TIMER_REG_TVAL:
> +                       BUG();
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
>                         write_sysreg(val, cntv_ctl_el0);
>                         break;
> -               case ARCH_TIMER_REG_TVAL:
> -                       write_sysreg(val, cntv_tval_el0);
> +               case ARCH_TIMER_REG_CVAL:
> +                       write_sysreg(val, cntv_cval_el0);
>                         break;
> +               case ARCH_TIMER_REG_TVAL:
> +                       BUG();
>                 }
>         }
>
> @@ -115,13 +119,14 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  }
>
>  static __always_inline
> -u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
> +u64 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>  {
>         if (access == ARCH_TIMER_PHYS_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
>                         return read_sysreg(cntp_ctl_el0);
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         break;
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
> @@ -129,6 +134,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                 case ARCH_TIMER_REG_CTRL:
>                         return read_sysreg(cntv_ctl_el0);
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         break;
>                 }
>         }
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 0b2bac3ef7ce..898a07dc01cd 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -112,6 +112,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>                 case ARCH_TIMER_REG_TVAL:
>                         writel_relaxed((u32)val, timer->base + CNTP_TVAL);
>                         break;
> +               case ARCH_TIMER_REG_CVAL:
> +                       BUG();
>                 }
>         } else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
>                 struct arch_timer *timer = to_arch_timer(clk);
> @@ -122,6 +124,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>                 case ARCH_TIMER_REG_TVAL:
>                         writel_relaxed((u32)val, timer->base + CNTV_TVAL);
>                         break;
> +               case ARCH_TIMER_REG_CVAL:
> +                       BUG();
>                 }
>         } else {
>                 arch_timer_reg_write_cp15(access, reg, val);
> @@ -141,6 +145,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>                         val = readl_relaxed(timer->base + CNTP_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         BUG();
>                 }
>         } else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
> @@ -150,6 +155,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>                         val = readl_relaxed(timer->base + CNTV_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> +               case ARCH_TIMER_REG_CVAL:
>                         BUG();
>                 }
>         } else {
> @@ -687,10 +693,18 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
>                                            struct clock_event_device *clk)
>  {
>         unsigned long ctrl;
> +       u64 cnt;
> +
>         ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
>         ctrl |= ARCH_TIMER_CTRL_ENABLE;
>         ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> -       arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
> +
> +       if (access == ARCH_TIMER_PHYS_ACCESS)
> +               cnt = __arch_counter_get_cntpct();
> +       else
> +               cnt = __arch_counter_get_cntvct();
> +
> +       arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
>         arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
>  }
>
> @@ -708,17 +722,29 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
>         return 0;
>  }
>
> +static __always_inline void set_next_event_mem(const int access, unsigned long evt,
> +                                          struct clock_event_device *clk)
> +{
> +       unsigned long ctrl;
> +       ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
> +       ctrl |= ARCH_TIMER_CTRL_ENABLE;
> +       ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
> +
> +       arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
> +       arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> +}
> +
>  static int arch_timer_set_next_event_virt_mem(unsigned long evt,
>                                               struct clock_event_device *clk)
>  {
> -       set_next_event(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
> +       set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
>         return 0;
>  }
>
>  static int arch_timer_set_next_event_phys_mem(unsigned long evt,
>                                               struct clock_event_device *clk)
>  {
> -       set_next_event(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
> +       set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
>         return 0;
>  }
>
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 73c7139c866f..d59537afb29d 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -25,6 +25,7 @@
>  enum arch_timer_reg {
>         ARCH_TIMER_REG_CTRL,
>         ARCH_TIMER_REG_TVAL,
> +       ARCH_TIMER_REG_CVAL,
>  };
>
>  enum arch_timer_ppi_nr {
> --
> 2.30.2
>
