Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520F32579D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhBYU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhBYU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:26:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF0AC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cpAde57ct/v1xBvVYYiQfJq5r5ZhmWUQp78o3xk9YQ=;
        b=EZFkXuBdJ9HmkbZuxoM3PT1NUVvYof+fpPzQ50/4ikWt9i6Fc6m50HY+wfrveDkVylYIbs
        dJWXjfQ1UR0ntY9uspyrJYEIMMQeKtktEiF9cMHr/ywg5gDRMdxWfd1Mx0veYtb0LB30/B
        /dedVsZOsSrCQ/eZu7gJwbKfDnOk+183BRZNpX3f1ci14SaZypAS2CPT3vJHjMMidQrZ9L
        xK/ioZ+ACrX84NomoKd5oGwq/0fJSKMUp2eHnTVkE4aRE8hsrPtUE/t7P4JHpdvKB14VJ5
        tWR0hfkIQSpkWeRoN5SPlJwes75XkYgEoECCQ3Odwn/gjpY6Y8Aq+oCXmjmzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cpAde57ct/v1xBvVYYiQfJq5r5ZhmWUQp78o3xk9YQ=;
        b=4+UPNpiR++1sJR+J8wiFZk7mYQhtbFeBewsM0itaLelH9In243kkAoPuzDWTt32zqzQrkw
        L6yQmCxQu0GcwDDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 08/15] printk: use seqcount_latch for clear_seq
Date:   Thu, 25 Feb 2021 21:24:31 +0100
Message-Id: <20210225202438.28985-9-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_rewind_nolock() locklessly reads @clear_seq. However,
this is not done atomically. Since @clear_seq is 64-bit, this
cannot be an atomic operation for all platforms. Therefore, use
a seqcount_latch to allow readers to always read a consistent
value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 58 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a60f709896dd..b78b85947312 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -402,8 +402,21 @@ static u64 console_seq;
 static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
 
-/* the next printk record to read after the last 'clear' command */
-static u64 clear_seq;
+struct latched_seq {
+	seqcount_latch_t	latch;
+	u64			val[2];
+};
+
+/*
+ * The next printk record to read after the last 'clear' command. There are
+ * two copies (updated with seqcount_latch) so that reads can locklessly
+ * access a valid value. Writers are synchronized by @logbuf_lock.
+ */
+static struct latched_seq clear_seq = {
+	.latch		= SEQCNT_LATCH_ZERO(clear_seq.latch),
+	.val[0]		= 0,
+	.val[1]		= 0,
+};
 
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
@@ -457,6 +470,31 @@ bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
+/* Must be called under logbuf_lock. */
+static void latched_seq_write(struct latched_seq *ls, u64 val)
+{
+	raw_write_seqcount_latch(&ls->latch);
+	ls->val[0] = val;
+	raw_write_seqcount_latch(&ls->latch);
+	ls->val[1] = val;
+}
+
+/* Can be called from any context. */
+static u64 latched_seq_read_nolock(struct latched_seq *ls)
+{
+	unsigned int seq;
+	unsigned int idx;
+	u64 val;
+
+	do {
+		seq = raw_read_seqcount_latch(&ls->latch);
+		idx = seq & 0x1;
+		val = ls->val[idx];
+	} while (read_seqcount_latch_retry(&ls->latch, seq));
+
+	return val;
+}
+
 /* Return log buffer address */
 char *log_buf_addr_get(void)
 {
@@ -801,7 +839,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = clear_seq;
+		user->seq = latched_seq_read_nolock(&clear_seq);
 		break;
 	case SEEK_END:
 		/* after the last record */
@@ -960,6 +998,9 @@ void log_buf_vmcoreinfo_setup(void)
 
 	VMCOREINFO_SIZE(atomic_long_t);
 	VMCOREINFO_TYPE_OFFSET(atomic_long_t, counter);
+
+	VMCOREINFO_STRUCT_SIZE(latched_seq);
+	VMCOREINFO_OFFSET(latched_seq, val);
 }
 #endif
 
@@ -1557,7 +1598,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	seq = find_first_fitting_seq(clear_seq, -1, size, true, time);
+	seq = find_first_fitting_seq(latched_seq_read_nolock(&clear_seq), -1,
+				     size, true, time);
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
@@ -1584,7 +1626,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 
 	if (clear)
-		clear_seq = seq;
+		latched_seq_write(&clear_seq, seq);
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1594,7 +1636,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
-	clear_seq = prb_next_seq(prb);
+	latched_seq_write(&clear_seq, prb_next_seq(prb));
 	logbuf_unlock_irq();
 }
 
@@ -3336,7 +3378,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		dumper->active = true;
 
 		logbuf_lock_irqsave(flags);
-		dumper->cur_seq = clear_seq;
+		dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 		dumper->next_seq = prb_next_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 
@@ -3534,7 +3576,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = clear_seq;
+	dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 	dumper->next_seq = prb_next_seq(prb);
 }
 
-- 
2.20.1

