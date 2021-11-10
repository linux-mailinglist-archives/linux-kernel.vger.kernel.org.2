Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7844C405
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhKJPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhKJPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:06:47 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05EC061228
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:03:24 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso4318580otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZ1rNip2BWzE9XrbLXmI80jkgZVMhDv14Vt1iPMqCbA=;
        b=loAx3mn3I8tWvXV9J1CnehL8M/0oCBse5fknnRXtFQ5ksEew7DOimzooF1jaf5/EV4
         HmiNBAch/VSjTgSPIoTYJywurvPDJy+OLYUclxNhqd2bg2OkZ3YonXUvVQ2zK7NtRDnn
         w2wXVfpiSRJCNI5B/i6YMSI2FEPUDk0JQuS3qw7M1VcVpDe/qTWKbkJLmHI9GSzlZHNl
         MPz8rCYXCN/e3KcXQ31C5LHVDmIPVbY7XsCgoXd6BMTrRY3qOtgn3zDvdO8SPgu9c5c4
         ruyamG0cLl7l5/sfOwEPMJifCQYsryJwamrduJIw1NXFL87ojjbJYd4xf4xszJwUt4lQ
         NiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZ1rNip2BWzE9XrbLXmI80jkgZVMhDv14Vt1iPMqCbA=;
        b=6OnDFQtBWyHUuyJCCnyr8zLsYh+eSditoVjhShc/z+U3Iuf3aSxnHHS8zYc9mdoLes
         8xI9yNW8GGEEYlsjemIq3tG4sn0fcjEJ8zCBJi7g/8f/qddpRXbBrmClR0jR4m8bK6TQ
         ZCTYF8Mmecek28JFQq8+/LHAQXsL4Wg2cUYfVMKsz49mzqG+B420VRSD6zm24dQdQRQh
         vUSlQzSixBU6iuVguiip5wNliOq473JcA90Caz7su/gaIB50V+yQS1kS9kgKdRVNd598
         f7bzfrOlxPia9PVy4sHQQ7aE6o986E27rKk0bdMeeHf/tTgzBtPQLLveDvTmKqFA5BUo
         4sjQ==
X-Gm-Message-State: AOAM531HlsyiSPfgRphcGz5gXU3JUv2PaTNVUmqgOuhYZRuX731oHPJw
        rcPgpaRsMAmFk3f+zalFIo04QkiJiKdzlV0saCPWag==
X-Google-Smtp-Source: ABdhPJwazvzeSXOEKajsDgodjc/c//1LVtnjIgmPemDFAc9R7quZv0M8t8RohN3ugFQrsugA1Ktl7wjNmZEeaGtu+U4=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr424220otl.92.1636556602777;
 Wed, 10 Nov 2021 07:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
 <20211110011738.GD288354@lothringen> <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
 <87h7cks16n.mognet@arm.com> <87bl2srrvq.mognet@arm.com>
In-Reply-To: <87bl2srrvq.mognet@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 10 Nov 2021 16:03:10 +0100
Message-ID: <CANpmjNN7mW=7jjkXDPHV6=SbjAMYq=vFRDi+6aGFCdPFm1LZ-A@mail.gmail.com>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC & !DYNAMIC
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 at 15:45, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 10/11/21 11:24, Valentin Schneider wrote:
> > Following Frederic's _STATIC suggestion, I got to the below. The nice thing
> > is if a defconfig picks say PREEMPT_VOLUNTARY and the arch supports
> > PREEMPT_DYNAMIC, then it'll pick PREEMPT_VOLUNTARY_BEHAVIOUR. The less nice
> > thing is that we end up selecting PREEMPT_STATIC for PREEMPT_DYNAMIC
> > kernels, naming's hard... Maybe _BUILD rather than _STATIC?
> >
>
> And now without a legacy compatibility layer crud...

If this works for everyone else, then I think this is the least
intrusive and hopefully won't require telling everyone about this
config change.

For the final version, it seems to be missing s/_BEHAVIOUR// in
kernel/sched/core.c.

And the kcsan_test.c change can be reverted, I think it's broken
either way now, because it wants the dynamic state (the test still
works in most configs, so fixing this isn't super urgent). Similarly
for kernel/trace/trace.c, which appears mainly cosmetic. So I'd defer
changing these until there are real helpers to get the true preemption
behaviour of the running system.

Thanks,
-- Marco

> ---
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 2776423a587e..9c7d774ef809 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -88,7 +88,7 @@
>  struct completion;
>  struct user;
>
> -#ifdef CONFIG_PREEMPT_VOLUNTARY
> +#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
>
>  extern int __cond_resched(void);
>  # define might_resched() __cond_resched()
> diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
> index 1eaaa93c37bf..f2b71920024c 100644
> --- a/include/linux/vermagic.h
> +++ b/include/linux/vermagic.h
> @@ -15,7 +15,7 @@
>  #else
>  #define MODULE_VERMAGIC_SMP ""
>  #endif
> -#ifdef CONFIG_PREEMPT
> +#ifdef CONFIG_PREEMPT_BUILD
>  #define MODULE_VERMAGIC_PREEMPT "preempt "
>  #elif defined(CONFIG_PREEMPT_RT)
>  #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
> @@ -39,9 +39,9 @@
>  #define MODULE_RANDSTRUCT_PLUGIN
>  #endif
>
> -#define VERMAGIC_STRING                                                \
> +#define VERMAGIC_STRING                                                        \
>         UTS_RELEASE " "                                                 \
> -       MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT                     \
> +       MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT                     \
>         MODULE_VERMAGIC_MODULE_UNLOAD MODULE_VERMAGIC_MODVERSIONS       \
>         MODULE_ARCH_VERMAGIC                                            \
>         MODULE_RANDSTRUCT_PLUGIN
> diff --git a/init/Makefile b/init/Makefile
> index 2846113677ee..04eeee12c076 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -30,7 +30,7 @@ $(obj)/version.o: include/generated/compile.h
>  quiet_cmd_compile.h = CHK     $@
>        cmd_compile.h = \
>         $(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@       \
> -       "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"    \
> +       "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"      \
>         "$(CONFIG_PREEMPT_RT)" $(CONFIG_CC_VERSION_TEXT) "$(LD)"
>
>  include/generated/compile.h: FORCE
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 60f1bfc3c7b2..ce77f0265660 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -1,12 +1,23 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> +config PREEMPT_NONE_BUILD
> +       bool
> +
> +config PREEMPT_VOLUNTARY_BUILD
> +       bool
> +
> +config PREEMPT_BUILD
> +       bool
> +       select PREEMPTION
> +       select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> +
>  choice
>         prompt "Preemption Model"
> -       default PREEMPT_NONE_BEHAVIOUR
> +       default PREEMPT_NONE
>
> -config PREEMPT_NONE_BEHAVIOUR
> +config PREEMPT_NONE
>         bool "No Forced Preemption (Server)"
> -       select PREEMPT_NONE if !PREEMPT_DYNAMIC
> +       select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>         help
>           This is the traditional Linux preemption model, geared towards
>           throughput. It will still provide good latencies most of the
> @@ -18,10 +29,10 @@ config PREEMPT_NONE_BEHAVIOUR
>           raw processing power of the kernel, irrespective of scheduling
>           latencies.
>
> -config PREEMPT_VOLUNTARY_BEHAVIOUR
> +config PREEMPT_VOLUNTARY
>         bool "Voluntary Kernel Preemption (Desktop)"
>         depends on !ARCH_NO_PREEMPT
> -       select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
> +       select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
>         help
>           This option reduces the latency of the kernel by adding more
>           "explicit preemption points" to the kernel code. These new
> @@ -37,10 +48,10 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
>
>           Select this if you are building a kernel for a desktop system.
>
> -config PREEMPT_BEHAVIOUR
> +config PREEMPT
>         bool "Preemptible Kernel (Low-Latency Desktop)"
>         depends on !ARCH_NO_PREEMPT
> -       select PREEMPT
> +       select PREEMPT_BUILD
>         help
>           This option reduces the latency of the kernel by making
>           all kernel code (that is not executing in a critical section)
> @@ -58,7 +69,7 @@ config PREEMPT_BEHAVIOUR
>
>  config PREEMPT_RT
>         bool "Fully Preemptible Kernel (Real-Time)"
> -       depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
> +       depends on EXPERT && ARCH_SUPPORTS_RT
>         select PREEMPTION
>         help
>           This option turns the kernel into a real-time kernel by replacing
> @@ -75,17 +86,6 @@ config PREEMPT_RT
>
>  endchoice
>
> -config PREEMPT_NONE
> -       bool
> -
> -config PREEMPT_VOLUNTARY
> -       bool
> -
> -config PREEMPT
> -       bool
> -       select PREEMPTION
> -       select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> -
>  config PREEMPT_COUNT
>         bool
>
> @@ -95,8 +95,8 @@ config PREEMPTION
>
>  config PREEMPT_DYNAMIC
>         bool "Preemption behaviour defined on boot"
> -       depends on HAVE_PREEMPT_DYNAMIC
> -       select PREEMPT
> +       depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
> +       select PREEMPT_BUILD
>         default y
>         help
>           This option allows to define the preemption model on the kernel
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index dc55fd5a36fc..845b17cf7811 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1005,13 +1005,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
>         else
>                 nthreads *= 2;
>
> -       if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
> +       if (!IS_ENABLED(CONFIG_PREEMPTION) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
>                 /*
>                  * Without any preemption, keep 2 CPUs free for other tasks, one
>                  * of which is the main test case function checking for
>                  * completion or failure.
>                  */
> -               const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
> +               const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE_BUILD) ? 2 : 0;
>                 const long min_required_cpus = 2 + min_unused_cpus;
>
>                 if (num_online_cpus() < min_required_cpus) {
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..3b3226ffbafa 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4271,11 +4271,11 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
>                    entries,
>                    total,
>                    buf->cpu,
> -#if defined(CONFIG_PREEMPT_NONE)
> +#if defined(CONFIG_PREEMPT_NONE_BUILD)
>                    "server",
> -#elif defined(CONFIG_PREEMPT_VOLUNTARY)
> +#elif defined(CONFIG_PREEMPT_VOLUNTARY_BUILD)
>                    "desktop",
> -#elif defined(CONFIG_PREEMPT)
> +#elif defined(CONFIG_PREEMPT_BUILD)
>                    "preempt",
>  #elif defined(CONFIG_PREEMPT_RT)
>                    "preempt_rt",
