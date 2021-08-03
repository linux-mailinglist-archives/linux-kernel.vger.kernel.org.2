Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E233DEEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhHCNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4AC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:13:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxrgoBpfIAsJ5d8JUPK/ZC4cndnEgJm5wqOjNGasENw=;
        b=KLZuUDA+lf7VFSKpKRANFc//Dz9jzdVuHq1UoShLzX3dlwH9j2MvDbufRLiXXVXIZOK2MN
        TYmFwkBlBFQg+IssZ7zX1/WhNhkEDNBKMlC2c7gNjBFGqO5dWFRur5xYa2TZqGJuQPgXqj
        hx9QTH/UHBe9LGd+ritPCqTkUOqfkdP/CPpEsaaUH+7blXaovHYr22GbCNMrOpT4u8Td0i
        LQz47zxPxhv2jHdC2D1ejw7nnIy79q4vdCnFnEZk8riN6EmnUtCW9tjNTkaqS4eUthW6E1
        IwGTmiegIq2qLVZBXIqJ1YeJcYLo8BxSngP2FwXZ+9Ck6vT2/4OI8DlqF1QqCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxrgoBpfIAsJ5d8JUPK/ZC4cndnEgJm5wqOjNGasENw=;
        b=MWGp4riSvM8h2quhx9crl8n9NYLY1HDh9yLsJZeFIueI/KMYvPlHqESlpXJa+mKJ6RimtT
        iRnMsJNK8DN4EVCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH printk v1 07/10] console: add write_atomic interface
Date:   Tue,  3 Aug 2021 15:18:58 +0206
Message-Id: <20210803131301.5588-8-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write_atomic() callback to the console. This is an optional
function for console drivers. The function must be atomic (including
NMI safe) for writing to the console.

Console drivers implementing write_atomic() must select the new
HAVE_ATOMIC_CONSOLE Kconfig option.

Console drivers must still implement the write() callback. The
write_atomic() callback will only be used in special situations,
such as when the kernel panics.

Creating an NMI safe write_atomic() that must synchronize with
write() requires a careful implementation of the console driver. To
aid with the implementation, a set of console_atomic_*() functions
are provided:

    void console_atomic_lock(unsigned long flags);
    void console_atomic_unlock(unsigned long flags);

These functions synchronize using the printk cpulock and disable
hardware interrupts.

In order to increase effectiveness, the printk cpulock functions are
also made more aggressive and now keep interrupts disabled while
spinning.

CPUs holding the printk cpulock must not spin on any other lock.
Therefore can_use_console() will now return false if the printk
cpulock is held in order to avoid calling into console driver code,
while typically contain spinlocks.

Likewise, console_trylock_spinning() will fail rather than attempt
to acquire the console_sem (which includes a spinlock in its
implementation) if the printk cpulock is held.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 29 +++++++++++++++++++++++++++++
 include/linux/printk.h  | 19 ++++++++-----------
 kernel/printk/printk.c  | 22 +++++++++++++++++++++-
 lib/Kconfig.debug       |  3 +++
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 20874db50bc8..2f11b604e487 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/printk.h>
 
 struct vc_data;
 struct console_font_op;
@@ -140,6 +141,7 @@ static inline int con_debug_leave(void)
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
+	void	(*write_atomic)(struct console *co, const char *s, unsigned int count);
 	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
@@ -159,6 +161,33 @@ struct console {
 #define for_each_console(con) \
 	for (con = console_drivers; con != NULL; con = con->next)
 
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+#define have_atomic_console()					\
+	({							\
+		struct console *con;				\
+								\
+		for_each_console(con) {				\
+			if (!(con->flags & CON_ENABLED))	\
+				continue;			\
+			if (con->write_atomic)			\
+				break;				\
+		}						\
+		(con != NULL);					\
+	})
+
+/*
+ * For write_atomic() implementations, the printk cpu-reentrant spinlock can
+ * be used to help synchronize between write_atomic() and write().
+ */
+#define console_atomic_cpu_lock		raw_printk_cpu_lock_irqsave
+#define console_atomic_cpu_unlock	raw_printk_cpu_unlock_irqrestore
+
+#else
+
+#define have_atomic_console()		false
+
+#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 974ea2c99749..e8181934cfc5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -295,22 +295,19 @@ static inline bool kgdb_roundup_delay(unsigned int cpu)
 #endif /* CONFIG_SMP */
 
 /**
- * raw_printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
- *                                 lock and disable interrupts.
+ * raw_printk_cpu_lock_irqsave() - Disable interrupts and acquire the printk
+ *                                 cpu-reentrant spinning lock.
  * @flags: Stack-allocated storage for saving local interrupt state,
  *         to be passed to raw_printk_cpu_unlock_irqrestore().
  *
  * If the lock is owned by another CPU, spin until it becomes available.
- * Interrupts are restored while spinning.
  */
-#define raw_printk_cpu_lock_irqsave(flags)	\
-	for (;;) {				\
-		local_irq_save(flags);		\
-		if (__printk_cpu_trylock())	\
-			break;			\
-		local_irq_restore(flags);	\
-		__printk_wait_on_cpu_lock();	\
-	}
+#define raw_printk_cpu_lock_irqsave(flags)		\
+	do {						\
+		local_irq_save(flags);			\
+		while (!__printk_cpu_trylock())		\
+			__printk_wait_on_cpu_lock();	\
+	} while (0)
 
 /**
  * raw_printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f8f46d9fba9b..acd80a8d299f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1993,6 +1993,16 @@ static int console_trylock_spinning(void)
 	bool spin = false;
 	unsigned long flags;
 
+#ifdef CONFIG_SMP
+	/*
+	 * CPUs holding the printk cpulock must not spin on any lock. Even
+	 * console_trylock() must not be called because its implementation
+	 * uses spinlocks.
+	 */
+	if (atomic_read(&printk_cpulock_owner) == smp_processor_id())
+		return 0;
+#endif
+
 	if (console_trylock())
 		return 1;
 
@@ -2719,7 +2729,17 @@ static int have_callable_console(void)
  */
 static inline int can_use_console(void)
 {
-	return cpu_online(raw_smp_processor_id()) || have_callable_console();
+	int cpu = raw_smp_processor_id();
+#ifdef CONFIG_SMP
+	/*
+	 * CPUs holding the printk cpulock must not spin on any lock.
+	 * Allowing console usage could call into the spinlocks of the
+	 * various console drivers.
+	 */
+	if (atomic_read(&printk_cpulock_owner) == cpu)
+		return 0;
+#endif
+	return cpu_online(cpu) || have_callable_console();
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924..a32e57329f0a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -72,6 +72,9 @@ config CONSOLE_LOGLEVEL_QUIET
 	  will be used as the loglevel. IOW passing "quiet" will be the
 	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
 
+config HAVE_ATOMIC_CONSOLE
+        bool
+
 config MESSAGE_LOGLEVEL_DEFAULT
 	int "Default message log level (1-7)"
 	range 1 7
-- 
2.20.1

