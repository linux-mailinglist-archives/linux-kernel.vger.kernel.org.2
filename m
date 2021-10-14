Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7442D696
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJNJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhJNJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BFD66109E;
        Thu, 14 Oct 2021 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634205444;
        bh=/IuaOK0r3stsDLvCgSeDG+yYRnpvsEN7DotBaEMiSwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAbNLk9PSRdvFfkJotl9eFkUHq+eysJdC4bPUFZk8kzi9Got4Jc4kbly266xzcEbL
         GMT3VwxJzGKSO9awduK8WpZjDMboF9hvRjxjjLFwzW89KDcL7MjPLPSDm/1ZoAHHQY
         /F+7vTUn59P99ssyn8JWar/H+1E38A3IMJ7V1t2g31v79Ru3DdF2fcrlsY7lUnYEuZ
         7HKJKJ3ok+MbPe2Ce0Ya52YuM9N7UkJN0b1Mdf3WQhoJLY9frRVZrQ5P5zoyQjZip1
         S3nG3K/pglPTo9b1eZUjMC4LC2jfXaaM9cI/7Q1e9MBx7M0DIryQ7oWgLlrAGZoyos
         KfOzxNWBVc+Zg==
Date:   Thu, 14 Oct 2021 18:57:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-Id: <20211014185720.67262334328b383e082d9db4@kernel.org>
In-Reply-To: <20211013101351.GB3187@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
        <163369613866.636038.15240679956943005288.stgit@devnote2>
        <20211013101351.GB3187@C02TD0UTHF1T.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 11:13:51 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Oct 08, 2021 at 09:28:58PM +0900, Masami Hiramatsu wrote:
> > Since the kretprobe replaces the function return address with
> > the kretprobe_trampoline on the stack, stack unwinder shows it
> > instead of the correct return address.
> > 
> > This checks whether the next return address is the
> > __kretprobe_trampoline(), and if so, try to find the correct
> > return address from the kretprobe instance list.
> > 
> > With this fix, now arm64 can enable
> > CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
> > kprobe self tests.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm64/Kconfig                  |    1 +
> >  arch/arm64/include/asm/stacktrace.h |    2 ++
> >  arch/arm64/kernel/stacktrace.c      |    3 +++
> >  3 files changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5c7ae4c3954b..edde5171ffb2 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -11,6 +11,7 @@ config ARM64
> >  	select ACPI_PPTT if ACPI
> >  	select ARCH_HAS_DEBUG_WX
> >  	select ARCH_BINFMT_ELF_STATE
> > +	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> >  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> >  	select ARCH_ENABLE_MEMORY_HOTPLUG
> >  	select ARCH_ENABLE_MEMORY_HOTREMOVE
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> > index 8aebc00c1718..8f997a602651 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/types.h>
> > +#include <linux/llist.h>
> >  
> >  #include <asm/memory.h>
> >  #include <asm/ptrace.h>
> > @@ -59,6 +60,7 @@ struct stackframe {
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  	int graph;
> >  #endif
> > +	struct llist_node *kr_cur;
> 
> As with the fgraph bits above, please make this depedn on the relevant
> Kconfig, i.e.
> 
> | #ifdef CONFIG_KRETPROBES
> | 	struct llist_node *kr_cur;
> | #endif
> 
> >  };

OK.

> >  
> >  extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 8982a2b78acf..f1eef5745542 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -129,6 +129,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
> >  		frame->pc = ret_stack->ret;
> >  	}
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > +	if (is_kretprobe_trampoline(frame->pc))
> > +		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
> 
> Please ifdef this, like the CONFIG_FUNCTION_GRAPH_TRACER bits above.
> i.e.
> 
> | #ifdef CONFIG_KRETPROBES
> | 	if (is_kretprobe_trampoline(frame->pc))
> | 		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
> | #endif

OK.

> 
> What does kretprobe_find_ret_addr() do when it can't find the original
> address? I couldn't spot it in this series or in mainline.

If it couldn't find, it returns NULL.
Hmm, should we check it and keep frame->pc if the return value is NULL?
(anyway, it must not happen. If it happens, that task can not continue to run.)

> As a future thing, I'd like to be able to have monotonicity and
> completeness checks as part of the unwind, i.e. checking that we consume
> the kretprobe address *in-order*, and can identify whether we've skipped
> any, so that we can identify when unwinding has gone wrong. Does it do
> that today?

Good question. No today, but is easy to do since we have the loop cursor
(frame->kr_cur).

unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
                                      struct llist_node **cur)
{
...
        do {
                ret = __kretprobe_find_ret_addr(tsk, cur);
                if (!ret)
                        break;
                ri = container_of(*cur, struct kretprobe_instance, llist);
        } while (ri->fp != fp);
...

Change this loop to;

	ri = container_of(*cur, struct kretprobe_instance, llist);
	prev_fp = ri->fp;
	do {
		ret = __kretprobe_find_ret_addr(tsk, cur);
		if (WARN_ON_ONCE(!ret))
			return ERR_PTR(-ENOENT);
		ri = container_of(*cur, struct kretprobe_instance, llist);
	} while (ri->fp == prev_fp);
	if (ri->fp != fp)
		return ERR_PTR(-EILSEQ);

Then, we can detect that wrong sequence from stacktrace side.

> 
> It'd be nice if it could signal failure reliably (without causing a
> BUG() or similar), e.g. by returning an error code.

As above, -EILSEQ is OK?

> 
> >  	frame->pc = ptrauth_strip_insn_pac(frame->pc);
> >  
> > @@ -224,6 +226,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >  {
> >  	struct stackframe frame;
> >  
> > +	memset(&frame, 0, sizeof(frame));
> 
> Please initialise stackframe::kr_cur in start_backtrace, where we
> initialize all the other fields in struct stackframe, i.e. just after
> the CONFIG_FUNCTION_GRAPH_TRACER bit, have:
> 
> | #ifdef CONFIG_KRETPROBES
> | 	frame->kr_cur = NULL;
> | #endif

OK, let me update it.

Thank you!

> 
> Thanks,
> Mark.
> 
> >  	if (regs)
> >  		start_backtrace(&frame, regs->regs[29], regs->pc);
> >  	else if (task == current)
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
