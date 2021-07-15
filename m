Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740E83CAD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbhGOTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:54:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245474AbhGOTg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:36:59 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626377644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgaJtSBLF4nBRlm25z1Xt7502dBDKcFRJ4X31C1mM5s=;
        b=eJkvKqnKfND+7+60SM5Qw8K6Xoqcv9BwQ4nVMkXEv7ae17tWLl2wWFanTP7CRNIbNicAwc
        PTlUygsGHpNl9hgGFJyucA0oqSmESSaKTC5l4wdH5GMKbLalJ6fNzZtlpTEpmmSOIrbmlf
        7tsLBAIRi20+oftAiCD8mefbEZqeiwQ4HtHSpzRcbrh/OFkyDwfBgU6uu6LtuLPDh1Hmxf
        WrGa8ql+IGzEyT3a9AYwnTbC3Umjs2MVLLlPzdqceAo/OYXxt0e79JNjayxwdpG3G/i8pZ
        d5PKDuS+LuonKCllr/YtDTdOncrsKbZfMFnM8SrzdOB/rANcCBbqrhRoCNTJAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626377644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgaJtSBLF4nBRlm25z1Xt7502dBDKcFRJ4X31C1mM5s=;
        b=27dl5hFdon8v+HG4rLKWf+PTckeEUKpkPpvaoTnRd7OeAmbRWxYsEyq5rzstjvfaMyKACB
        nizmuswaVih2/NAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 6/6] printk: syslog: close window between wait and read
Date:   Thu, 15 Jul 2021 21:39:59 +0206
Message-Id: <20210715193359.25946-7-john.ogness@linutronix.de>
In-Reply-To: <20210715193359.25946-1-john.ogness@linutronix.de>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 55 +++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 99160d0dafd6..d11612687323 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1480,12 +1480,14 @@ static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
 	return seq;
 }
 
+/* The caller is responsible for making sure @size is greater than 0. */
 static int syslog_print(char __user *buf, int size)
 {
 	struct printk_info info;
 	struct printk_record r;
 	char *text;
 	int len = 0;
+	u64 seq;
 
 	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
@@ -1493,15 +1495,35 @@ static int syslog_print(char __user *buf, int size)
 
 	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
-	while (size > 0) {
+	mutex_lock(&syslog_lock);
+
+	/*
+	 * Wait for the @syslog_seq record to be available. @syslog_seq may
+	 * change while waiting.
+	 */
+	do {
+		seq = syslog_seq;
+
+		mutex_unlock(&syslog_lock);
+		len = wait_event_interruptible(log_wait, prb_read_valid(prb, seq, NULL));
+		mutex_lock(&syslog_lock);
+
+		if (len)
+			goto out;
+	} while (syslog_seq != seq);
+
+	/*
+	 * Copy records that fit into the buffer. The above cycle makes sure
+	 * that the first record is always available.
+	 */
+	do {
 		size_t n;
 		size_t skip;
+		int err;
 
-		mutex_lock(&syslog_lock);
-		if (!prb_read_valid(prb, syslog_seq, &r)) {
-			mutex_unlock(&syslog_lock);
+		if (!prb_read_valid(prb, syslog_seq, &r))
 			break;
-		}
+
 		if (r.info->seq != syslog_seq) {
 			/* message is gone, move to next valid one */
 			syslog_seq = r.info->seq;
@@ -1528,12 +1550,15 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
-		mutex_unlock(&syslog_lock);
 
 		if (!n)
 			break;
 
-		if (copy_to_user(buf, text + skip, n)) {
+		mutex_unlock(&syslog_lock);
+		err = copy_to_user(buf, text + skip, n);
+		mutex_lock(&syslog_lock);
+
+		if (err) {
 			if (!len)
 				len = -EFAULT;
 			break;
@@ -1542,8 +1567,9 @@ static int syslog_print(char __user *buf, int size)
 		len += n;
 		size -= n;
 		buf += n;
-	}
-
+	} while (size);
+out:
+	mutex_unlock(&syslog_lock);
 	kfree(text);
 	return len;
 }
@@ -1614,7 +1640,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
-	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1632,15 +1657,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
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
@@ -1707,6 +1723,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
 			unsigned int line_count;
+			u64 seq;
 
 			prb_for_each_info(syslog_seq, prb, seq, &info,
 					  &line_count) {
-- 
2.20.1

