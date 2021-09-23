Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46184163B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhIWQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbhIWQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:16 -0400
Message-ID: <20210923165358.243232823@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eSA6JkwZs+rd7iYC2Q6m+Uh5Ww0kFeQKctUfzM7KODs=;
        b=Gy/IIi+CIPjFifV0s91SbpSpjVT41i4FzETe0fZz4nGeX6PVGo+z+usZ0Izq3b5pjpLNS1
        yN+Umj1VxR0RtBCWA01+tTx4WKevFz+nzc7aDjqB/ukNh349oPJFOlxKATzWrpb49DtEta
        qBm4dpUJ7T7GqTGk/raECZyWIG56chQyltgupaDqjc9sZUA1Gv43ISFK9kkZ8k4UvZI/OR
        DqgqTnesuRCXCEurzKwlXJ3DYvQNfG8aKHfajVu/NhydOKEba7eLfDETQOsYZV8MmhRoCZ
        ehmPbRsS5R8n0eiBLp8YGrMG9rND7QZM+ot6sOTBwny3PkM+KiHUaFCO0tMyKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=eSA6JkwZs+rd7iYC2Q6m+Uh5Ww0kFeQKctUfzM7KODs=;
        b=OHHiXePc/x6+vMQPbkJCFkDGDIhNWS9NhfqAfpMUtvkL0njWtIFWT5PbBHaVLkqmI/3ozo
        Wc48RsnVhVnk0DBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 6/8] sched: Make RCU nest depth distinct in __might_resched()
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:43 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For !RT kernels RCU nest depth in __might_resched() is always expected to
be 0, but on RT kernels it can be non zero while the preempt count is
expected to be always 0.

Instead of playing magic games in interpreting the 'preempt_offset'
argument, rename it to 'offsets' and use the lower 8 bits for the expected
preempt count, allow to hand in the expected RCU nest depth in the upper
bits and adopt the __might_resched() code and related checks and printks.

The affected call sites are updated in subsequent steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/kernel.h |    4 ++--
 include/linux/sched.h  |    3 +++
 kernel/sched/core.c    |   28 ++++++++++++++++------------
 3 files changed, 21 insertions(+), 14 deletions(-)

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,7 +111,7 @@ static __always_inline void might_resche
 #endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, int preempt_offset);
+extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
@@ -169,7 +169,7 @@ extern void __cant_migrate(const char *f
 # define non_block_end() WARN_ON(current->non_block_count-- == 0)
 #else
   static inline void __might_resched(const char *file, int line,
-				     int preempt_offset) { }
+				     unsigned int offsets) { }
 static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2049,6 +2049,9 @@ extern int __cond_resched_lock(spinlock_
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
+#define MIGHT_RESCHED_RCU_SHIFT		8
+#define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
+
 #define cond_resched_lock(lock) ({					\
 	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
 	__cond_resched_lock(lock);					\
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9425,12 +9425,6 @@ void __init sched_init(void)
 }
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-static inline int preempt_count_equals(int preempt_offset)
-{
-	int nested = preempt_count() + rcu_preempt_depth();
-
-	return (nested == preempt_offset);
-}
 
 void __might_sleep(const char *file, int line)
 {
@@ -9462,7 +9456,16 @@ static void print_preempt_disable_ip(int
 	print_ip_sym(KERN_ERR, ip);
 }
 
-void __might_resched(const char *file, int line, int preempt_offset)
+static inline bool resched_offsets_ok(unsigned int offsets)
+{
+	unsigned int nested = preempt_count();
+
+	nested += rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT;
+
+	return nested == offsets;
+}
+
+void __might_resched(const char *file, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9472,7 +9475,7 @@ void __might_resched(const char *file, i
 	/* WARN_ON_ONCE() by default, no rate limit required: */
 	rcu_sleep_check();
 
-	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
+	if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
 	     !is_idle_task(current) && !current->non_block_count) ||
 	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
@@ -9491,11 +9494,11 @@ void __might_resched(const char *file, i
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
 	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
-	       preempt_offset);
+	       offsets & MIGHT_RESCHED_PREEMPT_MASK);
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-		pr_err("RCU nest depth: %d, expected: 0\n",
-		       rcu_preempt_depth());
+		pr_err("RCU nest depth: %d, expected: %u\n",
+		       rcu_preempt_depth(), offsets >> MIGHT_RESCHED_RCU_SHIFT);
 	}
 
 	if (task_stack_end_corrupted(current))
@@ -9505,7 +9508,8 @@ void __might_resched(const char *file, i
 	if (irqs_disabled())
 		print_irqtrace_events(current);
 
-	print_preempt_disable_ip(preempt_offset, preempt_disable_ip);
+	print_preempt_disable_ip(offsets & MIGHT_RESCHED_PREEMPT_MASK,
+				 preempt_disable_ip);
 
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);

