Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74403191BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBKR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:59:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhBKRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:32:37 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613064712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JMWNWeCK4yV3tnqhinoR6R2uMPrJnIXKAJ98gW1Wo7g=;
        b=R2qZqaowSFUrPxp5l9Jx+MNWhM5Ua19fBXl6lUu6JilAC4l2md5A26FQUXwXeirhXKyA/O
        fgiF7N6SMUn7TlRDf/G19ek0VXCFY4UwY4KeDFJPvcSyuYtXI/R/FG+D1l5KIcbTryi4lL
        voT2Qk0NwbxCmWh/mlKvXo9TIPSKZnt6Z28Qavcr9PmRrelNwZLtc+Zm+6AK1hV2wVCcJe
        hhx6vjcqzR8qturdn6NI23u2AOnZ287/535EJvfMLlaKeONcpcBEt+2a1glvchg41VGr4z
        xJjEaZ/qY3XLB/OSWVVqrloOfCpQXO5mRClHonL1K78mXNE45NPfyM9CmozR7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613064712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JMWNWeCK4yV3tnqhinoR6R2uMPrJnIXKAJ98gW1Wo7g=;
        b=i7osXWI4JvakixBV3ll9Ikb0s6a3vScMqL+XMYV38bH9+xQ6qodUnUFDoNcvk2I7Z05qUN
        FFwhPiZGeU+78CBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "J. Avila" <elavila@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] printk: avoid prb_first_valid_seq() where possible
Date:   Thu, 11 Feb 2021 18:37:52 +0106
Message-Id: <20210211173152.1629-1-john.ogness@linutronix.de>
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
 patch against next-20210211

 v2: Abort and report no unread messages if SYSLOG_ACTION_SIZE_UNREAD
     fails to read the current or any newer record.

 kernel/printk/printk.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a95c688621f..575a34b88936 100644
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
@@ -1629,9 +1631,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
-		if (syslog_seq < prb_first_valid_seq(prb)) {
+		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
+			/* No unread messages. */
+			logbuf_unlock_irq();
+			return 0;
+		}
+		if (info.seq != syslog_seq) {
 			/* messages are gone, move to first one */
-			syslog_seq = prb_first_valid_seq(prb);
+			syslog_seq = info.seq;
 			syslog_partial = 0;
 		}
 		if (source == SYSLOG_FROM_PROC) {
@@ -1643,7 +1650,6 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			error = prb_next_seq(prb) - syslog_seq;
 		} else {
 			bool time = syslog_partial ? syslog_time : printk_time;
-			struct printk_info info;
 			unsigned int line_count;
 			u64 seq;
 
@@ -3429,9 +3435,11 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
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

