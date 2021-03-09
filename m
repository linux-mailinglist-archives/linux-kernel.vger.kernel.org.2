Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04A533216E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhCII6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCII5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28293C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:46 -0800 (PST)
Message-Id: <20210309085727.426370483@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HEb65trgRp9db9cEm3AQ527KmCf8Bt4yNOc9cF8qPzw=;
        b=g7diwBsNEQOVWhmDTRUk/m0m4ZE6K+YkuuGNKDcH/RhIx9ScZgO8Z59w/GjvJVboa9QqGC
        g7Dn7p+gYU+zdNcVAgo0E5PJmw50+on5m268AihoEXVcziTI8FubgH6r9ScFvNSZbvHcyu
        6+turjYz7f7eVAns0de2s2AnIxD51XFbrIm8NVDbB6vhEFXMNI/yFgsZAxbIJWvtzSFD9e
        q8P1vnE4bAMZaBK76w7/hKWD02M4zj9cvDSPr0MPFr2F5uQZfDbDjwjV1Fegyf9bGu3Wjl
        E56JDwCg74kp7OJBEKf6rwYsrJqAZVyh40YIFg1uesODySa3poqS3H5UCCBAYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HEb65trgRp9db9cEm3AQ527KmCf8Bt4yNOc9cF8qPzw=;
        b=h8KTakGcBVfj57q+15YnXBbOvtIpBMGEfR209b7t1FH3DqfXedyYmR0EFqOa8VEkeHS2mN
        n2I77DSBugASMEBg==
Date:   Tue, 09 Mar 2021 09:55:56 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 4/6] softirq: Make softirq control and processing RT aware
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a local lock based serialization for soft interrupts on RT which
allows the local_bh_disabled() sections and servicing soft interrupts to be
preemptible.

Provide the necessary inline helpers which allow to reuse the bulk of the
softirq processing code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/bottom_half.h |    2 
 kernel/softirq.c            |  188 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 182 insertions(+), 8 deletions(-)

--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,7 +4,7 @@
 
 #include <linux/preempt.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
 static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/local_lock.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/percpu.h>
@@ -103,20 +104,189 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_contex
 #endif
 
 /*
- * preempt_count and SOFTIRQ_OFFSET usage:
- * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
- *   softirq processing.
- * - preempt_count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
  *   on local_bh_disable or local_bh_enable.
+ *
  * This lets us distinguish between whether we are currently processing
  * softirq and whether we just have bh disabled.
  */
+#ifdef CONFIG_PREEMPT_RT
+
+/*
+ * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
+ * also in per CPU softirq_ctrl::cnt. This is necessary to allow tasks in a
+ * softirq disabled section to be preempted.
+ *
+ * The per task counter is used for softirq_count(), in_softirq() and
+ * in_serving_softirqs() because these counts are only valid when the task
+ * holding softirq_ctrl::lock is running.
+ *
+ * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
+ * the task which is in a softirq disabled section is preempted or blocks.
+ */
+struct softirq_ctrl {
+	local_lock_t	lock;
+	int		cnt;
+};
+
+static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
+};
+
+void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+{
+	unsigned long flags;
+	int newcnt;
+
+	WARN_ON_ONCE(in_hardirq());
+
+	/* First entry of a task into a BH disabled section? */
+	if (!current->softirq_disable_cnt) {
+		if (preemptible()) {
+			local_lock(&softirq_ctrl.lock);
+			/* Required to meet the RCU bottomhalf requirements. */
+			rcu_read_lock();
+		} else {
+			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+		}
+	}
+
+	/*
+	 * Track the per CPU softirq disabled state. On RT this is per CPU
+	 * state to allow preemption of bottom half disabled sections.
+	 */
+	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	/*
+	 * Reflect the result in the task state to prevent recursion on the
+	 * local lock and to make softirq_count() & al work.
+	 */
+	current->softirq_disable_cnt = newcnt;
+
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
+		raw_local_irq_save(flags);
+		lockdep_softirqs_off(ip);
+		raw_local_irq_restore(flags);
+	}
+}
+EXPORT_SYMBOL(__local_bh_disable_ip);
+
+static void __local_bh_enable(unsigned int cnt, bool unlock)
+{
+	unsigned long flags;
+	int newcnt;
+
+	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
+			    this_cpu_read(softirq_ctrl.cnt));
+
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
+		raw_local_irq_save(flags);
+		lockdep_softirqs_on(_RET_IP_);
+		raw_local_irq_restore(flags);
+	}
+
+	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	current->softirq_disable_cnt = newcnt;
+
+	if (!newcnt && unlock) {
+		rcu_read_unlock();
+		local_unlock(&softirq_ctrl.lock);
+	}
+}
+
+void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+{
+	bool preempt_on = preemptible();
+	unsigned long flags;
+	u32 pending;
+	int curcnt;
+
+	WARN_ON_ONCE(in_irq());
+	lockdep_assert_irqs_enabled();
+
+	local_irq_save(flags);
+	curcnt = __this_cpu_read(softirq_ctrl.cnt);
+
+	/*
+	 * If this is not reenabling soft interrupts, no point in trying to
+	 * run pending ones.
+	 */
+	if (curcnt != cnt)
+		goto out;
+
+	pending = local_softirq_pending();
+	if (!pending || ksoftirqd_running(pending))
+		goto out;
+
+	/*
+	 * If this was called from non preemptible context, wake up the
+	 * softirq daemon.
+	 */
+	if (!preempt_on) {
+		wakeup_softirqd();
+		goto out;
+	}
+
+	/*
+	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
+	 * in_serving_softirq() become true.
+	 */
+	cnt = SOFTIRQ_OFFSET;
+	__local_bh_enable(cnt, false);
+	__do_softirq();
+
+out:
+	__local_bh_enable(cnt, preempt_on);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(__local_bh_enable_ip);
+
+/*
+ * Invoked from ksoftirqd_run() outside of the interrupt disabled section
+ * to acquire the per CPU local lock for reentrancy protection.
+ */
+static inline void ksoftirqd_run_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_irq_disable();
+}
+
+/* Counterpart to ksoftirqd_run_begin() */
+static inline void ksoftirqd_run_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	WARN_ON_ONCE(in_interrupt());
+	local_irq_enable();
+}
+
+static inline void softirq_handle_begin(void) { }
+static inline void softirq_handle_end(void) { }
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+static inline void invoke_softirq(void)
+{
+	if (should_wake_ksoftirqd())
+		wakeup_softirqd();
+}
+
+#else /* CONFIG_PREEMPT_RT */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * This is for softirq.c-internal use, where hardirqs are disabled
+ * This one is for softirq.c-internal use, where hardirqs are disabled
  * legitimately:
  */
+#ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -277,6 +447,8 @@ asmlinkage __visible void do_softirq(voi
 	local_irq_restore(flags);
 }
 
+#endif /* !CONFIG_PREEMPT_RT */
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -381,8 +553,10 @@ asmlinkage __visible void __softirq_entr
 		pending >>= softirq_bit;
 	}
 
-	if (__this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
+
 	local_irq_disable();
 
 	pending = local_softirq_pending();

