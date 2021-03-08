Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B4330A78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCHJqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:46:35 -0500
Received: from foss.arm.com ([217.140.110.172]:34914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhCHJqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:46:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7326AD6E;
        Mon,  8 Mar 2021 01:46:03 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45A83F70D;
        Mon,  8 Mar 2021 01:46:01 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:45:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] kentry: Rename irqentry to kentry
Message-ID: <20210308094509.GA7951@C02TD0UTHF1T.local>
References: <cover.1614884673.git.luto@kernel.org>
 <b24fa05e79d4719e75016c513be1ec7e7bbe8756.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24fa05e79d4719e75016c513be1ec7e7bbe8756.1614884673.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:05:55AM -0800, Andy Lutomirski wrote:
> The common entry functions are mostly named irqentry, and this is
> confusing.  They are used for syscalls, exceptions, NMIs and, yes, IRQs.
> Call them kentry instead, since they are supposed to be usable for any
> entry to the kernel.
> 
> This path doesn't touch the .irqentry section -- someone can contemplate
> changing that later.  That code predates the common entry code.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

FWIW, I agree this is a better name, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/x86/entry/common.c         |  8 ++---
>  arch/x86/include/asm/idtentry.h | 28 +++++++--------
>  arch/x86/kernel/cpu/mce/core.c  | 10 +++---
>  arch/x86/kernel/kvm.c           |  6 ++--
>  arch/x86/kernel/nmi.c           |  6 ++--
>  arch/x86/kernel/traps.c         | 28 +++++++--------
>  arch/x86/mm/fault.c             |  6 ++--
>  include/linux/entry-common.h    | 60 ++++++++++++++++-----------------
>  kernel/entry/common.c           | 26 +++++++-------
>  9 files changed, 89 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 8fdb4cb27efe..95776f16c1cb 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -264,9 +264,9 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>  {
>  	struct pt_regs *old_regs;
>  	bool inhcall;
> -	irqentry_state_t state;
> +	kentry_state_t state;
>  
> -	state = irqentry_enter(regs);
> +	state = kentry_enter(regs);
>  	old_regs = set_irq_regs(regs);
>  
>  	instrumentation_begin();
> @@ -278,11 +278,11 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>  	inhcall = get_and_clear_inhcall();
>  	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
>  		instrumentation_begin();
> -		irqentry_exit_cond_resched();
> +		kentry_exit_cond_resched();
>  		instrumentation_end();
>  		restore_inhcall(inhcall);
>  	} else {
> -		irqentry_exit(regs, state);
> +		kentry_exit(regs, state);
>  	}
>  }
>  #endif /* CONFIG_XEN_PV */
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f656aabd1545..3ac805d24289 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -40,8 +40,8 @@
>   * The macro is written so it acts as function definition. Append the
>   * body with a pair of curly brackets.
>   *
> - * irqentry_enter() contains common code which has to be invoked before
> - * arbitrary code in the body. irqentry_exit() contains common code
> + * kentry_enter() contains common code which has to be invoked before
> + * arbitrary code in the body. kentry_exit() contains common code
>   * which has to run before returning to the low level assembly code.
>   */
>  #define DEFINE_IDTENTRY(func)						\
> @@ -49,12 +49,12 @@ static __always_inline void __##func(struct pt_regs *regs);		\
>  									\
>  __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> +	kentry_state_t state = kentry_enter(regs);			\
>  									\
>  	instrumentation_begin();					\
>  	__##func (regs);						\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	kentry_exit(regs, state);					\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs)
> @@ -96,12 +96,12 @@ static __always_inline void __##func(struct pt_regs *regs,		\
>  __visible noinstr void func(struct pt_regs *regs,			\
>  			    unsigned long error_code)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> +	kentry_state_t state = kentry_enter(regs);			\
>  									\
>  	instrumentation_begin();					\
>  	__##func (regs, error_code);					\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	kentry_exit(regs, state);					\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs,		\
> @@ -156,7 +156,7 @@ __visible noinstr void func(struct pt_regs *regs)
>   * body with a pair of curly brackets.
>   *
>   * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
> - * irqentry_enter/exit() helpers before and after the body invocation. This
> + * kentry_enter/exit() helpers before and after the body invocation. This
>   * needs to be done in the body itself if applicable. Use if extra work
>   * is required before the enter/exit() helpers are invoked.
>   */
> @@ -192,7 +192,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
>  __visible noinstr void func(struct pt_regs *regs,			\
>  			    unsigned long error_code)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> +	kentry_state_t state = kentry_enter(regs);			\
>  									\
>  	instrumentation_begin();					\
>  	irq_enter_rcu();						\
> @@ -200,7 +200,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  	__##func (regs, (u8)error_code);				\
>  	irq_exit_rcu();							\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	kentry_exit(regs, state);					\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs, u8 vector)
> @@ -224,7 +224,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector)
>   * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>   * @func:	Function name of the entry point
>   *
> - * irqentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
> + * kentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
>   * function body. KVM L1D flush request is set.
>   *
>   * Runs the function on the interrupt stack if the entry hit kernel mode
> @@ -234,7 +234,7 @@ static void __##func(struct pt_regs *regs);				\
>  									\
>  __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> +	kentry_state_t state = kentry_enter(regs);			\
>  									\
>  	instrumentation_begin();					\
>  	irq_enter_rcu();						\
> @@ -242,7 +242,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  	run_sysvec_on_irqstack_cond(__##func, regs);			\
>  	irq_exit_rcu();							\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	kentry_exit(regs, state);					\
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs)
> @@ -263,7 +263,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
>  									\
>  __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
> -	irqentry_state_t state = irqentry_enter(regs);			\
> +	kentry_state_t state = kentry_enter(regs);			\
>  									\
>  	instrumentation_begin();					\
>  	__irq_enter_raw();						\
> @@ -271,7 +271,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  	__##func (regs);						\
>  	__irq_exit_raw();						\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	kentry_exit(regs, state);					\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs)
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 47a0eb57725c..3d4bfd54934e 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1974,7 +1974,7 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
>  
>  static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
>  {
> -	irqentry_state_t irq_state;
> +	kentry_state_t irq_state;
>  
>  	WARN_ON_ONCE(user_mode(regs));
>  
> @@ -1986,7 +1986,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
>  	    mce_check_crashing_cpu())
>  		return;
>  
> -	irq_state = irqentry_nmi_enter(regs);
> +	irq_state = kentry_nmi_enter(regs);
>  	/*
>  	 * The call targets are marked noinstr, but objtool can't figure
>  	 * that out because it's an indirect call. Annotate it.
> @@ -1996,18 +1996,18 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
>  	machine_check_vector(regs);
>  
>  	instrumentation_end();
> -	irqentry_nmi_exit(regs, irq_state);
> +	kentry_nmi_exit(regs, irq_state);
>  }
>  
>  static __always_inline void exc_machine_check_user(struct pt_regs *regs)
>  {
> -	irqentry_enter_from_user_mode(regs);
> +	kentry_enter_from_user_mode(regs);
>  	instrumentation_begin();
>  
>  	machine_check_vector(regs);
>  
>  	instrumentation_end();
> -	irqentry_exit_to_user_mode(regs);
> +	kentry_exit_to_user_mode(regs);
>  }
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5e78e01ca3b4..bcecc3e7cd0a 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -238,12 +238,12 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
>  noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
>  {
>  	u32 flags = kvm_read_and_reset_apf_flags();
> -	irqentry_state_t state;
> +	kentry_state_t state;
>  
>  	if (!flags)
>  		return false;
>  
> -	state = irqentry_enter(regs);
> +	state = kentry_enter(regs);
>  	instrumentation_begin();
>  
>  	/*
> @@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
>  	}
>  
>  	instrumentation_end();
> -	irqentry_exit(regs, state);
> +	kentry_exit(regs, state);
>  	return true;
>  }
>  
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index bf250a339655..6f46722a6e94 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -475,7 +475,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
>  
>  DEFINE_IDTENTRY_RAW(exc_nmi)
>  {
> -	irqentry_state_t irq_state;
> +	kentry_state_t irq_state;
>  
>  	/*
>  	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
> @@ -502,14 +502,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
>  
>  	this_cpu_write(nmi_dr7, local_db_save());
>  
> -	irq_state = irqentry_nmi_enter(regs);
> +	irq_state = kentry_nmi_enter(regs);
>  
>  	inc_irq_stat(__nmi_count);
>  
>  	if (!ignore_nmis)
>  		default_do_nmi(regs);
>  
> -	irqentry_nmi_exit(regs, irq_state);
> +	kentry_nmi_exit(regs, irq_state);
>  
>  	local_db_restore(this_cpu_read(nmi_dr7));
>  
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7f5aec758f0e..be924180005a 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -249,7 +249,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  
>  DEFINE_IDTENTRY_RAW(exc_invalid_op)
>  {
> -	irqentry_state_t state;
> +	kentry_state_t state;
>  
>  	/*
>  	 * We use UD2 as a short encoding for 'CALL __WARN', as such
> @@ -259,11 +259,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>  	if (!user_mode(regs) && handle_bug(regs))
>  		return;
>  
> -	state = irqentry_enter(regs);
> +	state = kentry_enter(regs);
>  	instrumentation_begin();
>  	handle_invalid_op(regs);
>  	instrumentation_end();
> -	irqentry_exit(regs, state);
> +	kentry_exit(regs, state);
>  }
>  
>  DEFINE_IDTENTRY(exc_coproc_segment_overrun)
> @@ -410,7 +410,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
>  	}
>  #endif
>  
> -	irqentry_nmi_enter(regs);
> +	kentry_nmi_enter(regs);
>  	instrumentation_begin();
>  	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
>  
> @@ -646,26 +646,26 @@ DEFINE_IDTENTRY_RAW(exc_int3)
>  		return;
>  
>  	/*
> -	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
> +	 * kentry_enter_from_user_mode() uses static_branch_{,un}likely()
>  	 * and therefore can trigger INT3, hence poke_int3_handler() must
>  	 * be done before. If the entry came from kernel mode, then use
>  	 * nmi_enter() because the INT3 could have been hit in any context
>  	 * including NMI.
>  	 */
>  	if (user_mode(regs)) {
> -		irqentry_enter_from_user_mode(regs);
> +		kentry_enter_from_user_mode(regs);
>  		instrumentation_begin();
>  		do_int3_user(regs);
>  		instrumentation_end();
> -		irqentry_exit_to_user_mode(regs);
> +		kentry_exit_to_user_mode(regs);
>  	} else {
> -		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
> +		kentry_state_t irq_state = kentry_nmi_enter(regs);
>  
>  		instrumentation_begin();
>  		if (!do_int3(regs))
>  			die("int3", regs, 0);
>  		instrumentation_end();
> -		irqentry_nmi_exit(regs, irq_state);
> +		kentry_nmi_exit(regs, irq_state);
>  	}
>  }
>  
> @@ -860,7 +860,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>  	 * includes the entry stack is excluded for everything.
>  	 */
>  	unsigned long dr7 = local_db_save();
> -	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
> +	kentry_state_t irq_state = kentry_nmi_enter(regs);
>  	instrumentation_begin();
>  
>  	/*
> @@ -917,7 +917,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>  		regs->flags &= ~X86_EFLAGS_TF;
>  out:
>  	instrumentation_end();
> -	irqentry_nmi_exit(regs, irq_state);
> +	kentry_nmi_exit(regs, irq_state);
>  
>  	local_db_restore(dr7);
>  }
> @@ -935,14 +935,14 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
>  
>  	/*
>  	 * NB: We can't easily clear DR7 here because
> -	 * irqentry_exit_to_usermode() can invoke ptrace, schedule, access
> +	 * kentry_exit_to_usermode() can invoke ptrace, schedule, access
>  	 * user memory, etc.  This means that a recursive #DB is possible.  If
>  	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
>  	 * Since we're not on the IST stack right now, everything will be
>  	 * fine.
>  	 */
>  
> -	irqentry_enter_from_user_mode(regs);
> +	kentry_enter_from_user_mode(regs);
>  	instrumentation_begin();
>  
>  	/*
> @@ -988,7 +988,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
>  	local_irq_disable();
>  out:
>  	instrumentation_end();
> -	irqentry_exit_to_user_mode(regs);
> +	kentry_exit_to_user_mode(regs);
>  }
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 106b22d1d189..fea6dee3f6f2 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1432,7 +1432,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
>  DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>  {
>  	unsigned long address = read_cr2();
> -	irqentry_state_t state;
> +	kentry_state_t state;
>  
>  	prefetchw(&current->mm->mmap_lock);
>  
> @@ -1470,11 +1470,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>  	 * code reenabled RCU to avoid subsequent wreckage which helps
>  	 * debugability.
>  	 */
> -	state = irqentry_enter(regs);
> +	state = kentry_enter(regs);
>  
>  	instrumentation_begin();
>  	handle_page_fault(regs, error_code, address);
>  	instrumentation_end();
>  
> -	irqentry_exit(regs, state);
> +	kentry_exit(regs, state);
>  }
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index ca86a00abe86..fd2d7c35670a 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -363,7 +363,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
>  void syscall_exit_to_user_mode(struct pt_regs *regs);
>  
>  /**
> - * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
> + * kentry_enter_from_user_mode - Establish state before invoking the irq handler
>   * @regs:	Pointer to currents pt_regs
>   *
>   * Invoked from architecture specific entry code with interrupts disabled.
> @@ -373,10 +373,10 @@ void syscall_exit_to_user_mode(struct pt_regs *regs);
>   *
>   * The function establishes state (lockdep, RCU (context tracking), tracing)
>   */
> -void irqentry_enter_from_user_mode(struct pt_regs *regs);
> +void kentry_enter_from_user_mode(struct pt_regs *regs);
>  
>  /**
> - * irqentry_exit_to_user_mode - Interrupt exit work
> + * kentry_exit_to_user_mode - Interrupt exit work
>   * @regs:	Pointer to current's pt_regs
>   *
>   * Invoked with interrupts disbled and fully valid regs. Returns with all
> @@ -388,34 +388,34 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
>   * Interrupt exit is not invoking #1 which is the syscall specific one time
>   * work.
>   */
> -void irqentry_exit_to_user_mode(struct pt_regs *regs);
> +void kentry_exit_to_user_mode(struct pt_regs *regs);
>  
> -#ifndef irqentry_state
> +#ifndef kentry_state
>  /**
> - * struct irqentry_state - Opaque object for exception state storage
> - * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
> + * struct kentry_state - Opaque object for exception state storage
> + * @exit_rcu: Used exclusively in the kentry_*() calls; signals whether the
>   *            exit path has to invoke rcu_irq_exit().
> - * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
> + * @lockdep: Used exclusively in the kentry_nmi_*() calls; ensures that
>   *           lockdep state is restored correctly on exit from nmi.
>   *
> - * This opaque object is filled in by the irqentry_*_enter() functions and
> - * must be passed back into the corresponding irqentry_*_exit() functions
> + * This opaque object is filled in by the kentry_*_enter() functions and
> + * must be passed back into the corresponding kentry_*_exit() functions
>   * when the exception is complete.
>   *
> - * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
> + * Callers of kentry_*_[enter|exit]() must consider this structure opaque
>   * and all members private.  Descriptions of the members are provided to aid in
> - * the maintenance of the irqentry_*() functions.
> + * the maintenance of the kentry_*() functions.
>   */
> -typedef struct irqentry_state {
> +typedef struct kentry_state {
>  	union {
>  		bool	exit_rcu;
>  		bool	lockdep;
>  	};
> -} irqentry_state_t;
> +} kentry_state_t;
>  #endif
>  
>  /**
> - * irqentry_enter - Handle state tracking on ordinary interrupt entries
> + * kentry_enter - Handle state tracking on ordinary interrupt entries
>   * @regs:	Pointer to pt_regs of interrupted context
>   *
>   * Invokes:
> @@ -439,25 +439,25 @@ typedef struct irqentry_state {
>   * solves the problem of kernel mode pagefaults which can schedule, which
>   * is not possible after invoking rcu_irq_enter() without undoing it.
>   *
> - * For user mode entries irqentry_enter_from_user_mode() is invoked to
> + * For user mode entries kentry_enter_from_user_mode() is invoked to
>   * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
>   * would not be possible.
>   *
>   * Returns: An opaque object that must be passed to idtentry_exit()
>   */
> -irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
> +kentry_state_t noinstr kentry_enter(struct pt_regs *regs);
>  
>  /**
> - * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
> + * kentry_exit_cond_resched - Conditionally reschedule on return from interrupt
>   *
>   * Conditional reschedule with additional sanity checks.
>   */
> -void irqentry_exit_cond_resched(void);
> +void kentry_exit_cond_resched(void);
>  
>  /**
> - * irqentry_exit - Handle return from exception that used irqentry_enter()
> + * kentry_exit - Handle return from exception that used kentry_enter()
>   * @regs:	Pointer to pt_regs (exception entry regs)
> - * @state:	Return value from matching call to irqentry_enter()
> + * @state:	Return value from matching call to kentry_enter()
>   *
>   * Depending on the return target (kernel/user) this runs the necessary
>   * preemption and work checks if possible and required and returns to
> @@ -466,27 +466,27 @@ void irqentry_exit_cond_resched(void);
>   * This is the last action before returning to the low level ASM code which
>   * just needs to return to the appropriate context.
>   *
> - * Counterpart to irqentry_enter().
> + * Counterpart to kentry_enter().
>   */
> -void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
> +void noinstr kentry_exit(struct pt_regs *regs, kentry_state_t state);
>  
>  /**
> - * irqentry_nmi_enter - Handle NMI entry
> + * kentry_nmi_enter - Handle NMI entry
>   * @regs:	Pointer to currents pt_regs
>   *
> - * Similar to irqentry_enter() but taking care of the NMI constraints.
> + * Similar to kentry_enter() but taking care of the NMI constraints.
>   */
> -irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
> +kentry_state_t noinstr kentry_nmi_enter(struct pt_regs *regs);
>  
>  /**
> - * irqentry_nmi_exit - Handle return from NMI handling
> + * kentry_nmi_exit - Handle return from NMI handling
>   * @regs:	Pointer to pt_regs (NMI entry regs)
> - * @irq_state:	Return value from matching call to irqentry_nmi_enter()
> + * @irq_state:	Return value from matching call to kentry_nmi_enter()
>   *
>   * Last action before returning to the low level assembly code.
>   *
> - * Counterpart to irqentry_nmi_enter().
> + * Counterpart to kentry_nmi_enter().
>   */
> -void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
> +void noinstr kentry_nmi_exit(struct pt_regs *regs, kentry_state_t irq_state);
>  
>  #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 378341642f94..269766a8f981 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -304,12 +304,12 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
>  	__exit_to_user_mode();
>  }
>  
> -noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
> +noinstr void kentry_enter_from_user_mode(struct pt_regs *regs)
>  {
>  	__enter_from_user_mode(regs);
>  }
>  
> -noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
> +noinstr void kentry_exit_to_user_mode(struct pt_regs *regs)
>  {
>  	instrumentation_begin();
>  	exit_to_user_mode_prepare(regs);
> @@ -317,14 +317,14 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
>  	__exit_to_user_mode();
>  }
>  
> -noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
> +noinstr kentry_state_t kentry_enter(struct pt_regs *regs)
>  {
> -	irqentry_state_t ret = {
> +	kentry_state_t ret = {
>  		.exit_rcu = false,
>  	};
>  
>  	if (user_mode(regs)) {
> -		irqentry_enter_from_user_mode(regs);
> +		kentry_enter_from_user_mode(regs);
>  		return ret;
>  	}
>  
> @@ -355,7 +355,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  		/*
>  		 * If RCU is not watching then the same careful
>  		 * sequence vs. lockdep and tracing is required
> -		 * as in irqentry_enter_from_user_mode().
> +		 * as in kentry_enter_from_user_mode().
>  		 */
>  		lockdep_hardirqs_off(CALLER_ADDR0);
>  		rcu_irq_enter();
> @@ -382,7 +382,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  	return ret;
>  }
>  
> -void irqentry_exit_cond_resched(void)
> +void kentry_exit_cond_resched(void)
>  {
>  	if (!preempt_count()) {
>  		/* Sanity check RCU and thread stack */
> @@ -394,13 +394,13 @@ void irqentry_exit_cond_resched(void)
>  	}
>  }
>  
> -noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> +noinstr void kentry_exit(struct pt_regs *regs, kentry_state_t state)
>  {
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Check whether this returns to user mode */
>  	if (user_mode(regs)) {
> -		irqentry_exit_to_user_mode(regs);
> +		kentry_exit_to_user_mode(regs);
>  	} else if (!regs_irqs_disabled(regs)) {
>  		/*
>  		 * If RCU was not watching on entry this needs to be done
> @@ -420,7 +420,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  
>  		instrumentation_begin();
>  		if (IS_ENABLED(CONFIG_PREEMPTION))
> -			irqentry_exit_cond_resched();
> +			kentry_exit_cond_resched();
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();
> @@ -434,9 +434,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  	}
>  }
>  
> -irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
> +kentry_state_t noinstr kentry_nmi_enter(struct pt_regs *regs)
>  {
> -	irqentry_state_t irq_state;
> +	kentry_state_t irq_state;
>  
>  	irq_state.lockdep = lockdep_hardirqs_enabled();
>  
> @@ -453,7 +453,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
>  	return irq_state;
>  }
>  
> -void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
> +void noinstr kentry_nmi_exit(struct pt_regs *regs, kentry_state_t irq_state)
>  {
>  	instrumentation_begin();
>  	ftrace_nmi_exit();
> -- 
> 2.29.2
> 
