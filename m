Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED633E8AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhHKHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhHKHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:02:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E3C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:02:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u13so2914357lje.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rLTiBuo1leM5lyd26n8wd7axdx6DDYgQbNpZJBd0Oc=;
        b=ly5yxz8SuOEKpH44a5fgHXCGCc2V460wJe9kffPRU/kXJhcmjCjZB6e05MW5EvA/VY
         Q3Bx26Ba7V9EDRs1R5pqrmCRuGRLe0rO39kdHRS1W6jP8bVkN0PsJEoYzFQGldfIhdus
         TjpfL+jFdNEGKQ8A3jjUvQXKK+2dNHDcvn697wTNwRYghIPVSNEsItcAsGtmu6shv+d6
         LoLNd4ENoQF2rqh8m6uDw7uPdZRZX9JtYEXRLxjJ9t1e98X/iPd+aYdYnXsTcwJVEsGV
         mNNEnVzx0hIxKsd4+1qjWVtnsQYrURQrrAtuyPw24zzx95UKg5IYCqTe81S59PwcJ6Jw
         4GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rLTiBuo1leM5lyd26n8wd7axdx6DDYgQbNpZJBd0Oc=;
        b=d/Cfp4RowesKzFeHw4s/uPA5FUjQ3B/Y6kOkpKwCqN6LpRdCe88uAvCerdaLEBDLk2
         0CpM8coMMAb9R3XdMw0qnkdRxdoCww7j1hDuEncVO2tFALuOs8X7GFvJmNVlI0gdffhf
         99jgaA+QYHRl2ljN2FegQe9Kr3Pv9+VvaEuAnEcRxxF0ADkr5gpG+SHuSL0EJoAY6DRe
         FE9A4VNtiusmrjGEzmYhU9BS89NWS6piEtu2lDJwgcIg5zYvi05+pJMDYCuwPoTgdLf9
         cmU/PNdrDZSc0Bql/ABtHOEc0agJMA3T8z3/IqIDofdF+l4eXBmrgHg7YKYI+KrbFVYl
         YuXQ==
X-Gm-Message-State: AOAM5303KZes+TGFaRSnhkhpn+E0O8UHK98Yk/RmaTZ2pHpo+7phTsDS
        QilpnXt3pHVlOYVQxhO8CoPAVy0kWHbvirzHdXK7CQ==
X-Google-Smtp-Source: ABdhPJxHa6S0+cXreWzlP/8hEJHh6byHNBYMULmwsE3/e/DzvfdKw7s4xwfbTpTNAVb3nFd2KQbi7JDxkkoJQ8gRLH0=
X-Received: by 2002:a2e:a5c1:: with SMTP id n1mr1273589ljp.65.1628665336671;
 Wed, 11 Aug 2021 00:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-2-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-2-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Wed, 11 Aug 2021 00:02:05 -0700
Message-ID: <CAOQ_Qsi00vkzX6fzRDDNQw+b+NXN_vZx+Tw0QG=952E=jq6yXQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] clocksource/arm_arch_timer: Drop CNT*_TVAL read accessors
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
> The arch timer driver never reads the various TVAL registers, only
> writes to them. It is thus pointless to provide accessors
> for them and to implement errata workarounds.
>
> Drop these read-side accessors, and add a couple of BUG() statements
> for the time being. These statements will be removed further down
> the line.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  arch/arm/include/asm/arch_timer.h    |  6 ++--
>  arch/arm64/include/asm/arch_timer.h  | 17 ++---------
>  drivers/clocksource/arm_arch_timer.c | 44 ++--------------------------
>  3 files changed, 6 insertions(+), 61 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 99175812d903..0c09afaa590d 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -60,8 +60,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                         asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
> -                       break;
> +                       BUG();
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
>                 switch (reg) {
> @@ -69,8 +68,7 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                         asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
> -                       break;
> +                       BUG();
>                 }
>         }
>
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 88d20f04c64a..8e3b2ac60c30 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -52,8 +52,6 @@ struct arch_timer_erratum_workaround {
>         enum arch_timer_erratum_match_type match_type;
>         const void *id;
>         const char *desc;
> -       u32 (*read_cntp_tval_el0)(void);
> -       u32 (*read_cntv_tval_el0)(void);
>         u64 (*read_cntpct_el0)(void);
>         u64 (*read_cntvct_el0)(void);
>         int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
> @@ -64,17 +62,6 @@ struct arch_timer_erratum_workaround {
>  DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
>                 timer_unstable_counter_workaround);
>
> -/* inline sysreg accessors that make erratum_handler() work */
> -static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
> -{
> -       return read_sysreg(cntp_tval_el0);
> -}
> -
> -static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
> -{
> -       return read_sysreg(cntv_tval_el0);
> -}
> -
>  static inline notrace u64 arch_timer_read_cntpct_el0(void)
>  {
>         return read_sysreg(cntpct_el0);
> @@ -135,14 +122,14 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>                 case ARCH_TIMER_REG_CTRL:
>                         return read_sysreg(cntp_ctl_el0);
>                 case ARCH_TIMER_REG_TVAL:
> -                       return arch_timer_reg_read_stable(cntp_tval_el0);
> +                       break;
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
>                         return read_sysreg(cntv_ctl_el0);
>                 case ARCH_TIMER_REG_TVAL:
> -                       return arch_timer_reg_read_stable(cntv_tval_el0);
> +                       break;
>                 }
>         }
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index be6d741d404c..9db5c16e31e7 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -141,8 +141,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>                         val = readl_relaxed(timer->base + CNTP_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       val = readl_relaxed(timer->base + CNTP_TVAL);
> -                       break;
> +                       BUG();
>                 }
>         } else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
>                 struct arch_timer *timer = to_arch_timer(clk);
> @@ -151,8 +150,7 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>                         val = readl_relaxed(timer->base + CNTV_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       val = readl_relaxed(timer->base + CNTV_TVAL);
> -                       break;
> +                       BUG();
>                 }
>         } else {
>                 val = arch_timer_reg_read_cp15(access, reg);
> @@ -239,16 +237,6 @@ struct ate_acpi_oem_info {
>         _new;                                           \
>  })
>
> -static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
> -{
> -       return __fsl_a008585_read_reg(cntp_tval_el0);
> -}
> -
> -static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
> -{
> -       return __fsl_a008585_read_reg(cntv_tval_el0);
> -}
> -
>  static u64 notrace fsl_a008585_read_cntpct_el0(void)
>  {
>         return __fsl_a008585_read_reg(cntpct_el0);
> @@ -285,16 +273,6 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
>         _new;                                                   \
>  })
>
> -static u32 notrace hisi_161010101_read_cntp_tval_el0(void)
> -{
> -       return __hisi_161010101_read_reg(cntp_tval_el0);
> -}
> -
> -static u32 notrace hisi_161010101_read_cntv_tval_el0(void)
> -{
> -       return __hisi_161010101_read_reg(cntv_tval_el0);
> -}
> -
>  static u64 notrace hisi_161010101_read_cntpct_el0(void)
>  {
>         return __hisi_161010101_read_reg(cntpct_el0);
> @@ -379,16 +357,6 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
>  {
>         return __sun50i_a64_read_reg(cntvct_el0);
>  }
> -
> -static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
> -{
> -       return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
> -}
> -
> -static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
> -{
> -       return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
> -}
>  #endif
>
>  #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
> @@ -438,8 +406,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .match_type = ate_match_dt,
>                 .id = "fsl,erratum-a008585",
>                 .desc = "Freescale erratum a005858",
> -               .read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
> -               .read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
>                 .read_cntpct_el0 = fsl_a008585_read_cntpct_el0,
>                 .read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
>                 .set_next_event_phys = erratum_set_next_event_tval_phys,
> @@ -451,8 +417,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .match_type = ate_match_dt,
>                 .id = "hisilicon,erratum-161010101",
>                 .desc = "HiSilicon erratum 161010101",
> -               .read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
> -               .read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
>                 .read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>                 .read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
>                 .set_next_event_phys = erratum_set_next_event_tval_phys,
> @@ -462,8 +426,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .match_type = ate_match_acpi_oem_info,
>                 .id = hisi_161010101_oem_info,
>                 .desc = "HiSilicon erratum 161010101",
> -               .read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
> -               .read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
>                 .read_cntpct_el0 = hisi_161010101_read_cntpct_el0,
>                 .read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
>                 .set_next_event_phys = erratum_set_next_event_tval_phys,
> @@ -484,8 +446,6 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>                 .match_type = ate_match_dt,
>                 .id = "allwinner,erratum-unknown1",
>                 .desc = "Allwinner erratum UNKNOWN1",
> -               .read_cntp_tval_el0 = sun50i_a64_read_cntp_tval_el0,
> -               .read_cntv_tval_el0 = sun50i_a64_read_cntv_tval_el0,
>                 .read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
>                 .read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
>                 .set_next_event_phys = erratum_set_next_event_tval_phys,
> --
> 2.30.2
>
