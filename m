Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4BD3AAF51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFQJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhFQJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:10:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dSE7cXr6c+ZaHpDhiOeR5UKRnX+dPzrymP0StKDZ4Lk=; b=XurP/NxniV12my55YEKMxgEoIn
        Inmu9KGwrqOZROQFsDVYW5lNJCHcM91inBPegu49uDO5qEwS+E5DxQDXBtFEg1uJeQiQDPppdjB07
        l7D7oDvufQAGM3gJB780e0imA/UvXPW4L0oAEcUjExDlO4XeONsCJ1Bj7NinpYC3PuPCP6yTK/d3o
        ELIAe6U6Hw+Dsc9RYu0+NELJdMGuaDpcWJG6EpcA1YhoQl9uOM/V4ybNZnr087cl1ncH75OUunv+N
        XScKpthiPyVRoDU/UOvOBd1dI9fERskmCQTnUn9JdVke45EpeKMLpm9314FlzhLoGO7k6JhjhKtBE
        BUOSxlxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lto0G-008aN7-0r; Thu, 17 Jun 2021 09:08:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69EB0300252;
        Thu, 17 Jun 2021 11:08:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94F8C203C0549; Thu, 17 Jun 2021 11:08:03 +0200 (CEST)
Date:   Thu, 17 Jun 2021 11:08:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy mms
Message-ID: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
> Here it is.  Not even boot tested!

It is now, it even builds a kernel.. so it must be perfect :-)

> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=sched/lazymm&id=ecc3992c36cb88087df9c537e2326efb51c95e31

Since I had to turn it into a patch to post, so that I could comment on
it, I've cleaned it up a little for you.

I'll reply to self with some notes, but I think I like it.

---
 arch/x86/include/asm/mmu.h |   5 ++
 include/linux/sched/mm.h   |   3 +
 kernel/fork.c              |   2 +
 kernel/sched/core.c        | 138 ++++++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h       |  10 +++-
 5 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..ce94162168c2 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -66,4 +66,9 @@ typedef struct {
 void leave_mm(int cpu);
 #define leave_mm leave_mm
 
+/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using mm */
+#define for_each_possible_lazymm_cpu(cpu, mm) \
+	for_each_cpu((cpu), mm_cpumask((mm)))
+
+
 #endif /* _ASM_X86_MMU_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe348e3..5c7eafee6fea 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -77,6 +77,9 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
 
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
+
+extern void mm_unlazy_mm_count(struct mm_struct *mm);
+
 #ifdef CONFIG_MMU
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
diff --git a/kernel/fork.c b/kernel/fork.c
index e595e77913eb..57415cca088c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1104,6 +1104,8 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+
+	mm_unlazy_mm_count(mm);
 	mmdrop(mm);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ac693d542f6..e102ec53c2f6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -19,6 +19,7 @@
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/mmu.h>
 
 #include "../workqueue_internal.h"
 #include "../../fs/io-wq.h"
@@ -4501,6 +4502,81 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	prepare_arch_switch(next);
 }
 
+static void mmdrop_lazy(struct rq *rq)
+{
+	struct mm_struct *old_mm;
+
+	if (likely(!READ_ONCE(rq->drop_mm)))
+		return;
+
+	/*
+	 * Slow path.  This only happens when we recently stopped using
+	 * an mm that is exiting.
+	 */
+	old_mm = xchg(&rq->drop_mm, NULL);
+	if (old_mm)
+		mmdrop(old_mm);
+}
+
+#ifndef for_each_possible_lazymm_cpu
+#define for_each_possible_lazymm_cpu(cpu, mm) for_each_online_cpu((cpu))
+#endif
+
+/*
+ * This converts all lazy_mm references to mm to mm_count refcounts.  Our
+ * caller holds an mm_count reference, so we don't need to worry about mm
+ * being freed out from under us.
+ */
+void mm_unlazy_mm_count(struct mm_struct *mm)
+{
+	unsigned int drop_count = num_possible_cpus();
+	int cpu;
+
+	/*
+	 * mm_users is zero, so no cpu will set its rq->lazy_mm to mm.
+	 */
+	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
+
+	/* Grab enough references for the rest of this function. */
+	atomic_add(drop_count, &mm->mm_count);
+
+	for_each_possible_lazymm_cpu(cpu, mm) {
+		struct rq *rq = cpu_rq(cpu);
+		struct mm_struct *old_mm;
+
+		if (smp_load_acquire(&rq->lazy_mm) != mm)
+			continue;
+
+		drop_count--;	/* grab a reference; cpu will drop it later. */
+
+		old_mm = xchg(&rq->drop_mm, mm);
+
+		/*
+		 * We know that old_mm != mm: when we did the xchg(), we were
+		 * the only cpu to be putting mm into any drop_mm variable.
+		 */
+		WARN_ON_ONCE(old_mm == mm);
+		if (unlikely(old_mm)) {
+			/*
+			 * We just stole an mm reference from the target CPU.
+			 *
+			 * drop_mm was set to old by another call to
+			 * mm_unlazy_mm_count().  After that call xchg'd old
+			 * into drop_mm, the target CPU did:
+			 *
+			 *  smp_store_release(&rq->lazy_mm, mm);
+			 *
+			 * which synchronized with our smp_load_acquire()
+			 * above, so we know that the target CPU is done with
+			 * old. Drop old on its behalf.
+			 */
+			mmdrop(old_mm);
+		}
+	}
+
+	atomic_sub(drop_count, &mm->mm_count);
+}
+
 /**
  * finish_task_switch - clean up after a task-switch
  * @prev: the thread we just switched away from.
@@ -4524,7 +4600,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
 	long prev_state;
 
 	/*
@@ -4543,8 +4618,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
-
 	/*
 	 * A task struct has one reference for the use as "current".
 	 * If a task dies, then it sets TASK_DEAD in tsk->state and calls
@@ -4574,22 +4647,16 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
+
 	/*
-	 * When switching through a kernel thread, the loop in
-	 * membarrier_{private,global}_expedited() may have observed that
-	 * kernel thread and not issued an IPI. It is therefore possible to
-	 * schedule between user->kernel->user threads without passing though
-	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, so provide them here:
-	 *
-	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
-	 * - a sync_core for SYNC_CORE.
+	 * Do this unconditionally.  There's a race in which a remote CPU
+	 * sees rq->lazy_mm != NULL and gives us an extra mm ref while we
+	 * are executing this code and we don't notice.  Instead of letting
+	 * that ref sit around until the next time we unlazy, do it on every
+	 * context switch.
 	 */
-	if (mm) {
-		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
-	}
+	mmdrop_lazy(rq);
+
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
@@ -4652,25 +4719,32 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	/*
 	 * kernel -> kernel   lazy + transfer active
-	 *   user -> kernel   lazy + mmgrab() active
+	 *   user -> kernel   lazy + lazy_mm grab active
 	 *
-	 * kernel ->   user   switch + mmdrop() active
+	 * kernel ->   user   switch + lazy_mm release active
 	 *   user ->   user   switch
 	 */
 	if (!next->mm) {                                // to kernel
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
-		else
+		if (prev->mm) {                         // from user
+			SCHED_WARN_ON(rq->lazy_mm);
+
+			/*
+			 * Acqure a lazy_mm reference to the active
+			 * (lazy) mm.  No explicit barrier needed: we still
+			 * hold an explicit (mm_users) reference.  __mmput()
+			 * can't be called until we call mmput() to drop
+			 * our reference, and __mmput() is a release barrier.
+			 */
+			WRITE_ONCE(rq->lazy_mm, next->active_mm);
+		} else {
 			prev->active_mm = NULL;
+		}
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
-		 * sys_membarrier() requires an smp_mb() between setting
-		 * rq->curr / membarrier_switch_mm() and returning to userspace.
-		 *
 		 * The below provides this either through switch_mm(), or in
 		 * case 'prev->active_mm == next->mm' through
 		 * finish_task_switch()'s mmdrop().
@@ -4678,9 +4752,19 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 
 		if (!prev->mm) {                        // from kernel
-			/* will mmdrop() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+			/*
+			 * Even though nothing should reference ->active_mm
+			 * for a non-current task, don't leave a stale pointer
+			 * to an mm that might be freed.
+			 */
 			prev->active_mm = NULL;
+
+			/*
+			 * Drop our lazy_mm reference to the old lazy mm.
+			 * After this, any CPU may free it if it is
+			 * unreferenced.
+			 */
+			smp_store_release(&rq->lazy_mm, NULL);
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f0194cee0ba..703d95a4abd0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -966,7 +966,15 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+
+	/*
+	 * Fast refcounting scheme for lazy mm.  lazy_mm is a hazard pointer:
+	 * setting it to point to a lazily used mm keeps that mm from being
+	 * freed.  drop_mm points to am mm that needs an mmdrop() call
+	 * after the CPU owning the rq is done with it.
+	 */
+	struct mm_struct	*lazy_mm;
+	struct mm_struct	*drop_mm;
 
 	unsigned int		clock_update_flags;
 	u64			clock;
