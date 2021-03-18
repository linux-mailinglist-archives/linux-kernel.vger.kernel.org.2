Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAC340D30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhCRSgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232523AbhCRSg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEFF964F30;
        Thu, 18 Mar 2021 18:36:26 +0000 (UTC)
Date:   Thu, 18 Mar 2021 18:36:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, rui.xiang@huawei.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Message-ID: <20210318183623.GB10758@arm.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
 <20210317142050.57712-3-chenjun102@huawei.com>
 <20210317183636.GG12269@arm.com>
 <20210317193416.GB9786@C02TD0UTHF1T.local>
 <20210318161723.GA10758@arm.com>
 <20210318171207.GB29466@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318171207.GB29466@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 05:12:07PM +0000, Mark Rutland wrote:
> On Thu, Mar 18, 2021 at 04:17:24PM +0000, Catalin Marinas wrote:
> > On Wed, Mar 17, 2021 at 07:34:16PM +0000, Mark Rutland wrote:
> > > On Wed, Mar 17, 2021 at 06:36:36PM +0000, Catalin Marinas wrote:
> > > > On Wed, Mar 17, 2021 at 02:20:50PM +0000, Chen Jun wrote:
> > > > > On ARM64, cat /sys/kernel/debug/page_owner, all pages return the same
> > > > > stack:
> > > > >  stack_trace_save+0x4c/0x78
> > > > >  register_early_stack+0x34/0x70
> > > > >  init_page_owner+0x34/0x230
> > > > >  page_ext_init+0x1bc/0x1dc
> > > > > 
> > > > > The reason is that:
> > > > > check_recursive_alloc always return 1 because that
> > > > > entries[0] is always equal to ip (__set_page_owner+0x3c/0x60).
> > > > > 
> > > > > The root cause is that:
> > > > > commit 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > > > > make the save_trace save 2 more entries.
> > > > > 
> > > > > Add skip in arch_stack_walk when task == current.
> > > > > 
> > > > > Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > > > > Signed-off-by: Chen Jun <chenjun102@huawei.com>
> > > > > ---
> > > > >  arch/arm64/kernel/stacktrace.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > > > > index ad20981..c26b0ac 100644
> > > > > --- a/arch/arm64/kernel/stacktrace.c
> > > > > +++ b/arch/arm64/kernel/stacktrace.c
> > > > > @@ -201,11 +201,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> > > > >  
> > > > >  	if (regs)
> > > > >  		start_backtrace(&frame, regs->regs[29], regs->pc);
> > > > > -	else if (task == current)
> > > > > +	else if (task == current) {
> > > > > +		((struct stacktrace_cookie *)cookie)->skip += 2;
> > > > >  		start_backtrace(&frame,
> > > > >  				(unsigned long)__builtin_frame_address(0),
> > > > >  				(unsigned long)arch_stack_walk);
> > > > > -	else
> > > > > +	} else
> > > > >  		start_backtrace(&frame, thread_saved_fp(task),
> > > > >  				thread_saved_pc(task));
> > > > 
> > > > I don't like abusing the cookie here. It's void * as it's meant to be an
> > > > opaque type. I'd rather skip the first two frames in walk_stackframe()
> > > > instead before invoking fn().
> > > 
> > > I agree that we shouldn't touch cookie here.
> > > 
> > > I don't think that it's right to bodge this inside walk_stackframe(),
> > > since that'll add bogus skipping for the case starting with regs in the
> > > current task. If we need a bodge, it has to live in arch_stack_walk()
> > > where we set up the initial unwinding state.
> > 
> > Good point. However, instead of relying on __builtin_frame_address(1),
> > can we add a 'skip' value to struct stackframe via arch_stack_walk() ->
> > start_backtrace() that is consumed by walk_stackframe()?
> 
> We could, but I'd strongly prefer to use __builtin_frame_address(1) if
> we can, as it's much simpler to read and keeps the logic constrained to
> the starting function. I'd already hacked that up at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/unwind&id=5811a76c1be1dcea7104a9a771fc2604bc2a90ef
> 
> ... and I'm fairly confident that this works on arm64.

If it works with both clang and gcc (and various versions), it's cleaner
this way.

> If __builtin_frame_address(1) is truly unreliable, then we could just
> manually unwind one step within arch_stack_walk() when unwinding
> current, which I think is cleaner than spreading this within
> walk_stackframe().
> 
> I can clean up the commit message and post that as a real patch, if you
> like?

Yes, please. Either variant is fine by me, with a preference for
__builtin_frame_address(1) (if we know it works).

> > > In another thread, we came to the conclusion that arch_stack_walk()
> > > should start at its parent, and its parent should add any skipping it
> > > requires.
> > 
> > This makes sense.
> > 
> > > Currently, arch_stack_walk() is off-by-one, and we can bodge that by
> > > using __builtin_frame_address(1), though I'm waiting for some compiler
> > > folk to confirm that's sound. Otherwise we need to add an assembly
> > > trampoline to snapshot the FP, which is unfortunastely convoluted.
> > > 
> > > This report suggests that a caller of arch_stack_walk() is off-by-one
> > > too, which suggests a larger cross-architecture semantic issue. I'll try
> > > to take a look tomorrow.
> > 
> > I don't think the caller is off by one, at least not by the final skip
> > value. __set_page_owner() wants the trace to start at its caller. The
> > callee save_stack() in the same file adds a skip of 2.
> > save_stack_trace() increments the skip before invoking
> > arch_stack_walk(). So far, this assumes that arch_stack_walk() starts at
> > its parent, i.e. save_stack_trace().
> 
> FWIW, I had only assumed the caller was also off-by-one because the
> commit message for this patch said the conversion to ARCH_STACKWALK
> added two entries. Have I misunderstood, or is that incorrect?

I think the commit log is incorrect. Prior to the ARCH_STACKWALK
conversion, __save_stack_trace() was skipping 2 since it was creating
the initial stack_trace_data and called from save_stack_trace(). After
the conversion, the start frame is initialised by arch_stack_walk()
which doesn't have any other arch-specific caller it needs to skip.

-- 
Catalin
