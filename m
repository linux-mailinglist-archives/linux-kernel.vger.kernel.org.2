Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02243B2D61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhFXLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhFXLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:14:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:11:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624533112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiQSIzTqNuuROaf46XnDxXxQjYvmZnBN/IlZD6ylNL0=;
        b=0iCg6cbqb+PO4O7Re/C6HV0kLiBoR1z3OYgRPo8UV2lI5enDhYwsPyJkNy5ErUWc4qJr0Z
        bCAv9V8d6TRjxXSHCHo+3RQXUQiyGVVRx7JQglUiFvbkQwNF94kOExfJIb4Qn3dSroTaEv
        GmKDTpn6HgA7sdKoAyMqNsujDZCBu5r2LNIkDf2v85jnFVYaDyvUKURGXpGHG51CE+7V+x
        SrCTDy2OUf/rBO7c3ZWM/Mx6olec4mlCVulm1TpuH8Qn3mOUbbI4XwwLWnnA9YcL6Sln5y
        mFzPyXtUs+oRdGV+xHd59JOIEKTdALZB/gs5+OFRSn86W1jbTAeluhhLuaoS2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624533112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiQSIzTqNuuROaf46XnDxXxQjYvmZnBN/IlZD6ylNL0=;
        b=44yWJ4RWzdNY0roAdVZ5iqYhKzko9bLfDS7U4uei7LkkwqYmICb4NUhfZfT9Z9TsfzWBxj
        E1tdyJGrEVygHTAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 5/6] printk: convert @syslog_lock to mutex
Date:   Thu, 24 Jun 2021 13:17:47 +0206
Message-Id: <20210624111148.5190-6-john.ogness@linutronix.de>
In-Reply-To: <20210624111148.5190-1-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@syslog_lock was a raw_spin_lock to simplify the transition of
removing @logbuf_lock and the safe buffers. With that transition
complete, and since all uses of @syslog_lock are within sleepable
contexts, @syslog_lock can become a mutex.

Note that until now register_console() would disable interrupts
using irqsave, which implies that it may be called with interrupts
disabled. And indeed, there is one possible call chain on parisc
where this happens:

handle_interruption(code=1) /* High-priority machine check (HPMC) */
  pdc_console_restart()
    pdc_console_init_force()
      register_console()

However, register_console() calls console_lock(), which might sleep.
So it has never been allowed to call register_console() from an
atomic context and the above call chain is a bug.

Note that the removal of read_syslog_seq_irq() is slightly changing
the behavior of SYSLOG_ACTION_READ by testing against a possibly
outdated @seq value. However, the value of @seq could have changed
after the test, so it is not a new window. A follow-up commit closes
this window.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 495520b7369c..90954cb5a0ab 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -356,7 +356,7 @@ enum log_flags {
 };
 
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
-static DEFINE_RAW_SPINLOCK(syslog_lock);
+static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -1497,9 +1497,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		raw_spin_lock_irq(&syslog_lock);
+		mutex_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
-			raw_spin_unlock_irq(&syslog_lock);
+			mutex_unlock(&syslog_lock);
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1528,7 +1528,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
-		raw_spin_unlock_irq(&syslog_lock);
+		mutex_unlock(&syslog_lock);
 
 		if (!n)
 			break;
@@ -1592,9 +1592,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 
 	if (clear) {
-		raw_spin_lock_irq(&syslog_lock);
+		mutex_lock(&syslog_lock);
 		latched_seq_write(&clear_seq, seq);
-		raw_spin_unlock_irq(&syslog_lock);
+		mutex_unlock(&syslog_lock);
 	}
 
 	kfree(text);
@@ -1603,21 +1603,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	raw_spin_lock_irq(&syslog_lock);
+	mutex_lock(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
-	raw_spin_unlock_irq(&syslog_lock);
-}
-
-/* Return a consistent copy of @syslog_seq. */
-static u64 read_syslog_seq_irq(void)
-{
-	u64 seq;
-
-	raw_spin_lock_irq(&syslog_lock);
-	seq = syslog_seq;
-	raw_spin_unlock_irq(&syslog_lock);
-
-	return seq;
+	mutex_unlock(&syslog_lock);
 }
 
 int do_syslog(int type, char __user *buf, int len, int source)
@@ -1626,6 +1614,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
+	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1644,8 +1633,12 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		if (!access_ok(buf, len))
 			return -EFAULT;
 
-		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, read_syslog_seq_irq(), NULL));
+		/* Get a consistent copy of @syslog_seq. */
+		mutex_lock(&syslog_lock);
+		seq = syslog_seq;
+		mutex_unlock(&syslog_lock);
+
+		error = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1693,10 +1686,10 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		raw_spin_lock_irq(&syslog_lock);
+		mutex_lock(&syslog_lock);
 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
 			/* No unread messages. */
-			raw_spin_unlock_irq(&syslog_lock);
+			mutex_unlock(&syslog_lock);
 			return 0;
 		}
 		if (info.seq != syslog_seq) {
@@ -1714,7 +1707,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
 			unsigned int line_count;
-			u64 seq;
 
 			prb_for_each_info(syslog_seq, prb, seq, &info,
 					  &line_count) {
@@ -1724,7 +1716,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
-		raw_spin_unlock_irq(&syslog_lock);
+		mutex_unlock(&syslog_lock);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -2929,7 +2921,6 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
  */
 void register_console(struct console *newcon)
 {
-	unsigned long flags;
 	struct console *bcon = NULL;
 	int err;
 
@@ -3034,9 +3025,9 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 
 		/* Get a consistent copy of @syslog_seq. */
-		raw_spin_lock_irqsave(&syslog_lock, flags);
+		mutex_lock(&syslog_lock);
 		console_seq = syslog_seq;
-		raw_spin_unlock_irqrestore(&syslog_lock, flags);
+		mutex_unlock(&syslog_lock);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.20.1

