Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222B39E7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFGUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFGUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:04:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:02:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623096154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrqV7GNOJHbI3qdK5PHLo+54dtaMBbMu2UCiobMXO/Q=;
        b=2VFCDu8gnh2kagS/rPO/cvhIsPImYl6xVQKgshHNannP0ErneLpvPKpgIo4yFLeHTo0OG6
        dERSk2gCFPBFNXq4iRe0c6k901mvJ9H7ccTwGCDNvQ86YM64yzqt271E+x0KCN3mtQ8hEX
        IMy3oW5B/Xb8XsCmDOTK0Ln0/xYHga25unctk9Xm5GGTlyPfBP2p0A7ipBs0iXfFKZjVbO
        jy/pYbLD6UX+5Z016pHfareM26Qu6CV9momZshBnrxpstphSGC4WeLAUtDPMH75iQI8kgk
        ZCiEvz8wsOPAgMQXgd0A8XKWRYtvJZjsBdM1FWeQHhdm/tNvjEal7bwjr6pHDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623096154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrqV7GNOJHbI3qdK5PHLo+54dtaMBbMu2UCiobMXO/Q=;
        b=WTbjjkfAKjeZqLEYVnl1DjnGTo2z0KLhp3MHU2LELzO6Slh/XOiBInAbT+l1XN0QnbFpeY
        PzOPuY3nxIgXncAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
Date:   Mon,  7 Jun 2021 22:02:31 +0200
Message-Id: <20210607200232.22211-2-john.ogness@linutronix.de>
In-Reply-To: <20210607200232.22211-1-john.ogness@linutronix.de>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_stack() implements its own cpu-reentrant spinning lock to
best-effort serialize stack traces in the printk log. However,
there are other functions (such as show_regs()) that can also
benefit from this serialization.

Move the cpu-reentrant spinning lock (cpu lock) into new helper
functions printk_cpu_lock_irqsave()/printk_cpu_unlock_irqrestore()
so that it is available for others as well. For !CONFIG_SMP the
cpu lock is a NOP.

Note that having multiple cpu locks in the system can easily
lead to deadlock. Code needing a cpu lock should use the
printk cpu lock, since the printk cpu lock could be acquired
from any code and any context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 13 ++++++++
 kernel/printk/printk.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       | 41 +++--------------------
 3 files changed, 92 insertions(+), 37 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f589b8b60806..b84e0c59220f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -287,6 +287,19 @@ static inline void printk_safe_flush_on_panic(void)
 }
 #endif
 
+#if defined(CONFIG_SMP)
+extern void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags);
+extern void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags);
+#else
+static inline void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
+{
+}
+
+static inline void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags)
+{
+}
+#endif
+
 extern int kptr_restrict;
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 114e9963f903..f94babb38493 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3532,3 +3532,78 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
+
+#ifdef CONFIG_SMP
+static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
+
+/*
+ * printk_cpu_lock_irqsave: Acquire the printk cpu-reentrant spinning lock
+ *                          and disable interrupts.
+ * @lock_flag: A buffer to store lock state.
+ * @irq_flags: A buffer to store irq state.
+ *
+ * If no processor has the lock, the calling processor takes the lock and
+ * becomes the owner. If the calling processor is already the owner of the
+ * lock, this function succeeds immediately. If the lock is held by another
+ * processor, this function spins until the calling processor becomes the
+ * owner. This function returns with interrupts disabled.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
+{
+	int old;
+	int cpu;
+
+retry:
+	local_irq_save(*irq_flags);
+
+	cpu = smp_processor_id();
+
+	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
+	if (old == -1) {
+		/* This CPU is now the owner. */
+
+		*lock_flag = true;
+
+	} else if (old == cpu) {
+		/* This CPU is already the owner. */
+
+		*lock_flag = false;
+
+	} else {
+		local_irq_restore(*irq_flags);
+
+		/*
+		 * Wait for the lock to release before jumping to cmpxchg()
+		 * in order to mitigate the thundering herd problem.
+		 */
+		do {
+			cpu_relax();
+		} while (atomic_read(&printk_cpulock_owner) != -1);
+
+		goto retry;
+	}
+}
+EXPORT_SYMBOL(printk_cpu_lock_irqsave);
+
+/*
+ * printk_cpu_unlock_irqrestore: Release the printk cpu-reentrant spinning
+ *                               lock and restore interrupts.
+ * @lock_flag: The current lock state.
+ * @irq_flags: The current irq state.
+ *
+ * Release the lock. The calling processor must be the owner of the lock.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags)
+{
+	if (lock_flag) {
+		atomic_set(&printk_cpulock_owner, -1);
+
+		local_irq_restore(irq_flags);
+	}
+}
+EXPORT_SYMBOL(printk_cpu_unlock_irqrestore);
+#endif /* CONFIG_SMP */
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6e7ca3d67710..84c68bad94c7 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -93,52 +93,19 @@ static void __dump_stack(const char *log_lvl)
  *
  * Architectures can override this implementation by implementing its own.
  */
-#ifdef CONFIG_SMP
-static atomic_t dump_lock = ATOMIC_INIT(-1);
-
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
-	unsigned long flags;
-	int was_locked;
-	int old;
-	int cpu;
+	unsigned long irq_flags;
+	bool lock_flag;
 
 	/*
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-retry:
-	local_irq_save(flags);
-	cpu = smp_processor_id();
-	old = atomic_cmpxchg(&dump_lock, -1, cpu);
-	if (old == -1) {
-		was_locked = 0;
-	} else if (old == cpu) {
-		was_locked = 1;
-	} else {
-		local_irq_restore(flags);
-		/*
-		 * Wait for the lock to release before jumping to
-		 * atomic_cmpxchg() in order to mitigate the thundering herd
-		 * problem.
-		 */
-		do { cpu_relax(); } while (atomic_read(&dump_lock) != -1);
-		goto retry;
-	}
-
-	__dump_stack(log_lvl);
-
-	if (!was_locked)
-		atomic_set(&dump_lock, -1);
-
-	local_irq_restore(flags);
-}
-#else
-asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
-{
+	printk_cpu_lock_irqsave(&lock_flag, &irq_flags);
 	__dump_stack(log_lvl);
+	printk_cpu_unlock_irqrestore(lock_flag, irq_flags);
 }
-#endif
 EXPORT_SYMBOL(dump_stack_lvl);
 
 asmlinkage __visible void dump_stack(void)
-- 
2.20.1

