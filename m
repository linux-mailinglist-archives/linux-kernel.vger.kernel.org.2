Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47C437B419
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhELCOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E77616E8;
        Wed, 12 May 2021 02:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620785628;
        bh=ORI2FIntMXJEdc9XGc1cHCVFCdGZJ1M84YKy7WGkAPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sulqtEffHIXMLXA9V3mnN1foS+7K4T0o+QXIyA2oQlgBCbvNjY3JeXv1WXDSJuU4Z
         YI1ij/eZf7JVMCJ719P77DU0lTxKT4+L2x19gu/tA2b6QKXEvutiXp9V0/VUCvE8Yf
         22i1UqvUzPUyky55eEiNqDfZrw/FYxW9XSS98ehd0dzKJsTMHClWvJ0gLAxolwHgWG
         qOridnlrQmYJ8NKHaKhgHTb7wJg+2G8qj4IlAjwpvdoIPUgE7utYDuQLW1dn1STY1t
         UdDllF6HRL9MZ2Ci6SdRleJHf9cP4gokFUA+QqsCXfmYMxJgta/UZRYY51ELA5ZPQY
         y/vBpFGvxpLnw==
Received: by mail-lj1-f176.google.com with SMTP id w4so27643484ljw.9;
        Tue, 11 May 2021 19:13:48 -0700 (PDT)
X-Gm-Message-State: AOAM533MRKG3/7T+HkSfJvMsA8n604ZLOm0I9rWbSzGOqZOs8wXLAAwp
        hxaJWuu5U5qxrDVST0dsyNstQkozwwWXHRqMWXE=
X-Google-Smtp-Source: ABdhPJz9YufAB/LixXU0RwfrsDh9yXF1fl9qWsS+kel4T6YFESEN8JVIQJhuLQ94GIzqp5wohQGZWg8YtNfSr6RbpzM=
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr26544982lja.498.1620785626595;
 Tue, 11 May 2021 19:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210511132257.1272-1-wangjunqiang@iscas.ac.cn> <20210511132257.1272-2-wangjunqiang@iscas.ac.cn>
In-Reply-To: <20210511132257.1272-2-wangjunqiang@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 12 May 2021 10:13:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTpK=8FxybgY85pHTRRq_hEq3_tUMuhnYqxM_ZKWzMvrQ@mail.gmail.com>
Message-ID: <CAJF2gTTpK=8FxybgY85pHTRRq_hEq3_tUMuhnYqxM_ZKWzMvrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in traps
To:     Wang Junqiang <wangjunqiang@iscas.ac.cn>
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Tue, May 11, 2021 at 9:23 PM Wang Junqiang <wangjunqiang@iscas.ac.cn> wrote:
>
> This patch contains the use of fpu instruction emulation by trap_c.
> It defined _fcr, _fesr for user space in processor.h which is used in fpu.c
> and instruction emulation. During initialization, all fpe are enabled,
> and the config that read/write fcr and fesr in glibc library is captured
> when privilege exception is triggered by mfcr and mtcr < ,15>.
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
> Change in v2:
>  - fixup Kconfig bug by Randy and Guo Ren
>  - move CONFIG_CPU_HAS_MATHEMU to fpu.h by define macro
>  - del usr_fcr usr_fesr in struct user_fp and define in processor.h
>  - del mathemu use in do_trap_ and use in fpu_fpe
>
> Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
> Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
> ---
>  arch/csky/Kconfig                 |  7 +++++++
>  arch/csky/Makefile                |  1 +
>  arch/csky/abiv2/fpu.c             | 21 +++++++++++++------
>  arch/csky/abiv2/inc/abi/fpu.h     | 34 +++++++++++++++++++++++++++++--
>  arch/csky/include/asm/processor.h | 11 ++++++++++
>  arch/csky/kernel/traps.c          |  5 ++---
>  6 files changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 8de5b987edb9..1f47ff2294c9 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -285,6 +285,13 @@ config CPU_HAS_FPU
>         bool "CPU has FPU coprocessor"
>         depends on CPU_CK807 || CPU_CK810 || CPU_CK860
>
> +config CPU_HAS_MATHEMU
> +       bool "CPU has FPU Mathemu Instructions"
> +       depends on (CPU_CK810 || CPU_CK860) && CPU_HAS_FPU
Just: depends on CPU_HAS_FPU
For fpu, CK807 = CK810 and CK610 hasn't FPU.

> +       default y
> +       help
> +         Say Y/N here to allow turning FPU Instructions simulation on/off.
> +
>  config CPU_HAS_ICACHE_INS
>         bool "CPU has Icache invalidate instructions"
>         depends on CPU_HAS_CACHEV2
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
> index 5acc5c2e544e..a7f6f0bb8537 100644
> --- a/arch/csky/abiv2/fpu.c
> +++ b/arch/csky/abiv2/fpu.c
> @@ -38,8 +38,7 @@ int fpu_libc_helper(struct pt_regs *regs)
>                 return 0;
>
>         tinstr = instr_hi | ((unsigned long)instr_low << 16);
> -
> -       if (((tinstr >> 21) & 0x1F) != 2)
> +       if (((tinstr >> 21) & 0x1F) != CR_NUM)
>                 return 0;
>
>         if ((tinstr & MTCR_MASK) == MTCR_DIST) {
> @@ -54,9 +53,9 @@ int fpu_libc_helper(struct pt_regs *regs)
>                 regx =  *(&regs->a0 + index);
>
>                 if (tmp == 1)
> -                       mtcr("cr<1, 2>", regx);
> +                       MTCR_FCR(regx)
>                 else if (tmp == 2)
> -                       mtcr("cr<2, 2>", regx);
> +                       MTCR_FESR(regx)
>                 else
>                         return 0;
>
> @@ -74,9 +73,9 @@ int fpu_libc_helper(struct pt_regs *regs)
>                         return 0;
>
>                 if (tmp == 1)
> -                       regx = mfcr("cr<1, 2>");
> +                       regx = MFCR_FCR;
>                 else if (tmp == 2)
> -                       regx = mfcr("cr<2, 2>");
> +                       regx = MFCR_FESR;
>                 else
>                         return 0;
>
> @@ -94,6 +93,16 @@ void fpu_fpe(struct pt_regs *regs)
>         int sig, code;
>         unsigned int fesr;
>
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       unsigned int inst;
> +
> +       inst = get_fpu_insn(regs);
> +       if (inst && !do_fpu_insn(inst, regs)) {
> +               regs->pc += 4;
> +               return;
> +       }
> +#endif
> +
>         fesr = mfcr("cr<2, 2>");
>
>         sig = SIGFPE;
> diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
> index aabb79355013..6521f8814fd1 100644
> --- a/arch/csky/abiv2/inc/abi/fpu.h
> +++ b/arch/csky/abiv2/inc/abi/fpu.h
> @@ -6,14 +6,44 @@
>  #include <asm/sigcontext.h>
>  #include <asm/ptrace.h>
>
> +
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +#define FPU_INIT               mtcr("cr<1, 2>", 0x3f)
static inline void init_fpu(void)
{
       mtcr("cr<1, 2>", 0x3f);
}

> +#define MFCR_FCR        current->thread.emul_fp.user_fcr
> +#define MFCR_FESR       current->thread.emul_fp.user_fesr
> +#define MTCR_FCR(regx)         \
> +               {       \
> +                       mtcr("cr<1, 2>", regx | 0x3f);  \
> +                       current->thread.emul_fp.user_fcr = regx;        \
> +               }
> +#define MTCR_FESR(regx)                \
> +               {       \
> +                       mtcr("cr<2, 2>", regx); \
> +                       current->thread.emul_fp.user_fesr = regx;       \
> +               }
> +#define CR_NUM          15
> +
> +inline unsigned int get_fpu_insn(struct pt_regs *regs);
> +inline int do_fpu_insn(unsigned int inst, struct pt_regs *regs);
> +#else
> +#define FPU_INIT               mtcr("cr<1, 2>", 0)
static inline void init_fpu(void)
{
       mtcr("cr<1, 2>", 0);
}

> +#define MFCR_FCR mfcr("cr<1, 2>")
> +#define MFCR_FESR mfcr("cr<2, 2>")
> +#define MTCR_FCR(regx)         { mtcr("cr<1, 2>", regx); }
> +#define MTCR_FESR(regx)                { mtcr("cr<2, 2>", regx); }
> +#define CR_NUM    2
> +#endif
> +
>  int fpu_libc_helper(struct pt_regs *regs);
>  void fpu_fpe(struct pt_regs *regs);
>
> -static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
> +static inline void init_fpu(void)
> +{
> +       FPU_INIT;
> +}
Remove it and move it to above.

>
>  void save_to_user_fp(struct user_fp *user_fp);
>  void restore_from_user_fp(struct user_fp *user_fp);
> -
>  /*
>   * Define the fesr bit for fpe handle.
>   */
> diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> index 9e933021fe8e..645b6b27841d 100644
> --- a/arch/csky/include/asm/processor.h
> +++ b/arch/csky/include/asm/processor.h
> @@ -21,6 +21,14 @@ struct cpuinfo_csky {
>
>  extern struct cpuinfo_csky cpu_data[];
>
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +struct emul_fp {
> +       unsigned long   user_fcr;
> +       unsigned long   user_fesr;
> +       unsigned long   reserved1;
> +       unsigned long   reserved2;
> +};
> +#endif
>  /*
>   * User space process size: 2GB. This is hardcoded into a few places,
>   * so don't change it unless you know what you are doing.  TASK_SIZE
> @@ -45,6 +53,9 @@ struct thread_struct {
>
>         /* FPU regs */
>         struct user_fp __aligned(16) user_fp;
> +#ifdef CONFIG_CPU_HAS_MATHEMU
> +       struct emul_fp __aligned(16) emul_fp;
> +#endif
>  };
>
>  #define INIT_THREAD  { \
> diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> index e5fbf8653a21..a63a56eca0a2 100644
> --- a/arch/csky/kernel/traps.c
> +++ b/arch/csky/kernel/traps.c
> @@ -187,7 +187,6 @@ asmlinkage void do_trap_bkpt(struct pt_regs *regs)
>  asmlinkage void do_trap_illinsn(struct pt_regs *regs)
>  {
>         current->thread.trap_no = trap_no(regs);
> -
No need.

>  #ifdef CONFIG_KPROBES
>         if (kprobe_breakpoint_handler(regs))
>                 return;
> @@ -209,7 +208,7 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
>
>  asmlinkage void do_trap_fpe(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
> +#ifdef CONFIG_CPU_HAS_FPU
>         return fpu_fpe(regs);
>  #else
>         do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
> @@ -219,7 +218,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
>
>  asmlinkage void do_trap_priv(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
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
