Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BC3A8F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFPDXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhFPDXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BE8C613DB;
        Wed, 16 Jun 2021 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813678;
        bh=Oj1vCsN2BPGc3P+iT1tIZ7CyX6hi/S+z5frsn89G8kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+grdF5BoRBtmAGqZOzBiIZOdQTNRAwWMfymPVh6qQaUACHWRoqCOU9xuf/XoD8HL
         k1hynejm8pVU7rcCf6coWPb+VDmuPAFALr4scJTmp2jEZsIz5xXhjp7Lw3NpOyOzEn
         POhrzEdWS1PAuP91maVCYV2PKfOD3xidT+nPz9WEBSfOYUpKSH/4JXaegRFdBhkZZA
         r+tlWEHo8wjhNFLf9CISJfxBvw1LqJYSQPYfmCfT9nuFB/suk1ItIww8Ey+Qp2NFTQ
         BGtV2zEZ7mWYUB4eFnTu+b5ipmnzw2lDjdwFwTe3AlFW3KCooucfP6Z0lxFsaNkARq
         bCR4ItuLs3tqQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Date:   Tue, 15 Jun 2021 20:21:09 -0700
Message-Id: <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier() needs a barrier after any CPU changes mm.  There is currently
a comment explaining why this barrier probably exists in all cases.  This
is very fragile -- any change to the relevant parts of the scheduler
might get rid of these barriers, and it's not really clear to me that
the barrier actually exists in all necessary cases.

Simplify the logic by adding an explicit barrier, and allow architectures
to override it as an optimization if they want to.

One of the deleted comments in this patch said "It is therefore
possible to schedule between user->kernel->user threads without
passing through switch_mm()".  It is possible to do this without, say,
writing to CR3 on x86, but the core scheduler indeed calls
switch_mm_irqs_off() to tell the arch code to go back from lazy mode
to no-lazy mode.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/sched/mm.h | 21 +++++++++++++++++++++
 kernel/kthread.c         | 12 +-----------
 kernel/sched/core.c      | 35 +++++++++--------------------------
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 10aace21d25e..c6eebbafadb0 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -341,6 +341,27 @@ enum {
 	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
+#ifdef CONFIG_MEMBARRIER
+
+/*
+ * Called by the core scheduler after calling switch_mm_irqs_off().
+ * Architectures that have implicit barriers when switching mms can
+ * override this as an optimization.
+ */
+#ifndef membarrier_finish_switch_mm
+static inline void membarrier_finish_switch_mm(int membarrier_state)
+{
+	if (membarrier_state & (MEMBARRIER_STATE_GLOBAL_EXPEDITED | MEMBARRIER_STATE_PRIVATE_EXPEDITED))
+		smp_mb();
+}
+#endif
+
+#else
+
+static inline void membarrier_finish_switch_mm(int membarrier_state) {}
+
+#endif
+
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 #include <asm/membarrier.h>
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fe3f2a40d61e..8275b415acec 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1325,25 +1325,15 @@ void kthread_use_mm(struct mm_struct *mm)
 	tsk->mm = mm;
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
+	membarrier_finish_switch_mm(atomic_read(&mm->membarrier_state));
 	local_irq_enable();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
 #endif
 
-	/*
-	 * When a kthread starts operating on an address space, the loop
-	 * in membarrier_{private,global}_expedited() may not observe
-	 * that tsk->mm, and not issue an IPI. Membarrier requires a
-	 * memory barrier after storing to tsk->mm, before accessing
-	 * user-space memory. A full memory barrier for membarrier
-	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop(), or explicitly with smp_mb().
-	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
-	else
-		smp_mb();
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e4c122f8bf21..329a6d2a4e13 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4221,15 +4221,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 
 	fire_sched_in_preempt_notifiers(current);
 
-	/*
-	 * When switching through a kernel thread, the loop in
-	 * membarrier_{private,global}_expedited() may have observed that
-	 * kernel thread and not issued an IPI. It is therefore possible to
-	 * schedule between user->kernel->user threads without passing though
-	 * switch_mm(). Membarrier requires a barrier after storing to
-	 * rq->curr, before returning to userspace, and mmdrop() provides
-	 * this barrier.
-	 */
 	if (mm)
 		mmdrop(mm);
 
@@ -4311,15 +4302,14 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			prev->active_mm = NULL;
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
+		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
-		 * rq->curr / membarrier_switch_mm() and returning to userspace.
-		 *
-		 * The below provides this either through switch_mm(), or in
-		 * case 'prev->active_mm == next->mm' through
-		 * finish_task_switch()'s mmdrop().
+		 * rq->curr->mm to a membarrier-enabled mm and returning
+		 * to userspace.
 		 */
-		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+		membarrier_finish_switch_mm(rq->membarrier_state);
 
 		if (!prev->mm) {                        // from kernel
 			/* will mmdrop() in finish_task_switch(). */
@@ -5121,17 +5111,10 @@ static void __sched notrace __schedule(bool preempt)
 		RCU_INIT_POINTER(rq->curr, next);
 		/*
 		 * The membarrier system call requires each architecture
-		 * to have a full memory barrier after updating
-		 * rq->curr, before returning to user-space.
-		 *
-		 * Here are the schemes providing that barrier on the
-		 * various architectures:
-		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
-		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
-		 * - finish_lock_switch() for weakly-ordered
-		 *   architectures where spin_unlock is a full barrier,
-		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
-		 *   is a RELEASE barrier),
+		 * to have a full memory barrier before and after updating
+		 * rq->curr->mm, before returning to userspace.  This
+		 * is provided by membarrier_finish_switch_mm().  Architectures
+		 * that want to optimize this can override that function.
 		 */
 		++*switch_count;
 
-- 
2.31.1

