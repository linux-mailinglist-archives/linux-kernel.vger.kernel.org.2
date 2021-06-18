Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53E03AC156
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFRDbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhFRDbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86E160720;
        Fri, 18 Jun 2021 03:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623986971;
        bh=HGhRf1Z3debyMBXBp8fLLPQU7hOOTqrnU2Lse5ouSZ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uabkGXVcGU1JkaRqRrpeS5BxatrmmVzsJ/jcD/Cag5XAYY0BXK3dd96HFr4JzDK1t
         UoFdmRbCNKVG792dNhnXsAsLJSM8wL4ZsUEtpbfa3oQ+RpNu7A64CUNAohMRCAMWL8
         XbBi6Wds4TYIvz784DjVC5dTfkD9kVClwjqp+/GswRtpMFssJZI6fjmoLPEGf2WcYM
         yaY14tB35NrbTlFTzg/FE5vxVQU4vZ/k1xcWIqnH4BoIgKCapifCIARiLqQOVarmWn
         rHpTLykNSRWb1CT522FAao1P9IedkjNM5SE1WwtW8Js/LYIP2b0m6CaEjAWxxkkQdT
         BvVXpa/V9b8Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A01165C0124; Thu, 17 Jun 2021 20:29:31 -0700 (PDT)
Date:   Thu, 17 Jun 2021 20:29:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
Message-ID: <20210618032931.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
> > Here it is.  Not even boot tested!
> 
> It is now, it even builds a kernel.. so it must be perfect :-)
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=sched/lazymm&id=ecc3992c36cb88087df9c537e2326efb51c95e31
> 
> Since I had to turn it into a patch to post, so that I could comment on
> it, I've cleaned it up a little for you.
> 
> I'll reply to self with some notes, but I think I like it.

But rcutorture isn't too happy with it when applied to current
mainline:

------------------------------------------------------------------------
[   32.559192] ------------[ cut here ]------------
[   32.559528] WARNING: CPU: 0 PID: 175 at kernel/fork.c:686 __mmdrop+0x9f/0xb0
[   32.560197] Modules linked in:
[   32.560470] CPU: 0 PID: 175 Comm: torture_onoff Not tainted 5.13.0-rc6+ #23
[   32.561077] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   32.561809] RIP: 0010:__mmdrop+0x9f/0xb0
[   32.562179] Code: fb 20 75 e6 48 8b 45 68 48 85 c0 0f 85 1e 48 ad 00 48 8b 3d 93 e0 c3 01 5b 48 89 ee 5d 41 5c e9 97 45 18 00 0f 0b 0f 0b eb 87 <0f> 0b eb 95 48 89 ef e8 a5 f1 17 00 eb a9 0f 1f 00 48 81 ef c0 03
[   32.563822] RSP: 0018:ffff944c40623d68 EFLAGS: 00010246
[   32.564331] RAX: ffff8e84c2339c00 RBX: ffff8e84df5572e0 RCX: 00000000fffffffa
[   32.564978] RDX: 0000000000000000 RSI: 0000000000000033 RDI: ffff8e84c29a0000
[   32.565648] RBP: ffff8e84c29a0000 R08: ffff8e84c11c774a R09: 0000000000000001
[   32.566256] R10: ffff8e85411c773f R11: ffff8e84c11c774a R12: 0000000000000057
[   32.566909] R13: 0000000000000000 R14: ffffffffb0e487f8 R15: 000000000000000d
[   32.567584] FS:  0000000000000000(0000) GS:ffff8e84df200000(0000) knlGS:0000000000000000
[   32.568321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.568860] CR2: 0000000000000000 CR3: 00000000029ec000 CR4: 00000000000006f0
[   32.569559] Call Trace:
[   32.569804]  ? takedown_cpu+0xd0/0xd0
[   32.570123]  finish_cpu+0x2e/0x40
[   32.570449]  cpuhp_invoke_callback+0xf6/0x3f0
[   32.570755]  cpuhp_invoke_callback_range+0x3b/0x80
[   32.571137]  _cpu_down+0xdf/0x2a0
[   32.571467]  cpu_down+0x2a/0x50
[   32.571771]  device_offline+0x80/0xb0
[   32.572101]  remove_cpu+0x1a/0x30
[   32.572393]  torture_offline+0x80/0x140
[   32.572730]  torture_onoff+0x147/0x260
[   32.573068]  ? torture_kthread_stopping+0xa0/0xa0
[   32.573488]  kthread+0xf9/0x130
[   32.573777]  ? kthread_park+0x80/0x80
[   32.574119]  ret_from_fork+0x22/0x30
[   32.574418] ---[ end trace b77effd8aab7f902 ]---
[   32.574819] BUG: Bad rss-counter state mm:00000000bccc5a55 type:MM_ANONPAGES val:1
[   32.575450] BUG: non-zero pgtables_bytes on freeing mm: 24576
------------------------------------------------------------------------

Are we absolutely sure that the mmdrop()s are balanced in all cases?

							Thanx, Paul

> ---
>  arch/x86/include/asm/mmu.h |   5 ++
>  include/linux/sched/mm.h   |   3 +
>  kernel/fork.c              |   2 +
>  kernel/sched/core.c        | 138 ++++++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h       |  10 +++-
>  5 files changed, 130 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..ce94162168c2 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -66,4 +66,9 @@ typedef struct {
>  void leave_mm(int cpu);
>  #define leave_mm leave_mm
>  
> +/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using mm */
> +#define for_each_possible_lazymm_cpu(cpu, mm) \
> +	for_each_cpu((cpu), mm_cpumask((mm)))
> +
> +
>  #endif /* _ASM_X86_MMU_H */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index e24b1fe348e3..5c7eafee6fea 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -77,6 +77,9 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
>  
>  /* mmput gets rid of the mappings and all user-space */
>  extern void mmput(struct mm_struct *);
> +
> +extern void mm_unlazy_mm_count(struct mm_struct *mm);
> +
>  #ifdef CONFIG_MMU
>  /* same as above but performs the slow path from the async context. Can
>   * be called from the atomic context as well
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e595e77913eb..57415cca088c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1104,6 +1104,8 @@ static inline void __mmput(struct mm_struct *mm)
>  	}
>  	if (mm->binfmt)
>  		module_put(mm->binfmt->module);
> +
> +	mm_unlazy_mm_count(mm);
>  	mmdrop(mm);
>  }
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8ac693d542f6..e102ec53c2f6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -19,6 +19,7 @@
>  
>  #include <asm/switch_to.h>
>  #include <asm/tlb.h>
> +#include <asm/mmu.h>
>  
>  #include "../workqueue_internal.h"
>  #include "../../fs/io-wq.h"
> @@ -4501,6 +4502,81 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>  	prepare_arch_switch(next);
>  }
>  
> +static void mmdrop_lazy(struct rq *rq)
> +{
> +	struct mm_struct *old_mm;
> +
> +	if (likely(!READ_ONCE(rq->drop_mm)))
> +		return;
> +
> +	/*
> +	 * Slow path.  This only happens when we recently stopped using
> +	 * an mm that is exiting.
> +	 */
> +	old_mm = xchg(&rq->drop_mm, NULL);
> +	if (old_mm)
> +		mmdrop(old_mm);
> +}
> +
> +#ifndef for_each_possible_lazymm_cpu
> +#define for_each_possible_lazymm_cpu(cpu, mm) for_each_online_cpu((cpu))
> +#endif
> +
> +/*
> + * This converts all lazy_mm references to mm to mm_count refcounts.  Our
> + * caller holds an mm_count reference, so we don't need to worry about mm
> + * being freed out from under us.
> + */
> +void mm_unlazy_mm_count(struct mm_struct *mm)
> +{
> +	unsigned int drop_count = num_possible_cpus();
> +	int cpu;
> +
> +	/*
> +	 * mm_users is zero, so no cpu will set its rq->lazy_mm to mm.
> +	 */
> +	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
> +
> +	/* Grab enough references for the rest of this function. */
> +	atomic_add(drop_count, &mm->mm_count);
> +
> +	for_each_possible_lazymm_cpu(cpu, mm) {
> +		struct rq *rq = cpu_rq(cpu);
> +		struct mm_struct *old_mm;
> +
> +		if (smp_load_acquire(&rq->lazy_mm) != mm)
> +			continue;
> +
> +		drop_count--;	/* grab a reference; cpu will drop it later. */
> +
> +		old_mm = xchg(&rq->drop_mm, mm);
> +
> +		/*
> +		 * We know that old_mm != mm: when we did the xchg(), we were
> +		 * the only cpu to be putting mm into any drop_mm variable.
> +		 */
> +		WARN_ON_ONCE(old_mm == mm);
> +		if (unlikely(old_mm)) {
> +			/*
> +			 * We just stole an mm reference from the target CPU.
> +			 *
> +			 * drop_mm was set to old by another call to
> +			 * mm_unlazy_mm_count().  After that call xchg'd old
> +			 * into drop_mm, the target CPU did:
> +			 *
> +			 *  smp_store_release(&rq->lazy_mm, mm);
> +			 *
> +			 * which synchronized with our smp_load_acquire()
> +			 * above, so we know that the target CPU is done with
> +			 * old. Drop old on its behalf.
> +			 */
> +			mmdrop(old_mm);
> +		}
> +	}
> +
> +	atomic_sub(drop_count, &mm->mm_count);
> +}
> +
>  /**
>   * finish_task_switch - clean up after a task-switch
>   * @prev: the thread we just switched away from.
> @@ -4524,7 +4600,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	__releases(rq->lock)
>  {
>  	struct rq *rq = this_rq();
> -	struct mm_struct *mm = rq->prev_mm;
>  	long prev_state;
>  
>  	/*
> @@ -4543,8 +4618,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		      current->comm, current->pid, preempt_count()))
>  		preempt_count_set(FORK_PREEMPT_COUNT);
>  
> -	rq->prev_mm = NULL;
> -
>  	/*
>  	 * A task struct has one reference for the use as "current".
>  	 * If a task dies, then it sets TASK_DEAD in tsk->state and calls
> @@ -4574,22 +4647,16 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	kmap_local_sched_in();
>  
>  	fire_sched_in_preempt_notifiers(current);
> +
>  	/*
> -	 * When switching through a kernel thread, the loop in
> -	 * membarrier_{private,global}_expedited() may have observed that
> -	 * kernel thread and not issued an IPI. It is therefore possible to
> -	 * schedule between user->kernel->user threads without passing though
> -	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them here:
> -	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * Do this unconditionally.  There's a race in which a remote CPU
> +	 * sees rq->lazy_mm != NULL and gives us an extra mm ref while we
> +	 * are executing this code and we don't notice.  Instead of letting
> +	 * that ref sit around until the next time we unlazy, do it on every
> +	 * context switch.
>  	 */
> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);
> -		mmdrop(mm);
> -	}
> +	mmdrop_lazy(rq);
> +
>  	if (unlikely(prev_state == TASK_DEAD)) {
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
> @@ -4652,25 +4719,32 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  
>  	/*
>  	 * kernel -> kernel   lazy + transfer active
> -	 *   user -> kernel   lazy + mmgrab() active
> +	 *   user -> kernel   lazy + lazy_mm grab active
>  	 *
> -	 * kernel ->   user   switch + mmdrop() active
> +	 * kernel ->   user   switch + lazy_mm release active
>  	 *   user ->   user   switch
>  	 */
>  	if (!next->mm) {                                // to kernel
>  		enter_lazy_tlb(prev->active_mm, next);
>  
>  		next->active_mm = prev->active_mm;
> -		if (prev->mm)                           // from user
> -			mmgrab(prev->active_mm);
> -		else
> +		if (prev->mm) {                         // from user
> +			SCHED_WARN_ON(rq->lazy_mm);
> +
> +			/*
> +			 * Acqure a lazy_mm reference to the active
> +			 * (lazy) mm.  No explicit barrier needed: we still
> +			 * hold an explicit (mm_users) reference.  __mmput()
> +			 * can't be called until we call mmput() to drop
> +			 * our reference, and __mmput() is a release barrier.
> +			 */
> +			WRITE_ONCE(rq->lazy_mm, next->active_mm);
> +		} else {
>  			prev->active_mm = NULL;
> +		}
>  	} else {                                        // to user
>  		membarrier_switch_mm(rq, prev->active_mm, next->mm);
>  		/*
> -		 * sys_membarrier() requires an smp_mb() between setting
> -		 * rq->curr / membarrier_switch_mm() and returning to userspace.
> -		 *
>  		 * The below provides this either through switch_mm(), or in
>  		 * case 'prev->active_mm == next->mm' through
>  		 * finish_task_switch()'s mmdrop().
> @@ -4678,9 +4752,19 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  		switch_mm_irqs_off(prev->active_mm, next->mm, next);
>  
>  		if (!prev->mm) {                        // from kernel
> -			/* will mmdrop() in finish_task_switch(). */
> -			rq->prev_mm = prev->active_mm;
> +			/*
> +			 * Even though nothing should reference ->active_mm
> +			 * for a non-current task, don't leave a stale pointer
> +			 * to an mm that might be freed.
> +			 */
>  			prev->active_mm = NULL;
> +
> +			/*
> +			 * Drop our lazy_mm reference to the old lazy mm.
> +			 * After this, any CPU may free it if it is
> +			 * unreferenced.
> +			 */
> +			smp_store_release(&rq->lazy_mm, NULL);
>  		}
>  	}
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8f0194cee0ba..703d95a4abd0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -966,7 +966,15 @@ struct rq {
>  	struct task_struct	*idle;
>  	struct task_struct	*stop;
>  	unsigned long		next_balance;
> -	struct mm_struct	*prev_mm;
> +
> +	/*
> +	 * Fast refcounting scheme for lazy mm.  lazy_mm is a hazard pointer:
> +	 * setting it to point to a lazily used mm keeps that mm from being
> +	 * freed.  drop_mm points to am mm that needs an mmdrop() call
> +	 * after the CPU owning the rq is done with it.
> +	 */
> +	struct mm_struct	*lazy_mm;
> +	struct mm_struct	*drop_mm;
>  
>  	unsigned int		clock_update_flags;
>  	u64			clock;
