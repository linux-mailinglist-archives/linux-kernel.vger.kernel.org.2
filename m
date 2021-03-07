Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA1332FE96
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCGDqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCGDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:46:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF4C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 19:46:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m22so13602834lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 19:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK42aRGGlm/OwUAIuhucFNHyVgULs1imdF3+9v0RPss=;
        b=Od2sV+XL9dGBoMe9POd50mG8LzJC512QQXHmO81U27GfgmPEhF34q6AqrDA9r8k0Yd
         peUUq+yqmbfOckVB2is5/u2tK2nfPuelbHUK9xvG6+Xe5tjWDoTGVMhuMERtgFsLOEPQ
         EArmVnh15DuxPm1HUuXcSLhAWLmCrPp6e7Gogx4wrzBc85+52Gpx1swUu4MERHz14uAD
         bW1Ss8o2HbYs6LawyIxuRFdt5hdrRJjYm8xH7mkfKu7jf8xlqvSA40ZHWbLdp21k4f8a
         czleOcwq1m08z1RN8Dz3r6CybxVIr9PF0Td0kZ3XhSRCDj7GLIEiJtVIOm7qNquV1Dff
         Nglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK42aRGGlm/OwUAIuhucFNHyVgULs1imdF3+9v0RPss=;
        b=lO2Jrk1gfbFst9gn51PFVLB/c9l2tJ1yZ80mJywehyqiJHfE3zEjZ5D+LYMudp3BQh
         GCxQWf1dwt2L0fqEVb01Rt4h8vcrlhdJwAuNpxz2++oZ1mvgOp9ZkKJMXkuUB5aqL425
         tcg6l/F4TAWMWDaVs/Rl7fOBE+ArK1tMPTDOME+HmUOhIdrzbZV4hUlBjK318BccDP5M
         kL+JjM2ihFq5z8Kw5YVNh9KkIcKHolz4HQx/t/l0eezhiZZdJtYzNVJDlLd2SAjrv/TT
         pkTKI1AZ2/W0D5lx87t11qEXSf0l1GctPq9e+nX8GgU2l0RqUF13KMgz/Cc4m1lp419f
         frpw==
X-Gm-Message-State: AOAM5305yTkGAJqyh1EZgk2nBRrfarsaLVzt3gOCyGStVLOh1RCV+hr/
        xxrnZIXj61amC85dcDIY+Wb7ri41LEFhaY3/r8otwGXa3PE=
X-Google-Smtp-Source: ABdhPJxRKFoNmd92l+KRp5t2vy9zd1/V7LfqWmVyfpZjV8w8pdakYgr48HMBAWRHVDUXwnNEly1gYfskwlCIa4SYA30=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr10162815lfu.87.1615088761838;
 Sat, 06 Mar 2021 19:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20210307022446.63732-1-guoren@kernel.org> <20210307022446.63732-2-guoren@kernel.org>
In-Reply-To: <20210307022446.63732-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 Mar 2021 09:15:49 +0530
Message-ID: <CAAhSdy16JtDj81iXgXTY=n2i-svvR4u8y=1WxmxwZgAPNiH7cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Enable generic clockevent broadcast
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 7:55 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When percpu-timers are stopped by deep power saving mode, we
> need system timer help to broadcast IPI_TIMER.
>
> This is first introduced by broken x86 hardware, where the local apic
> timer stops in C3 state. But many other architectures(powerpc, mips,
> arm, hexagon, openrisc, sh) have supported the infrastructure to
> deal with Power Management issues.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Greentime Hu <greentime.hu@sifive.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig      |  2 ++
>  arch/riscv/kernel/smp.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 85d626b8ce5e..8637e7344abe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>         select ARCH_HAS_SET_DIRECT_MAP
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> +       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> @@ -39,6 +40,7 @@ config RISCV
>         select EDAC_SUPPORT
>         select GENERIC_ARCH_TOPOLOGY if SMP
>         select GENERIC_ATOMIC64 if !64BIT
> +       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>         select GENERIC_EARLY_IOREMAP
>         select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>         select GENERIC_IOREMAP
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index ea028d9e0d24..8325d33411d8 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/cpu.h>
> +#include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/profile.h>
> @@ -27,6 +28,7 @@ enum ipi_message_type {
>         IPI_CALL_FUNC,
>         IPI_CPU_STOP,
>         IPI_IRQ_WORK,
> +       IPI_TIMER,
>         IPI_MAX
>  };
>
> @@ -176,6 +178,12 @@ void handle_IPI(struct pt_regs *regs)
>                         irq_work_run();
>                 }
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +               if (ops & (1 << IPI_TIMER)) {
> +                       stats[IPI_TIMER]++;
> +                       tick_receive_broadcast();
> +               }
> +#endif
>                 BUG_ON((ops >> IPI_MAX) != 0);
>
>                 /* Order data access and bit testing. */
> @@ -192,6 +200,7 @@ static const char * const ipi_names[] = {
>         [IPI_CALL_FUNC]         = "Function call interrupts",
>         [IPI_CPU_STOP]          = "CPU stop interrupts",
>         [IPI_IRQ_WORK]          = "IRQ work interrupts",
> +       [IPI_TIMER]             = "Timer broadcast interrupts",
>  };
>
>  void show_ipi_stats(struct seq_file *p, int prec)
> @@ -217,6 +226,13 @@ void arch_send_call_function_single_ipi(int cpu)
>         send_ipi_single(cpu, IPI_CALL_FUNC);
>  }
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +void tick_broadcast(const struct cpumask *mask)
> +{
> +       send_ipi_mask(mask, IPI_TIMER);
> +}
> +#endif
> +
>  void smp_send_stop(void)
>  {
>         unsigned long timeout;
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
