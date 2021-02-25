Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8E325798
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhBYU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:26:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhBYUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:26 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUh9AQdpak/Ivn7suhyTdO/F4X3qfKOJJGmaxcJ3ou4=;
        b=3rHpCJLHGUEZEUa+05r79KAjvENed3E6xoEkW4h/Ov9ZdgAUedH7h7aEn4ooBmSJPyu9NQ
        CrR2WrwdcD5kJUUYNVbkBjnIWWWiDqutH9s+chL450OtkIDcEgpsEWhsSmZE13bB9WFCAY
        FCsc4o0Mj9Scpp8IT8M5vqgRaEnogD87VE0i3Jki6dMpnZ1r8Rf2k9TaLQBnq3ZlnB4gcy
        mhyeODnchqIq2EsHjc8zdH9glr4lhM7DUXwWY7ixqtIkY4OGNe479WTFYpaMyTCA4ohtXG
        czQ/Iy3bzVKqzf8Nxh5SDXlNO/TcQKS3KQIQnz4ITZhszXjiw2ZtFV1GSXuXhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUh9AQdpak/Ivn7suhyTdO/F4X3qfKOJJGmaxcJ3ou4=;
        b=mwAUBtTK54L6//Yc2C+BYtk6+GycE0XYesQ2ntnXLjyRNy9FwJe1RJlglOKHXqHxbD8Q+G
        zLHGxEIp5i/eQxCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 09/15] printk: use atomic64_t for devkmsg_user.seq
Date:   Thu, 25 Feb 2021 21:24:32 +0100
Message-Id: <20210225202438.28985-10-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
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
index b78b85947312..82d89eec4aac 100644
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

