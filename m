Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84C431E82E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhBRJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhBRITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA93C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:18:22 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzepJ7AJzP3TpbmyWwXwHCMWX+jwQ47rRBSE79MvDSk=;
        b=INikAX3EOfaEFmuaQfOf/yktpeimRZr2+2ZpRufjzYzfvhOIHa9OkIYuUvd5gXEvBsFKYH
        WFiW2obwewGmVjm0JxBIxSP4ESkhB5lMLzm7/VyoCDWqbe3QRODHze20Jv6OK2xQuQwfZq
        Pez470Sgzser4aopiIR7euddEbajNFsh3OV+qj+L0zGVhrH+iELdz+SvO1yLklRRHPX+PH
        KYDIz3ILZ/iRmns8UXdvo191HvFJP4b5dutTQJKU1O2XlRuATSTZGIHWScgePjfhaHybbj
        zm1ysQ4hjUOX/0zXad3/qKhKFWjGqnQ0iLTI/qI81Oe1FL8kn0jPZwZied2muA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzepJ7AJzP3TpbmyWwXwHCMWX+jwQ47rRBSE79MvDSk=;
        b=YtTthLsQtMt4gA9+N0UZlaswgGFkEUYJ//IP/mh8hlmoV3DrrsmM+BNEbB94AwF7exIX2k
        l01pDR5ABBtVWMCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 04/14] printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
Date:   Thu, 18 Feb 2021 09:18:07 +0100
Message-Id: <20210218081817.28849-5-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for finding records to fit into a buffer is the same for
kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
function find_first_fitting_seq() to handle this logic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 87 ++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b4f72b5f70b9..d6f93ebd7bd0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1422,6 +1422,50 @@ static size_t get_record_print_text_size(struct printk_info *info,
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
@@ -1493,9 +1537,7 @@ static int syslog_print(char __user *buf, int size)
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
-	u64 max_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1511,21 +1553,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
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
 
@@ -3423,7 +3451,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
 	unsigned long flags;
 	u64 seq;
@@ -3451,26 +3478,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
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

