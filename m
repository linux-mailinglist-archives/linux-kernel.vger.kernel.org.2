Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C13E4981
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhHIQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:13:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6885C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:13:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m9so24401993ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8WlEulb8AeNf7tLXeGzmUmh0+aQ67ZSDKgWkCZGD2g=;
        b=Wmmb6YeOUVKER5jbjnYHxfSNQjOSZj55iWqnDPXkzFAb8OD9KSMBRZoq1LaWBK7kq4
         7b6pjbS65xRoguQIvH7MMqPf8PMjr7NbETu82gNBnG3tqjvRTBKDGhwvvYu8eIr2IMe3
         0j0WtFlrS+oxYIz56+OejE+nct0e6AW3/YzRwfRblETl3cxHcq7cERE4ZVisx8wK5cF5
         jLURDwnpNwL4sBRe8AoSVJfk3X81zrYZCtREnJcRNazW8Nwy7unv1vG27Q/UzmgshWa7
         +/1OTS6sMrDMImXQiCATUhbIQzPJktCqu1OJZ8Z+JdD4W8HbOQqPf7OA6wS/XORb+BHP
         Us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8WlEulb8AeNf7tLXeGzmUmh0+aQ67ZSDKgWkCZGD2g=;
        b=fxftp1Wa1Eq9c9LLbFgJq+t9jVoncEQiB4TiMCwajmS9zCa7coAcfysimmb/U2GY4Y
         zOguzEpdooMCKDmtg6R/420d1HwRIbnnak0mZApLgSol3y8M0wwStgQbG8vNCGycVQCu
         N+SahFuQivaYMhi9ypSUqXWfFFSQ8AzPmZcfMyAxqB54oGY5egWvcuCwI+QOS1dsPX6s
         rhRlD3vkHtSfscTAoOylvcvNZRnImhXfspaslj+dVaBFOtlkIR/TpfKc4fMdSP8I1nIX
         gm4wh/WAM0+6T75vEmu5QnLqxXgAynABdNMnURu4LMPYNknryQQfcLwHrMI8+kcru0g2
         8UrQ==
X-Gm-Message-State: AOAM531eKkiVTNgctsj4BaYKl61n+Vbb8u6QAv7PF+ZXf9fUVK+18N2c
        1n4x/8038dosk3CBaH0H6FI7iq+fSqv0T0rjKUl+yA==
X-Google-Smtp-Source: ABdhPJwzSyZYjH3UrLs0ru2MScYXvgbMeFrTs3QH5sLg+tJb6Ljh51wWJ/dDF2HKs11fOWRuSRkTSuDbWV67bYBxoOU=
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr13761082ljp.388.1628525583623;
 Mon, 09 Aug 2021 09:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-3-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-3-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:12:52 -0700
Message-ID: <CAOQ_QshJmjSUGVVLOqGJFicDpGfvf159W8utDWMpuT6i4fCBQQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] clocksource/arm_arch_timer: Extend write side of
 timer register accessors to u64
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
> The various accessors for the timer sysreg and MMIO registers are
> currently hardwired to 32bit. However, we are about to introduce
> the use of the CVAL registers, which require a 64bit access.
>
> Upgrade the write side of the accessors to take a 64bit value
> (the read side is left untouched as we don't plan to ever read
> back any of these registers).
>
> No functional change expected.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  arch/arm/include/asm/arch_timer.h    | 10 +++++-----
>  arch/arm64/include/asm/arch_timer.h  |  2 +-
>  drivers/clocksource/arm_arch_timer.c | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 0c09afaa590d..88075c7f4bfd 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -24,24 +24,24 @@ int arch_timer_arch_init(void);
>   * the code. At least it does so with a recent GCC (4.6.3).
>   */
>  static __always_inline
> -void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
> +void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  {
>         if (access == ARCH_TIMER_PHYS_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
> -                       asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
> +                       asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
> +                       asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
>                         break;
>                 }
>         } else if (access == ARCH_TIMER_VIRT_ACCESS) {
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
> -                       asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
> +                       asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
> +                       asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
>                         break;
>                 }
>         }
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 8e3b2ac60c30..107afb721749 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -89,7 +89,7 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
>   * the code.
>   */
>  static __always_inline
> -void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
> +void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
>  {
>         if (access == ARCH_TIMER_PHYS_ACCESS) {
>                 switch (reg) {
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9db5c16e31e7..0b2bac3ef7ce 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -100,27 +100,27 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>   */
>
>  static __always_inline
> -void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
> +void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
>                           struct clock_event_device *clk)
>  {
>         if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
>                 struct arch_timer *timer = to_arch_timer(clk);
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
> -                       writel_relaxed(val, timer->base + CNTP_CTL);
> +                       writel_relaxed((u32)val, timer->base + CNTP_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       writel_relaxed(val, timer->base + CNTP_TVAL);
> +                       writel_relaxed((u32)val, timer->base + CNTP_TVAL);
>                         break;
>                 }
>         } else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
>                 struct arch_timer *timer = to_arch_timer(clk);
>                 switch (reg) {
>                 case ARCH_TIMER_REG_CTRL:
> -                       writel_relaxed(val, timer->base + CNTV_CTL);
> +                       writel_relaxed((u32)val, timer->base + CNTV_CTL);
>                         break;
>                 case ARCH_TIMER_REG_TVAL:
> -                       writel_relaxed(val, timer->base + CNTV_TVAL);
> +                       writel_relaxed((u32)val, timer->base + CNTV_TVAL);
>                         break;
>                 }
>         } else {
> --
> 2.30.2
>
