Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB232579E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhBYU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhBYU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:26:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0EC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:24:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJfiUrEk/zreDyiSipPn1FUIU5EFgo3MLrkX7qP8wHE=;
        b=MU6+uQr4Gwcx0jFa7iJpx+tfUE+CobCOY5dYzGz+HR8dYq19KCdFCOIJ7o+N8PoFIL3+cD
        t9SKqgRKHwY6IxFfe9Gis4efrkEjm4XSItANvrTEN8r47WmL5ktcUKYQTsWpidAc1K8vrG
        594Yqd3bzVbrk7fArSp41abmA+muGpZha51B36RzEBL2ziay1RlaOciWX5Z8dhb9lzdacl
        bwMTXdox9/qtbEuKhmNPAmxeO3tksIAW+HZssFVGbBXcSXn5IhjoVF6fQr2Qt8aMPyNey7
        fqMydiiEGE8TTwClQU52K/vgGPQiRgGIQuI+8scs1f3K2xApmvEgd0bUIeHu9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJfiUrEk/zreDyiSipPn1FUIU5EFgo3MLrkX7qP8wHE=;
        b=jl/Pdo9qg8OmqEl/fUcmy2+63q9VzqYN4zwuu5+wzGeUakaitnBZYre1jx5e2H5An5nq+g
        5oag6ALXTYqOZFAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 07/15] printk: introduce CONSOLE_LOG_MAX for improved multi-line support
Date:   Thu, 25 Feb 2021 21:24:30 +0100
Message-Id: <20210225202438.28985-8-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a5f9ccc46ea..a60f709896dd 100644
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

