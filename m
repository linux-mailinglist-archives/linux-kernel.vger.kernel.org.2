Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22C432BCA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442518AbhCCOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842947AbhCCKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C15FC08ED46
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODVNacDDQEYFgKxxLAM74yhhppM+KAkpAvj8JN2WxJg=;
        b=ys5kM6e3VxpcS/kuaNk/WsgDFMq7lR9SqdPHraIo2T0071xTBRry5J40X0+Cr5ti14ZbDr
        U0hyLDwrpEmkgnUejbYs4uls6K0aRjGG6yGvGlOp6wEUsu9CYVpJ00HKq7j8a+BZ53cd4g
        +4ykfmQ65r6pixx7qaHB1KlkpjJFuGFbHTdcWi9Qn5RYFKZ91G2fnEpEjI4wuMyhoI2xpx
        JkM96mAzqaRJAlmeh5YjO0sBc32F9EzAqkYQdYhtkc4iN8REdovs6Sz+pdUWwG6rkftQho
        MTx86K0Y9wKjjOal5hraD9P2Kf8Q2Rct1YMTJPmyjJPwue+Et55fGAM7clfzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODVNacDDQEYFgKxxLAM74yhhppM+KAkpAvj8JN2WxJg=;
        b=XmvVkw4kY3ekUTsOfbx2zkHTHNRNR3mdLSc/mx+hrshjUdbYxZaufAzmw8BDKK0IzEpZe1
        6AVJOUhwC+x/tcBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 07/15] printk: introduce CONSOLE_LOG_MAX
Date:   Wed,  3 Mar 2021 11:15:20 +0100
Message-Id: <20210303101528.29901-8-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
that is allowed to be printed to the console for a single record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a5f9ccc46ea..2c8873fa2f29 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -410,7 +410,12 @@ static u64 clear_seq;
 #else
 #define PREFIX_MAX		32
 #endif
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+
+/* the maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		1024
+
+/* the maximum size allowed to be reserved for a record */
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -1472,11 +1477,11 @@ static int syslog_print(char __user *buf, int size)
 	char *text;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	while (size > 0) {
 		size_t n;
@@ -1542,7 +1547,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1554,7 +1559,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 */
 	seq = find_first_fitting_seq(clear_seq, -1, size, true, time);
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -2187,8 +2192,7 @@ EXPORT_SYMBOL(printk);
 
 #else /* CONFIG_PRINTK */
 
-#define LOG_LINE_MAX		0
-#define PREFIX_MAX		0
+#define CONSOLE_LOG_MAX		0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
@@ -2506,7 +2510,7 @@ static inline int can_use_console(void)
 void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char text[CONSOLE_LOG_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
-- 
2.20.1

