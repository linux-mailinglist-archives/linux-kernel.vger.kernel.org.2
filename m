Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F542BA00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhJMIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhJMIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:16:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E316860FDA;
        Wed, 13 Oct 2021 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634112861;
        bh=NykAuL4Zs+K1r0m5ec470r276RbfqkZyRxE5hp85tts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDJuvWzO9Q9VVshMROzj0M+J3PvfMSu2V4Hj8rvk2A9SEnSRwGQQ0i7Ai54KcpYtZ
         TKZVNl9ExEhZUZ5lfMGfVCLhn36epSWvd+oYvYY21GY/N6kEPaOmhs1x6CIXh3aRks
         x+ipkpeNICeDerkzU3iAcnrQ0M+tWN7Nj/JCzyF1s1A0ByUPmqFaHPjaFF+sWuwnnW
         Y3CB7VIttO78gYaUbRRxdAW4zBIPeYPgAWse/pk67jNEHGFQyxnq5cqRNs6mzHUBi9
         G/Cgf2BD8KHKoJyKJB9LC3JA7Osp7adEErhC3ufinnGfjLopagms8bsyej3iSqoo82
         t3HZR+tIBOv0Q==
Date:   Wed, 13 Oct 2021 09:14:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/8] arm64: Recover kretprobe modified return address in
 stacktrace
Message-ID: <20211013081416.GC6701@willie-the-truck>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369613866.636038.15240679956943005288.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369613866.636038.15240679956943005288.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
>  };

Please update the comment above this structure to describe the new member
you're adding. If it's only relevant for kprobes, then let's define it
conditionally too (based on CONFIG_KRETPROBES ?)

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
>  
>  	frame->pc = ptrauth_strip_insn_pac(frame->pc);
>  
> @@ -224,6 +226,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  {
>  	struct stackframe frame;
>  
> +	memset(&frame, 0, sizeof(frame));

Why do we need this?

Will
