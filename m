Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFF32BC86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359311AbhCCOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842921AbhCCKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C23C08ED82
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bV4acOLBKzR+P4WEzqLKGGz2LRMOZ3l7+n8NxpAIp+w=;
        b=NmSk7b2ppDXwvv+t354gXADXoT3Vxg5xo8Ay6EvxN0FG7sraztnf2A7SpgICZYJp2xa7o5
        KKdUJkRL7mbvtUtUutlpTTmIMWiSSOd0nOuJg9YmOiX4FPg8EFAdtbZQMYKRAP1T1xkqeP
        J0+hDyGWS9gBNaKZNobaQNfykc7Luz0vb7TCppLXHecMy9ZaKQHqlMojcJ5DjFhQOesquI
        Qxkc9eV4MQAxf7M6vnXP8JspH7592E59DXx1NFVh8yn+tNRRGg1BudQgl0W2MaR8WyZs8g
        451CSmc2cRJj8tC7MZEvkgP4sjAvA8U7G8nRQW0f7s+hbQ0W3uBl9WVSiWBlIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bV4acOLBKzR+P4WEzqLKGGz2LRMOZ3l7+n8NxpAIp+w=;
        b=X/miGsYajEYM8nokn/02F4rzo8aT6MernjTwB/1a3Q7GeYDFrYvxY3CqMjVoFhDs2KY6sV
        4t30rlhzOoja6hCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 09/15] printk: use atomic64_t for devkmsg_user.seq
Date:   Wed,  3 Mar 2021 11:15:22 +0100
Message-Id: <20210303101528.29901-10-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@user->seq is indirectly protected by @logbuf_lock. Once @logbuf_lock
is removed, @user->seq will be no longer safe from an atomicity point
of view.

In preparation for the removal of @logbuf_lock, change it to
atomic64_t to provide this safety.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b4bb88c3547..65e216ca6ca6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -662,7 +662,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
-	u64 seq;
+	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
@@ -763,7 +763,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	if (!prb_read_valid(prb, user->seq, r)) {
+	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -772,15 +772,15 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
 		logbuf_unlock_irq();
 		ret = wait_event_interruptible(log_wait,
-					prb_read_valid(prb, user->seq, r));
+				prb_read_valid(prb, atomic64_read(&user->seq), r));
 		if (ret)
 			goto out;
 		logbuf_lock_irq();
 	}
 
-	if (r->info->seq != user->seq) {
+	if (r->info->seq != atomic64_read(&user->seq)) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = r->info->seq;
+		atomic64_set(&user->seq, r->info->seq);
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -791,7 +791,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
-	user->seq = r->info->seq + 1;
+	atomic64_set(&user->seq, r->info->seq + 1);
 	logbuf_unlock_irq();
 
 	if (len > count) {
@@ -831,7 +831,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		break;
 	case SEEK_DATA:
 		/*
@@ -839,11 +839,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = latched_seq_read_nolock(&clear_seq);
+		atomic64_set(&user->seq, latched_seq_read_nolock(&clear_seq));
 		break;
 	case SEEK_END:
 		/* after the last record */
-		user->seq = prb_next_seq(prb);
+		atomic64_set(&user->seq, prb_next_seq(prb));
 		break;
 	default:
 		ret = -EINVAL;
@@ -864,9 +864,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
+	if (prb_read_valid_info(prb, atomic64_read(&user->seq), &info, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (info.seq != user->seq)
+		if (info.seq != atomic64_read(&user->seq))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -905,7 +905,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 			&user->text_buf[0], sizeof(user->text_buf));
 
 	logbuf_lock_irq();
-	user->seq = prb_first_valid_seq(prb);
+	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 	logbuf_unlock_irq();
 
 	file->private_data = user;
-- 
2.20.1

