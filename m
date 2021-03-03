Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7024B32BCA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443722AbhCCOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842950AbhCCKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFD7C08ED45
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OHghGQm+bwa08tgJMWX7wwmvP173TujWasH9A+HblY=;
        b=sGB80es9+G1yBPXZYiC47rF17kGdVsF2QbG/+5zOdpwgziq7UARKlYHmwn2QICAb7WO+Wn
        BfpoJYTUIbiZmyyEt+Oth+6cjPOOtg4locYHurrdwEb2dTaTH+eHnLSB87Bva/D0gAFH01
        QW6pTGojJtRIO2EvNL6Oj9Y+2xKCLKVWiRkRniWrTKWo7hQefacTkyXK2/6HovE3FUM38l
        VMrwCfJUQvSOxpThx7ECwwQ57WrQxcUxVJq3CQKm4IV1BQ0c1PJvULuQaa8UyguQ/Qgg/U
        vN32o/jJ8mcHg5vSU76gYtjHCy+ShN6SDPWcl0bA1mDDtCmd/sSrbnvsysnGsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OHghGQm+bwa08tgJMWX7wwmvP173TujWasH9A+HblY=;
        b=WJqua8/aDjqXmk45F6bqKp1SHsMyO+Ablc7G8OveFRNZqt2L7yOqM+T6Q1lPeH4EyjrL2b
        HviLuL/oQqElh3BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 06/15] printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
Date:   Wed,  3 Mar 2021 11:15:19 +0100
Message-Id: <20210303101528.29901-7-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for finding records to fit into a buffer is the same for
kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
function find_first_fitting_seq() to handle this logic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 87 ++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ed678d84dc51..9a5f9ccc46ea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1421,6 +1421,50 @@ static size_t get_record_print_text_size(struct printk_info *info,
 	return ((prefix_len * line_count) + info->text_len + 1);
 }
 
+/*
+ * Beginning with @start_seq, find the first record where it and all following
+ * records up to (but not including) @max_seq fit into @size.
+ *
+ * @max_seq is simply an upper bound and does not need to exist. If the caller
+ * does not require an upper bound, -1 can be used for @max_seq.
+ */
+static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
+				  bool syslog, bool time)
+{
+	struct printk_info info;
+	unsigned int line_count;
+	size_t len = 0;
+	u64 seq;
+
+	/* Determine the size of the records up to @max_seq. */
+	prb_for_each_info(start_seq, prb, seq, &info, &line_count) {
+		if (info.seq >= max_seq)
+			break;
+		len += get_record_print_text_size(&info, line_count, syslog, time);
+	}
+
+	/*
+	 * Adjust the upper bound for the next loop to avoid subtracting
+	 * lengths that were never added.
+	 */
+	if (seq < max_seq)
+		max_seq = seq;
+
+	/*
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is a best effort
+	 * that prevents an infinite loop that could occur with a retry.
+	 */
+	prb_for_each_info(start_seq, prb, seq, &info, &line_count) {
+		if (len <= size || info.seq >= max_seq)
+			break;
+		len -= get_record_print_text_size(&info, line_count, syslog, time);
+	}
+
+	return seq;
+}
+
 static int syslog_print(char __user *buf, int size)
 {
 	struct printk_info info;
@@ -1492,9 +1536,7 @@ static int syslog_print(char __user *buf, int size)
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
-	u64 max_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1510,21 +1552,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
-		len += get_record_print_text_size(&info, line_count, true, time);
-
-	/*
-	 * Set an upper bound for the next loop to avoid subtracting lengths
-	 * that were never added.
-	 */
-	max_seq = seq;
-
-	/* move first record forward until length fits into the buffer */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
-		if (len <= size || info.seq >= max_seq)
-			break;
-		len -= get_record_print_text_size(&info, line_count, true, time);
-	}
+	seq = find_first_fitting_seq(clear_seq, -1, size, true, time);
 
 	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
 
@@ -3427,7 +3455,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
 	unsigned long flags;
 	u64 seq;
@@ -3455,26 +3482,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	/*
 	 * Find first record that fits, including all following records,
-	 * into the user-provided buffer for this dump.
+	 * into the user-provided buffer for this dump. Pass in size-1
+	 * because this function (by way of record_print_text()) will
+	 * not write more than size-1 bytes of text into @buf.
 	 */
-
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (info.seq >= dumper->next_seq)
-			break;
-		len += get_record_print_text_size(&info, line_count, syslog, time);
-	}
-
-	/*
-	 * Move first record forward until length fits into the buffer. Ignore
-	 * newest messages that were not counted in the above cycle. Messages
-	 * might appear and get lost in the meantime. This is the best effort
-	 * that prevents an infinite loop.
-	 */
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (len < size || info.seq >= dumper->next_seq)
-			break;
-		len -= get_record_print_text_size(&info, line_count, syslog, time);
-	}
+	seq = find_first_fitting_seq(dumper->cur_seq, dumper->next_seq,
+				     size - 1, syslog, time);
 
 	/*
 	 * Next kmsg_dump_get_buffer() invocation will dump block of
-- 
2.20.1

