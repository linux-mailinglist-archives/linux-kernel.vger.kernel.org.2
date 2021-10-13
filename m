Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5C42BC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhJMKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:16:01 -0400
Received: from foss.arm.com ([217.140.110.172]:60286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239273AbhJMKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:16:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B1913D5;
        Wed, 13 Oct 2021 03:13:57 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2FC3F70D;
        Wed, 13 Oct 2021 03:13:54 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:13:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/8] arm64: Recover kretprobe modified return address in
 stacktrace
Message-ID: <20211013101351.GB3187@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369613866.636038.15240679956943005288.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369613866.636038.15240679956943005288.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:28:58PM +0900, Masami Hiramatsu wrote:
> Since the kretprobe replaces the function return address with
> the kretprobe_trampoline on the stack, stack unwinder shows it
> instead of the correct return address.
> 
> This checks whether the next return address is the
> __kretprobe_trampoline(), and if so, try to find the correct
> return address from the kretprobe instance list.
> 
> With this fix, now arm64 can enable
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
> kprobe self tests.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/Kconfig                  |    1 +
>  arch/arm64/include/asm/stacktrace.h |    2 ++
>  arch/arm64/kernel/stacktrace.c      |    3 +++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..edde5171ffb2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ARM64
>  	select ACPI_PPTT if ACPI
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 8aebc00c1718..8f997a602651 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -9,6 +9,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/types.h>
> +#include <linux/llist.h>
>  
>  #include <asm/memory.h>
>  #include <asm/ptrace.h>
> @@ -59,6 +60,7 @@ struct stackframe {
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	int graph;
>  #endif
> +	struct llist_node *kr_cur;

As with the fgraph bits above, please make this depedn on the relevant
Kconfig, i.e.

| #ifdef CONFIG_KRETPROBES
| 	struct llist_node *kr_cur;
| #endif

>  };
>  
>  extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 8982a2b78acf..f1eef5745542 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -129,6 +129,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  		frame->pc = ret_stack->ret;
>  	}
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +	if (is_kretprobe_trampoline(frame->pc))
> +		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);

Please ifdef this, like the CONFIG_FUNCTION_GRAPH_TRACER bits above.
i.e.

| #ifdef CONFIG_KRETPROBES
| 	if (is_kretprobe_trampoline(frame->pc))
| 		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
| #endif

What does kretprobe_find_ret_addr() do when it can't find the original
address? I couldn't spot it in this series or in mainline.

As a future thing, I'd like to be able to have monotonicity and
completeness checks as part of the unwind, i.e. checking that we consume
the kretprobe address *in-order*, and can identify whether we've skipped
any, so that we can identify when unwinding has gone wrong. Does it do
that today?

It'd be nice if it could signal failure reliably (without causing a
BUG() or similar), e.g. by returning an error code.

>  	frame->pc = ptrauth_strip_insn_pac(frame->pc);
>  
> @@ -224,6 +226,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  {
>  	struct stackframe frame;
>  
> +	memset(&frame, 0, sizeof(frame));

Please initialise stackframe::kr_cur in start_backtrace, where we
initialize all the other fields in struct stackframe, i.e. just after
the CONFIG_FUNCTION_GRAPH_TRACER bit, have:

| #ifdef CONFIG_KRETPROBES
| 	frame->kr_cur = NULL;
| #endif

Thanks,
Mark.

>  	if (regs)
>  		start_backtrace(&frame, regs->regs[29], regs->pc);
>  	else if (task == current)
> 
