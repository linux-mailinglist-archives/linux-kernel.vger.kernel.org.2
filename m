Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C684B3257AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhBYU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:26:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5BC061797
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zq2Wpkoct56RJvjmIToRjHhgBrI/RwkhbYK7gEkKlQ=;
        b=zLNrcTUH3jbTR4zuvp769DYaQWL/K87/JJ3nCZLl34et6U+WxhpSnd4UXUaxZuATQ43Mm/
        qkmrHj/J7eFeCrX3OlqhdYxhEKqX3dETXMoq6RLHqBU3KFohz0MpgQijIACVel2DJ7jVqn
        QqrNq+yXTBu3Q9mIOgny16ZxXshzzgqiw+V/TD6hcgnYgytKBwalGTaPGyt7i2cN+56dj5
        Cu7kyA2KEtF/C+bl6J+1OamG1DoIVLQYcwE9k/McMTh+X1QJxNiQHlLUNL0a25OByLxIM0
        OCPnGiL71gStOB0P4kvhzirPMtEHAlCZiVLGtPjBz6a0v5YCP/ZOgGLUWJ/awQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zq2Wpkoct56RJvjmIToRjHhgBrI/RwkhbYK7gEkKlQ=;
        b=6OwyeHig7zxUvY4PIQAI5shFMUoyhYlRTJh0FyxyI+btMx6c68gXpDiSSek9yMcNDXQT1r
        ZtDaZ4vJtQxnAsAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 13/15] printk: remove logbuf_lock
Date:   Thu, 25 Feb 2021 21:24:36 +0100
Message-Id: <20210225202438.28985-14-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is lockless, there is no need for it to be
protected by @logbuf_lock. Remove @logbuf_lock.

@console_seq, @exclusive_console_stop_seq, @console_dropped are
protected by @console_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h    |   4 +-
 kernel/printk/printk.c      | 112 ++++++++++++------------------------
 kernel/printk/printk_safe.c |  27 +++------
 3 files changed, 46 insertions(+), 97 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3a8fd491758c..e7acc2888c8e 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -12,8 +12,6 @@
 
 #define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
-extern raw_spinlock_t logbuf_lock;
-
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -59,7 +57,7 @@ void defer_console_output(void);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 
 /*
- * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
+ * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
  * printk-safe must preserve the existing local IRQ guarantees.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e58ccc368348..01385ea92e7c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -355,41 +355,6 @@ enum log_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
-/*
- * The logbuf_lock protects kmsg buffer, indices, counters.  This can be taken
- * within the scheduler's rq lock. It must be released before calling
- * console_unlock() or anything else that might wake up a process.
- */
-DEFINE_RAW_SPINLOCK(logbuf_lock);
-
-/*
- * Helper macros to lock/unlock logbuf_lock and switch between
- * printk-safe/unsafe modes.
- */
-#define logbuf_lock_irq()				\
-	do {						\
-		printk_safe_enter_irq();		\
-		raw_spin_lock(&logbuf_lock);		\
-	} while (0)
-
-#define logbuf_unlock_irq()				\
-	do {						\
-		raw_spin_unlock(&logbuf_lock);		\
-		printk_safe_exit_irq();			\
-	} while (0)
-
-#define logbuf_lock_irqsave(flags)			\
-	do {						\
-		printk_safe_enter_irqsave(flags);	\
-		raw_spin_lock(&logbuf_lock);		\
-	} while (0)
-
-#define logbuf_unlock_irqrestore(flags)		\
-	do {						\
-		raw_spin_unlock(&logbuf_lock);		\
-		printk_safe_exit_irqrestore(flags);	\
-	} while (0)
-
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_RAW_SPINLOCK(syslog_lock);
 
@@ -401,6 +366,7 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+/* All 3 protected by @console_sem. */
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u64 exclusive_console_stop_seq;
@@ -766,27 +732,27 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
-			logbuf_unlock_irq();
+			printk_safe_exit_irq();
 			goto out;
 		}
 
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		ret = wait_event_interruptible(log_wait,
 				prb_read_valid(prb, atomic64_read(&user->seq), r));
 		if (ret)
 			goto out;
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 	}
 
 	if (r->info->seq != atomic64_read(&user->seq)) {
 		/* our last seen message is gone, return error and reset */
 		atomic64_set(&user->seq, r->info->seq);
 		ret = -EPIPE;
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		goto out;
 	}
 
@@ -796,7 +762,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->info->dev_info);
 
 	atomic64_set(&user->seq, r->info->seq + 1);
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	if (len > count) {
 		ret = -EINVAL;
@@ -831,7 +797,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	if (offset)
 		return -ESPIPE;
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
@@ -852,7 +818,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	default:
 		ret = -EINVAL;
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 	return ret;
 }
 
@@ -867,7 +833,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &log_wait, wait);
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	if (prb_read_valid_info(prb, atomic64_read(&user->seq), &info, NULL)) {
 		/* return error when data has vanished underneath us */
 		if (info.seq != atomic64_read(&user->seq))
@@ -875,7 +841,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	return ret;
 }
@@ -908,9 +874,9 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	prb_rec_init_rd(&user->record, &user->info,
 			&user->text_buf[0], sizeof(user->text_buf));
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	file->private_data = user;
 	return 0;
@@ -1532,11 +1498,11 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
 			raw_spin_unlock(&syslog_lock);
-			logbuf_unlock_irq();
+			printk_safe_exit_irq();
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1566,7 +1532,7 @@ static int syslog_print(char __user *buf, int size)
 		} else
 			n = 0;
 		raw_spin_unlock(&syslog_lock);
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 
 		if (!n)
 			break;
@@ -1600,7 +1566,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return -ENOMEM;
 
 	time = printk_time;
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
@@ -1621,12 +1587,12 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
 			len += textlen;
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 
 		if (len < 0)
 			break;
@@ -1637,7 +1603,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		latched_seq_write(&clear_seq, seq);
 		raw_spin_unlock(&syslog_lock);
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	kfree(text);
 	return len;
@@ -1645,11 +1611,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	raw_spin_lock(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
 	raw_spin_unlock(&syslog_lock);
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 }
 
 /* Return a consistent copy of @syslog_seq. */
@@ -1737,12 +1703,12 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
 			/* No unread messages. */
 			raw_spin_unlock(&syslog_lock);
-			logbuf_unlock_irq();
+			printk_safe_exit_irq();
 			return 0;
 		}
 		if (info.seq != syslog_seq) {
@@ -1771,7 +1737,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			error -= syslog_partial;
 		}
 		raw_spin_unlock(&syslog_lock);
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -2627,7 +2593,6 @@ void console_unlock(void)
 		size_t len;
 
 		printk_safe_enter_irqsave(flags);
-		raw_spin_lock(&logbuf_lock);
 skip:
 		if (!prb_read_valid(prb, console_seq, &r))
 			break;
@@ -2671,7 +2636,6 @@ void console_unlock(void)
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time);
 		console_seq++;
-		raw_spin_unlock(&logbuf_lock);
 
 		/*
 		 * While actively printing out messages, if another printk()
@@ -2698,8 +2662,6 @@ void console_unlock(void)
 
 	console_locked = 0;
 
-	raw_spin_unlock(&logbuf_lock);
-
 	up_console_sem();
 
 	/*
@@ -2708,9 +2670,7 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	raw_spin_lock(&logbuf_lock);
 	retry = prb_read_valid(prb, console_seq, NULL);
-	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
 	if (retry && console_trylock())
@@ -2777,9 +2737,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL) {
 		unsigned long flags;
 
-		logbuf_lock_irqsave(flags);
+		printk_safe_enter_irqsave(flags);
 		console_seq = prb_first_valid_seq(prb);
-		logbuf_unlock_irqrestore(flags);
+		printk_safe_exit_irqrestore(flags);
 	}
 	console_unlock();
 }
@@ -3008,7 +2968,7 @@ void register_console(struct console *newcon)
 		 * console_unlock(); will print out the buffered messages
 		 * for us.
 		 */
-		logbuf_lock_irqsave(flags);
+		printk_safe_enter_irqsave(flags);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
@@ -3026,7 +2986,7 @@ void register_console(struct console *newcon)
 		console_seq = syslog_seq;
 		raw_spin_unlock(&syslog_lock);
 
-		logbuf_unlock_irqrestore(flags);
+		printk_safe_exit_irqrestore(flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
@@ -3488,9 +3448,9 @@ bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
 	unsigned long flags;
 	bool ret;
 
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 	ret = kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 
 	return ret;
 }
@@ -3530,7 +3490,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 	if (!buf || !size)
 		goto out;
 
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 	if (prb_read_valid_info(prb, iter->cur_seq, &info, NULL)) {
 		if (info.seq != iter->cur_seq) {
 			/* messages are gone, move to first available one */
@@ -3540,7 +3500,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 
 	/* last entry */
 	if (iter->cur_seq >= iter->next_seq) {
-		logbuf_unlock_irqrestore(flags);
+		printk_safe_exit_irqrestore(flags);
 		goto out;
 	}
 
@@ -3574,7 +3534,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dump_iter *iter, bool syslog,
 
 	iter->next_seq = next_seq;
 	ret = true;
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 out:
 	if (len_out)
 		*len_out = len;
@@ -3610,9 +3570,9 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 {
 	unsigned long flags;
 
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 	kmsg_dump_rewind_nolock(iter);
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2e9e3ed7d63e..bbf5c1993636 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -16,7 +16,7 @@
 #include "internal.h"
 
 /*
- * printk() could not take logbuf_lock in NMI context. Instead,
+ * In NMI and safe mode, printk() avoids taking locks. Instead,
  * it uses an alternative implementation that temporary stores
  * the strings into a per-CPU buffer. The content of the buffer
  * is later flushed into the main ring buffer via IRQ work.
@@ -267,17 +267,9 @@ void printk_safe_flush(void)
 void printk_safe_flush_on_panic(void)
 {
 	/*
-	 * Make sure that we could access the main ring buffer.
+	 * Make sure that we could access the safe buffers.
 	 * Do not risk a double release when more CPUs are up.
 	 */
-	if (raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
-	}
-
 	if (raw_spin_is_locked(&safe_read_lock)) {
 		if (num_online_cpus() > 1)
 			return;
@@ -319,9 +311,7 @@ void noinstr printk_nmi_exit(void)
  * reordering.
  *
  * It has effect only when called in NMI context. Then printk()
- * will try to store the messages into the main logbuf directly
- * and use the per-CPU buffers only as a fallback when the lock
- * is not available.
+ * will store the messages into the main logbuf directly.
  */
 void printk_nmi_direct_enter(void)
 {
@@ -376,20 +366,21 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 #endif
 
 	/*
-	 * Try to use the main logbuf even in NMI. But avoid calling console
+	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
-	    raw_spin_trylock(&logbuf_lock)) {
+	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
+		unsigned long flags;
 		int len;
 
+		printk_safe_enter_irqsave(flags);
 		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		raw_spin_unlock(&logbuf_lock);
+		printk_safe_exit_irqrestore(flags);
 		defer_console_output();
 		return len;
 	}
 
-	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
+	/* Use extra buffer in NMI. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
-- 
2.20.1

