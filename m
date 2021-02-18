Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1531E835
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhBRJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:31:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50568 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhBRITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:21 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trsmi8VaLmNxCz8CGmqMpr6EsxkwxlnSJuVu91KogyI=;
        b=j+SEJPRwN9WGhDDJSGq5at1dgCY87qUmN7yI44JIWhA5hJ+SF9NY0a0XbfXfAoE1ZGvUAb
        bQcjcfBz7xBsX3ECD7fDvD7EWq7f5U3aVVJLDROYk970CcXp3auoEK0nnkfCYDjFa2RCfT
        NOJva7NF5eZaKQWukLHuSH+fqzswni4gi9T4ShCAi15At7lJw0vbKStJqJvNMEFRKas0l7
        HP/5MJqvsvveeauncFAgozsNa5CFRCmOyd/fOMQTXNgzRdfc85ufREteyz58ffZq36esq6
        mC6Da7jjUVu766seosfrlZ+qJnxJPX5p7b8H5rEExhhw05aUlvf9yMGEIIcILQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trsmi8VaLmNxCz8CGmqMpr6EsxkwxlnSJuVu91KogyI=;
        b=73C6JO1Q8YZ0Vi9oz95r4lNZ0eU1pwCilaRiT8VrIeqiceeiDUkH2/WwcenOc9PZ5Rsq9U
        8yjehA2i4E0vFSBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 06/14] printk: use seqcount_latch for clear_seq
Date:   Thu, 18 Feb 2021 09:18:09 +0100
Message-Id: <20210218081817.28849-7-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
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
index f79e7515b5f1..a71e0d41ccb5 100644
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
@@ -802,7 +840,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = clear_seq;
+		user->seq = latched_seq_read_nolock(&clear_seq);
 		break;
 	case SEEK_END:
 		/* after the last record */
@@ -961,6 +999,9 @@ void log_buf_vmcoreinfo_setup(void)
 
 	VMCOREINFO_SIZE(atomic_long_t);
 	VMCOREINFO_TYPE_OFFSET(atomic_long_t, counter);
+
+	VMCOREINFO_STRUCT_SIZE(latched_seq);
+	VMCOREINFO_OFFSET(latched_seq, val);
 }
 #endif
 
@@ -1558,7 +1599,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	seq = find_first_fitting_seq(clear_seq, -1, size, true, time);
+	seq = find_first_fitting_seq(latched_seq_read_nolock(&clear_seq), -1,
+				     size, true, time);
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
@@ -1585,7 +1627,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 
 	if (clear)
-		clear_seq = seq;
+		latched_seq_write(&clear_seq, seq);
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1595,7 +1637,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
-	clear_seq = prb_next_seq(prb);
+	latched_seq_write(&clear_seq, prb_next_seq(prb));
 	logbuf_unlock_irq();
 }
 
@@ -3332,7 +3374,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		dumper->active = true;
 
 		logbuf_lock_irqsave(flags);
-		dumper->cur_seq = clear_seq;
+		dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 		dumper->next_seq = prb_next_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 
@@ -3530,7 +3572,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = clear_seq;
+	dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
 	dumper->next_seq = prb_next_seq(prb);
 }
 
-- 
2.20.1

