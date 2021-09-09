Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79040584F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhIIN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349110AbhIINza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F710611CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195660;
        bh=wxBTAJeOQ7MeLpizJg2FKExj67MUK1RXo6sqqLtc3Xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=acXhtfwZLRSW++s4vpRVkF8y9kGQij45KNFpPpoi3BnAZr4lrhG+Oy5Z2XS/AeRaN
         X7bYJVU48OIgxCgsocHrl9UDINq/5OP4QWaRB60wYgBNY3RlpZk9tIAOZSSs1tn5ts
         KpFBvjv4n59oqvyWlx+9Zxbn5dct054ZxnmbZP/yvqoTvMNb9uZ6VgqNlFVKutyNkn
         N2r2NLgKyZ3a9JzoxYettAzxVgHN3lzZtRMmD6EYiypbs3JQAlw+VjhLjhPK3GPMJF
         5v/OZwiolP34hpPi1RYwrF1wtM2JJlColdtMRBh8nsVroLCCDA1xOoyS1uMBqP5bW2
         ZVD4xKp4bRILg==
Received: by mail-ot1-f43.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so2553569otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:54:20 -0700 (PDT)
X-Gm-Message-State: AOAM533K/rgncKzJNFn6xr/2+Nevi95UzCBriTSdVS/pdZbn+nvT/XEJ
        LkqDF2R1LPrHXXmADrVzCjbvg9u457kJY5i82wE=
X-Google-Smtp-Source: ABdhPJwTAIJ7a6Q8xfcCOYf16QFYVRJbMmyw75DbA9S8CvOrm7ZEqo6hO/7Ut+wiBW/tBTix5EXK4xui6c5FyG2orZY=
X-Received: by 2002:a05:6830:603:: with SMTP id w3mr2540426oti.147.1631195659768;
 Thu, 09 Sep 2021 06:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210904060908.1310204-1-keithp@keithp.com> <20210907220038.91021-1-keithpac@amazon.com>
 <20210907220038.91021-6-keithpac@amazon.com>
In-Reply-To: <20210907220038.91021-6-keithpac@amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Sep 2021 15:54:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-cWAVn7MinFFEOiG2F-bdQ+TqgSuV0rfXz75Vh2Y7SQ@mail.gmail.com>
Message-ID: <CAMj1kXG-cWAVn7MinFFEOiG2F-bdQ+TqgSuV0rfXz75Vh2Y7SQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: Stop using TPIDRPRW to hold per_cpu_offset
To:     Keith Packard <keithpac@amazon.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 00:00, Keith Packard <keithpac@amazon.com> wrote:
>
> We're going to store TPIDRPRW here instead
>

?

> Signed-off-by: Keith Packard <keithpac@amazon.com>

I'd much prefer to keep using TPIDIRPRW for the per-CPU offsets, and
use the user space TLS register for current.

There are several reasons for this:
- arm64 does the same - as someone who still cares about ARM while
many have moved on to arm64 or RISC-V, I am still trying to maintain
parity between ARM and arm64 where possible.
- efficiency: loading the per-CPU offset using a CPU id stored in
memory, which is then used to index the per-CPU offsets array in
memory adds two additional loads to every load/store of a per-CPU
variable
- 'current' usually does not change value under the code's feet,
whereas per-CPU offsets might change at any time. Given the fact that
the CPU offset load is visible to the compiler as a memory access, I
suppose this should be safe, but I would still prefer per-CPU access
to avoid going via current if possible.

> ---
>  arch/arm/include/asm/percpu.h | 31 -------------------------------
>  arch/arm/kernel/setup.c       |  7 -------
>  arch/arm/kernel/smp.c         |  3 ---
>  3 files changed, 41 deletions(-)
>
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index e2fcb3cfd3de..eeafcd6a3e01 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -7,37 +7,6 @@
>
>  register unsigned long current_stack_pointer asm ("sp");
>
> -/*
> - * Same as asm-generic/percpu.h, except that we store the per cpu offset
> - * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
> - */
> -#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> -static inline void set_my_cpu_offset(unsigned long off)
> -{
> -       /* Set TPIDRPRW */
> -       asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
> -}
> -
> -static inline unsigned long __my_cpu_offset(void)
> -{
> -       unsigned long off;
> -
> -       /*
> -        * Read TPIDRPRW.
> -        * We want to allow caching the value, so avoid using volatile and
> -        * instead use a fake stack read to hazard against barrier().
> -        */
> -       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off)
> -               : "Q" (*(const unsigned long *)current_stack_pointer));
> -
> -       return off;
> -}
> -#define __my_cpu_offset __my_cpu_offset()
> -#else
> -#define set_my_cpu_offset(x)   do {} while(0)
> -
> -#endif /* CONFIG_SMP */
> -
>  #include <asm-generic/percpu.h>
>
>  #endif /* _ASM_ARM_PERCPU_H_ */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index ca0201635fac..d0dc60afe54f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -590,13 +590,6 @@ void __init smp_setup_processor_id(void)
>         for (i = 1; i < nr_cpu_ids; ++i)
>                 cpu_logical_map(i) = i == cpu ? 0 : i;
>
> -       /*
> -        * clear __my_cpu_offset on boot CPU to avoid hang caused by
> -        * using percpu variable early, for example, lockdep will
> -        * access percpu variable inside lock_release
> -        */
> -       set_my_cpu_offset(0);
> -
>         pr_info("Booting Linux on physical CPU 0x%x\n", mpidr);
>  }
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5e999f1f1aea..8ccf10b34f08 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -410,8 +410,6 @@ asmlinkage void secondary_start_kernel(unsigned int cpu, struct task_struct *tas
>  {
>         struct mm_struct *mm = &init_mm;
>
> -       set_my_cpu_offset(per_cpu_offset(cpu));
> -
>         secondary_biglittle_init();
>
>         /*
> @@ -495,7 +493,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
>
>  void __init smp_prepare_boot_cpu(void)
>  {
> -       set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
>  }
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> --
> 2.33.0
>
