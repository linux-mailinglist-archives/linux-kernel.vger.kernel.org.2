Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719A93B2D60
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhFXLOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:14:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhFXLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:14:12 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624533112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+YEXzJlGfG0hu3d0X2DfAVFyIJLvZiTDn2Uh6d5r70=;
        b=Jlu0jTJtfR592f90KKjCJZ/7l6QnnoTzS2nosqX85JewLe8Tb120FxBo84qqFwHHmFr3T9
        eXlsO4mIkctDRAs3NzvmWQ0a/2+/KxbjeD3iKCyJz7ZOWXRoAZ/hp7TgOfqx4aEoV3oP07
        yukAt6DHtbZT07sAjEUECzyXFM/I/fdIuJSOzIao69HE/ddVbWdoGHyk3J3FHb20Wh6ST+
        3QpT2w6e5bd7FNmyRb3wWgbwGfODwCJH18Qyv/v1p3SvUlh+r/rYpZXK2h9H/8K2gw45AU
        0sVHR1nwl/1lOmhyto9MuooFxb80NTRcOtoFeT3Oa8pmq6yDkitavjdABY8CtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624533112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+YEXzJlGfG0hu3d0X2DfAVFyIJLvZiTDn2Uh6d5r70=;
        b=0ZbYGpFfO+4cfCc9g02bGA2DWWs5EplFt4aNq+AHHbTLR6UEVa45TceufUsm2+iseDpSAx
        PTIUXt9HjY0RVmDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 6/6] printk: syslog: close window between wait and read
Date:   Thu, 24 Jun 2021 13:17:48 +0206
Message-Id: <20210624111148.5190-7-john.ogness@linutronix.de>
In-Reply-To: <20210624111148.5190-1-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syslog's SYSLOG_ACTION_READ is supposed to block until the next
syslog record can be read, and then it should read that record.
However, because @syslog_lock is not held between waking up and
reading the record, another reader could read the record first,
thus causing SYSLOG_ACTION_READ to return with a value of 0, never
having read _anything_.

By holding @syslog_lock between waking up and reading, it can be
guaranteed that SYSLOG_ACTION_READ blocks until it successfully
reads a syslog record (or a real error occurs).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 50 +++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 90954cb5a0ab..4737804d6c6d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1486,6 +1486,7 @@ static int syslog_print(char __user *buf, int size)
 	struct printk_record r;
 	char *text;
 	int len = 0;
+	u64 seq;
 
 	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
@@ -1493,11 +1494,38 @@ static int syslog_print(char __user *buf, int size)
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
-	while (size > 0) {
+	/* Get a consistent copy of @syslog_seq. */
+	mutex_lock(&syslog_lock);
+	seq = syslog_seq;
+	mutex_unlock(&syslog_lock);
+
+	/* Wait for the @syslog_seq record to be available. */
+	for (;;) {
+		len = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
+		if (len)
+			goto out;
+
+		/*
+		 * @syslog_seq may have changed while waiting. If so, wait
+		 * for the new @syslog_seq record.
+		 */
+
+		mutex_lock(&syslog_lock);
+		if (syslog_seq == seq)
+			break;
+		seq = syslog_seq;
+		mutex_unlock(&syslog_lock);
+	}
+
+	/*
+	 * @syslog_lock is held when entering the read loop to prevent
+	 * another reader from modifying @syslog_seq.
+	 */
+
+	for (;;) {
 		size_t n;
 		size_t skip;
 
-		mutex_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
 			mutex_unlock(&syslog_lock);
 			break;
@@ -1542,8 +1570,13 @@ static int syslog_print(char __user *buf, int size)
 		len += n;
 		size -= n;
 		buf += n;
-	}
 
+		if (!size)
+			break;
+
+		mutex_lock(&syslog_lock);
+	}
+out:
 	kfree(text);
 	return len;
 }
@@ -1614,7 +1647,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
-	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1632,15 +1664,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
-
-		/* Get a consistent copy of @syslog_seq. */
-		mutex_lock(&syslog_lock);
-		seq = syslog_seq;
-		mutex_unlock(&syslog_lock);
-
-		error = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
-		if (error)
-			return error;
 		error = syslog_print(buf, len);
 		break;
 	/* Read/clear last kernel messages */
@@ -1707,6 +1730,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
 			unsigned int line_count;
+			u64 seq;
 
 			prb_for_each_info(syslog_seq, prb, seq, &info,
 					  &line_count) {
-- 
2.20.1

