Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6043E396716
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhEaRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhEaRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B534EC08EB1E
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:20:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622478053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHN6YtdZdaFsXiKwxgeW++Wq9zqWkXdx8RkPCfcy37g=;
        b=OGQK8d4b6co2ZOL3kQxZ+6LC3N1m7PUZIraUy8busQk81Kak5QaMZGBmysQvrEiYhI7FTD
        p4oWwpl4P1XACu536rXP/rFfWHZvfeR/7x46vGgxdTAl2qujqWtj9oXS5SPcC6KSj++u5I
        Ya7iQn7/QC39u7pdWMAXwjPQVYvCRIColFf9WQ9K9ALLWX6N9NmUqOzAt8FQFedJvDVDXr
        GzgzkyOIfRTNS834zLbrLE9fUV2VEEK4FcKrp81Rh12WXl3xPgjPBLQcDAfkZhbfoEUDNh
        1JgKOMUaONvJSJ0ILjN19gBQ/VF44sT6yEgntX30bthAmT60/WtW9FRDztmB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622478053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHN6YtdZdaFsXiKwxgeW++Wq9zqWkXdx8RkPCfcy37g=;
        b=/EL1StyCtL4Y946UUY9lG12h6C4E/+De+GDHFN1U5Z8xPY1ZTLDAMDj6WRcA9+cEaYYMLW
        czt4mfRo5NMBElDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
Date:   Mon, 31 May 2021 18:20:50 +0200
Message-Id: <20210531162051.2325-2-john.ogness@linutronix.de>
In-Reply-To: <20210531162051.2325-1-john.ogness@linutronix.de>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
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
functions printk_cpu_lock()/printk_cpu_unlock() so that it is
available for others as well. For !CONFIG_PRINTK or !CONFIG_SMP
the cpu lock is a NOP.

Note that having multiple cpu locks in the system can easily
lead to deadlock. Code needing a cpu lock should use the
printk cpu lock, since the printk cpu lock could be acquired
from any code and any context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 13 ++++++
 kernel/printk/printk.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c       | 43 ++------------------
 3 files changed, 108 insertions(+), 40 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f589b8b60806..2f2d89b9e728 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -287,6 +287,19 @@ static inline void printk_safe_flush_on_panic(void)
 }
 #endif
 
+#if defined(CONFIG_PRINTK) && defined(CONFIG_SMP)
+extern void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags);
+extern void printk_cpu_unlock(unsigned int cpu_store, unsigned long flags);
+#else
+static inline void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
+{
+}
+
+static inline void printk_cpu_unlock(unsigned int cpu_store, unsigned long flags)
+{
+}
+#endif
+
 extern int kptr_restrict;
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 114e9963f903..98feead621ff 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3531,4 +3531,96 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+#ifdef CONFIG_SMP
+static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
+
+/*
+ * printk_cpu_lock: Acquire the printk cpu-reentrant spinning lock.
+ * @cpu_store: A buffer to store lock state.
+ * @flags: A buffer to store irq state.
+ *
+ * If no processor has the lock, the calling processor takes the lock and
+ * becomes the owner. If the calling processor is already the owner of the
+ * lock, this function succeeds immediately. If the lock is locked by another
+ * processor, that function spins until the calling processor becomes the
+ * owner.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
+{
+	unsigned int cpu;
+
+	for (;;) {
+		cpu = get_cpu();
+
+		*cpu_store = atomic_read(&printk_cpulock_owner);
+
+		if (*cpu_store == -1) {
+			local_irq_save(*flags);
+
+			/*
+			 * Guarantee loads an stores from the previous lock
+			 * owner are visible to this CPU once it is the lock
+			 * owner. This pairs with cpu_lock:A.
+			 *
+			 * Memory barrier involvement:
+			 *
+			 * If cpu_lock:A reads from cpu_unlock:B, then
+			 * cpu_lock:B reads from cpu_unlock:A.
+			 *
+			 * Relies on:
+			 *
+			 * RELEASE from cpu_unlock:A to cpu_unlock:B
+			 *    matching
+			 * ACQUIRE from cpu_lock:A to cpu_lock:B
+			 */
+			if (atomic_try_cmpxchg_acquire(&printk_cpulock_owner,
+						       cpu_store, cpu)) { /* LMM(cpu_lock:A) */
+
+				/* This CPU begins loading/storing data: LMM(cpu_lock:B) */
+				break;
+			}
+
+			local_irq_restore(*flags);
+
+		} else if (*cpu_store == cpu) {
+			break;
+		}
+
+		put_cpu();
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL(printk_cpu_lock);
+
+/*
+ * printk_cpu_unlock: Release the printk cpu-reentrant spinning lock.
+ * @cpu_store: The current lock state.
+ * @flags: The current irq state.
+ *
+ * Release the lock. The calling processor must be the owner of the lock.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void printk_cpu_unlock(unsigned int cpu_store, unsigned long flags)
+{
+	if (cpu_store == -1) {
+		/* This CPU is finished loading/storing data: LMM(cpu_unlock:A) */
+
+		/*
+		 * Guarantee loads an stores from this CPU when it is the lock
+		 * owner are visible to the next lock owner. This pairs with
+		 * cpu_lock:A.
+		 */
+		atomic_set_release(&printk_cpulock_owner, cpu_store); /* LMM(cpu_unlock:B) */
+
+		local_irq_restore(flags);
+	}
+
+	put_cpu();
+}
+EXPORT_SYMBOL(printk_cpu_unlock);
+#endif /* CONFIG_SMP */
+
 #endif
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6e7ca3d67710..88f13250f29d 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -93,52 +93,15 @@ static void __dump_stack(const char *log_lvl)
  *
  * Architectures can override this implementation by implementing its own.
  */
-#ifdef CONFIG_SMP
-static atomic_t dump_lock = ATOMIC_INIT(-1);
-
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
+	unsigned int cpu_store;
 	unsigned long flags;
-	int was_locked;
-	int old;
-	int cpu;
-
-	/*
-	 * Permit this cpu to perform nested stack dumps while serialising
-	 * against other CPUs
-	 */
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
 
-	local_irq_restore(flags);
-}
-#else
-asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
-{
+	printk_cpu_lock(&cpu_store, &flags);
 	__dump_stack(log_lvl);
+	printk_cpu_unlock(cpu_store, flags);
 }
-#endif
 EXPORT_SYMBOL(dump_stack_lvl);
 
 asmlinkage __visible void dump_stack(void)
-- 
2.20.1

