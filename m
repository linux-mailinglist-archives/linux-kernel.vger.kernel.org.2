Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7832BC78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359205AbhCCN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839763AbhCCKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3FC08ED38
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:33 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZEnIipZrGhXuuERrPSOiy5gvUiRtoMxjnVriftYR3w=;
        b=mcNOofMxvnmkP/be2WTK4iDdTJ2+kvyq7lsoNMhZJDefaNYsdfy+L6SZRqA4rv2q00q6b6
        fNM5iPUMqB76OGcL3MMiJU50bZLjXy+hmxgslwgPGALhO9WYuLLUVDZRXfXNSxUbL+26TK
        ZvymOTxm6+m52XPjfef4zRjF8ZNYt13c483vZaObrqwd8oOyk5QU+za2l7uKtN2TRotFc6
        jeD3r5Gb6bd6cYV89GIJiR5fEsfScYhLa8olNbtEWss9LZA7j4dpWIij5kRAKTyGZsHEM5
        n16/eqfim3LCf+bcKSiGK8owy9XQoS1fbvAcjVssYuXbUIc5QwE5OPOPy9dIwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZEnIipZrGhXuuERrPSOiy5gvUiRtoMxjnVriftYR3w=;
        b=KzQSoc1NwocMAWlBlJ9aYf1M6HAXummq8ykwY5dtjPzkGV9Jlm91g7gkHwsIHuJGfemJxu
        z69wGn/l8WKTaQAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH next v4 05/15] printk: refactor kmsg_dump_get_buffer()
Date:   Wed,  3 Mar 2021 11:15:18 +0100
Message-Id: <20210303101528.29901-6-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_get_buffer() requires nearly the same logic as
syslog_print_all(), but uses different variable names and
does not make use of the ringbuffer loop macros. Modify
kmsg_dump_get_buffer() so that the implementation is as similar
to syslog_print_all() as possible.

A follow-up commit will move this common logic into a
separate helper function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kmsg_dump.h |  2 +-
 kernel/printk/printk.c    | 62 +++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index ae38035f1dca..070c994ff19f 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -62,7 +62,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
 			char *line, size_t size, size_t *len);
 
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
-			  char *buf, size_t size, size_t *len);
+			  char *buf, size_t size, size_t *len_out);
 
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 77ae2704e979..ed678d84dc51 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3410,7 +3410,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * @syslog: include the "<4>" prefixes
  * @buf: buffer to copy the line to
  * @size: maximum size of the buffer
- * @len: length of line placed into buffer
+ * @len_out: length of line placed into buffer
  *
  * Start at the end of the kmsg buffer and fill the provided buffer
  * with as many of the *youngest* kmsg records that fit into it.
@@ -3424,7 +3424,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * read.
  */
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
-			  char *buf, size_t size, size_t *len)
+			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
 	unsigned int line_count;
@@ -3432,12 +3432,10 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	unsigned long flags;
 	u64 seq;
 	u64 next_seq;
-	size_t l = 0;
+	size_t len = 0;
 	bool ret = false;
 	bool time = printk_time;
 
-	prb_rec_init_rd(&r, &info, buf, size);
-
 	if (!dumper->active || !buf || !size)
 		goto out;
 
@@ -3455,48 +3453,54 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 	}
 
-	/* calculate length of entire buffer */
-	seq = dumper->cur_seq;
-	while (prb_read_valid_info(prb, seq, &info, &line_count)) {
-		if (r.info->seq >= dumper->next_seq)
+	/*
+	 * Find first record that fits, including all following records,
+	 * into the user-provided buffer for this dump.
+	 */
+
+	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
+		if (info.seq >= dumper->next_seq)
 			break;
-		l += get_record_print_text_size(&info, line_count, syslog, time);
-		seq = r.info->seq + 1;
+		len += get_record_print_text_size(&info, line_count, syslog, time);
 	}
 
-	/* move first record forward until length fits into the buffer */
-	seq = dumper->cur_seq;
-	while (l >= size && prb_read_valid_info(prb, seq,
-						&info, &line_count)) {
-		if (r.info->seq >= dumper->next_seq)
+	/*
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is the best effort
+	 * that prevents an infinite loop.
+	 */
+	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
+		if (len < size || info.seq >= dumper->next_seq)
 			break;
-		l -= get_record_print_text_size(&info, line_count, syslog, time);
-		seq = r.info->seq + 1;
+		len -= get_record_print_text_size(&info, line_count, syslog, time);
 	}
 
-	/* last message in next interation */
+	/*
+	 * Next kmsg_dump_get_buffer() invocation will dump block of
+	 * older records stored right before this one.
+	 */
 	next_seq = seq;
 
-	/* actually read text into the buffer now */
-	l = 0;
-	while (prb_read_valid(prb, seq, &r)) {
+	prb_rec_init_rd(&r, &info, buf, size);
+
+	len = 0;
+	prb_for_each_record(seq, prb, seq, &r) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
 
-		l += record_print_text(&r, syslog, time);
+		len += record_print_text(&r, syslog, time);
 
-		/* adjust record to store to remaining buffer space */
-		prb_rec_init_rd(&r, &info, buf + l, size - l);
-
-		seq = r.info->seq + 1;
+		/* Adjust record to store to remaining buffer space. */
+		prb_rec_init_rd(&r, &info, buf + len, size - len);
 	}
 
 	dumper->next_seq = next_seq;
 	ret = true;
 	logbuf_unlock_irqrestore(flags);
 out:
-	if (len)
-		*len = l;
+	if (len_out)
+		*len_out = len;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
-- 
2.20.1

