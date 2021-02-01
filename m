Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B930AF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhBAShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhBASdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:33:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89DBD64EAA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204391;
        bh=Jx6t/GRsyZk7hc+abZ81Y+IBo7n6qmPXTJ/+S/JYeoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvG3M8pan/mbU6ZJH46rij6l6R0YJ7t8dTeCykiP/qezOWOul0KlUEHMma+PP0j2A
         yVqHzN1UX1rjAAOMEFBtwczZmNpfp5ZXcVGAplvAH758FPOlgoXg54TjB1JFYeUW/y
         s4/lQbizrN6C0kkZfmNRoOIuT1BaQ+wO1M/AAR0QYQe0Wj5jyHjevGeB6eGPLfI1iH
         3e7RdWrzziAERqCUL/zUz6nkUsQWRblO12PUTm7uLblSZ5Q4Q+h4PtFF20X/R8Ik4D
         eGGMHKE3nR2+ojm45l6glxivUzu6HDoOC+RdCPXTDv9avuySZR3l44yO3JA0bNb5NO
         e20Uy243jMo3g==
Received: by mail-ed1-f42.google.com with SMTP id s3so6338935edi.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:33:11 -0800 (PST)
X-Gm-Message-State: AOAM531QnwnJOVLFbaOMgNkb+751cObOZWrfeAkI1lJ3NUSUhcBhMpyC
        UAFfJZc0PTtFumrncmQC4cU161uNe0Jkfif/Wao+JQ==
X-Google-Smtp-Source: ABdhPJzfbHXPHu67/9GcwBJRfWGTCjFCXUoO/2B8osZeIPlgPs/eRzohq1hlQ9Je0f+ijNkPibazb34ZTcLh51Lh3R4=
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr20215346edq.263.1612204389945;
 Mon, 01 Feb 2021 10:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20210201174555.GA17819@redhat.com> <20210201174709.GA17895@redhat.com>
In-Reply-To: <20210201174709.GA17895@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 10:32:58 -0800
X-Gmail-Original-Message-ID: <CALCETrWrPyd1HLXfKLc17CF85r2336YoEpe6bo6dNGdG_2A2bQ@mail.gmail.com>
Message-ID: <CALCETrWrPyd1HLXfKLc17CF85r2336YoEpe6bo6dNGdG_2A2bQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] x86: introduce TS_COMPAT_RESTART to fix
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:47 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> The comment in get_nr_restart_syscall() says:
>
>          * The problem is that we can get here when ptrace pokes
>          * syscall-like values into regs even if we're not in a syscall
>          * at all.
>
> Yes. but if we are not in syscall then the
>
>         status & (TS_COMPAT|TS_I386_REGS_POKED)
>
> check below can't really help:
>
>         - TS_COMPAT can't be set
>
>         - TS_I386_REGS_POKED is only set if regs->orig_ax was changed by
>           32bit debugger; and even in this case get_nr_restart_syscall()
>           is only correct if the tracee is 32bit too.
>
> Suppose that 64bit debugger plays with 32bit tracee and

At the risk of asking an obnoxious question here:

>
>         * Tracee calls sleep(2) // TS_COMPAT is set
>         * User interrupts the tracee by CTRL-C after 1 sec and does
>           "(gdb) call func()"
>         * gdb saves the regs by PTRACE_GETREGS

It seems to me that a better solution may be for gdb to see the
post-restart-setup state.  In other words, shouldn't the GETREGS
return with the ax pointing to the restart syscall already?

Now maybe this ship has sailed a long long time ago and we can't do
this, but is it at all worth considering?

>         * does PTRACE_SETREGS to set %rip='func' and %orig_rax=-1
>         * PTRACE_CONT           // TS_COMPAT is cleared
>         * func() hits int3.
>         * Debugger catches SIGTRAP.
>         * Restore original regs by PTRACE_SETREGS.
>         * PTRACE_CONT
>
> get_nr_restart_syscall() wrongly returns __NR_restart_syscall==219, the
> tracee calls ia32_sys_call_table[219] == sys_madvise.
>
> This patch adds the sticky TS_COMPAT_RESTART flag which survives after
> return to user mode, hopefully it allows us to kill TS_I386_REGS_POKED
> but this needs another patch.
>
> Test-case:
>
>   $ cvs -d :pserver:anoncvs:anoncvs@sourceware.org:/cvs/systemtap co ptrace-tests
>   $ gcc -o erestartsys-trap-debuggee ptrace-tests/tests/erestartsys-trap-debuggee.c --m32
>   $ gcc -o erestartsys-trap-debugger ptrace-tests/tests/erestartsys-trap-debugger.c -lutil
>   $ ./erestartsys-trap-debugger
>   Unexpected: retval 1, errno 22
>   erestartsys-trap-debugger: ptrace-tests/tests/erestartsys-trap-debugger.c:421
>
> Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/include/asm/thread_info.h | 14 +++++++++++++-
>  arch/x86/kernel/signal.c           | 24 +-----------------------
>  2 files changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index c2dc29e215ea..30d1d187019f 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -214,10 +214,22 @@ static inline int arch_within_stack_frames(const void * const stack,
>   */
>  #define TS_COMPAT              0x0002  /* 32bit syscall active (64BIT)*/
>
> +#ifndef __ASSEMBLY__
>  #ifdef CONFIG_COMPAT
>  #define TS_I386_REGS_POKED     0x0004  /* regs poked by 32-bit ptracer */
> +#define TS_COMPAT_RESTART      0x0008
> +
> +#define arch_set_restart_data  arch_set_restart_data
> +
> +static inline void arch_set_restart_data(struct restart_block *restart)
> +{
> +       struct thread_info *ti = current_thread_info();
> +       if (ti->status & TS_COMPAT)
> +               ti->status |= TS_COMPAT_RESTART;
> +       else
> +               ti->status &= ~TS_COMPAT_RESTART;
> +}
>  #endif
> -#ifndef __ASSEMBLY__
>
>  #ifdef CONFIG_X86_32
>  #define in_ia32_syscall() true
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ea794a083c44..6c26d2c3a2e4 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -766,30 +766,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>
>  static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
>  {
> -       /*
> -        * This function is fundamentally broken as currently
> -        * implemented.
> -        *
> -        * The idea is that we want to trigger a call to the
> -        * restart_block() syscall and that we want in_ia32_syscall(),
> -        * in_x32_syscall(), etc. to match whatever they were in the
> -        * syscall being restarted.  We assume that the syscall
> -        * instruction at (regs->ip - 2) matches whatever syscall
> -        * instruction we used to enter in the first place.
> -        *
> -        * The problem is that we can get here when ptrace pokes
> -        * syscall-like values into regs even if we're not in a syscall
> -        * at all.
> -        *
> -        * For now, we maintain historical behavior and guess based on
> -        * stored state.  We could do better by saving the actual
> -        * syscall arch in restart_block or (with caveats on x32) by
> -        * checking if regs->ip points to 'int $0x80'.  The current
> -        * behavior is incorrect if a tracer has a different bitness
> -        * than the tracee.
> -        */
>  #ifdef CONFIG_IA32_EMULATION
> -       if (current_thread_info()->status & (TS_COMPAT|TS_I386_REGS_POKED))
> +       if (current_thread_info()->status & TS_COMPAT_RESTART)
>                 return __NR_ia32_restart_syscall;
>  #endif
>  #ifdef CONFIG_X86_X32_ABI
> --
> 2.25.1.362.g51ebf55
>
