Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1917334ECAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhC3PgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhC3Pf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:27 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617118516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPl+s+JpKl89Q4u3IDJDwNQFwzL5H5hBnoVBUHnRpbA=;
        b=1jb1cXqxbsBUQOZHYPAbpVa75YIMSO4/kd3m3n84w/GO91vOu8rMrdkEMy8yam+JMbn6av
        ZIgeG2grXn47RAJGkeDxVXbfclotdmooLWmT+q5aWcTFHPNxNNV01n/f9cktehDcLJmwN1
        GVPzNY+cOrIO+pBPSSuMRXdnGFJUzrn7N8JwAIUpvkKlLKOGFdEQ+odkPD0KHdJyW1qN6m
        y6D9uyOpEkOvpKQHfe+g7RBw22nFs0N/ejHGi0PqH7/GCb60yM39yPQIYm5p2nztateO0l
        qpozV7taIgubMj5QnISOkhPyi4sAi3DOhD2J57hTTut7XPPWLjrHkAE0H0yWUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617118516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPl+s+JpKl89Q4u3IDJDwNQFwzL5H5hBnoVBUHnRpbA=;
        b=829kVO9RYfHlI7YMVeF02yY2iFoG8AO0WU6BSher+temKlOCNH0/evh9LIpxUegODsyKtG
        akqjfEKPlJtBrgAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 4/5] printk: convert @syslog_lock to mutex
Date:   Tue, 30 Mar 2021 17:35:11 +0200
Message-Id: <20210330153512.1182-5-john.ogness@linutronix.de>
In-Reply-To: <20210330153512.1182-1-john.ogness@linutronix.de>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
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

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Note: The removal of read_syslog_seq_irq() is technically a small
       step backwards. But the follow-up patch moves forward again
       and closes a window that existed with read_syslog_seq_irq()
       and @syslog_lock as a spin_lock.

 kernel/printk/printk.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f090d6a1b39e..b771aae46445 100644
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
@@ -2925,7 +2917,6 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
  */
 void register_console(struct console *newcon)
 {
-	unsigned long flags;
 	struct console *bcon = NULL;
 	int err;
 
@@ -3030,9 +3021,9 @@ void register_console(struct console *newcon)
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

