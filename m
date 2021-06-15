Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACA3A8817
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFORv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:51:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFORvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:51:54 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623779388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y12741Qzx3w1OavxZ7X9S0Hwe/Y76atKnVlUvDDN9+o=;
        b=verDw6oXXICgGp150Y5vI4FOsWBInVYq8f3ymwCaAULC0peQFd6bFody7UQtW0IAW1ToZS
        WqbMIRUsELI/a1Ub8eIFeBMrVH1nq2owE39bcEujroX7dWGnhRlc7K49eD4QlGFdCgjieC
        UX4oFHGsQwGTtRZ2JVlT+fMUxr730DGWz32Hq9bkpD6K6fiyGpwxBA7kPclegSK6xapUyY
        yvga+yxQCJUxKXxU04O5UXwsnSbhkXkwxA+cbjmAdRLmYSK1Eh1zMuP2KEXSyhKr7BN74C
        q6NJIm5Vhh6jcbnWmVEjyADJR6bIzapNR0H+CM4fnOU4SQqURsnqhf6X/9n3uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623779388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y12741Qzx3w1OavxZ7X9S0Hwe/Y76atKnVlUvDDN9+o=;
        b=qTxp8o00TEeU31JjqI6STyAZcxjkSZwJdRvZt+fHiICBFSyVeFS2BzVVP5AXBOsbCK/rqG
        RBIpS+ZjNIv2IfCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH next v3 1/2] dump_stack: move cpu lock to printk.c
Date:   Tue, 15 Jun 2021 19:55:46 +0206
Message-Id: <20210615174947.32057-2-john.ogness@linutronix.de>
In-Reply-To: <20210615174947.32057-1-john.ogness@linutronix.de>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
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
 include/linux/printk.h | 41 ++++++++++++++++++++++++++
 kernel/printk/printk.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       | 38 ++----------------------
 3 files changed, 110 insertions(+), 36 deletions(-)

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
index 114e9963f903..5369d8f33299 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3532,3 +3532,70 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
+
+#ifdef CONFIG_SMP
+static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
+static bool printk_cpulock_nested;
+
+/**
+ * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
+ *                               spinning lock is not owned by any CPU.
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
+		printk_cpulock_nested = true;
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
+	if (printk_cpulock_nested) {
+		printk_cpulock_nested = false;
+		return;
+	}
+
+	atomic_set_release(&printk_cpulock_owner, -1);
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

