Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD343DEEE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhHCNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E402C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:13:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sujL9gb9FRsF6DfOcifSfCHHB+XTlow0qpwJoRkfMQU=;
        b=oKEGa2wjjRG9jQsypG2JRkq7h84Pqf24Srn8nMEyvLANObWEzZ0ma/GdBo0k/TejtaiXIv
        yUKgCkaAdZd+6ActllT/5Wl++KRzdAe8NXXUzmLnHpHnjDhpUfLh0umaYxpXsyiEtLioxN
        Vp9p1yRgbI2hpWpVCD+PddfbRHt+S+SbzBFsgKkFcw/SxNQxnGSu7QI5py4daUrPwSoyX7
        Or++1/4Nwn6UB+t8Vz2ZjJuH4VawucqQu+GANt+X6VjyuIWIXUEc/D1Zvz/7C6+mtJL2Ki
        3fFGcV3FcTlBSaqlrA70pbuYVBOX9hqa4ghSu6X6ARrtnH90kAgNIxiojwd6iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sujL9gb9FRsF6DfOcifSfCHHB+XTlow0qpwJoRkfMQU=;
        b=EZ5N3U18IexZ3CSV0LzqrKBM1Wjx1u7viWbqmN7FXJbT8HOeVv2YfWZW/djp+7ANQBEkqX
        OI2QE/lGtwlrQ7Bw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 01/10] printk: relocate printk cpulock functions
Date:   Tue,  3 Aug 2021 15:18:52 +0206
Message-Id: <20210803131301.5588-2-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the printk cpulock functions "as is" further up so that they
can be used by other printk.c functions in an upcoming commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 232 ++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 116 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 825277e1e742..3d0c933937b4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -211,6 +211,122 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 	return 0;
 }
 
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
+	/*
+	 * Guarantee loads and stores from this CPU when it is the lock owner
+	 * are _not_ visible to the previous lock owner. This pairs with
+	 * __printk_cpu_unlock:B.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B, then
+	 * __printk_cpu_unlock:A can never read from __printk_cpu_trylock:B.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * of the previous CPU
+	 *    matching
+	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
+	 * of this CPU
+	 */
+	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1,
+				     cpu); /* LMM(__printk_cpu_trylock:A) */
+	if (old == -1) {
+		/*
+		 * This CPU is now the owner and begins loading/storing
+		 * data: LMM(__printk_cpu_trylock:B)
+		 */
+		return 1;
+
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
+	/*
+	 * This CPU is finished loading/storing data:
+	 * LMM(__printk_cpu_unlock:A)
+	 */
+
+	/*
+	 * Guarantee loads and stores from this CPU when it was the
+	 * lock owner are visible to the next lock owner. This pairs
+	 * with __printk_cpu_trylock:A.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B,
+	 * then __printk_cpu_trylock:B reads from __printk_cpu_unlock:A.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * of this CPU
+	 *    matching
+	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
+	 * of the next CPU
+	 */
+	atomic_set_release(&printk_cpulock_owner,
+			   -1); /* LMM(__printk_cpu_unlock:B) */
+}
+EXPORT_SYMBOL(__printk_cpu_unlock);
+#endif /* CONFIG_SMP */
+
 /* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
@@ -3578,119 +3694,3 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
-
-#ifdef CONFIG_SMP
-static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
-static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
-
-/**
- * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
- *                               spinning lock is not owned by any CPU.
- *
- * Context: Any context.
- */
-void __printk_wait_on_cpu_lock(void)
-{
-	do {
-		cpu_relax();
-	} while (atomic_read(&printk_cpulock_owner) != -1);
-}
-EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
-
-/**
- * __printk_cpu_trylock() - Try to acquire the printk cpu-reentrant
- *                          spinning lock.
- *
- * If no processor has the lock, the calling processor takes the lock and
- * becomes the owner. If the calling processor is already the owner of the
- * lock, this function succeeds immediately.
- *
- * Context: Any context. Expects interrupts to be disabled.
- * Return: 1 on success, otherwise 0.
- */
-int __printk_cpu_trylock(void)
-{
-	int cpu;
-	int old;
-
-	cpu = smp_processor_id();
-
-	/*
-	 * Guarantee loads and stores from this CPU when it is the lock owner
-	 * are _not_ visible to the previous lock owner. This pairs with
-	 * __printk_cpu_unlock:B.
-	 *
-	 * Memory barrier involvement:
-	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B, then
-	 * __printk_cpu_unlock:A can never read from __printk_cpu_trylock:B.
-	 *
-	 * Relies on:
-	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
-	 * of the previous CPU
-	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of this CPU
-	 */
-	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1,
-				     cpu); /* LMM(__printk_cpu_trylock:A) */
-	if (old == -1) {
-		/*
-		 * This CPU is now the owner and begins loading/storing
-		 * data: LMM(__printk_cpu_trylock:B)
-		 */
-		return 1;
-
-	} else if (old == cpu) {
-		/* This CPU is already the owner. */
-		atomic_inc(&printk_cpulock_nested);
-		return 1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(__printk_cpu_trylock);
-
-/**
- * __printk_cpu_unlock() - Release the printk cpu-reentrant spinning lock.
- *
- * The calling processor must be the owner of the lock.
- *
- * Context: Any context. Expects interrupts to be disabled.
- */
-void __printk_cpu_unlock(void)
-{
-	if (atomic_read(&printk_cpulock_nested)) {
-		atomic_dec(&printk_cpulock_nested);
-		return;
-	}
-
-	/*
-	 * This CPU is finished loading/storing data:
-	 * LMM(__printk_cpu_unlock:A)
-	 */
-
-	/*
-	 * Guarantee loads and stores from this CPU when it was the
-	 * lock owner are visible to the next lock owner. This pairs
-	 * with __printk_cpu_trylock:A.
-	 *
-	 * Memory barrier involvement:
-	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B,
-	 * then __printk_cpu_trylock:B reads from __printk_cpu_unlock:A.
-	 *
-	 * Relies on:
-	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
-	 * of this CPU
-	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of the next CPU
-	 */
-	atomic_set_release(&printk_cpulock_owner,
-			   -1); /* LMM(__printk_cpu_unlock:B) */
-}
-EXPORT_SYMBOL(__printk_cpu_unlock);
-#endif /* CONFIG_SMP */
-- 
2.20.1

