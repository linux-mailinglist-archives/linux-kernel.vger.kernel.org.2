Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1C3257A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBYU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhBYU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:26:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A7C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OHghGQm+bwa08tgJMWX7wwmvP173TujWasH9A+HblY=;
        b=MZfT4swAKiGD/+cI/8ZotW1/qbj5N/WQ+1+7kaJF6YffEiotlh/f+0D8q0y/gKZzj3b5TR
        gi4n1D8kTWAfi1r+BSRCijf1ZI1330zquqjOHc8wainz+m0RMR/HCoLb5qaJ6G0Y2ZtmYt
        2k+ry+XWq7FZkVPIfXms45DWYC7RP5v0DWpYg5RRmidlMIanT2SMLqePjYGBkbmK6qHsES
        62ztlvlOLV+/6nZUEzjlm2rItU/UTPpKq5W7clD+l15+7w85M2D+EWPhy1GofqshYQ5Jhh
        fFrCzR23FHg8SJVyOomX4FkY8y6dCEOC5qQAojcUSVXYgbLlbBZpxrTI46rSJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OHghGQm+bwa08tgJMWX7wwmvP173TujWasH9A+HblY=;
        b=dNz0YnsTvDly+VBlr4INROyFtVVT3iUGN/rUSTqKMJ0iN/WP1110EWZiwSKObTpiiiWnRc
        J/HrHFoeiu8BZUBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 06/15] printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
Date:   Thu, 25 Feb 2021 21:24:29 +0100
Message-Id: <20210225202438.28985-7-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
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

