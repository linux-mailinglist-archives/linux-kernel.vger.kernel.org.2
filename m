Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC93A6809
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhFNNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:37:42 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:34763 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhFNNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:37:33 -0400
Received: by mail-yb1-f182.google.com with SMTP id c8so13762613ybq.1;
        Mon, 14 Jun 2021 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICFF0gvP4WNJHWCdVhPKr0RwlnFvCsrPtpKk22BCZLQ=;
        b=EmhgcFk2DqMKDyHM3E7HQNDiGpXsM4m9T9EKkiHOjZuY2EH4B0WoHDwdiZ6Vg0vbqP
         EJqQMOPAxLfrf3yW8OUr1y2QBfIF6RzDKplGH42ZszBAcRyrDhQsXtG2Kq81kzBKXK3X
         9JWZtGUZ0DIlqLnitd5jv/on8BCNk1q/VF5ZlI56UO+b4Q7oeyi3nrX+PT5wpSJtDU5b
         Xk+VlLJowpKxDoeOxnfzWKsRJL/o7scLS1EE20VIlzzqY+tpUfdFLDmylsIxMJU6IcH/
         TdxWOn7xktZ4ngEQzk8d6uk6Cc7s8YrFXhbTUNui2AJvatgyDm4FquEh1lcbvW65Jtcp
         1nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICFF0gvP4WNJHWCdVhPKr0RwlnFvCsrPtpKk22BCZLQ=;
        b=A8/3lzKd6A6Pt0rogQKXbYil5d/6AuE8lvbCj+QPQD5aIkqhXbRfljSg/gax0pHwuB
         sB4MxhJy7A6c6CyDKF8MvA5oejYfJ2nQ7zDJm2fhYZ85qwwWnOs2e31vPMi30lKxZ6nP
         sUlcDlsGRshke7Z1ZhXjZFfX6pL1+OdrD+2bg7NJfA3UZBl4XpDQvhMI77e3Eq/GBHx1
         aX5zoovwT4JgDwVYCr8MRIDbod8G1eJzVDZq1NIQCQOeqvH/LQCt2t5ndffkrGqgioT6
         X3dAm3mxgb5wg399fmpZM3+bwOAEengZK4sGskOx5p2flOE09iKsS9eBI/WGFyayjNqc
         cENw==
X-Gm-Message-State: AOAM533hvOKaY95LlYseDJ2+vOnXgX/4Fy5l7jkH1RVcRHCOzSDuuV/Y
        PdSSHSxO/oUvhPs703CWQMuM343IZhjNtGhoc+A=
X-Google-Smtp-Source: ABdhPJzx0RiztLvnYqg26eV9a6k96ttW/ISNP/7urlvspkOhQ+qAr2ajxmUcXb/gW1OKFhvry41rf1BgdMgucq/zteM=
X-Received: by 2002:a25:6c04:: with SMTP id h4mr24796509ybc.122.1623677658008;
 Mon, 14 Jun 2021 06:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-8-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-8-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:34:05 +0800
Message-ID: <CAEUhbmUvjFg7a4xr9p_r0qynwa5DAOejtV77XMUJvwfTOOFu1A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/10] clocksource: clint: Add support for ACLINT
 MTIMER device
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:07 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The RISC-V ACLINT specification is a modular specification and the
> ACLINT MTIMER device is compatible with the M-mode timer functionality
> of the CLINT device. This patch extends the CLINT driver to support
> both CLINT device and ACLINT MTIMER device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/clocksource/timer-clint.c | 43 +++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index dfdcd94c1fd5..ca329c450810 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -2,8 +2,15 @@
>  /*
>   * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>   *
> - * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
> - * CLINT MMIO timer device.
> + * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a CLINT
> + * MMIO device which is a composite device capable of injecting M-mode
> + * software interrupts and M-mode timer interrupts.
> + *
> + * The RISC-V ACLINT specification is modular in nature and defines
> + * separate devices for M-mode software interrupt (MSWI), M-mode timer
> + * (MTIMER) and S-mode software interrupt (SSWI).
> + *
> + * This is a common driver for CLINT device and ACLINT MTIMER device.
>   */
>
>  #define pr_fmt(fmt) "clint: " fmt
> @@ -21,14 +28,20 @@
>  #include <linux/smp.h>
>  #include <linux/timex.h>
>
> -#ifndef CONFIG_RISCV_M_MODE
> +#ifdef CONFIG_RISCV_M_MODE
>  #include <asm/clint.h>
> +
> +u64 __iomem *clint_time_val;
> +EXPORT_SYMBOL(clint_time_val);
>  #endif
>
>  #define CLINT_IPI_OFF          0
>  #define CLINT_TIMER_CMP_OFF    0x4000
>  #define CLINT_TIMER_VAL_OFF    0xbff8
>
> +#define ACLINT_MTIMER_CMP_OFF  0x0000
> +#define ACLINT_MTIMER_VAL_OFF  0x7ff8
> +
>  /* CLINT manages IPI and Timer for RISC-V M-mode  */
>  static u32 __iomem *clint_ipi_base;
>  static u64 __iomem *clint_timer_cmp;
> @@ -36,11 +49,6 @@ static u64 __iomem *clint_timer_val;
>  static unsigned long clint_timer_freq;
>  static unsigned int clint_timer_irq;
>
> -#ifdef CONFIG_RISCV_M_MODE
> -u64 __iomem *clint_time_val;
> -EXPORT_SYMBOL(clint_time_val);
> -#endif
> -
>  static void clint_send_ipi(const struct cpumask *target)
>  {
>         unsigned int cpu;
> @@ -191,9 +199,15 @@ static int __init clint_timer_init_dt(struct device_node *np)
>                 return -ENODEV;
>         }
>
> -       clint_ipi_base = base + CLINT_IPI_OFF;
> -       clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
> -       clint_timer_val = base + CLINT_TIMER_VAL_OFF;
> +       if (of_device_is_compatible(np, "riscv,aclint-mtimer")) {

This patch should come after patch 8 which introduces this DT binding

> +               clint_ipi_base = NULL;
> +               clint_timer_cmp = base + ACLINT_MTIMER_CMP_OFF;
> +               clint_timer_val = base + ACLINT_MTIMER_VAL_OFF;
> +       } else {
> +               clint_ipi_base = base + CLINT_IPI_OFF;
> +               clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
> +               clint_timer_val = base + CLINT_TIMER_VAL_OFF;
> +       }
>         clint_timer_freq = riscv_timebase;
>
>  #ifdef CONFIG_RISCV_M_MODE
> @@ -230,8 +244,10 @@ static int __init clint_timer_init_dt(struct device_node *np)
>                 goto fail_free_irq;
>         }
>
> -       riscv_set_ipi_ops(&clint_ipi_ops);
> -       clint_clear_ipi();
> +       if (clint_ipi_base) {
> +               riscv_set_ipi_ops(&clint_ipi_ops);
> +               clint_clear_ipi();
> +       }
>
>         return 0;
>
> @@ -244,3 +260,4 @@ static int __init clint_timer_init_dt(struct device_node *np)
>
>  TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
>  TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer2, "riscv,aclint-mtimer", clint_timer_init_dt);

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
