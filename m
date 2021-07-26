Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE43D63A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhGZPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhGZPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:30:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B3E660F93;
        Mon, 26 Jul 2021 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627315858;
        bh=YqW3QUT+cwzuM6V2M99VRjZUCoIpN3L9l17Om+8lmiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jje5idyN243jJSAfVy095mxDYJlDj8B9+hmiut8w8Bk1Jg9NhGyOsX8e0KAymiFmh
         8W0iAl+2EZ6GiXmpks5P/RYspbtCnHf4mPb2IuzuT+JvA5TynxbhBa7vLbwki6CFoj
         eSs1JIUDBVg4KuETpcXdrB9d7PSuMCMZH2wJs9MldXQbSwTvativ0rx85GM/nDCa+V
         la2PypCi0uuk/fwJyDeSReYMAeWXxtb/w19kVFLeiWZBh+R32ES3bnB04jhT/HyPsN
         qf3ne5DjcJJ2M4hej2E9wdbaa+BhxAL9UybOXSYTEVcUn8hecDaCAJEdU1u89ILeKz
         8Wm8p6BTqBH9Q==
Received: by mail-lf1-f52.google.com with SMTP id z2so16479889lft.1;
        Mon, 26 Jul 2021 09:10:58 -0700 (PDT)
X-Gm-Message-State: AOAM532/MzL7AZ20Xj5lqAb3eXj+WxfT3UC6GTBdEdkPxwcZarem0grw
        QpZorluZJOGbvOCk9iJSF1+gcgbCqfsjatW5EgU=
X-Google-Smtp-Source: ABdhPJwnTzeSXafF//zNm8VDfjmmfkTE+NNQ8Qd5FOli6qhoq4CYkSwSqC5xltem5wlN7LxwjnLGSAZSMVpaxuNvwl0=
X-Received: by 2002:a19:6403:: with SMTP id y3mr5014260lfb.24.1627315856714;
 Mon, 26 Jul 2021 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com> <20210723161600.19688-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20210723161600.19688-2-mathieu.desnoyers@efficios.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Jul 2021 00:10:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
Message-ID: <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Revert "csky: Add support for restartable sequence"
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Mathieu,

Sorry for forgetting to CC you in the last patch, and that patch has
been merged into master which has the problem of syscall restart.

I still want to keep rseq feature for csky, and implement the
RSEQ_SKIP_FASTPATH for self-test, it that okay?

diff --git a/tools/testing/selftests/rseq/param_test.c
b/tools/testing/selftests/rseq/param_test.c
index 699ad5f93c34..1e67b212ad98 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -208,6 +208,8 @@ unsigned int yield_mod_cnt, nr_abort;
        "bnez " INJECT_ASM_REG ", 222b\n\t" \
        "333:\n\t"

+#elif defined(__csky__)
+#define RSEQ_SKIP_FASTPATH
 #else
 #error unsupported target
 #endif

diff --git a/tools/testing/selftests/rseq/rseq.h
b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..c3dce298b36c 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -79,6 +79,8 @@ extern int __rseq_handled;
 #include <rseq-mips.h>
 #elif defined(__s390__)
 #include <rseq-s390.h>
+#elif defined(__csky__)
+#include <rseq-csky.h>
 #else
 #error unsupported target
 #endif

diff --git a/tools/testing/selftests/rseq/rseq-csky.h
b/tools/testing/selftests/rseq/rseq-csky.h
new file mode 100644
index 000000000000..ecad40e9aeda
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-csky.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#if __ORDER_LITTLE_ENDIAN__ == 1234
+#define RSEQ_SIG       0xc1e6643f  /* mtcr    r6, cr<31, 15> */
+#else
+#error "Currently, RSEQ only supports Little-Endian version"
+#endif
+
+/*
+ * bar.brwarws: ordering barrier for all load/store instructions
+ *              before/after
+ *
+ * |31|30 26|25 21|20 16|15  10|9   5|4           0|
+ *  1  10000 00000 00000 100001        00001 0 bw br aw ar
+ *
+ * b: before
+ * a: after
+ * r: read
+ * w: write
+ *
+ * Here are all combinations:
+ *
+ * bar.brw
+ * bar.br
+ * bar.bw
+ * bar.arw
+ * bar.ar
+ * bar.aw
+ * bar.brwarw
+ * bar.brarw
+ * bar.bwarw
+ * bar.brwar
+ * bar.brwaw
+ * bar.brar
+ * bar.bwaw
+ */
+#define __bar_brw()    asm volatile (".long 0x842cc000\n":::"memory")
+#define __bar_br()     asm volatile (".long 0x8424c000\n":::"memory")
+#define __bar_bw()     asm volatile (".long 0x8428c000\n":::"memory")
+#define __bar_arw()    asm volatile (".long 0x8423c000\n":::"memory")
+#define __bar_ar()     asm volatile (".long 0x8421c000\n":::"memory")
+#define __bar_aw()     asm volatile (".long 0x8422c000\n":::"memory")
+#define __bar_brwarw() asm volatile (".long 0x842fc000\n":::"memory")
+#define __bar_brarw()  asm volatile (".long 0x8427c000\n":::"memory")
+#define __bar_bwarw()  asm volatile (".long 0x842bc000\n":::"memory")
+#define __bar_brwar()  asm volatile (".long 0x842dc000\n":::"memory")
+#define __bar_brwaw()  asm volatile (".long 0x842ec000\n":::"memory")
+#define __bar_brar()   asm volatile (".long 0x8425c000\n":::"memory")
+#define __bar_brar()   asm volatile (".long 0x8425c000\n":::"memory")
+#define __bar_bwaw()   asm volatile (".long 0x842ac000\n":::"memory")
+
+#define rseq_smp_mb()  __bar_brwarw()
+#define rseq_smp_rmb() __bar_brar()
+#define rseq_smp_wmb() __bar_bwaw()
+
+#define rseq_smp_load_acquire(p)                                       \
+__extension__ ({                                                       \
+       __typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);                       \
+       __bar_brarw();                                                  \
+       ____p1;                                                         \
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()     rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)                                   \
+do {                                                                   \
+       __bar_brwaw();                                                  \
+       RSEQ_WRITE_ONCE(*p, v);                                         \
+} while (0)
+
+#include "rseq-skip.h"

On Sat, Jul 24, 2021 at 12:16 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This reverts commit 9866d141a0977ace974400bf1f793dfc163409ce.
>
> The csky rseq support has been merged without ever notifying the rseq
> maintainers, and without any of the required asssembler glue in the rseq
> selftests, which means it is entirely untested.
>
> It is also derived from a non-upstream riscv patch which has known bugs.
I noticed that in [1]:

As Al Viro pointed out on IRC, the rseq_signal_deliver() should go after syscall
restart handling, similarly to what is done on every other supported
architecture.

[1] https://lore.kernel.org/linux-riscv/1257037909.25426.1626705790861.JavaMail.zimbra@efficios.com/

I still want to fixup it, instead of revert it.

>
> The assembly part of this revert should be carefully reviewed by the
> architecture maintainer because it touches code which has changed since
> the merge of the reverted patch.
>
> The rseq selftests assembly glue should be introduced at the same time
> as the architecture rseq support. Without the presence of any test, I
> recommend reverting rseq support from csky for now.
>
> Link: https://lore.kernel.org/lkml/1257037909.25426.1626705790861.JavaMail.zimbra@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/Kconfig         | 1 -
>  arch/csky/kernel/entry.S  | 4 ----
>  arch/csky/kernel/signal.c | 3 ---
>  3 files changed, 8 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 2716f6395ba7..c9655f09e591 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -66,7 +66,6 @@ config CSKY
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_REGS_AND_STACK_ACCESS_API
> -       select HAVE_RSEQ
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
>         select MAY_HAVE_SPARSE_IRQ
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index d89afe3b24cc..cc2a7e84c8e5 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -50,10 +50,6 @@ ENTRY(csky_systemcall)
>         SAVE_ALL TRAP0_SIZE
>         zero_fp
>         context_tracking
> -#ifdef CONFIG_RSEQ_DEBUG
> -       mov     a0, sp
> -       jbsr    rseq_syscall
> -#endif
>         psrset  ee, ie
>
>         lrw     r9, __NR_syscalls
> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index 312f046d452d..3cf08732b142 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -175,8 +175,6 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>         sigset_t *oldset = sigmask_to_save();
>         int ret;
>
> -       rseq_signal_deliver(ksig, regs);
> -
>         /* Are we from a system call? */
>         if (in_syscall(regs)) {
>                 /* Avoid additional syscall restarting via ret_from_exception */
> @@ -262,6 +260,5 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>
>         if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>                 tracehook_notify_resume(regs);
> -               rseq_handle_notify_resume(NULL, regs);
>         }
>  }
> --
> 2.20.1
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
