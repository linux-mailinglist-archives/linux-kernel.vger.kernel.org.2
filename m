Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F813E4A22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhHIQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:42:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:42:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m9so24526462ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0L46GNwVNhS6BcTRCD6YmQlBFO5AocAQ1zmSjP7eDA=;
        b=fV2Ots+U75gJK4rdV7Gkw663FHzj9qPLAGBYDML39+05IaDxr6/7muOK4gFdBB93JC
         3ZM6hBuTahI/4ALZXLIpTDaXX7Tuag81H63MSCWBlGtDZJyWAmN1nmo5n4ieurMODrTD
         uHsYVes4qcwgT08AEzqChKw+l4n0F+U85nXrQaFpy+L6dC9K6QJiip+lYUis8MFaPync
         4hYkec9a7O1LZEyWmH+IglksHXDf3qlyQRPhNXny4g26VEJIMUffVh6udi97FXbdomon
         5iqANcrhCmCURKMYIRing4Hktf/0tI0BYM6NJ5FsqDWl8MGHG6qV0Jzt5iIp80vfOm0L
         Js0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0L46GNwVNhS6BcTRCD6YmQlBFO5AocAQ1zmSjP7eDA=;
        b=dD5RvPI27g1dlJp3chDcVcou6UQwNV5JR6l+qvzOAElQpLjuFaw5n5Yr4BZwqUHh0w
         P4JtEUmATK9ScEnxhjNMrMhRTTv+1pMkMKWCkraZn0gFlXSZzMdRnXPVlcIGGkuOQeZc
         cNemaHC45CXD3rhvBJGXRHy4eof5/mOm88DckDS9UjmoyCKVTjV2EOseY/7RyJo6gIwV
         wP+lAhYcxMtB2fd0fR75Wn+CdrzPOH4VrMtt+52CGIg3CbOcPrktqNOj6nX4wNf5ppPj
         Q8iMEVoh8Zu8gM9AJtMa5h30ri5Nw+qIMQj5AH6p/hJI05AK5tljPx6k9/HjuE4bu0Uk
         nsaA==
X-Gm-Message-State: AOAM530XgZETnTA1aEm1BPW2Wg6THpylsn7deZhWVhZZaYaXZpPdL2Mi
        vfB8fF/Nry4vbYOpVDE8A1EWEdG7bd5F/JOV6e+LIQ==
X-Google-Smtp-Source: ABdhPJxqZWQhyMCKHHP0SH7t5512vpnJZZqDvwR48RjMKEqV9en67B8DJvEkAOVH4DCQk83co2JFttVHK5ZZj+mhVaI=
X-Received: by 2002:a2e:80ca:: with SMTP id r10mr15371387ljg.331.1628527331936;
 Mon, 09 Aug 2021 09:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-14-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-14-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:42:00 -0700
Message-ID: <CAOQ_QshjRWh=onT-j3dWgmVfnAXsMFJoz0i7OEezQxkW4O9KZA@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
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

On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
>
> CNTPCTSS_EL0 and CNTVCTSS_EL0 are alternatives to the usual
> CNTPCT_EL0 and CNTVCT_EL0 that do not require a previous ISB
> to be synchronised (SS stands for Self-Synchronising).
>
> Use the ARM64_HAS_ECV capability to control alternative sequences
> that switch to these low(er)-cost primitives. Note that the
> counter access in the VDSO is for now left alone until we decide
> whether we want to allow this.

What remains to be figured out before we add this to the vDSO (and
presumably advertise to userspace through some standard convention)?
It would be nice to skip the trap handler altogether, unless there's a
can of worms lurking that I'm not aware of.

--
Thanks,
Oliver

> For a good measure, wire the cntvct hooks to also handle CNTVCTSS.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/arch_timer.h | 30 +++++++++++++++++++++++------
>  arch/arm64/include/asm/esr.h        |  6 ++++++
>  arch/arm64/include/asm/sysreg.h     |  3 +++
>  arch/arm64/kernel/traps.c           | 11 +++++++++++
>  4 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index b2f056db1225..785411a48512 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -64,12 +64,26 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
>
>  static inline notrace u64 arch_timer_read_cntpct_el0(void)
>  {
> -       return read_sysreg(cntpct_el0);
> +       u64 cnt;
> +
> +       asm volatile(ALTERNATIVE("isb\n mrs %x0, cntpct_el0",
> +                                "nop\n" __mrs_s("%x0", SYS_CNTPCTSS_EL0),
> +                                ARM64_HAS_ECV)
> +                    : "=r" (cnt));
> +
> +       return cnt;
>  }
>
>  static inline notrace u64 arch_timer_read_cntvct_el0(void)
>  {
> -       return read_sysreg(cntvct_el0);
> +       u64 cnt;
> +
> +       asm volatile(ALTERNATIVE("isb\n mrs %x0, cntvct_el0",
> +                                "nop\n" __mrs_s("%x0", SYS_CNTVCTSS_EL0),
> +                                ARM64_HAS_ECV)
> +                    : "=r" (cnt));
> +
> +       return cnt;
>  }
>
>  #define arch_timer_reg_read_stable(reg)                                        \
> @@ -166,8 +180,10 @@ static __always_inline u64 __arch_counter_get_cntpct(void)
>  {
>         u64 cnt;
>
> -       isb();
> -       cnt = read_sysreg(cntpct_el0);
> +       asm volatile(ALTERNATIVE("isb\n mrs %x0, cntpct_el0",
> +                                "nop\n" __mrs_s("%x0", SYS_CNTPCTSS_EL0),
> +                                ARM64_HAS_ECV)
> +                    : "=r" (cnt));
>         arch_counter_enforce_ordering(cnt);
>         return cnt;
>  }
> @@ -186,8 +202,10 @@ static __always_inline u64 __arch_counter_get_cntvct(void)
>  {
>         u64 cnt;
>
> -       isb();
> -       cnt = read_sysreg(cntvct_el0);
> +       asm volatile(ALTERNATIVE("isb\n mrs %x0, cntvct_el0",
> +                                "nop\n" __mrs_s("%x0", SYS_CNTVCTSS_EL0),
> +                                ARM64_HAS_ECV)
> +                    : "=r" (cnt));
>         arch_counter_enforce_ordering(cnt);
>         return cnt;
>  }
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 29f97eb3dad4..a305ce256090 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -227,6 +227,9 @@
>  #define ESR_ELx_SYS64_ISS_SYS_CNTVCT   (ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
>                                          ESR_ELx_SYS64_ISS_DIR_READ)
>
> +#define ESR_ELx_SYS64_ISS_SYS_CNTVCTSS (ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 6, 14, 0) | \
> +                                        ESR_ELx_SYS64_ISS_DIR_READ)
> +
>  #define ESR_ELx_SYS64_ISS_SYS_CNTFRQ   (ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 0, 14, 0) | \
>                                          ESR_ELx_SYS64_ISS_DIR_READ)
>
> @@ -317,6 +320,9 @@
>  #define ESR_ELx_CP15_64_ISS_SYS_CNTVCT (ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
>                                          ESR_ELx_CP15_64_ISS_DIR_READ)
>
> +#define ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS (ESR_ELx_CP15_64_ISS_SYS_VAL(9, 14) | \
> +                                        ESR_ELx_CP15_64_ISS_DIR_READ)
> +
>  #define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ (ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
>                                          ESR_ELx_CP15_32_ISS_DIR_READ)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7b9c3acba684..897f9c882895 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -506,6 +506,9 @@
>
>  #define SYS_CNTFRQ_EL0                 sys_reg(3, 3, 14, 0, 0)
>
> +#define SYS_CNTPCTSS_EL0               sys_reg(3, 3, 14, 0, 5)
> +#define SYS_CNTVCTSS_EL0               sys_reg(3, 3, 14, 0, 6)
> +
>  #define SYS_CNTP_TVAL_EL0              sys_reg(3, 3, 14, 2, 0)
>  #define SYS_CNTP_CTL_EL0               sys_reg(3, 3, 14, 2, 1)
>  #define SYS_CNTP_CVAL_EL0              sys_reg(3, 3, 14, 2, 2)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b03e383d944a..16710ca55fbb 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -653,6 +653,12 @@ static const struct sys64_hook sys64_hooks[] = {
>                 .esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
>                 .handler = cntvct_read_handler,
>         },
> +       {
> +               /* Trap read access to CNTVCTSS_EL0 */
> +               .esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
> +               .esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCTSS,
> +               .handler = cntvct_read_handler,
> +       },
>         {
>                 /* Trap read access to CNTFRQ_EL0 */
>                 .esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
> @@ -729,6 +735,11 @@ static const struct sys64_hook cp15_64_hooks[] = {
>                 .esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCT,
>                 .handler = compat_cntvct_read_handler,
>         },
> +       {
> +               .esr_mask = ESR_ELx_CP15_64_ISS_SYS_MASK,
> +               .esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS,
> +               .handler = compat_cntvct_read_handler,
> +       },
>         {},
>  };
>
> --
> 2.30.2
>
