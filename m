Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C332579F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhBYU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhBYU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:26:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80502C061793
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5v23+mTPe8CE0ELwPBYB3GYiYYxoJyxUD2IwTlh2Rlk=;
        b=ZDNXH2e8oGH5ULCH58tDdIHfJgycEfVIzUp3fOGxsq5AuLLI08HlmGZx9J9WCYHhIwLSOX
        WsQVusKnqhg9TCNhE2Rs7YORRRgKzKUbLm7O7a1KdL/JRShJKqcQMC2yJdeSS7NlgiM3Bn
        +iqV4y8jFDsWod70M2hvh4dmZApxyIQ9k6VNuIXdA85uyMMTjzGrZcABAr+sUrZxKyBqw/
        p4RqVIGUK2vsG5Ofg735SXIq9UiasV+1xDowJzGlj99hzGKkYaWv+T9cWK30xSB9i1eJt5
        iaElJN9O4/ObrDmqLZU+vNkPlPY3mDWc/Bl0Wk651y46c0j7lCU6/vcUlMIDAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5v23+mTPe8CE0ELwPBYB3GYiYYxoJyxUD2IwTlh2Rlk=;
        b=+du/qDOqrSgCFQ+zFOQuvRrzi5muEiOhjkJRxWXFCqiF3Yw8vNjgk8xdwi/IXiHTGq11fN
        ANuvUo4297h+oUBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 10/15] printk: add syslog_lock
Date:   Thu, 25 Feb 2021 21:24:33 +0100
Message-Id: <20210225202438.28985-11-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variables @syslog_seq, @syslog_partial, @syslog_time
and write access to @clear_seq are protected by @logbuf_lock.
Once @logbuf_lock is removed, these variables will need their
own synchronization method. Introduce @syslog_lock for this
purpose.

@syslog_lock is a raw_spin_lock for now. This simplifies the
transition to removing @logbuf_lock. Once @logbuf_lock and the
safe buffers are removed, @syslog_lock can change to spin_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82d89eec4aac..c2ed7db8930b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -390,8 +390,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 		printk_safe_exit_irqrestore(flags);	\
 	} while (0)
 
+/* syslog_lock protects syslog_* variables and write access to clear_seq. */
+static DEFINE_RAW_SPINLOCK(syslog_lock);
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+/* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static size_t syslog_partial;
@@ -410,7 +414,7 @@ struct latched_seq {
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
- * access a valid value. Writers are synchronized by @logbuf_lock.
+ * access a valid value. Writers are synchronized by @syslog_lock.
  */
 static struct latched_seq clear_seq = {
 	.latch		= SEQCNT_LATCH_ZERO(clear_seq.latch),
@@ -470,7 +474,7 @@ bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
-/* Must be called under logbuf_lock. */
+/* Must be called under syslog_lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
@@ -1529,7 +1533,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t skip;
 
 		logbuf_lock_irq();
+		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
+			raw_spin_unlock(&syslog_lock);
 			logbuf_unlock_irq();
 			break;
 		}
@@ -1559,6 +1565,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
+		raw_spin_unlock(&syslog_lock);
 		logbuf_unlock_irq();
 
 		if (!n)
@@ -1625,8 +1632,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 	}
 
-	if (clear)
+	if (clear) {
+		raw_spin_lock(&syslog_lock);
 		latched_seq_write(&clear_seq, seq);
+		raw_spin_unlock(&syslog_lock);
+	}
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1636,10 +1646,24 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
+	raw_spin_lock(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
+	raw_spin_unlock(&syslog_lock);
 	logbuf_unlock_irq();
 }
 
+/* Return a consistent copy of @syslog_seq. */
+static u64 read_syslog_seq_irq(void)
+{
+	u64 seq;
+
+	raw_spin_lock_irq(&syslog_lock);
+	seq = syslog_seq;
+	raw_spin_unlock_irq(&syslog_lock);
+
+	return seq;
+}
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	struct printk_info info;
@@ -1663,8 +1687,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
+
 		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, syslog_seq, NULL));
+				prb_read_valid(prb, read_syslog_seq_irq(), NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1713,8 +1738,10 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
+		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
 			/* No unread messages. */
+			raw_spin_unlock(&syslog_lock);
 			logbuf_unlock_irq();
 			return 0;
 		}
@@ -1743,6 +1770,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
+		raw_spin_unlock(&syslog_lock);
 		logbuf_unlock_irq();
 		break;
 	/* Size of the log buffer */
@@ -2992,7 +3020,12 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+
+		/* Get a consistent copy of @syslog_seq. */
+		raw_spin_lock(&syslog_lock);
 		console_seq = syslog_seq;
+		raw_spin_unlock(&syslog_lock);
+
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
-- 
2.20.1

