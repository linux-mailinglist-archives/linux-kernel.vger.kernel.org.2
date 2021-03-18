Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85803409E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhCRQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232014AbhCRQR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:17:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C296764F1C;
        Thu, 18 Mar 2021 16:17:26 +0000 (UTC)
Date:   Thu, 18 Mar 2021 16:17:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, rui.xiang@huawei.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Message-ID: <20210318161723.GA10758@arm.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
 <20210317142050.57712-3-chenjun102@huawei.com>
 <20210317183636.GG12269@arm.com>
 <20210317193416.GB9786@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317193416.GB9786@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:34:16PM +0000, Mark Rutland wrote:
> On Wed, Mar 17, 2021 at 06:36:36PM +0000, Catalin Marinas wrote:
> > On Wed, Mar 17, 2021 at 02:20:50PM +0000, Chen Jun wrote:
> > > On ARM64, cat /sys/kernel/debug/page_owner, all pages return the same
> > > stack:
> > >  stack_trace_save+0x4c/0x78
> > >  register_early_stack+0x34/0x70
> > >  init_page_owner+0x34/0x230
> > >  page_ext_init+0x1bc/0x1dc
> > > 
> > > The reason is that:
> > > check_recursive_alloc always return 1 because that
> > > entries[0] is always equal to ip (__set_page_owner+0x3c/0x60).
> > > 
> > > The root cause is that:
> > > commit 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > > make the save_trace save 2 more entries.
> > > 
> > > Add skip in arch_stack_walk when task == current.
> > > 
> > > Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > > Signed-off-by: Chen Jun <chenjun102@huawei.com>
> > > ---
> > >  arch/arm64/kernel/stacktrace.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > > index ad20981..c26b0ac 100644
> > > --- a/arch/arm64/kernel/stacktrace.c
> > > +++ b/arch/arm64/kernel/stacktrace.c
> > > @@ -201,11 +201,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> > >  
> > >  	if (regs)
> > >  		start_backtrace(&frame, regs->regs[29], regs->pc);
> > > -	else if (task == current)
> > > +	else if (task == current) {
> > > +		((struct stacktrace_cookie *)cookie)->skip += 2;
> > >  		start_backtrace(&frame,
> > >  				(unsigned long)__builtin_frame_address(0),
> > >  				(unsigned long)arch_stack_walk);
> > > -	else
> > > +	} else
> > >  		start_backtrace(&frame, thread_saved_fp(task),
> > >  				thread_saved_pc(task));
> > 
> > I don't like abusing the cookie here. It's void * as it's meant to be an
> > opaque type. I'd rather skip the first two frames in walk_stackframe()
> > instead before invoking fn().
> 
> I agree that we shouldn't touch cookie here.
> 
> I don't think that it's right to bodge this inside walk_stackframe(),
> since that'll add bogus skipping for the case starting with regs in the
> current task. If we need a bodge, it has to live in arch_stack_walk()
> where we set up the initial unwinding state.

Good point. However, instead of relying on __builtin_frame_address(1),
can we add a 'skip' value to struct stackframe via arch_stack_walk() ->
start_backtrace() that is consumed by walk_stackframe()?

> In another thread, we came to the conclusion that arch_stack_walk()
> should start at its parent, and its parent should add any skipping it
> requires.

This makes sense.

> Currently, arch_stack_walk() is off-by-one, and we can bodge that by
> using __builtin_frame_address(1), though I'm waiting for some compiler
> folk to confirm that's sound. Otherwise we need to add an assembly
> trampoline to snapshot the FP, which is unfortunastely convoluted.
> 
> This report suggests that a caller of arch_stack_walk() is off-by-one
> too, which suggests a larger cross-architecture semantic issue. I'll try
> to take a look tomorrow.

I don't think the caller is off by one, at least not by the final skip
value. __set_page_owner() wants the trace to start at its caller. The
callee save_stack() in the same file adds a skip of 2.
save_stack_trace() increments the skip before invoking
arch_stack_walk(). So far, this assumes that arch_stack_walk() starts at
its parent, i.e. save_stack_trace().

So save_stack_trace() only need to skip 1 and I think that's in line
with the original report where the entries[0] is __set_page_owner(). We
only need to skip one. Another untested quick hack (we should probably
add the skip argument to start_backtrace()):

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index eb29b1fe8255..0d32d932ac89 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -56,6 +56,7 @@ struct stackframe {
 	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
 	unsigned long prev_fp;
 	enum stack_type prev_type;
+	int skip;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
@@ -153,6 +154,7 @@ static inline void start_backtrace(struct stackframe *frame,
 {
 	frame->fp = fp;
 	frame->pc = pc;
+	frame->skip = 0;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame->graph = 0;
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ad20981dfda4..a89b2ecbf3de 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -118,7 +118,9 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 	while (1) {
 		int ret;
 
-		if (!fn(data, frame->pc))
+		if (frame->skip > 0)
+			frame->skip--;
+		else if (!fn(data, frame->pc))
 			break;
 		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
@@ -201,11 +203,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 
 	if (regs)
 		start_backtrace(&frame, regs->regs[29], regs->pc);
-	else if (task == current)
+	else if (task == current) {
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)arch_stack_walk);
-	else
+		frame.skip = 1;
+	} else
 		start_backtrace(&frame, thread_saved_fp(task),
 				thread_saved_pc(task));
 

-- 
Catalin
