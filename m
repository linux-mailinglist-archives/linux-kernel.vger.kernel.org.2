Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E1F311486
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhBEWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhBEO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EF8C06121D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:35:34 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612534648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N8KO666twl5u14ugBpv1szWkDqruvHS7Y9dzUpQGTP0=;
        b=1C8T2UOISLEGbuRRwRe80ACDHSF6XD5mmn3jGC5agkBB4BU9JDCF8kSxvS0YYVnuv/0F5g
        J3MPl/cggNCaQwudslAkI47jxXW5C/HXDpCkuC5bUBl9OtmnAPUCJRyVcvTW7iYlnqUPOf
        QzYRsmIvqQJkCXPmaRV58MCMINNAf3w6B9jSIMmkqPZQcwWcGQDWTPzm5cORdGZaRNUD41
        IRFczYfhqjuaNQ0GHMifr9mIJZ8YLI5L5SsAolskc0owrQ7NC8QJmSO/hJjKpBeVjIYRvM
        3cKmkfG/y1Iz2HPj39b219SJopl8uOG0Whe9t8Id8hu1+gErit/IIFC+JqMIyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612534648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N8KO666twl5u14ugBpv1szWkDqruvHS7Y9dzUpQGTP0=;
        b=BeUbJQ4GcI499wGWyYva+ayki6NdCXPRbBtgj6+U23l8BefpBbELHs3gjr+lPu++CooJOn
        xaubbY2VCr/mfqDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: [PATCH] printk: avoid prb_first_valid_seq() where possible
Date:   Fri,  5 Feb 2021 15:23:28 +0106
Message-Id: <20210205141728.18117-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If message sizes average larger than expected (more than 32
characters), the data_ring will wrap before the desc_ring. Once the
data_ring wraps, it will start invalidating descriptors. These
invalid descriptors hang around until they are eventually recycled
when the desc_ring wraps. Readers do not care about invalid
descriptors, but they still need to iterate past them. If the
average message size is much larger than 32 characters, then there
will be many invalid descriptors preceding the valid descriptors.

The function prb_first_valid_seq() always begins at the oldest
descriptor and searches for the first valid descriptor. This can
be rather expensive for the above scenario. And, in fact, because
of its heavy usage in /dev/kmsg, there have been reports of long
delays and even RCU stalls.

For code that does not need to search from the oldest record,
replace prb_first_valid_seq() usage with prb_read_valid_*()
functions, which provide a start sequence number to search from.

Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: J. Avila <elavila@google.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 patch against next-20210205

 kernel/printk/printk.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a95c688621f..035aae771ea1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -735,9 +735,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_valid_seq(prb)) {
+	if (r->info->seq != user->seq) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_valid_seq(prb);
+		user->seq = r->info->seq;
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -812,6 +812,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 {
 	struct devkmsg_user *user = file->private_data;
+	struct printk_info info;
 	__poll_t ret = 0;
 
 	if (!user)
@@ -820,9 +821,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (prb_read_valid(prb, user->seq, NULL)) {
+	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_valid_seq(prb))
+		if (info.seq != user->seq)
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -1559,6 +1560,7 @@ static void syslog_clear(void)
 
 int do_syslog(int type, char __user *buf, int len, int source)
 {
+	struct printk_info info;
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
@@ -1629,9 +1631,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
-		if (syslog_seq < prb_first_valid_seq(prb)) {
-			/* messages are gone, move to first one */
-			syslog_seq = prb_first_valid_seq(prb);
+		if (prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
+			if (info.seq != syslog_seq) {
+				/* messages are gone, move to first one */
+				syslog_seq = info.seq;
+				syslog_partial = 0;
+			}
+		} else {
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -1643,7 +1649,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			error = prb_next_seq(prb) - syslog_seq;
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
-			struct printk_info info;
 			unsigned int line_count;
 			u64 seq;
 
@@ -3429,9 +3434,11 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
-		/* messages are gone, move to first available one */
-		dumper->cur_seq = prb_first_valid_seq(prb);
+	if (prb_read_valid_info(prb, dumper->cur_seq, &info, NULL)) {
+		if (info.seq != dumper->cur_seq) {
+			/* messages are gone, move to first available one */
+			dumper->cur_seq = info.seq;
+		}
 	}
 
 	/* last entry */
-- 
2.20.1

