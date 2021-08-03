Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467943DEEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhHCNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B69C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:13:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4H75eLMRewx6WW+2hvKpHYD+oIYTkHYdXg7pqedPR8=;
        b=u/Gv/skJZ1vUkWLOWyB95WBx1G+EEDzy4JPrUrOqOTZ0xAKVn1xlLmyT4llbvqHvvfIs6k
        /6bozUBBYzRm+uSNC8Z8vUw5GQ/VD0hZmQL/T8wd/5xEBWdNMp99fKLa49Qkr78h6i8U6U
        of+57cFCvIoamTv158as+wSNp/KbgqeNdxIqBHksCFb6dj/st0SyG78uYY+hOpaOP1jJ3x
        FtHb7SaUc9ixjMT63u4Iy3UGO1aqgymiXm9W47vAAVYNaZu2HLSe33tAhnINE/AoS7aumf
        RTncEPWZNQUXBuKWzj+7TuCTgA9uKD8x1qzNU0EpOyFEEmJWrKCDChdUPjkufg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4H75eLMRewx6WW+2hvKpHYD+oIYTkHYdXg7pqedPR8=;
        b=PJwMIwzsjxDJR0lnXWXaBT43WXFpvJsDcoR2gOV+CxjqePNyX7bhWqzyqgI5s7G4Eq3Gug
        DsAD81tF0pAT7WCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 02/10] printk: rename printk cpulock API and always disable interrupts
Date:   Tue,  3 Aug 2021 15:18:53 +0206
Message-Id: <20210803131301.5588-3-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk cpulock functions use local_irq_disable(). This means that
hardware interrupts are also disabled on PREEMPT_RT. To make this
clear, rename the functions to use the raw_ prefix:

    raw_printk_cpu_lock_irqsave(flags);
    raw_printk_cpu_unlock_irqrestore(flags);

Also, these functions were a NOP for !CONFIG_SMP. But for !CONFIG_SMP
they still need to disable hardware interrupts. So modify them
appropriately for this.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h | 30 ++++++++++++++----------------
 lib/dump_stack.c       |  4 ++--
 lib/nmi_backtrace.c    |  4 ++--
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 259af4f97f50..ac738d1d9934 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -280,17 +280,22 @@ static inline void dump_stack(void)
 extern int __printk_cpu_trylock(void);
 extern void __printk_wait_on_cpu_lock(void);
 extern void __printk_cpu_unlock(void);
+#else
+#define __printk_cpu_trylock()		1
+#define __printk_wait_on_cpu_lock()
+#define __printk_cpu_unlock()
+#endif /* CONFIG_SMP */
 
 /**
- * printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
- *                             lock and disable interrupts.
+ * raw_printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
+ *                                 lock and disable interrupts.
  * @flags: Stack-allocated storage for saving local interrupt state,
- *         to be passed to printk_cpu_unlock_irqrestore().
+ *         to be passed to raw_printk_cpu_unlock_irqrestore().
  *
  * If the lock is owned by another CPU, spin until it becomes available.
  * Interrupts are restored while spinning.
  */
-#define printk_cpu_lock_irqsave(flags)		\
+#define raw_printk_cpu_lock_irqsave(flags)	\
 	for (;;) {				\
 		local_irq_save(flags);		\
 		if (__printk_cpu_trylock())	\
@@ -300,22 +305,15 @@ extern void __printk_cpu_unlock(void);
 	}
 
 /**
- * printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant spinning
- *                                  lock and restore interrupts.
- * @flags: Caller's saved interrupt state, from printk_cpu_lock_irqsave().
+ * raw_printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant
+ *                                      spinning lock and restore interrupts.
+ * @flags: Caller's saved interrupt state from raw_printk_cpu_lock_irqsave().
  */
-#define printk_cpu_unlock_irqrestore(flags)	\
+#define raw_printk_cpu_unlock_irqrestore(flags)	\
 	do {					\
 		__printk_cpu_unlock();		\
 		local_irq_restore(flags);	\
-	} while (0)				\
-
-#else
-
-#define printk_cpu_lock_irqsave(flags) ((void)flags)
-#define printk_cpu_unlock_irqrestore(flags) ((void)flags)
-
-#endif /* CONFIG_SMP */
+	} while (0)
 
 extern int kptr_restrict;
 
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index cd3387bb34e5..7af32829b062 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -101,9 +101,9 @@ asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	printk_cpu_lock_irqsave(flags);
+	raw_printk_cpu_lock_irqsave(flags);
 	__dump_stack(log_lvl);
-	printk_cpu_unlock_irqrestore(flags);
+	raw_printk_cpu_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index f9e89001b52e..569ec8676072 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -93,7 +93,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
-		printk_cpu_lock_irqsave(flags);
+		raw_printk_cpu_lock_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -104,7 +104,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		printk_cpu_unlock_irqrestore(flags);
+		raw_printk_cpu_unlock_irqrestore(flags);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.20.1

