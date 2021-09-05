Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A9401185
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhIEU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhIEU0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC3DA61051
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630873548;
        bh=jvqK5MOKEiuMUZfVYv70SUUKMTKBzqnrpLUINlYxDsU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TrrFpNTRjjO2Hz6hHKo0KVQDmU/GY/zOTyS7r6ARsshI6wPHirjRc0Eks491twNMX
         Ph5htjryZP973ZzzTA3aCkC/cVWe1BDLhJANGjXGcB8fLyrW+5Xy31+dndlMc9wFO8
         3b7LeUK9gQvCIGX/BATmWo8xCdl9amA9QAHAbYB3qABGeTbx1HBWQxQyDbFK7UoCVY
         m0lw3x07SxUTaDf78v08UgDOe+SbGpjU0cJR0Wi4tT+e7bPx2Qp2I7gCbXZd2Nkkh3
         xyxfsOHPPcXjA4O8yZgdtFFd5rTnxuqbjlkMyNspGom8RoNuaEN1ZTfmp4REqiKkZ5
         k83LtiXGxMFCw==
Received: by mail-ot1-f47.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so6145230otg.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:25:48 -0700 (PDT)
X-Gm-Message-State: AOAM532uXBIhUYgtNGSQUVmH6GHhcHQm4KULt19ejiS+0XQbtQxtHcR2
        OIIp0VmCD7CpNNF9L/fg9LljuFAp/QMxV7iJAJk=
X-Google-Smtp-Source: ABdhPJy5fGmipkk4mNMOPumV5B8kOcAihT0XXVmm7Nvg1N85HNF7sX8xq0TYQx90nueu1uHkjq8krLVFwkDWQ3XJT/o=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr8062882ota.30.1630873547870;
 Sun, 05 Sep 2021 13:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155429.3987201-1-keithp@keithp.com> <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-2-keithp@keithp.com>
In-Reply-To: <20210904060908.1310204-2-keithp@keithp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 5 Sep 2021 22:25:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFYVPXD3VKDrKCvJ8ubc4NNK7T7ObOAFObM+_mFddKOBA@mail.gmail.com>
Message-ID: <CAMj1kXFYVPXD3VKDrKCvJ8ubc4NNK7T7ObOAFObM+_mFddKOBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: Pass cpu number to secondary_start_kernel
To:     Keith Packard <keithp@keithp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

This looks like a worthwhile cleanup to me regardless of the following patches.

On Sat, 4 Sept 2021 at 08:09, Keith Packard <keithp@keithp.com> wrote:
>
> Instead of pulling the CPU value out of the thread_info struct, pass
> it as an argument. When first initializing secondary processors, this
> is done by stashing the value in the secondary_data struct. When
> restarting idle processors, the previous CPU value is passed.
>
> Because the cpu is now known at the top of secondary_start_kernel, the
> per_cpu_offset value can now be set at this point, instead of in
> cpu_init where it was also incorrectly setting the per_cpu_offset for
> the boot processor before that value had been computed.
>
> Signed-off-by: Keith Packard <keithpac@amazon.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/include/asm/smp.h   |  3 ++-
>  arch/arm/kernel/head-nommu.S |  1 +
>  arch/arm/kernel/head.S       |  1 +
>  arch/arm/kernel/setup.c      |  6 ------
>  arch/arm/kernel/smp.c        | 14 +++++++++-----
>  5 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 5d508f5d56c4..86a7fd721556 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -48,7 +48,7 @@ extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
>   * Called from platform specific assembly code, this is the
>   * secondary CPU entry point.
>   */
> -asmlinkage void secondary_start_kernel(void);
> +asmlinkage void secondary_start_kernel(unsigned int cpu);
>
>
>  /*
> @@ -61,6 +61,7 @@ struct secondary_data {
>         };
>         unsigned long swapper_pg_dir;
>         void *stack;
> +       unsigned int cpu;
>  };
>  extern struct secondary_data secondary_data;
>  extern void secondary_startup(void);
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 0fc814bbc34b..5aa8ef42717f 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -114,6 +114,7 @@ ENTRY(secondary_startup)
>         add     r12, r12, r10
>         ret     r12
>  1:     bl      __after_proc_init
> +       ldr     r0, [r7, #16]                   @ set up cpu number
>         ldr     sp, [r7, #12]                   @ set up the stack pointer
>         mov     fp, #0
>         b       secondary_start_kernel
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 7f62c5eccdf3..0e541af738e2 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -394,6 +394,7 @@ ENDPROC(secondary_startup_arm)
>
>  ENTRY(__secondary_switched)
>         ldr_l   r7, secondary_data + 12         @ get secondary_data.stack
> +       ldr_l   r0, secondary_data + 16         @ get secondary_data.cpu
>         mov     sp, r7
>         mov     fp, #0
>         b       secondary_start_kernel
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 73ca7797b92f..ca0201635fac 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -532,12 +532,6 @@ void notrace cpu_init(void)
>                 BUG();
>         }
>
> -       /*
> -        * This only works on resume and secondary cores. For booting on the
> -        * boot cpu, smp_prepare_boot_cpu is called after percpu area setup.
> -        */
> -       set_my_cpu_offset(per_cpu_offset(cpu));
> -
>         cpu_proc_init();
>
>         /*
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 74679240a9d8..55cb1689a4b3 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -153,6 +153,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>         secondary_data.pgdir = virt_to_phys(idmap_pgd);
>         secondary_data.swapper_pg_dir = get_arch_pgd(swapper_pg_dir);
>  #endif
> +       secondary_data.cpu = cpu;
>         sync_cache_w(&secondary_data);
>
>         /*
> @@ -373,11 +374,14 @@ void arch_cpu_idle_dead(void)
>          * cpu initialisation.  There's some initialisation which needs
>          * to be repeated to undo the effects of taking the CPU offline.
>          */
> -       __asm__("mov    sp, %0\n"
> +       __asm__("mov    r0, %1\n"
> +       "       mov     sp, %0\n"
>         "       mov     fp, #0\n"
>         "       b       secondary_start_kernel"
>                 :
> -               : "r" (task_stack_page(current) + THREAD_SIZE - 8));
> +               : "r" (task_stack_page(current) + THREAD_SIZE - 8),
> +                 "r" (cpu)
> +               : "r0");
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */
>
> @@ -400,10 +404,11 @@ static void smp_store_cpu_info(unsigned int cpuid)
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
>   */
> -asmlinkage void secondary_start_kernel(void)
> +asmlinkage void secondary_start_kernel(unsigned int cpu)
>  {
>         struct mm_struct *mm = &init_mm;
> -       unsigned int cpu;
> +
> +       set_my_cpu_offset(per_cpu_offset(cpu));
>
>         secondary_biglittle_init();
>
> @@ -420,7 +425,6 @@ asmlinkage void secondary_start_kernel(void)
>          * All kernel threads share the same mm context; grab a
>          * reference and switch to it.
>          */
> -       cpu = smp_processor_id();
>         mmgrab(mm);
>         current->active_mm = mm;
>         cpumask_set_cpu(cpu, mm_cpumask(mm));
> --
> 2.33.0
>
