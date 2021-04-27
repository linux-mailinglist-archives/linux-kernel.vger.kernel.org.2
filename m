Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646C836C836
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhD0PDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236710AbhD0PDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:03:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE36560FEE;
        Tue, 27 Apr 2021 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619535754;
        bh=v6dpb92S48cVgsyVg0NHPQz3vwm2P2qTme5oG4502sQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zl82g4t27sdPe96hHArMxrlch6ZTYzI/YKcPhkODzeyobFHcDTNEKD/3KpTj9ja2c
         jXlW3OKo3mc4STomnXpXGnQzLCgDQME+p4YS4k0Sue5t3i3K10u0qXdMTAmnbkgp4g
         Fi+pPBddn0ZJlKqhmdCgb2AJXBnS9iDjZjaSG4RorjHp2smB0/xaUvx/Oo+uND+urW
         CQMSwx1PiiVA19HzJm2xHFpZ5LsNlDo26OnUgXrqy2zodLoAfClEcdt4InsDNQXbXg
         PAJC+W9iHQ1/JAMu6keDjvMbXqmbmDEftTbquGRTBhkA8JUwf6itDYVOoncKrni+Ch
         Pa5Zj1OqGQxWw==
Received: by mail-lf1-f49.google.com with SMTP id x19so63831122lfa.2;
        Tue, 27 Apr 2021 08:02:34 -0700 (PDT)
X-Gm-Message-State: AOAM530MZKd7/+wQN9Izif7WK1OgN/cUvDiBKlN7FsrTc0IDvSu/e0r+
        nuzq8T5n1Hf4JRLFZKXBCs0DftjG/X0hg6pE1a0=
X-Google-Smtp-Source: ABdhPJx7WQ4uxUrCKE+edstD5RVMQ6sjSpKHrRUMTRYqG7u3UheU3kwGFAHxV980YSA94a0c1VnsoQZBapad/AJ0zY8=
X-Received: by 2002:a19:e34c:: with SMTP id c12mr17383076lfk.555.1619535752877;
 Tue, 27 Apr 2021 08:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
In-Reply-To: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Apr 2021 23:02:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS+DNPJomuuVn3ZocO5BXKd_zmqqSP_1R0o1-p4NR925Q@mail.gmail.com>
Message-ID: <CAJF2gTS+DNPJomuuVn3ZocO5BXKd_zmqqSP_1R0o1-p4NR925Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in traps
To:     Wang Junqiang <wangjunqiang@iscas.ac.cn>
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang & Li,

On Wed, Apr 21, 2021 at 10:56 AM Wang Junqiang <wangjunqiang@iscas.ac.cn> wrote:
>
> This patch contains the use of fpu instruction emulation by trap_c.
> It defined _fcr, _fesr for user space in ptrace.h which is used in fpu.c
> and instruction emulation. During initialization, all fpe are enabled,
> and the configuration that read/write fcr and fesr in glibc library is captured
> when privilege exception is triggerd by mfcr and mtcr < ,15>.
>
> steps:
>  1.enable all fpe interrupts
>  2.mfcr/mtcr trigger privilege exception
>  3.synchronize fcr and fesr of user app through fpu_libc_helper function
>  4.fpe interrupt at runtime
>  5.fpu instruction simulation is based on user_fcr and user_fesr
>  6.clearing interrupts and synchronizing fcr fesr
>  7.state restore and continue running
>
> Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
> Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
> ---
>  arch/csky/Kconfig                   |  8 ++++++++
>  arch/csky/Makefile                  |  1 +
>  arch/csky/abiv2/fpu.c               | 31 ++++++++++++++++++++++++-----
>  arch/csky/abiv2/inc/abi/fpu.h       |  9 ++++++++-
>  arch/csky/include/uapi/asm/ptrace.h |  6 ++++++
>  arch/csky/kernel/traps.c            | 30 +++++++++++++++++++++++++---
>  6 files changed, 76 insertions(+), 9 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 34e91224adc3..a414225570c1 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -97,6 +97,9 @@ config CPU_HAS_CACHEV2
>  config CPU_HAS_FPUV2
>         bool
>
> +config CPU_HAS_MATHEMU
> +       bool
> +
Duplicated

>  config CPU_HAS_HILO
>         bool
>
> @@ -281,6 +284,11 @@ config CPU_HAS_VDSP
>         bool "CPU has VDSP coprocessor"
>         depends on CPU_HAS_FPU && CPU_HAS_FPUV2
>
> +config CPU_HAS_MATHEMU
> +       bool "CPU has FPU Mathemu Instructions"
> +       depends on CPU_CK810 || CPU_CK860
> +       default n
No need "default n", only "default y" need.

> +
>  config CPU_HAS_FPU
>         bool "CPU has FPU coprocessor"
>         depends on CPU_CK807 || CPU_CK810 || CPU_CK860
> diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> index 37f593a4bf53..495f3a2fad6a 100644
> --- a/arch/csky/Makefile
> +++ b/arch/csky/Makefile
> @@ -64,6 +64,7 @@ head-y := arch/csky/kernel/head.o
>  core-y += arch/csky/kernel/
>  core-y += arch/csky/mm/
>  core-y += arch/csky/$(CSKYABI)/
> +core-$(CONFIG_CPU_HAS_MATHEMU) += arch/csky/math-emu/
>
>  libs-y += arch/csky/lib/ \
>         $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
> diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
> index 5acc5c2e544e..3cd17cf9319e 100644
> --- a/arch/csky/abiv2/fpu.c
> +++ b/arch/csky/abiv2/fpu.c
> @@ -38,8 +38,11 @@ int fpu_libc_helper(struct pt_regs *regs)
>                 return 0;
>
>         tinstr = instr_hi | ((unsigned long)instr_low << 16);
> -
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       if (((tinstr >> 21) & 0x1F) != 15)
> +#else
>         if (((tinstr >> 21) & 0x1F) != 2)
> +#endif
>                 return 0;
>
>         if ((tinstr & MTCR_MASK) == MTCR_DIST) {
> @@ -53,10 +56,19 @@ int fpu_libc_helper(struct pt_regs *regs)
>
>                 regx =  *(&regs->a0 + index);
>
> -               if (tmp == 1)
> +               if (tmp == 1) {
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +                       mtcr("cr<1, 2>", regx | 0x3f);
> +                       current->thread.user_fp.user_fcr = regx;
> +#else
>                         mtcr("cr<1, 2>", regx);
> -               else if (tmp == 2)
> +#endif
> +               } else if (tmp == 2) {
>                         mtcr("cr<2, 2>", regx);
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +                       current->thread.user_fp.user_fesr = regx;
> +#endif
> +               }
>                 else
>                         return 0;
>
> @@ -73,10 +85,19 @@ int fpu_libc_helper(struct pt_regs *regs)
>                 if (tmp > 2)
>                         return 0;
>
> -               if (tmp == 1)
> +               if (tmp == 1) {
> +#ifndef CONFIG_CPU_HAS_MATHEMU
>                         regx = mfcr("cr<1, 2>");
> -               else if (tmp == 2)
> +#else
> +                       regx = current->thread.user_fp.user_fcr;
> +#endif
> +               } else if (tmp == 2) {
> +#ifndef CONFIG_CPU_HAS_MATHEMU
>                         regx = mfcr("cr<2, 2>");
> +#else
> +                       regx = current->thread.user_fp.user_fesr;
> +#endif
> +               }
>                 else
>                         return 0;
>
> diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
> index aabb79355013..c3509ace542c 100644
> --- a/arch/csky/abiv2/inc/abi/fpu.h
> +++ b/arch/csky/abiv2/inc/abi/fpu.h
> @@ -9,7 +9,14 @@
>  int fpu_libc_helper(struct pt_regs *regs);
>  void fpu_fpe(struct pt_regs *regs);
>
> -static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
> +static inline void init_fpu(void)
> +{
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       mtcr("cr<1, 2>", 0x3f);
> +#else
> +       mtcr("cr<1, 2>", 0);
> +#endif
> +}
Could we put all CONFIG_CPU_HAS_MATHEMU differences in fpu.h?

#ifdef CONFIG_CPU_HAS_MATHEMU
#define MFCR_FESR       current->thread.user_fp.user_fesr
#define MFCR_FCR        current->thread.user_fp.user_fcr
#define MTCR_FESR(regx) {current->thread.user_fp.user_fesr = regx; ...}
#define MTCR_FCR(regx)  {current->thread.user_fp.user_fcr = regx; ...}
#define CR_NUM          15
#else
#define MFCR_FESR(regx) mtcr("cr<1, 2>", regx)
#define MFCR_FESR(regx) mtcr("cr<1, 2>", regx)
...
#define CR_NUM    2
#endif

>
>  void save_to_user_fp(struct user_fp *user_fp);
>  void restore_from_user_fp(struct user_fp *user_fp);
> diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
> index 3be9c14334a6..1ffb6190686a 100644
> --- a/arch/csky/include/uapi/asm/ptrace.h
> +++ b/arch/csky/include/uapi/asm/ptrace.h
> @@ -45,6 +45,12 @@ struct user_fp {
>         unsigned long   fesr;
>         unsigned long   fid;
>         unsigned long   reserved;
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       unsigned long   user_fcr;
> +       unsigned long   user_fesr;
> +       unsigned long   reserved1;
> +       unsigned long   reserved2;
> +#endif
>  };
No, we couldn't modify user_fp, it'll break the old version toolchain.
(signal context)

A new struct of saving them in thread struct is enough.

>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> index e5fbf8653a21..053a4f7dff9e 100644
> --- a/arch/csky/kernel/traps.c
> +++ b/arch/csky/kernel/traps.c
> @@ -27,6 +27,10 @@
>
>  #ifdef CONFIG_CPU_HAS_FPU
>  #include <abi/fpu.h>
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +extern inline unsigned int get_fpu_insn(struct pt_regs *regs);
> +extern inline int do_fpu_insn(unsigned int inst, struct pt_regs *regs);
> +#endif
>  #endif
>
>  int show_unhandled_signals = 1;
> @@ -186,8 +190,19 @@ asmlinkage void do_trap_bkpt(struct pt_regs *regs)
>
>  asmlinkage void do_trap_illinsn(struct pt_regs *regs)
>  {
> -       current->thread.trap_no = trap_no(regs);
> +#ifdef CONFIG_CPU_HAS_FPU
> +#ifdef CONFIG_CPU_HAS_MATHEMU
CONFIG_CPU_HAS_FPU && CONFIG_CPU_HAS_MATHEMU ?

> +       unsigned int inst;
> +
> +       inst = get_fpu_insn(regs);
> +       if (inst && !do_fpu_insn(inst, regs)) {
> +               regs->pc += 4;
> +               return;
> +       }
> +#endif
> +#endif
Don't double.

>
> +       current->thread.trap_no = trap_no(regs);
>  #ifdef CONFIG_KPROBES
>         if (kprobe_breakpoint_handler(regs))
>                 return;
> @@ -209,7 +224,16 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
>
>  asmlinkage void do_trap_fpe(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
Thx for fixup.

> +#ifdef CONFIG_CPU_HAS_FPU
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       unsigned int inst;
> +
> +       inst = get_fpu_insn(regs);
> +       if (inst && !do_fpu_insn(inst, regs)) {
> +               regs->pc += 4;
> +               return;
> +       }
> +#endif
Move above into fpu_fpe.

>         return fpu_fpe(regs);
>  #else
>         do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
> @@ -219,7 +243,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
>
>  asmlinkage void do_trap_priv(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
Thx for fixup.

> +#ifdef CONFIG_CPU_HAS_FPU
>         if (user_mode(regs) && fpu_libc_helper(regs))
>                 return;
>  #endif
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
