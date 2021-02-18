Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2448931E831
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhBRJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhBRITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABCC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:18:24 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVHqdRKV1HFfAYlKnYMcum18ynWIS9td9yMlLmcYJNk=;
        b=Zr6PEpsJ6F6IbUOnyjLsT4wZgYefwHgKaWkoRo+KkOwxmnj2J5XaPQ35VnrQanVEnjp4jZ
        2Bgoqk0KR6Gh3MpkDlTsvuuyySp2DC04mODILuUkFocmHXH2o5l9hsiGUegTr70FRn5C7Q
        WwCJ/jxiI+7wIQ8E5RrBGhqK0XgjHVNGx1+QpqXDi74ChfwFRzlqg13LXC+pRQ6tyl5oMc
        Q5OGOlXd73B7Tv9Cxucd33FqI/uvpht3S9vBp14CZ1rFPWHwtxnx2PzfvSij9nkLpF62Y2
        Z0oCE6Fmm5ru7DnE4uJRm9akBONXWkDcnLCuwteeqo6a/vizspXDwN9pxdBLMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVHqdRKV1HFfAYlKnYMcum18ynWIS9td9yMlLmcYJNk=;
        b=YqsYiv738tAQTn/evil7INUktmg/jXbV7AzUL/8LpWqibdcyfPDgWl3UfIm23KdnrRhBIy
        rocTqIpItppxuoAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 05/14] printk: introduce CONSOLE_LOG_MAX for improved multi-line support
Date:   Thu, 18 Feb 2021 09:18:08 +0100
Message-Id: <20210218081817.28849-6-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
that is allowed to be printed to the console for a single record.

Rather than setting CONSOLE_LOG_MAX to "LOG_LINE_MAX + PREFIX_MAX"
(1024), increase it to 4096. With a larger buffer size, multi-line
records that are nearly LOG_LINE_MAX in length will have a better
chance of being fully printed. (When formatting a record for the
console, each line of a multi-line record is prepended with a copy
of the prefix.)

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d6f93ebd7bd0..f79e7515b5f1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -410,8 +410,13 @@ static u64 clear_seq;
 #else
 #define PREFIX_MAX		32
 #endif
+
+/* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
+/* the maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		4096
+
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
@@ -1473,11 +1478,11 @@ static int syslog_print(char __user *buf, int size)
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
@@ -1543,7 +1548,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1555,7 +1560,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 */
 	seq = find_first_fitting_seq(clear_seq, -1, size, true, time);
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -2188,8 +2193,7 @@ EXPORT_SYMBOL(printk);
 
 #else /* CONFIG_PRINTK */
 
-#define LOG_LINE_MAX		0
-#define PREFIX_MAX		0
+#define CONSOLE_LOG_MAX		0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
@@ -2500,7 +2504,7 @@ static inline int can_use_console(void)
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

