Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12840119F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhIEU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhIEU5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21706103E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630875377;
        bh=rKPAEQ3xd0gQPzqhrNVQNiukwEH1sFQZX9esT8huMKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFtwErdZp2o1fgcqTA9mp3sp7PsYoyOoZ9C7QExLZ3rOJ5KLbA1ESkB6pzjzUY93q
         t/vrDsF/KsPjw9Kmm+PyYlJROAPoTUl2ucd3pYcPpRodP7/wN2XJN6oc4/awft1GjC
         fikUtgKUv2z0B4MW9yQIbyhkm7JLXyZ+rg39u/4joR4MAJaYL1MnsZ6tjUyP2KgGCB
         yJfTltDSruZSAHtn2e2Pg/meJ8m43Z2yk2fIJc84DtnPItthARAdc1flg48WPZxvE5
         wgaOO87dYRVAZktDA7TmvveYl6O+a2bN18/tkjQD24B7IkWKPGRmnTp1rDCZpV8q0f
         lDg0gq2rcGzzA==
Received: by mail-ot1-f42.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso6242368ota.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:56:17 -0700 (PDT)
X-Gm-Message-State: AOAM53157leqQJJ+c8n9x4gUivJu1NddTwRDKKJJP52sCxebpGib4pnI
        +lyhSIN2Od0KEcgsgdwYcpK5avYbTmCFWnr/CZg=
X-Google-Smtp-Source: ABdhPJz1bJVqmynPC8kyz3pLCB7Ud/y7jG/KjbHQ0NF6vmd78QbEKxDPD7a+VLjMCMGXkOKhxm0EXS43nFQyN0WA5WY=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr8125947ota.30.1630875376711;
 Sun, 05 Sep 2021 13:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155429.3987201-1-keithp@keithp.com> <20210904060908.1310204-1-keithp@keithp.com>
 <20210904060908.1310204-3-keithp@keithp.com>
In-Reply-To: <20210904060908.1310204-3-keithp@keithp.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 5 Sep 2021 22:56:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
Message-ID: <CAMj1kXHHb_d4Exg7_5OdB-Ah=EQxVEUgEv1agUQZg-Rz8pLd5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Move thread_info into task_struct (v7 only)
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 08:09, Keith Packard <keithp@keithp.com> wrote:
>
> This avoids many stack overflow attacks which modified the thread_info
> structure by moving that into the task_struct as is done is almost all
> other architectures.
>
> The task_struct is now referenced by a per-cpu variable,
> 'current_task', allowing the current one on each cpu to be located
> from both C and assembly.
>
> This also involved removing the 'cpu' member from the thread_info
> struct and using the one added to the task_struct instead by the
> THREAD_INFO_IN_TASK code.
>
> This code is currently enabled only for v7 hardware as other ARM
> architectures do not make the c13 register in the p15 co-processor
> available for general OS use, leaving identifying the current cpu to
> the 'cpu' field in the thread_info located off the stack pointer.
>

c13 is not a register, it is a value in one of the dimensions of the
ARM sysreg space, and probably covers other system registers that
pre-v7 cores do implement.

Better to use its architectural name (TPIDRPRW) and clarify that
pre-v6k/v7 cores simply don't implement it.

> Signed-off-by: Keith Packard <keithpac@amazon.com>
> ---
>  arch/arm/Kconfig                   |  1 +
>  arch/arm/Makefile                  |  8 ++++
>  arch/arm/include/asm/assembler.h   | 66 ++++++++++++++++++++++++++----
>  arch/arm/include/asm/current.h     | 41 +++++++++++++++++++
>  arch/arm/include/asm/smp.h         | 18 ++++++++
>  arch/arm/include/asm/thread_info.h | 17 ++++++++
>  arch/arm/kernel/asm-offsets.c      |  4 ++
>  arch/arm/kernel/entry-armv.S       | 17 ++++----
>  arch/arm/kernel/entry-common.S     |  6 +--
>  arch/arm/kernel/entry-v7m.S        |  7 +++-
>  arch/arm/kernel/iwmmxt.S           |  2 +-
>  arch/arm/kernel/smp.c              | 12 ++++++
>  arch/arm/lib/copy_from_user.S      |  2 +-
>  arch/arm/lib/copy_to_user.S        |  2 +-
>  arch/arm/mach-ep93xx/crunch-bits.S |  2 +-
>  arch/arm/mm/proc-macros.S          |  2 +-
>  arch/arm/vfp/entry.S               |  4 ++
>  arch/arm/vfp/vfpmodule.c           | 25 +++++++----
>  18 files changed, 204 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm/include/asm/current.h
>

Could we split this up?

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 24804f11302d..1c1ded500a2b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -128,6 +128,7 @@ config ARM
>         select RTC_LIB
>         select SET_FS
>         select SYS_SUPPORTS_APM_EMULATION
> +       select THREAD_INFO_IN_TASK if CPU_V7

CPU_V6K also supports this

>         # Above selects are sorted alphabetically; please add new ones
>         # according to that.  Thanks.
>         help
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 415c3514573a..71a2ba4549d3 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -284,6 +284,14 @@ stack_protector_prepare: prepare0
>         $(eval GCC_PLUGINS_CFLAGS +=3D $(SSP_PLUGIN_CFLAGS))
>  endif
>
> +ifdef CONFIG_SMP
> +prepare: task_cpu_prepare
> +
> +PHONY +=3D task_cpu_prepare
> +task_cpu_prepare: prepare0
> +       $(eval KBUILD_CFLAGS +=3D -D_TSK_CPU=3D$(shell awk '{if ($$2 =3D=
=3D "TSK_CPU") print $$3;}' include/generated/asm-offsets.h))
> +endif
> +
>  all:   $(notdir $(KBUILD_IMAGE))
>

This is rather horrid, and removed again in the next patch. Can we
omit it entirely?

>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/asse=
mbler.h
> index e2b1fd558bf3..2ce7403f9298 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -199,16 +199,68 @@
>         .endm
>         .endr
>
> +#ifdef CONFIG_THREAD_INFO_IN_TASK

No need for this #ifdef - it only guards macros that will have no
effect if they are never instantiated (another case below)

>  /*
> - * Get current thread_info.
> + * Get per-CPU offset
> + * rd: Destination register
>   */
> -       .macro  get_thread_info, rd
> - ARM(  mov     \rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT    )
> - THUMB(        mov     \rd, sp                 )
> - THUMB(        lsr     \rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT       )
> -       mov     \rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
> +       .macro this_cpu_offset rd:req
> +       mrc p15, 0, \rd, c13, c0, 4
>         .endm
>
> +/*
> + * Load a per-cpu variable
> + * @dst: Destination register to receive value
> + * @sym: The name of the per-cpu variable
> + * @tmp: scratch register
> + */
> +       .macro ldr_this_cpu dst : req, sym : req, tmp : req
> +       movw    \dst, #:lower16:\sym
> +       movt    \dst, #:upper16:\sym
> +       this_cpu_offset \tmp
> +       ldr     \dst, [\dst, \tmp]
> +       .endm
> +
> +/*
> + * Store a value in a per-cpu variable
> + * @src: Source register with value
> + * @sym: The name of the per-cpu variable
> + * @t1: scratch register 1
> + * @t2: scratch register 2
> + */
> +       .macro str_this_cpu src : req, sym : req, t1 : req, t2 : req
> +       movw    \t1, #:lower16:\sym
> +       movt    \t1, #:upper16:\sym
> +       this_cpu_offset \t2
> +       str     \src, [\t1, \t2]
> +       .endm
> +#endif
> +
> +/*
> + * Get current thread_info
> + * @dst: Destination register to receive current thread info
> + * @tmp: scratch register
> + */
> +       .macro get_current, dst : req, tmp : req
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       ldr_this_cpu \dst, current_task, \tmp
> +#else
> + ARM(  mov     \dst, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT   )
> + THUMB(        mov     \dst, sp                        )
> + THUMB(        lsr     \dst, \dst, #THREAD_SIZE_ORDER + PAGE_SHIFT     )
> +       mov     \dst, \dst, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
> +#endif
> +       .endm
> +
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +/*
> + * Set current task info
> + */
> +       .macro  set_current_task rs : req, t1 : req, t2 : req
> +       str_this_cpu \rs, current_task, \t1, \t2
> +       .endm
> +#endif
> +
>  /*
>   * Increment/decrement the preempt count.
>   */
> @@ -226,7 +278,7 @@
>         .endm
>
>         .macro  dec_preempt_count_ti, ti, tmp
> -       get_thread_info \ti
> +       get_current \ti, \tmp
>         dec_preempt_count \ti, \tmp
>         .endm
>  #else
> diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/curren=
t.h
> new file mode 100644
> index 000000000000..7160315eb569
> --- /dev/null
> +++ b/arch/arm/include/asm/current.h
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright =C2=A9 2021 Keith Packard <keithp@keithp.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.

Please drop the boilerplate and use a SPDX header instead.

> + */
> +
> +#ifndef _ASM_ARM_CURRENT_H
> +#define _ASM_ARM_CURRENT_H
> +
> +#include <linux/compiler.h>
> +#include <linux/thread_info.h>
> +#include <asm/percpu.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +struct task_struct;
> +
> +DECLARE_PER_CPU(struct task_struct *, current_task);
> +
> +static __always_inline struct task_struct *get_current(void)
> +{
> +       return raw_cpu_read(current_task);

This needs to run with preemption disabled, or we might get migrated
to another CPU halfway through, and produce the wrong result (i.e.,
the current task of the CPU we migrated from). However, it appears
that manipulating the preempt count will create a circular dependency
here.

Instead of using a per-CPU variable for current, I think it might be
better to borrow another system register (TPIDRURO or TPIDRURW) to
carry 'current' when THREAD_INFO_IN_TASK is in effect, similar to how
arm64 uses SP_EL0 - those registers could be preserved/restored in the
entry/exit from/to user space paths rather than in the context switch
path, and then be used any way we like while running in the kernel.


> +}
> +
> +#define current get_current()
> +#else
> +#include <asm-generic/current.h>
> +#endif
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_ARM_CURRENT_H */
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 86a7fd721556..1c38d1fde641 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -15,7 +15,25 @@
>  # error "<asm/smp.h> included in non-SMP build"
>  #endif
>
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +/*
> + * This is particularly ugly: it appears we can't actually get the defin=
ition
> + * of task_struct here, but we need access to the CPU this task is runni=
ng on.
> + * Instead of using task_struct we're using TSK_CPU which is extracted f=
rom
> + * asm-offsets.h by kbuild to get the current processor ID.
> + *
> + * This also needs to be safeguarded when building asm-offsets.s because=
 at
> + * that time TSK_CPU is not defined yet.
> + */
> +#ifndef _TSK_CPU
> +#define raw_smp_processor_id()         (0)
> +#else
> +#define raw_smp_processor_id()         (*(unsigned int *)((void *)curren=
t + _TSK_CPU))
> +#endif
> +
> +#else
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
> +#endif
>
>  struct seq_file;
>
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/th=
read_info.h
> index 70d4cbc49ae1..cbcd476a095b 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -55,8 +55,10 @@ struct thread_info {
>         unsigned long           flags;          /* low level flags */
>         int                     preempt_count;  /* 0 =3D> preemptable, <0=
 =3D> bug */
>         mm_segment_t            addr_limit;     /* address limit */
> +#ifndef CONFIG_THREAD_INFO_IN_TASK
>         struct task_struct      *task;          /* main task structure */
>         __u32                   cpu;            /* cpu */
> +#endif
>         __u32                   cpu_domain;     /* cpu domain */
>  #ifdef CONFIG_STACKPROTECTOR_PER_TASK
>         unsigned long           stack_canary;
> @@ -75,6 +77,17 @@ struct thread_info {
>  #endif
>  };
>
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +
> +#define INIT_THREAD_INFO(tsk)                                          \
> +{                                                                      \
> +       .flags          =3D 0,                                           =
 \
> +       .preempt_count  =3D INIT_PREEMPT_COUNT,                          =
 \
> +       .addr_limit     =3D KERNEL_DS,                                   =
 \
> +}
> +
> +#else
> +
>  #define INIT_THREAD_INFO(tsk)                                          \
>  {                                                                      \
>         .task           =3D &tsk,                                        =
 \
> @@ -83,6 +96,9 @@ struct thread_info {
>         .addr_limit     =3D KERNEL_DS,                                   =
 \
>  }
>
> +#endif
> +
> +#ifndef CONFIG_THREAD_INFO_IN_TASK
>  /*
>   * how to get the thread information struct from C
>   */
> @@ -93,6 +109,7 @@ static inline struct thread_info *current_thread_info(=
void)
>         return (struct thread_info *)
>                 (current_stack_pointer & ~(THREAD_SIZE - 1));
>  }
> +#endif
>
>  #define thread_saved_pc(tsk)   \
>         ((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.=
c
> index 70993af22d80..c91dcfe34bdd 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -44,8 +44,12 @@ int main(void)
>    DEFINE(TI_FLAGS,             offsetof(struct thread_info, flags));
>    DEFINE(TI_PREEMPT,           offsetof(struct thread_info, preempt_coun=
t));
>    DEFINE(TI_ADDR_LIMIT,                offsetof(struct thread_info, addr=
_limit));
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +  DEFINE(TSK_CPU,              offsetof(struct task_struct, cpu));
> +#else
>    DEFINE(TI_TASK,              offsetof(struct thread_info, task));
>    DEFINE(TI_CPU,               offsetof(struct thread_info, cpu));
> +#endif
>    DEFINE(TI_CPU_DOMAIN,                offsetof(struct thread_info, cpu_=
domain));
>    DEFINE(TI_CPU_SAVE,          offsetof(struct thread_info, cpu_context)=
);
>    DEFINE(TI_USED_CP,           offsetof(struct thread_info, used_cp));
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 0ea8529a4872..a5d71b0d8897 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -179,7 +179,7 @@ ENDPROC(__und_invalid)
>         @
>         stmia   r7, {r2 - r6}
>
> -       get_thread_info tsk
> +       get_current tsk, r0
>         uaccess_entry tsk, r0, r1, r2, \uaccess
>
>         .if \trace
> @@ -260,7 +260,7 @@ __und_svc:
>         bl      __und_fault
>
>  __und_svc_finish:
> -       get_thread_info tsk
> +       get_current tsk, r5
>         ldr     r5, [sp, #S_PSR]                @ Get SVC cpsr
>         svc_exit r5                             @ return from exception
>   UNWIND(.fnend         )
> @@ -428,7 +428,7 @@ __irq_usr:
>         usr_entry
>         kuser_cmpxchg_check
>         irq_handler
> -       get_thread_info tsk
> +       get_current tsk, why
>         mov     why, #0
>         b       ret_to_user_from_irq
>   UNWIND(.fnend         )
> @@ -572,12 +572,12 @@ ENDPROC(__und_usr)
>         @ Fall-through from Thumb-2 __und_usr
>         @
>  #ifdef CONFIG_NEON
> -       get_thread_info r10                     @ get current thread
> +       get_current r10, r6                     @ get current thread
>         adr     r6, .LCneon_thumb_opcodes
>         b       2f
>  #endif
>  call_fpe:
> -       get_thread_info r10                     @ get current thread
> +       get_current r10, r6                     @ get current thread
>  #ifdef CONFIG_NEON
>         adr     r6, .LCneon_arm_opcodes
>  2:     ldr     r5, [r6], #4                    @ mask value
> @@ -722,7 +722,7 @@ __pabt_usr:
>  ENTRY(ret_from_exception)
>   UNWIND(.fnstart       )
>   UNWIND(.cantunwind    )
> -       get_thread_info tsk
> +       get_current tsk, why
>         mov     why, #0
>         b       ret_to_user
>   UNWIND(.fnend         )
> @@ -735,7 +735,7 @@ __fiq_usr:
>         kuser_cmpxchg_check
>         mov     r0, sp                          @ struct pt_regs *regs
>         bl      handle_fiq_as_nmi
> -       get_thread_info tsk
> +       get_current tsk, r0
>         restore_user_regs fast =3D 0, offset =3D 0
>   UNWIND(.fnend         )
>  ENDPROC(__fiq_usr)
> @@ -771,6 +771,9 @@ ENTRY(__switch_to)
>  #endif
>  #ifdef CONFIG_CPU_USE_DOMAINS
>         mcr     p15, 0, r6, c3, c0, 0           @ Set domain register
> +#endif
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       set_current_task r2, r4, r5
>  #endif
>         mov     r5, r0
>         add     r4, r2, #TI_CPU_SAVE
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-commo=
n.S
> index 7f0b7aba1498..52580ee463fe 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -156,7 +156,7 @@ ENTRY(ret_from_fork)
>         movne   r0, r4
>         badrne  lr, 1f
>         retne   r5
> -1:     get_thread_info tsk
> +1:     get_current tsk, r1
>         b       ret_slow_syscall
>  ENDPROC(ret_from_fork)
>
> @@ -243,7 +243,7 @@ ENTRY(vector_swi)
>         bic     scno, scno, #0xff000000         @ mask off SWI op-code
>         eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number
>  #endif
> -       get_thread_info tsk
> +       get_current tsk, r10
>         /*
>          * Reload the registers that may have been corrupted on entry to
>          * the syscall assembly (by tracing or context tracking.)
> @@ -278,7 +278,7 @@ local_restart:
>  9001:
>         sub     lr, saved_pc, #4
>         str     lr, [sp, #S_PC]
> -       get_thread_info tsk
> +       get_current tsk, r1
>         b       ret_fast_syscall
>  #endif
>  ENDPROC(vector_swi)
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index d0e898608d30..f36a7a876085 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -57,7 +57,7 @@ __irq_entry:
>         tst     r0, V7M_SCB_ICSR_RETTOBASE
>         beq     2f
>
> -       get_thread_info tsk
> +       get_current tsk, r2
>         ldr     r2, [tsk, #TI_FLAGS]
>         movs    r2, r2, lsl #16
>         beq     2f                      @ no work pending
> @@ -83,7 +83,7 @@ __pendsv_entry:
>         str     r0, [r1, V7M_SCB_ICSR]  @ clear PendSV
>
>         @ execute the pending work, including reschedule
> -       get_thread_info tsk
> +       get_current tsk, why
>         mov     why, #0
>         b       ret_to_user_from_irq
>  ENDPROC(__pendsv_entry)
> @@ -107,6 +107,9 @@ ENTRY(__switch_to)
>         bl      atomic_notifier_call_chain
>         mov     ip, r4
>         mov     r0, r5
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       set_current_task r2, r4, r5
> +#endif
>         ldmia   ip!, {r4 - r11}         @ Load all regs saved previously
>         ldr     sp, [ip]
>         ldr     pc, [ip, #4]!
> diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
> index d2b4ac06e4ed..781f7c7fca90 100644
> --- a/arch/arm/kernel/iwmmxt.S
> +++ b/arch/arm/kernel/iwmmxt.S
> @@ -96,7 +96,7 @@ ENTRY(iwmmxt_task_enable)
>         bl      concan_save
>
>  #ifdef CONFIG_PREEMPT_COUNT
> -       get_thread_info r10
> +       get_current r10, r3
>  #endif
>  4:     dec_preempt_count r10, r3
>         ret     r9                              @ normal exit from except=
ion
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 55cb1689a4b3..be0ede16dbb1 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -51,6 +51,13 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/ipi.h>
>
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned=
 =3D
> +       &init_task;
> +EXPORT_PER_CPU_SYMBOL(current_task);
> +
> +#endif
> +
>  /*
>   * as from 2.5, kernels no longer have an init_tasks structure
>   * so we need some other way of telling a new secondary core
> @@ -156,6 +163,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *i=
dle)
>         secondary_data.cpu =3D cpu;
>         sync_cache_w(&secondary_data);
>
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       per_cpu(current_task, cpu) =3D idle;
> +#endif
> +
>         /*
>          * Now bring the CPU into our world.
>          */
> @@ -509,6 +520,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>          */
>         if (max_cpus > ncores)
>                 max_cpus =3D ncores;
> +
>         if (ncores > 1 && max_cpus) {
>                 /*
>                  * Initialise the present map, which describes the set of=
 CPUs
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.=
S
> index f8016e3db65d..5320950100a2 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -109,7 +109,7 @@
>
>  ENTRY(arm_copy_from_user)
>  #ifdef CONFIG_CPU_SPECTRE
> -       get_thread_info r3
> +       get_current r3, ip
>         ldr     r3, [r3, #TI_ADDR_LIMIT]
>         uaccess_mask_range_ptr r1, r2, r3, ip
>  #endif
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index ebfe4cb3d912..e7e61c87893a 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -109,7 +109,7 @@
>  ENTRY(__copy_to_user_std)
>  WEAK(arm_copy_to_user)
>  #ifdef CONFIG_CPU_SPECTRE
> -       get_thread_info r3
> +       get_current r3, ip
>         ldr     r3, [r3, #TI_ADDR_LIMIT]
>         uaccess_mask_range_ptr r0, r2, r3, ip
>  #endif
> diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/cr=
unch-bits.S
> index fb2dbf76f09e..d0bb34b3d973 100644
> --- a/arch/arm/mach-ep93xx/crunch-bits.S
> +++ b/arch/arm/mach-ep93xx/crunch-bits.S
> @@ -192,7 +192,7 @@ crunch_load:
>
>  1:
>  #ifdef CONFIG_PREEMPT_COUNT
> -       get_thread_info r10
> +       get_current r10, r3
>  #endif
>  2:     dec_preempt_count r10, r3
>         ret     lr
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index e2c743aa2eb2..a782c025fdf3 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -30,7 +30,7 @@
>   * act_mm - get current->active_mm
>   */
>         .macro  act_mm, rd
> -       get_thread_info \rd
> +       get_current \rd, unused                 @ won't build if THREAD_I=
NFO_IN_TASK
>         ldr     \rd, [\rd, #TI_TASK]
>         .if (TSK_ACTIVE_MM > IMM12_MASK)
>         add     \rd, \rd, #TSK_ACTIVE_MM & ~IMM12_MASK
> diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
> index 27b0a1f27fbd..48cb40a3b72d 100644
> --- a/arch/arm/vfp/entry.S
> +++ b/arch/arm/vfp/entry.S
> @@ -24,7 +24,11 @@
>  ENTRY(do_vfp)
>         inc_preempt_count r10, r4
>         ldr     r4, .LCvfp
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       ldr     r11, [r10, #TSK_CPU]    @ CPU number
> +#else
>         ldr     r11, [r10, #TI_CPU]     @ CPU number
> +#endif
>         add     r10, r10, #TI_VFPSTATE  @ r10 =3D workspace
>         ldr     pc, [r4]                @ call VFP entry point
>  ENDPROC(do_vfp)
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 2cb355c1b5b7..f929a26a05a5 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -143,22 +143,27 @@ static void vfp_thread_copy(struct thread_info *thr=
ead)
>   *  THREAD_NOFTIFY_SWTICH:
>   *   - the previously running thread will not be scheduled onto another =
CPU.
>   *   - the next thread to be run (v) will not be running on another CPU.
> - *   - thread->cpu is the local CPU number
> + *   - tsk->cpu is the local CPU number
>   *   - not preemptible as we're called in the middle of a thread switch
>   *  THREAD_NOTIFY_FLUSH:
>   *   - the thread (v) will be running on the local CPU, so
> - *     v =3D=3D=3D current_thread_info()
> - *   - thread->cpu is the local CPU number at the time it is accessed,
> + *     v =3D=3D=3D current
> + *   - tsk->cpu is the local CPU number at the time it is accessed,
>   *     but may change at any time.
>   *   - we could be preempted if tree preempt rcu is enabled, so
> - *     it is unsafe to use thread->cpu.
> + *     it is unsafe to use tsk->cpu.
>   *  THREAD_NOTIFY_EXIT
>   *   - we could be preempted if tree preempt rcu is enabled, so
> - *     it is unsafe to use thread->cpu.
> + *     it is unsafe to use tsk->cpu.
>   */
>  static int vfp_notifier(struct notifier_block *self, unsigned long cmd, =
void *v)
>  {
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +       struct task_struct *tsk =3D v;
> +       struct thread_info *thread =3D &tsk->thread_info;
> +#else
>         struct thread_info *thread =3D v;
> +#endif
>         u32 fpexc;
>  #ifdef CONFIG_SMP
>         unsigned int cpu;
> @@ -169,7 +174,11 @@ static int vfp_notifier(struct notifier_block *self,=
 unsigned long cmd, void *v)
>                 fpexc =3D fmrx(FPEXC);
>
>  #ifdef CONFIG_SMP
> +#ifdef CONFIG_THREAD_INFO_IN_TASK
> +               cpu =3D tsk->cpu;
> +#else
>                 cpu =3D thread->cpu;
> +#endif
>
>                 /*
>                  * On SMP, if VFP is enabled, save the old state in
> @@ -458,16 +467,16 @@ static int vfp_pm_suspend(void)
>
>                 /* disable, just in case */
>                 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> -       } else if (vfp_current_hw_state[ti->cpu]) {
> +       } else if (vfp_current_hw_state[smp_processor_id()]) {
>  #ifndef CONFIG_SMP
>                 fmxr(FPEXC, fpexc | FPEXC_EN);
> -               vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
> +               vfp_save_state(vfp_current_hw_state[smp_processor_id()], =
fpexc);
>                 fmxr(FPEXC, fpexc);
>  #endif
>         }
>
>         /* clear any information we had about last context state */
> -       vfp_current_hw_state[ti->cpu] =3D NULL;
> +       vfp_current_hw_state[smp_processor_id()] =3D NULL;
>
>         return 0;
>  }
> --
> 2.33.0
>
