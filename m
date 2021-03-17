Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4D33F964
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCQTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:34:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhCQTeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:34:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D03ED1;
        Wed, 17 Mar 2021 12:34:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0853F70D;
        Wed, 17 Mar 2021 12:34:19 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:34:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, rui.xiang@huawei.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Message-ID: <20210317193416.GB9786@C02TD0UTHF1T.local>
References: <20210317142050.57712-1-chenjun102@huawei.com>
 <20210317142050.57712-3-chenjun102@huawei.com>
 <20210317183636.GG12269@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317183636.GG12269@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 06:36:36PM +0000, Catalin Marinas wrote:
> On Wed, Mar 17, 2021 at 02:20:50PM +0000, Chen Jun wrote:
> > On ARM64, cat /sys/kernel/debug/page_owner, all pages return the same
> > stack:
> >  stack_trace_save+0x4c/0x78
> >  register_early_stack+0x34/0x70
> >  init_page_owner+0x34/0x230
> >  page_ext_init+0x1bc/0x1dc
> > 
> > The reason is that:
> > check_recursive_alloc always return 1 because that
> > entries[0] is always equal to ip (__set_page_owner+0x3c/0x60).
> > 
> > The root cause is that:
> > commit 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > make the save_trace save 2 more entries.
> > 
> > Add skip in arch_stack_walk when task == current.
> > 
> > Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > Signed-off-by: Chen Jun <chenjun102@huawei.com>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index ad20981..c26b0ac 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -201,11 +201,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> >  
> >  	if (regs)
> >  		start_backtrace(&frame, regs->regs[29], regs->pc);
> > -	else if (task == current)
> > +	else if (task == current) {
> > +		((struct stacktrace_cookie *)cookie)->skip += 2;
> >  		start_backtrace(&frame,
> >  				(unsigned long)__builtin_frame_address(0),
> >  				(unsigned long)arch_stack_walk);
> > -	else
> > +	} else
> >  		start_backtrace(&frame, thread_saved_fp(task),
> >  				thread_saved_pc(task));
> 
> I don't like abusing the cookie here. It's void * as it's meant to be an
> opaque type. I'd rather skip the first two frames in walk_stackframe()
> instead before invoking fn().

I agree that we shouldn't touch cookie here.

I don't think that it's right to bodge this inside walk_stackframe(),
since that'll add bogus skipping for the case starting with regs in the
current task. If we need a bodge, it has to live in arch_stack_walk()
where we set up the initial unwinding state.

In another thread, we came to the conclusion that arch_stack_walk()
should start at its parent, and its parent should add any skipping it
requires.

Currently, arch_stack_walk() is off-by-one, and we can bodge that by
using __builtin_frame_address(1), though I'm waiting for some compiler
folk to confirm that's sound. Otherwise we need to add an assembly
trampoline to snapshot the FP, which is unfortunastely convoluted.

This report suggests that a caller of arch_stack_walk() is off-by-one
too, which suggests a larger cross-architecture semantic issue. I'll try
to take a look tomorrow.

Thanks,
Mark.

> 
> Prior to the conversion to ARCH_STACKWALK, we were indeed skipping two
> more entries in __save_stack_trace() if tsk == current. Something like
> below, completely untested:
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index ad20981dfda4..2a9f759aa41a 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -115,10 +115,15 @@ NOKPROBE_SYMBOL(unwind_frame);
>  void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>  			     bool (*fn)(void *, unsigned long), void *data)
>  {
> +	/* for the current task, we don't want this function nor its caller */
> +	int skip = tsk == current ? 2 : 0;
> +
>  	while (1) {
>  		int ret;
>  
> -		if (!fn(data, frame->pc))
> +		if (skip)
> +			skip--;
> +		else if (!fn(data, frame->pc))
>  			break;
>  		ret = unwind_frame(tsk, frame);
>  		if (ret < 0)
> 
> 
> -- 
> Catalin
