Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C853A8F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFPDX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhFPDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0C461246;
        Wed, 16 Jun 2021 03:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813676;
        bh=8xTEY6258VphZmOp7/78ibSDKTiVzWwNTg/WzyrBRA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnYUJYlmRtQJWbzC8b+FXG8rHtN8FVajY3diwKCSB/YYyyhBfVHO53x2a4y/YY9lb
         1D/V4u/xLroD7HhpYI9H/xYx4l5OZTdKBpkHUBP8ODiUyfV41ZLMQBJOThFMzKywcL
         Jvd3Wgvj/wWNKYs/fmCsljtmBD7UxFTyPoGKmwWZQvmHBXKjDBB2cg3pEthMINeBgD
         491sTCxKS4ZKLJ4O5NR92A9rDTOz420ArdXTzHsPCf5dKtyq3+NrEPDrrCLdwjltlz
         M4D9EqrdrGjDUL3O+63rZXQsB0LZOSyVZruC4LRJU+fLSUE0uLiSSbpM2qmPfDhJtE
         saRZgdHCT9AuQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/8] x86/mm: Handle unlazying membarrier core sync in the arch code
Date:   Tue, 15 Jun 2021 20:21:07 -0700
Message-Id: <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core scheduler isn't a great place for
membarrier_mm_sync_core_before_usermode() -- the core scheduler
doesn't actually know whether we are lazy.  With the old code, if a
CPU is running a membarrier-registered task, goes idle, gets unlazied
via a TLB shootdown IPI, and switches back to the
membarrier-registered task, it will do an unnecessary core sync.

Conveniently, x86 is the only architecture that does anything in this
sync_core_before_usermode(), so membarrier_mm_sync_core_before_usermode()
is a no-op on all other architectures and we can just move the code.

(I am not claiming that the SYNC_CORE code was correct before or after this
 change on any non-x86 architecture.  I merely claim that this change
 improves readability, is correct on x86, and makes no change on any other
 architecture.)

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/tlb.c        | 53 +++++++++++++++++++++++++++++++---------
 include/linux/sched/mm.h | 13 ----------
 kernel/sched/core.c      | 13 ++++------
 3 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 78804680e923..59488d663e68 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/mm.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -473,16 +474,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
-	 * The membarrier system call requires a full memory barrier and
-	 * core serialization before returning to user-space, after
-	 * storing to rq->curr, when changing mm.  This is because
-	 * membarrier() sends IPIs to all CPUs that are in the target mm
-	 * to make them issue memory barriers.  However, if another CPU
-	 * switches to/from the target mm concurrently with
-	 * membarrier(), it can cause that CPU not to receive an IPI
-	 * when it really should issue a memory barrier.  Writing to CR3
-	 * provides that full memory barrier and core serializing
-	 * instruction.
+	 * membarrier() support requires that, when we change rq->curr->mm:
+	 *
+	 *  - If next->mm has membarrier registered, a full memory barrier
+	 *    after writing rq->curr (or rq->curr->mm if we switched the mm
+	 *    without switching tasks) and before returning to user mode.
+	 *
+	 *  - If next->mm has SYNC_CORE registered, then we sync core before
+	 *    returning to user mode.
+	 *
+	 * In the case where prev->mm == next->mm, membarrier() uses an IPI
+	 * instead, and no particular barriers are needed while context
+	 * switching.
+	 *
+	 * x86 gets all of this as a side-effect of writing to CR3 except
+	 * in the case where we unlazy without flushing.
+	 *
+	 * All other architectures are civilized and do all of this implicitly
+	 * when transitioning from kernel to user mode.
 	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
@@ -500,7 +509,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
-		 * process. No TLB flush required.
+		 * process. No TLB flush or membarrier() synchronization
+		 * is required.
 		 */
 		if (!was_lazy)
 			return;
@@ -510,16 +520,35 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * If the TLB is up to date, just use it.
 		 * The barrier synchronizes with the tlb_gen increment in
 		 * the TLB shootdown code.
+		 *
+		 * As a future optimization opportunity, it's plausible
+		 * that the x86 memory model is strong enough that this
+		 * smp_mb() isn't needed.
 		 */
 		smp_mb();
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
-				next_tlb_gen)
+		    next_tlb_gen) {
+#ifdef CONFIG_MEMBARRIER
+			/*
+			 * We switched logical mm but we're not going to
+			 * write to CR3.  We already did smp_mb() above,
+			 * but membarrier() might require a sync_core()
+			 * as well.
+			 */
+			if (unlikely(atomic_read(&next->membarrier_state) &
+				     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE))
+				sync_core_before_usermode();
+#endif
+
 			return;
+		}
 
 		/*
 		 * TLB contents went out of date while we were in lazy
 		 * mode. Fall through to the TLB switching code below.
+		 * No need for an explicit membarrier invocation -- the CR3
+		 * write will serialize.
 		 */
 		new_asid = prev_asid;
 		need_flush = true;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe348e3..24d97d1b6252 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -345,16 +345,6 @@ enum {
 #include <asm/membarrier.h>
 #endif
 
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-	if (current->mm != mm)
-		return;
-	if (likely(!(atomic_read(&mm->membarrier_state) &
-		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
-		return;
-	sync_core_before_usermode();
-}
-
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
 extern void membarrier_update_current_mm(struct mm_struct *next_mm);
@@ -370,9 +360,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
-{
-}
 static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 {
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..e4c122f8bf21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4220,22 +4220,19 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
+
 	/*
 	 * When switching through a kernel thread, the loop in
 	 * membarrier_{private,global}_expedited() may have observed that
 	 * kernel thread and not issued an IPI. It is therefore possible to
 	 * schedule between user->kernel->user threads without passing though
 	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, so provide them here:
-	 *
-	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
-	 *   provided by mmdrop(),
-	 * - a sync_core for SYNC_CORE.
+	 * rq->curr, before returning to userspace, and mmdrop() provides
+	 * this barrier.
 	 */
-	if (mm) {
-		membarrier_mm_sync_core_before_usermode(mm);
+	if (mm)
 		mmdrop(mm);
-	}
+
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
-- 
2.31.1

