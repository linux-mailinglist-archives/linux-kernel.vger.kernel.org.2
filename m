Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1B3AB044
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhFQJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:53:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFQJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:53:02 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623923453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeLCzk4xF1dmwBRa4oHVF9oB2trijXemDjQstFIFv54=;
        b=TSnREDaCHA1e41oDpQ+EbNTr0o2WFLCo9V6nHrfOqkRYRRJb+7BOqXiOTyU9wvRhLWMkCf
        1uJjGEEvlzYPvCsqofKRQTQ8uMhBsf3YKzJBzq914yD8N7xjGkJ1MtGtw3/oiOzjN6IU9V
        be1op3FRqdVF7tNlgPp8F1Rl7HaXdG46ASbbQCilOF9Hfnm0BhwxFRjUHpnabwP/CrOq5w
        7pJc9cvSbJpdb9DHwtkGdOvdajtHPfVhM8NVqdPcC/wGzUczSFPBW7ZBiN3M7MYHGgtUP7
        F5vEX8cAaimU1EpqUY3H40qcYnoqVD5Luid0DuPiOn8lYcGm1Rfu/7NPv/dSfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623923453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeLCzk4xF1dmwBRa4oHVF9oB2trijXemDjQstFIFv54=;
        b=3z8bm0stvL8Etw26mB4oAjAFgZ2OQASVU2Ra4MIb4b7xwfFvXtmUdGvmnvpl0rqM2LyK7c
        /Acmp9SpZCANj8CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
Date:   Thu, 17 Jun 2021 11:56:50 +0206
Message-Id: <20210617095051.4808-2-john.ogness@linutronix.de>
In-Reply-To: <20210617095051.4808-1-john.ogness@linutronix.de>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
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

Also note that it is not necessary for a cpu lock to disable
interrupts. However, in upcoming work this cpu lock will be used
for emergency tasks (for example, atomic consoles during kernel
crashes) and any interruptions while holding the cpu lock should
be avoided if possible.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 41 +++++++++++++++++++++++++
 kernel/printk/printk.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       | 38 ++---------------------
 3 files changed, 112 insertions(+), 36 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f589b8b60806..d796183f26c9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -287,6 +287,47 @@ static inline void printk_safe_flush_on_panic(void)
 }
 #endif
 
+#ifdef CONFIG_SMP
+extern int __printk_cpu_trylock(void);
+extern void __printk_wait_on_cpu_lock(void);
+extern void __printk_cpu_unlock(void);
+
+/**
+ * printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
+ *                             lock and disable interrupts.
+ * @flags: Stack-allocated storage for saving local interrupt state,
+ *         to be passed to printk_cpu_unlock_irqrestore().
+ *
+ * If the lock is owned by another CPU, spin until it becomes available.
+ * Interrupts are restored while spinning.
+ */
+#define printk_cpu_lock_irqsave(flags)		\
+	for (;;) {				\
+		local_irq_save(flags);		\
+		if (__printk_cpu_trylock())	\
+			break;			\
+		local_irq_restore(flags);	\
+		__printk_wait_on_cpu_lock();	\
+	}
+
+/**
+ * printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant spinning
+ *                                  lock and restore interrupts.
+ * @flags: Caller's saved interrupt state, from printk_cpu_lock_irqsave().
+ */
+#define printk_cpu_unlock_irqrestore(flags)	\
+	do {					\
+		__printk_cpu_unlock();		\
+		local_irq_restore(flags);	\
+	} while (0)				\
+
+#else
+
+#define printk_cpu_lock_irqsave(flags) ((void)flags)
+#define printk_cpu_unlock_irqrestore(flags) ((void)flags)
+
+#endif /* CONFIG_SMP */
+
 extern int kptr_restrict;
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 114e9963f903..08e14a67c44e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3532,3 +3532,72 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
+
+#ifdef CONFIG_SMP
+static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
+static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
+
+/**
+ * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
+ *                               spinning lock is not owned by any CPU.
+ *
+ * Context: Any context.
+ */
+void __printk_wait_on_cpu_lock(void)
+{
+	do {
+		cpu_relax();
+	} while (atomic_read(&printk_cpulock_owner) != -1);
+}
+EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
+
+/**
+ * __printk_cpu_trylock() - Try to acquire the printk cpu-reentrant
+ *                          spinning lock.
+ *
+ * If no processor has the lock, the calling processor takes the lock and
+ * becomes the owner. If the calling processor is already the owner of the
+ * lock, this function succeeds immediately.
+ *
+ * Context: Any context. Expects interrupts to be disabled.
+ * Return: 1 on success, otherwise 0.
+ */
+int __printk_cpu_trylock(void)
+{
+	int cpu;
+	int old;
+
+	cpu = smp_processor_id();
+
+	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
+	if (old == -1) {
+		/* This CPU is now the owner. */
+		return 1;
+	} else if (old == cpu) {
+		/* This CPU is already the owner. */
+		atomic_inc(&printk_cpulock_nested);
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__printk_cpu_trylock);
+
+/**
+ * __printk_cpu_unlock() - Release the printk cpu-reentrant spinning lock.
+ *
+ * The calling processor must be the owner of the lock.
+ *
+ * Context: Any context. Expects interrupts to be disabled.
+ */
+void __printk_cpu_unlock(void)
+{
+	if (atomic_read(&printk_cpulock_nested)) {
+		atomic_dec(&printk_cpulock_nested);
+		return;
+	}
+
+	atomic_set(&printk_cpulock_owner, -1);
+}
+EXPORT_SYMBOL(__printk_cpu_unlock);
+#endif /* CONFIG_SMP */
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6e7ca3d67710..cd3387bb34e5 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -93,52 +93,18 @@ static void __dump_stack(const char *log_lvl)
  *
  * Architectures can override this implementation by implementing its own.
  */
-#ifdef CONFIG_SMP
-static atomic_t dump_lock = ATOMIC_INIT(-1);
-
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
 	unsigned long flags;
-	int was_locked;
-	int old;
-	int cpu;
 
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
+	printk_cpu_lock_irqsave(flags);
 	__dump_stack(log_lvl);
+	printk_cpu_unlock_irqrestore(flags);
 }
-#endif
 EXPORT_SYMBOL(dump_stack_lvl);
 
 asmlinkage __visible void dump_stack(void)
-- 
2.20.1

