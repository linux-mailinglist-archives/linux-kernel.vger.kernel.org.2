Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20533E233
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 00:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCPXdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCPXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:33:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 16:33:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615937610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfM7hJN4/YE2bPc8jKE9fybnKrSZiZEwM5+EqT78KpQ=;
        b=ZPdkfUkptWzABGwfts3uvtGSL9b4SNLUjj10N30tzsQ3ZrQJekp+vbIvFHhGGKcsbNTUlx
        yxsb5tZj8WAHhNrsqfKUOvX5QwQuui0a+G1E9upyrU3WEgHfIGyRC5EvcxQcFA4SB8OnvM
        YPIaisi/k628BVd2Kp6m+OYQolUsO+ydbZBr3hm6Wft0BZHsRb27iNG8iLmlwXpo76ZHJM
        PDS1YDmoQHb1VP3FCM4KHd8qGnsXmcGs8279G04zHZBH8oj0HPQNiiUFxw/7gKPOiWakTP
        G1bl2XmSlNqSQMFpvU8bt8ZseFgsxXZBpp37l6BqKnlgaiG7pMvutcd8PND+YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615937610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfM7hJN4/YE2bPc8jKE9fybnKrSZiZEwM5+EqT78KpQ=;
        b=KLpZH4eXwfxsEp5y3m3oif4FXqauXBq5NHHJa5kx9He2v/d00cL7WFDxyp9R8Km3Nn1yyY
        wrZt7W/zBBRPNBAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v1 3/3] printk: convert @syslog_lock to spin_lock
Date:   Wed, 17 Mar 2021 00:33:26 +0100
Message-Id: <20210316233326.10778-4-john.ogness@linutronix.de>
In-Reply-To: <20210316233326.10778-1-john.ogness@linutronix.de>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@syslog_log was a raw_spin_lock to simplify the transition of
removing @logbuf_lock and the safe buffers. With that transition
complete, @syslog_log can become a spin_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fa52a5daa232..1e38174583c5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -356,7 +356,7 @@ enum log_flags {
 };
 
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
-static DEFINE_RAW_SPINLOCK(syslog_lock);
+static DEFINE_SPINLOCK(syslog_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -1478,9 +1478,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		raw_spin_lock_irq(&syslog_lock);
+		spin_lock_irq(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
-			raw_spin_unlock_irq(&syslog_lock);
+			spin_unlock_irq(&syslog_lock);
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1509,7 +1509,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
-		raw_spin_unlock_irq(&syslog_lock);
+		spin_unlock_irq(&syslog_lock);
 
 		if (!n)
 			break;
@@ -1573,9 +1573,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 
 	if (clear) {
-		raw_spin_lock_irq(&syslog_lock);
+		spin_lock_irq(&syslog_lock);
 		latched_seq_write(&clear_seq, seq);
-		raw_spin_unlock_irq(&syslog_lock);
+		spin_unlock_irq(&syslog_lock);
 	}
 
 	kfree(text);
@@ -1584,9 +1584,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	raw_spin_lock_irq(&syslog_lock);
+	spin_lock_irq(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
-	raw_spin_unlock_irq(&syslog_lock);
+	spin_unlock_irq(&syslog_lock);
 }
 
 /* Return a consistent copy of @syslog_seq. */
@@ -1594,9 +1594,9 @@ static u64 read_syslog_seq_irq(void)
 {
 	u64 seq;
 
-	raw_spin_lock_irq(&syslog_lock);
+	spin_lock_irq(&syslog_lock);
 	seq = syslog_seq;
-	raw_spin_unlock_irq(&syslog_lock);
+	spin_unlock_irq(&syslog_lock);
 
 	return seq;
 }
@@ -1674,10 +1674,10 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		raw_spin_lock_irq(&syslog_lock);
+		spin_lock_irq(&syslog_lock);
 		if (!prb_read_valid_info(prb, syslog_seq, &info, NULL)) {
 			/* No unread messages. */
-			raw_spin_unlock_irq(&syslog_lock);
+			spin_unlock_irq(&syslog_lock);
 			return 0;
 		}
 		if (info.seq != syslog_seq) {
@@ -1705,7 +1705,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
-		raw_spin_unlock_irq(&syslog_lock);
+		spin_unlock_irq(&syslog_lock);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -3013,9 +3013,9 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 
 		/* Get a consistent copy of @syslog_seq. */
-		raw_spin_lock_irqsave(&syslog_lock, flags);
+		spin_lock_irqsave(&syslog_lock, flags);
 		console_seq = syslog_seq;
-		raw_spin_unlock_irqrestore(&syslog_lock, flags);
+		spin_unlock_irqrestore(&syslog_lock, flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.20.1

