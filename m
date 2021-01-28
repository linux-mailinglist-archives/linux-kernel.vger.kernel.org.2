Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B02307F78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhA1UWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:22:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:53446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhA1UVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:21:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B0A5B114;
        Thu, 28 Jan 2021 20:21:05 +0000 (UTC)
Subject: Re: [PATCH] x86/debug: 'Fix' ptrace dr6 output
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
From:   Tom de Vries <tdevries@suse.de>
Message-ID: <bc1f78e1-3515-3698-9510-bea0345db728@suse.de>
Date:   Thu, 28 Jan 2021 21:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 7:20 PM, Peter Zijlstra wrote:
> 
> Tom reported that one of the GDB test-cases failed, and Boris bisected
> it to commit:
> 
>   d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
> 
> The debugging session led us to commit:
> 
>   6c0aca288e72 ("x86: Ignore trap bits on single step exceptions")
> 
> Which describes a nice Wine case in it's bugzilla. Interaction between
> TF and DR7 is such that TF has the highest priority, but if both are
> triggered by the same instruction and are both trap, DR6 might contain
> both BS and B# flags.
> 
> Commit 6c0aca288e72 made sure to not process the B# flags when the BS
> flag is set, which is correct since the hardware will generate another
> exception.
> 
> The result of commit d53d9bc0cf78 was that in this case the DR6
> register presented to ptrace() would no longer reflect the B# flags
> when BS was set.
> 
> Furthermore, previously it would pass down the DR6 bits as observed by
> the hardware, which doesn't need to match the order that ptrace()
> thinks (although typically there is a 1:1 mapping).
> 
> So explicitly copy DR6 B# bits when BS is set, but make sure to only
> copy those bits ptrace() knows about and indexed consistent with what
> ptrace expects.
> 
> This restores function to the GDB testcase and retains functionality
> of the Wine test-case (which Thomas replicated in a small C program).
> 
> Noteworthy is that Wine explicitly ignores B# bits when BS is set,
> because Windows isn't consistent about this either. Why GDB cares
> about them is a bit of a mystery, but so be it.
> 

Looking in gdb.repo/gdb/nat/x86-dregs.c:
...
/* Did the watchpoint whose address is in the I'th register break?  */
#define X86_DR_WATCH_HIT(dr6, i) ((dr6) & (1 << (i)))
...
the point of B# bits seems to be to test which watchpoint hit.

My guess about why gdb wants to know about both BS and B# at the same
time: because either of them causes gdb to stop and present a user
prompt, and you want to report both events at one user stop, instead of
presenting two separate stops and user prompts at the same address.

Thanks,
- Tom

> Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
> Reported-by: Tom de Vries <tdevries@suse.de>
> Bisected-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Borislav Petkov <bp@alien8.de>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |    2 +
>  arch/x86/kernel/hw_breakpoint.c      |   39 ++++++++++++++++++++++++-----------
>  arch/x86/kernel/ptrace.c             |   26 ++++++++++++++++-------
>  arch/x86/kernel/traps.c              |    5 ++++
>  4 files changed, 52 insertions(+), 20 deletions(-)
> 
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -75,6 +75,8 @@ int decode_dr7(unsigned long dr7, int bp
>  extern int arch_bp_generic_fields(int x86_len, int x86_type,
>  				  int *gen_len, int *gen_type);
>  
> +extern int ptrace_bp_idx(struct perf_event *bp);
> +
>  extern struct pmu perf_ops_bp;
>  
>  #endif	/* _I386_HW_BREAKPOINT_H */
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -496,9 +496,32 @@ static int hw_breakpoint_handler(struct
>  	dr6_p = (unsigned long *)ERR_PTR(args->err);
>  	dr6 = *dr6_p;
>  
> -	/* If it's a single step, TRAP bits are random */
> -	if (dr6 & DR_STEP)
> +	/*
> +	 * If DR_STEP is set, TRAP bits might also be set, but we must not
> +	 * process them since another exception (without DR_STEP) will follow.
> +	 */
> +	if (dr6 & DR_STEP) {
> +		/*
> +		 * Still, userspace wants to see them, so copy those that are
> +		 * due to ptrace() out into their right index.
> +		 */
> +		if (user_mode(args->regs)) {
> +			int idx;
> +
> +			for (i = 0; i < HBP_NUM; i++) {
> +				if (likely(!(dr6 & (DR_TRAP0 << i))))
> +					continue;
> +
> +				bp = this_cpu_read(bp_per_reg[i]);
> +				idx = ptrace_bp_idx(bp);
> +				if (idx < 0)
> +					continue;
> +
> +				current->thread.virtual_dr6 |= (DR_TRAP0 << idx);
> +			}
> +		}
>  		return NOTIFY_DONE;
> +	}
>  
>  	/* Do an early return if no trap bits are set in DR6 */
>  	if ((dr6 & DR_TRAP_BITS) == 0)
> @@ -509,14 +534,6 @@ static int hw_breakpoint_handler(struct
>  		if (likely(!(dr6 & (DR_TRAP0 << i))))
>  			continue;
>  
> -		/*
> -		 * The counter may be concurrently released but that can only
> -		 * occur from a call_rcu() path. We can then safely fetch
> -		 * the breakpoint, use its callback, touch its counter
> -		 * while we are in an rcu_read_lock() path.
> -		 */
> -		rcu_read_lock();
> -
>  		bp = this_cpu_read(bp_per_reg[i]);
>  		/*
>  		 * Reset the 'i'th TRAP bit in dr6 to denote completion of
> @@ -540,8 +557,6 @@ static int hw_breakpoint_handler(struct
>  		 */
>  		if (bp->hw.info.type == X86_BREAKPOINT_EXECUTE)
>  			args->regs->flags |= X86_EFLAGS_RF;
> -
> -		rcu_read_unlock();
>  	}
>  	/*
>  	 * Further processing in do_debug() is needed for a) user-space
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -449,22 +449,33 @@ static int genregs_set(struct task_struc
>  	return ret;
>  }
>  
> +int ptrace_bp_idx(struct perf_event *bp)
> +{
> +	struct thread_struct *thread = &current->thread;
> +	int i;
> +
> +	for (i = 0; i < HBP_NUM; i++) {
> +		if (thread->ptrace_bps[i] == bp)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
>  static void ptrace_triggered(struct perf_event *bp,
>  			     struct perf_sample_data *data,
>  			     struct pt_regs *regs)
>  {
> -	int i;
>  	struct thread_struct *thread = &(current->thread);
> +	int i = ptrace_bp_idx(bp);
> +
> +	if (WARN_ON_ONCE(i < 0))
> +		return;
>  
>  	/*
>  	 * Store in the virtual DR6 register the fact that the breakpoint
>  	 * was hit so the thread's debugger will see it.
>  	 */
> -	for (i = 0; i < HBP_NUM; i++) {
> -		if (thread->ptrace_bps[i] == bp)
> -			break;
> -	}
> -
>  	thread->virtual_dr6 |= (DR_TRAP0 << i);
>  }
>  
> @@ -518,8 +529,7 @@ ptrace_register_breakpoint(struct task_s
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	return register_user_hw_breakpoint(&attr, ptrace_triggered,
> -						 NULL, tsk);
> +	return register_user_hw_breakpoint(&attr, ptrace_triggered, NULL, tsk);
>  }
>  
>  static int ptrace_modify_breakpoint(struct perf_event *bp, int len, int type,
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -838,6 +840,9 @@ static bool notify_debug(struct pt_regs
>  	 *
>  	 * Notifiers will set bits in @virtual_dr6 to indicate the desire
>  	 * for signals - ptrace_triggered(), kgdb_hw_overflow_handler().
> +	 *
> +	 * @dr6 is in hardware order
> +	 * @virtual_dr6 is in ptrace order
>  	 */
>  	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
>  		return true;
> 
