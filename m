Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120253DEEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhHCNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTZ6z5pm94vU7QqF/Xw94ypcgMvE/6I4DjY1csplQDA=;
        b=pF+sXnUbp/NQnLtZFthNwazGY8OizU1zgqsNOSxyLb6JO2fiMADlmyHSiplG39vESIplfj
        lZBXMRMSBn3UdD8uJXhj3gtDlJmXxn8zSAobz/e25ph3Z3SwR+sWEV/9od9a3a8rbI8fSJ
        MfdiLWQNF6CZcGwxIbyVq6WwnHhyhQ0maSFMcsMUwtxnIZbXntHYGb8knlplKHM94xADN8
        AiA2u+I8PowfV13GaIcvq/9Ox2pUlGPbMDGWt3FRwE9VhyHYxAOtXw23BaqqZqLBJ2xY9y
        GwFYE+fyiqW+29h6SF83BQj6jJtqrxESoz/kLJ/DDA94c2CUObTQ44d1w9Jcjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTZ6z5pm94vU7QqF/Xw94ypcgMvE/6I4DjY1csplQDA=;
        b=TZU7YaQcQzH71tMfbDYLcW0MFr7eXMVPKziJR8TCFrDZ2YSqsRDBBH78TsSe2R/y5hX8EW
        t593LBFtfNkda5BA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 08/10] printk: introduce kernel sync mode
Date:   Tue,  3 Aug 2021 15:18:59 +0206
Message-Id: <20210803131301.5588-9-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce "sync mode", which means that all printk calls will
synchronously write to the console. Once activated, this mode is
never deactivated. It is used when the kernel is about to end
(such as panic, oops, shutdown, reboot).

Sync mode can only be activated if atomic consoles are available.

In sync mode:

- only atomic consoles (write_atomic() callback) will print
- printing occurs within vprintk_store() instead of console_unlock()

CONSOLE_LOG_MAX is moved to printk.h to support the per-console
buffer used in sync mode.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |   3 +
 include/linux/printk.h  |   6 ++
 kernel/printk/printk.c  | 190 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 2f11b604e487..eda9b96e3fb6 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -151,6 +151,9 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
+#if defined(CONFIG_PRINTK) && defined(CONFIG_HAVE_ATOMIC_CONSOLE)
+	char	sync_buf[CONSOLE_LOG_MAX];
+#endif
 	void	*data;
 	struct	 console *next;
 };
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e8181934cfc5..04dd6e3617f0 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -47,6 +47,12 @@ static inline const char *printk_skip_headers(const char *buffer)
 
 #define CONSOLE_EXT_LOG_MAX	8192
 
+/*
+ * The maximum size of a record formatted for console printing
+ * (i.e. with the prefix prepended to every line).
+ */
+#define CONSOLE_LOG_MAX		1024
+
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index acd80a8d299f..3fed3be9effe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -45,6 +45,7 @@
 #include <linux/ctype.h>
 #include <linux/uio.h>
 #include <linux/kgdb.h>
+#include <linux/clocksource.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -509,6 +510,35 @@ static struct latched_seq console_seq = {
 	.val[1]		= 0,
 };
 
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+/*
+ * A separate console_seq is used during sync mode. This allows tracking the
+ * current printk record to write to the console without holding @console_sem.
+ * Writers are synchronized by the printk cpulock.
+ */
+static struct latched_seq console_sync_seq = {
+	.latch		= SEQCNT_LATCH_ZERO(console_sync_seq.latch),
+	.val[0]		= 0,
+	.val[1]		= 0,
+};
+
+#ifdef CONFIG_HAVE_NMI
+/*
+ * A separate console_seq is used in NMI context during sync mode. This allows
+ * tracking the current printk record to write to the console from NMI
+ * context. Writers are synchronized by the printk cpulock.
+ */
+static struct latched_seq console_sync_nmi_seq = {
+	.latch		= SEQCNT_LATCH_ZERO(console_sync_nmi_seq.latch),
+	.val[0]		= 0,
+	.val[1]		= 0,
+};
+#endif
+
+/* Set to enable sync mode. Once set, it is never cleared. */
+static bool sync_mode;
+#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
+
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
@@ -526,9 +556,6 @@ static struct latched_seq clear_seq = {
 #define PREFIX_MAX		32
 #endif
 
-/* the maximum size of a formatted record (i.e. with prefix added per line) */
-#define CONSOLE_LOG_MAX		1024
-
 /* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
@@ -1900,6 +1927,126 @@ static inline void printk_delay(int level)
 	}
 }
 
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+/*
+ * Locklessly determine the next record seq to print. The sync and sync+nmi
+ * variants must also be checked because the latest records may have been
+ * printed from these contexts.
+ */
+static u64 read_console_seq(void)
+{
+	u64 sync_seq;
+	u64 seq;
+
+	seq = latched_seq_read_nolock(&console_seq);
+	sync_seq = latched_seq_read_nolock(&console_sync_seq);
+	if (sync_seq > seq)
+		seq = sync_seq;
+#ifdef CONFIG_HAVE_NMI
+	sync_seq = latched_seq_read_nolock(&console_sync_nmi_seq);
+	if (sync_seq > seq)
+		seq = sync_seq;
+#endif
+	return seq;
+}
+
+static void enable_sync_mode(void)
+{
+	if (!sync_mode) {
+		/*
+		 * The trailing printk message is important in order
+		 * to flush any pending messages.
+		 */
+		sync_mode = true;
+		pr_info("sync mode enabled\n");
+	}
+}
+
+static bool in_sync_mode(void)
+{
+	if (sync_mode)
+		return true;
+	if (oops_in_progress && have_atomic_console()) {
+		enable_sync_mode();
+		return true;
+	}
+	return false;
+}
+
+static bool print_sync(struct console *con, u64 *seq)
+{
+	struct printk_info info;
+	struct printk_record r;
+	size_t text_len;
+
+	prb_rec_init_rd(&r, &info, &con->sync_buf[0], sizeof(con->sync_buf));
+
+	if (!prb_read_valid(prb, *seq, &r))
+		return false;
+
+	text_len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+
+	con->write_atomic(con, &con->sync_buf[0], text_len);
+
+	*seq = r.info->seq;
+
+	touch_softlockup_watchdog_sync();
+	clocksource_touch_watchdog();
+	rcu_cpu_stall_reset();
+	touch_nmi_watchdog();
+
+	if (text_len)
+		printk_delay(r.info->level);
+
+	return true;
+}
+
+static void print_sync_to(struct console *con, u64 seq)
+{
+	u64 printk_seq;
+
+	while (!__printk_cpu_trylock())
+		__printk_wait_on_cpu_lock();
+
+	for (;;) {
+		printk_seq = read_console_seq();
+		if (printk_seq > seq)
+			break;
+		if (!print_sync(con, &printk_seq))
+			break;
+#ifdef CONFIG_PRINTK_NMI
+		if (in_nmi()) {
+			latched_seq_write(&console_sync_nmi_seq, printk_seq + 1);
+			continue;
+		}
+#endif
+		latched_seq_write(&console_sync_seq, printk_seq + 1);
+	}
+
+	__printk_cpu_unlock();
+}
+
+static void call_sync_console_drivers(u64 seq)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		if (!(con->flags & CON_ENABLED))
+			continue;
+		if (!con->write_atomic)
+			continue;
+		print_sync_to(con, seq);
+	}
+}
+#else
+
+#define read_console_seq()		latched_seq_read_nolock(&console_seq)
+#define in_sync_mode()			false
+#define enable_sync_mode()
+#define call_sync_console_drivers(seq)	((void)seq)
+
+#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
+
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -2084,6 +2231,8 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		if (!cpu_online(smp_processor_id()) &&
 		    !(con->flags & CON_ANYTIME))
 			continue;
+		if (in_sync_mode())
+			continue;
 		if (con->flags & CON_EXTENDED)
 			con->write(con, ext_text, ext_len);
 		else {
@@ -2251,6 +2400,7 @@ int vprintk_store(int facility, int level,
 	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum printk_info_flags flags = 0;
+	bool final_commit = false;
 	struct printk_record r;
 	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
@@ -2261,6 +2411,7 @@ int vprintk_store(int facility, int level,
 	u16 text_len;
 	int ret = 0;
 	u64 ts_nsec;
+	u64 seq;
 
 	/*
 	 * Since the duration of printk() can vary depending on the message
@@ -2299,6 +2450,7 @@ int vprintk_store(int facility, int level,
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
+			seq = r.info->seq;
 			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
 						 facility, &flags, fmt, args);
 			r.info->text_len += text_len;
@@ -2306,6 +2458,7 @@ int vprintk_store(int facility, int level,
 			if (flags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
 				prb_final_commit(&e);
+				final_commit = true;
 			} else {
 				prb_commit(&e);
 			}
@@ -2330,6 +2483,8 @@ int vprintk_store(int facility, int level,
 			goto out;
 	}
 
+	seq = r.info->seq;
+
 	/* fill message */
 	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &flags, fmt, args);
 	if (trunc_msg_len)
@@ -2344,13 +2499,19 @@ int vprintk_store(int facility, int level,
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
 	/* A message without a trailing newline can be continued. */
-	if (!(flags & LOG_NEWLINE))
+	if (!(flags & LOG_NEWLINE)) {
 		prb_commit(&e);
-	else
+	} else {
 		prb_final_commit(&e);
+		final_commit = true;
+	}
 
 	ret = text_len + trunc_msg_len;
 out:
+	/* only the kernel may perform synchronous printing */
+	if (in_sync_mode() && facility == 0 && final_commit)
+		call_sync_console_drivers(seq);
+
 	printk_exit_irqrestore(recursion_ptr, irqflags);
 	return ret;
 }
@@ -2419,13 +2580,13 @@ EXPORT_SYMBOL(_printk);
 
 #else /* CONFIG_PRINTK */
 
-#define CONSOLE_LOG_MAX		0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
 #define prb_first_valid_seq(rb)		0
-#define latched_seq_read_nolock(seq)	0
+#define read_console_seq()		0
 #define latched_seq_write(dst, src)
+#define in_sync_mode()			false
 
 static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
@@ -2739,6 +2900,8 @@ static inline int can_use_console(void)
 	if (atomic_read(&printk_cpulock_owner) == cpu)
 		return 0;
 #endif
+	if (in_sync_mode())
+		return 0;
 	return cpu_online(cpu) || have_callable_console();
 }
 
@@ -2808,7 +2971,7 @@ void console_unlock(void)
 		size_t len;
 
 skip:
-		seq = latched_seq_read_nolock(&console_seq);
+		seq = read_console_seq();
 		if (!prb_read_valid(prb, seq, &r))
 			break;
 
@@ -2888,7 +3051,7 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	retry = prb_read_valid(prb, latched_seq_read_nolock(&console_seq), NULL);
+	retry = prb_read_valid(prb, read_console_seq(), NULL);
 	if (retry && console_trylock())
 		goto again;
 }
@@ -3188,7 +3351,7 @@ void register_console(struct console *newcon)
 		 * ignores console_lock.
 		 */
 		exclusive_console = newcon;
-		exclusive_console_stop_seq = latched_seq_read_nolock(&console_seq);
+		exclusive_console_stop_seq = read_console_seq();
 
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
@@ -3558,6 +3721,13 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 {
 	struct kmsg_dumper *dumper;
 
+	/*
+	 * If atomic consoles are available, activate sync mode
+	 * to make sure any final messages are visible.
+	 */
+	if (have_atomic_console())
+		enable_sync_mode();
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
 		enum kmsg_dump_reason max_reason = dumper->max_reason;
-- 
2.20.1

