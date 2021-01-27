Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94113305F71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbhA0PVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:21:53 -0500
Received: from foss.arm.com ([217.140.110.172]:50700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234641AbhA0PPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:15:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 009AF1042;
        Wed, 27 Jan 2021 07:14:58 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197E03F66B;
        Wed, 27 Jan 2021 07:14:56 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:14:39 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64/ptrace: don't clobber task registers on
 syscall entry/exit traps
Message-ID: <20210127151438.GD13952@arm.com>
References: <20210119220637.494476-1-avagin@gmail.com>
 <20210119220637.494476-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119220637.494476-2-avagin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:06:35PM -0800, Andrei Vagin wrote:
> ip/r12 for AArch32 and x7 for AArch64 is used to indicate whether or not
> the stop has been signalled from syscall entry or syscall exit. This
> means that:
> 
> - Any writes by the tracer to this register during the stop are
>   ignored/discarded.
> 
> - The actual value of the register is not available during the stop,
>   so the tracer cannot save it and restore it later.
> 
> Right now, these registers are clobbered in tracehook_report_syscall.
> This change moves this logic to gpr_get and compat_gpr_get where
> registers are copied into a user-space buffer.
> 
> This will allow to change these registers and to introduce a new
> NT_ARM_PRSTATUS command to get the full set of registers.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/include/asm/ptrace.h |   5 ++
>  arch/arm64/kernel/ptrace.c      | 104 +++++++++++++++++++-------------
>  2 files changed, 67 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e58bca832dff..0a9552b4f61e 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -170,6 +170,11 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
>  	return psr;
>  }
>  
> +enum ptrace_syscall_dir {
> +	PTRACE_SYSCALL_ENTER = 0,
> +	PTRACE_SYSCALL_EXIT,
> +};
> +
>  /*
>   * This struct defines the way the registers are stored on the stack during an
>   * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 (for
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 8ac487c84e37..1863f080cb07 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -40,6 +40,7 @@
>  #include <asm/syscall.h>
>  #include <asm/traps.h>
>  #include <asm/system_misc.h>
> +#include <asm/ptrace.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
> @@ -561,7 +562,33 @@ static int gpr_get(struct task_struct *target,
>  		   struct membuf to)
>  {
>  	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
> -	return membuf_write(&to, uregs, sizeof(*uregs));
> +	unsigned long saved_reg;
> +	int ret;
> +
> +	/*
> +	 * We have some ABI weirdness here in the way that we handle syscall
> +	 * exit stops because we indicate whether or not the stop has been
> +	 * signalled from syscall entry or syscall exit by clobbering the general
> +	 * purpose register x7.
> +	 */
> +	switch (target->ptrace_message) {
> +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +		saved_reg = uregs->regs[7];
> +		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
> +		break;
> +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +		saved_reg = uregs->regs[7];
> +		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
> +		break;
> +	}
> +
> +	ret =  membuf_write(&to, uregs, sizeof(*uregs));
> +
> +	if (target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY ||
> +	    target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT)
> +		uregs->regs[7] = saved_reg;

This might be a reasonable cleanup even if the extra regset isn't
introduced: it makes it clear that we're not changing the user registers
here, just the tracer's view of them.

I'm assuming it doesn't break tracing anywhere else.  I can't think of
anything it would break just now, but I haven't spent much time looking
into it.


Can you not just unconditionally back up and restore regs[7] here?  e.g.

	saved_reg = uregs->regs[7];

	switch (target->ptrace_message) {
	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
	case PTRACE_EVENTMSG_SYSCALL_EXIT:
		uregs->regs[7] = target->ptrace_message;
	}

	ret = membuf_write(...);

	uregs->regs[7] = saved_reg;


> +
> +	return ret;
>  }
>  
>  static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> @@ -1221,10 +1248,40 @@ static int compat_gpr_get(struct task_struct *target,
>  			  const struct user_regset *regset,
>  			  struct membuf to)
>  {
> +	compat_ulong_t r12;
> +	bool overwrite_r12;
>  	int i = 0;
>  
> -	while (to.left)
> -		membuf_store(&to, compat_get_user_reg(target, i++));
> +	/*
> +	 * We have some ABI weirdness here in the way that we handle syscall
> +	 * exit stops because we indicate whether or not the stop has been
> +	 * signalled from syscall entry or syscall exit by clobbering the
> +	 * general purpose register r12.
> +	 */
> +	switch (target->ptrace_message) {
> +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +		r12 = PTRACE_SYSCALL_ENTER;
> +		overwrite_r12 = true;
> +		break;
> +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +		r12 = PTRACE_SYSCALL_EXIT;
> +		overwrite_r12 = true;
> +		break;
> +	default:
> +		overwrite_r12 = false;
> +		break;
> +	}
> +
> +	while (to.left) {
> +		compat_ulong_t val;
> +
> +		if (!overwrite_r12 || i != 12)
> +			val = compat_get_user_reg(target, i++);
> +		else
> +			val = r12;
> +		membuf_store(&to, val);
> +	}
> +

Can this be condensed too, say by introducing a wrapper for
compat_get_user_reg() that does the fudging on r12?

[...]

Cheers
---Dave
