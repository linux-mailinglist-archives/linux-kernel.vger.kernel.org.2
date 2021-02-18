Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BD831E836
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhBRJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:31:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhBRITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:21 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jy7mAb1KrfeQAkl+XZYx7Q4dVEAajM+sy5En1tPxWk=;
        b=Fu9O5uJJpUx3/kjbFiuWzTokiUgQXUxBpNapRbGh31UvW32jUvK1UkR8Xt9g12PPTn4B7z
        9ik8qkW2cSLQowjkkQ534TdNBCWSVkqnv8085PJIfyQASqqNd7098qQTrF78DQ4kFGmeVU
        YAZFNChggMq5DTJ5KZLpwd3Ptr6Vnd3QSh+QUAcq8NlDPs1n0MORPxYN7ihes5Jl1b1nkr
        MVKYlY/cwxr81banEpfsiDMuQV0MpaX0CDHx7P162DeNjKDbSYzSAYTysNy0tVww3pOfjG
        HX9fyQ0M9Fnm3fNxYSaEXkZBGLGC18vxZKyvTLXVBdDQ60mDrkFivMoZrzkzpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jy7mAb1KrfeQAkl+XZYx7Q4dVEAajM+sy5En1tPxWk=;
        b=e27YUbhtiigaow0Eesz1LBxAUG0yUMERaqgU6grVMHVO6G/xjTqL3E0/Asj34RrEALo+Uq
        5uSmkjUy6OIRirAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 07/14] printk: use atomic64_t for devkmsg_user.seq
Date:   Thu, 18 Feb 2021 09:18:10 +0100
Message-Id: <20210218081817.28849-8-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a71e0d41ccb5..20c21a25143d 100644
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
@@ -764,7 +764,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	if (!prb_read_valid(prb, user->seq, r)) {
+	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -773,15 +773,15 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 
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
@@ -792,7 +792,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
-	user->seq = r->info->seq + 1;
+	atomic64_set(&user->seq, r->info->seq + 1);
 	logbuf_unlock_irq();
 
 	if (len > count) {
@@ -832,7 +832,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->seq = prb_first_valid_seq(prb);
+		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		break;
 	case SEEK_DATA:
 		/*
@@ -840,11 +840,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
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
@@ -865,9 +865,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
+	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {
 		/* return error when data has vanished underneath us */
-		if (info.seq != user->seq)
+		if (info.seq != atomic64_read(&user->seq))
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
@@ -906,7 +906,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 			&user->text_buf[0], sizeof(user->text_buf));
 
 	logbuf_lock_irq();
-	user->seq = prb_first_valid_seq(prb);
+	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 	logbuf_unlock_irq();
 
 	file->private_data = user;
-- 
2.20.1

