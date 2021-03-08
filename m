Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C107330A83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCHJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:49:48 -0500
Received: from foss.arm.com ([217.140.110.172]:34980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhCHJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:49:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD9CD6E;
        Mon,  8 Mar 2021 01:49:37 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85833F73C;
        Mon,  8 Mar 2021 01:49:35 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:49:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/11] kentry: Simplify the common syscall API
Message-ID: <20210308094928.GB7951@C02TD0UTHF1T.local>
References: <cover.1614884673.git.luto@kernel.org>
 <71443459ef325bcadf171b78cbac6abc9d873e44.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71443459ef325bcadf171b78cbac6abc9d873e44.1614884673.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:05:59AM -0800, Andy Lutomirski wrote:
> The new common syscall API had a large and confusing API surface.  Simplify
> it.  Now there is exactly one way to use it.  It's a bit more verbose than
> the old way for the simple x86_64 native case, but it's much easier to use
> right, and the diffstat should speak for itself.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

I think that having this more verbose is going to make it easier to
handle ABI warts that differ across architectures, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/x86/entry/common.c      | 57 +++++++++++++++---------
>  include/linux/entry-common.h | 86 ++++++------------------------------
>  kernel/entry/common.c        | 57 +++---------------------
>  3 files changed, 54 insertions(+), 146 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index ef1c65938a6b..8710b2300b8d 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -38,9 +38,12 @@
>  #ifdef CONFIG_X86_64
>  __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  {
> -	nr = syscall_enter_from_user_mode(regs, nr);
> -
> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();
>  	instrumentation_begin();
> +
> +	nr = kentry_syscall_begin(regs, nr);
> +
>  	if (likely(nr < NR_syscalls)) {
>  		nr = array_index_nospec(nr, NR_syscalls);
>  		regs->ax = sys_call_table[nr](regs);
> @@ -52,8 +55,12 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  		regs->ax = x32_sys_call_table[nr](regs);
>  #endif
>  	}
> +
> +	kentry_syscall_end(regs);
> +
> +	local_irq_disable();
>  	instrumentation_end();
> -	syscall_exit_to_user_mode(regs);
> +	kentry_exit_to_user_mode(regs);
>  }
>  #endif
>  
> @@ -83,33 +90,34 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
>  {
>  	unsigned int nr = syscall_32_enter(regs);
>  
> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();
> +	instrumentation_begin();
> +
>  	/*
>  	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
>  	 * orig_ax, the unsigned int return value truncates it.  This may
>  	 * or may not be necessary, but it matches the old asm behavior.
>  	 */
> -	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
> -	instrumentation_begin();
> -
> +	nr = (unsigned int)kentry_syscall_begin(regs, nr);
>  	do_syscall_32_irqs_on(regs, nr);
> +	kentry_syscall_end(regs);
>  
> +	local_irq_disable();
>  	instrumentation_end();
> -	syscall_exit_to_user_mode(regs);
> +	kentry_exit_to_user_mode(regs);
>  }
>  
>  static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  {
>  	unsigned int nr = syscall_32_enter(regs);
> +	bool ret;
>  	int res;
>  
> -	/*
> -	 * This cannot use syscall_enter_from_user_mode() as it has to
> -	 * fetch EBP before invoking any of the syscall entry work
> -	 * functions.
> -	 */
> -	syscall_enter_from_user_mode_prepare(regs);
> -
> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();
>  	instrumentation_begin();
> +
>  	/* Fetch EBP from where the vDSO stashed it. */
>  	if (IS_ENABLED(CONFIG_X86_64)) {
>  		/*
> @@ -126,21 +134,23 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  	if (res) {
>  		/* User code screwed up. */
>  		regs->ax = -EFAULT;
> -
> -		instrumentation_end();
> -		local_irq_disable();
> -		irqentry_exit_to_user_mode(regs);
> -		return false;
> +		ret = false;
> +		goto out;
>  	}
>  
>  	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
> -	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
> +	nr = (unsigned int)kentry_syscall_begin(regs, nr);
>  
>  	/* Now this is just like a normal syscall. */
>  	do_syscall_32_irqs_on(regs, nr);
>  
> +	kentry_syscall_end(regs);
> +	ret = true;
> +
> +out:
> +	local_irq_disable();
>  	instrumentation_end();
> -	syscall_exit_to_user_mode(regs);
> +	kentry_exit_to_user_mode(regs);
>  	return true;
>  }
>  
> @@ -233,8 +243,11 @@ __visible void noinstr ret_from_fork(struct task_struct *prev,
>  		user_regs->ax = 0;
>  	}
>  
> +	kentry_syscall_end(user_regs);
> +
> +	local_irq_disable();
>  	instrumentation_end();
> -	syscall_exit_to_user_mode(user_regs);
> +	kentry_exit_to_user_mode(user_regs);
>  }
>  
>  #ifdef CONFIG_XEN_PV
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index fd2d7c35670a..5287c6c15a66 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -119,31 +119,12 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
>  void enter_from_user_mode(struct pt_regs *regs);
>  
>  /**
> - * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
> - * @regs:	Pointer to currents pt_regs
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This handles lockdep, RCU (context tracking) and tracing state, i.e.
> - * the functionality provided by enter_from_user_mode().
> - *
> - * This is invoked when there is extra architecture specific functionality
> - * to be done between establishing state and handling user mode entry work.
> - */
> -void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
> -
> -/**
> - * syscall_enter_from_user_mode_work - Check and handle work before invoking
> - *				       a syscall
> + * kentry_syscall_begin - Prepare to invoke a syscall handler
>   * @regs:	Pointer to currents pt_regs
>   * @syscall:	The syscall number
>   *
>   * Invoked from architecture specific syscall entry code with interrupts
> - * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
> - * architecture specific work.
> + * enabled after kentry_enter_from_usermode or a similar function.
>   *
>   * Returns: The original or a modified syscall number
>   *
> @@ -152,32 +133,16 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
>   * syscall_set_return_value() first.  If neither of those are called and -1
>   * is returned, then the syscall will fail with ENOSYS.
>   *
> + * After calling kentry_syscall_begin(), regardless of the return value,
> + * the caller must call kentry_syscall_end().
> + *
>   * It handles the following work items:
>   *
>   *  1) syscall_work flag dependent invocations of
>   *     arch_syscall_enter_tracehook(), __secure_computing(), trace_sys_enter()
>   *  2) Invocation of audit_syscall_entry()
>   */
> -long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
> -
> -/**
> - * syscall_enter_from_user_mode - Establish state and check and handle work
> - *				  before invoking a syscall
> - * @regs:	Pointer to currents pt_regs
> - * @syscall:	The syscall number
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This is combination of syscall_enter_from_user_mode_prepare() and
> - * syscall_enter_from_user_mode_work().
> - *
> - * Returns: The original or a modified syscall number. See
> - * syscall_enter_from_user_mode_work() for further explanation.
> - */
> -long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
> +long kentry_syscall_begin(struct pt_regs *regs, long syscall);
>  
>  /**
>   * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
> @@ -317,28 +282,16 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
>  void exit_to_user_mode(void);
>  
>  /**
> - * syscall_exit_to_user_mode_work - Handle work before returning to user mode
> + * kentry_syscall_end - Finish syscall processing
>   * @regs:	Pointer to currents pt_regs
>   *
> - * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
> - * exit_to_user_mode() to perform the final transition to user mode.
>   *
> - * Calling convention is the same as for syscall_exit_to_user_mode() and it
> - * returns with all work handled and interrupts disabled. The caller must
> - * invoke exit_to_user_mode() before actually switching to user mode to
> - * make the final state transitions. Interrupts must stay disabled between
> - * return from this function and the invocation of exit_to_user_mode().
> - */
> -void syscall_exit_to_user_mode_work(struct pt_regs *regs);
> -
> -/**
> - * syscall_exit_to_user_mode - Handle work before returning to user mode
> - * @regs:	Pointer to currents pt_regs
> + * This must be called after arch code calls kentry_syscall_begin()
> + * and invoking a syscall handler, if any.  This must also be called when
> + * returning from fork() to user mode, since return-from-fork is considered
> + * to be a syscall return.
>   *
> - * Invoked with interrupts enabled and fully valid regs. Returns with all
> - * work handled, interrupts disabled such that the caller can immediately
> - * switch to user mode. Called from architecture specific syscall and ret
> - * from fork code.
> + * Called with IRQs on.  Returns with IRQs still on.
>   *
>   * The call order is:
>   *  1) One-time syscall exit work:
> @@ -346,21 +299,8 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
>   *      - audit
>   *	- syscall tracing
>   *	- tracehook (single stepping)
> - *
> - *  2) Preparatory work
> - *	- Exit to user mode loop (common TIF handling). Invokes
> - *	  arch_exit_to_user_mode_work() for architecture specific TIF work
> - *	- Architecture specific one time work arch_exit_to_user_mode_prepare()
> - *	- Address limit and lockdep checks
> - *
> - *  3) Final transition (lockdep, tracing, context tracking, RCU), i.e. the
> - *     functionality in exit_to_user_mode().
> - *
> - * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
> - * exit_to_user_mode(). This function is preferred unless there is a
> - * compelling architectural reason to use the seperate functions.
>   */
> -void syscall_exit_to_user_mode(struct pt_regs *regs);
> +void kentry_syscall_end(struct pt_regs *regs);
>  
>  /**
>   * kentry_enter_from_user_mode - Establish state before invoking the irq handler
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 269766a8f981..800ad406431b 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -80,44 +80,19 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  	return ret ? : syscall;
>  }
>  
> -static __always_inline long
> -__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
> +long kentry_syscall_begin(struct pt_regs *regs, long syscall)
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
> +	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
> +	lockdep_assert_irqs_enabled();
> +
>  	if (work & SYSCALL_WORK_ENTER)
>  		syscall = syscall_trace_enter(regs, syscall, work);
>  
>  	return syscall;
>  }
>  
> -long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
> -{
> -	return __syscall_enter_from_user_work(regs, syscall);
> -}
> -
> -noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
> -{
> -	long ret;
> -
> -	__enter_from_user_mode(regs);
> -
> -	instrumentation_begin();
> -	local_irq_enable();
> -	ret = __syscall_enter_from_user_work(regs, syscall);
> -	instrumentation_end();
> -
> -	return ret;
> -}
> -
> -noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
> -{
> -	__enter_from_user_mode(regs);
> -	instrumentation_begin();
> -	local_irq_enable();
> -	instrumentation_end();
> -}
> -
>  /* See comment for exit_to_user_mode() in entry-common.h */
>  static __always_inline void __exit_to_user_mode(void)
>  {
> @@ -218,7 +193,7 @@ static inline bool report_single_step(unsigned long work)
>  /*
>   * If SYSCALL_EMU is set, then the only reason to report is when
>   * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> - * instruction has been already reported in syscall_enter_from_user_mode().
> + * instruction has been already reported in kentry_syscall_begin().
>   */
>  static inline bool report_single_step(unsigned long work)
>  {
> @@ -261,7 +236,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>   * Syscall specific exit to user mode preparation. Runs with interrupts
>   * enabled.
>   */
> -static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> +void kentry_syscall_end(struct pt_regs *regs)
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  	unsigned long nr = syscall_get_nr(current, regs);
> @@ -284,26 +259,6 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>  		syscall_exit_work(regs, work);
>  }
>  
> -static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
> -{
> -	syscall_exit_to_user_mode_prepare(regs);
> -	local_irq_disable_exit_to_user();
> -	exit_to_user_mode_prepare(regs);
> -}
> -
> -void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> -{
> -	__syscall_exit_to_user_mode_work(regs);
> -}
> -
> -__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
> -{
> -	instrumentation_begin();
> -	__syscall_exit_to_user_mode_work(regs);
> -	instrumentation_end();
> -	__exit_to_user_mode();
> -}
> -
>  noinstr void kentry_enter_from_user_mode(struct pt_regs *regs)
>  {
>  	__enter_from_user_mode(regs);
> -- 
> 2.29.2
> 
