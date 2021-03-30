Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B132334ECAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhC3PgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhC3Pfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:30 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617118516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOY79cc5KL5/V5yJebiZ/YPWwhKUw2uTlDk5obc0710=;
        b=G5zcY61iN06RNhsGDS2vQ+RC/je+0ialRw+wope6xZgMrEu3uQCJvuyx6fNpl9xS3Av5CS
        w1gwU4dVkB/e4OOJWkmyMbVdxX3nYqmfFOol6WQMhe+Nmu9lFdvUZWIi+ZiODJg0CNzGF3
        uLBOxNN4wq7rc6AqDc8U+DIzsH+aZ3UxW8w5rCV+k+E5A9mUyROIqal+xf7K80ZvLJR4LY
        YOd56gsRnE7o33nhQqAprZC7WtQXrKYUKI8Zud3ibu1JMQwHjEDzCu8M2lJCdyq33O5dXa
        wb/lRgKWCciKSnL/cG6II8nsLesxBXXAMc2GOK6Jwxqhxt2upLU8z61lNzSVEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617118516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOY79cc5KL5/V5yJebiZ/YPWwhKUw2uTlDk5obc0710=;
        b=wKX8zcucWm+2LsoXrhlxYqgn0wLSPSLBuAmlovDZEsIwHE67tHUHX9f0PpY+WbFCYfl8kW
        nMFhbRiOKrxcTxBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 5/5] printk: syslog: close window between wait and read
Date:   Tue, 30 Mar 2021 17:35:12 +0200
Message-Id: <20210330153512.1182-6-john.ogness@linutronix.de>
In-Reply-To: <20210330153512.1182-1-john.ogness@linutronix.de>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
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
index b771aae46445..bd23f00ebc32 100644
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

