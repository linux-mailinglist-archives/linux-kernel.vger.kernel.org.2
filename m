Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACF32BC7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbhCCOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842909AbhCCKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDCC08ED80
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIgzcClqdt8bamaPognH+cXAeOEvrwnEOvhbMvR50pI=;
        b=aafh14V6g/BpVLvTFZJ7nDVt57Jccy7Q9ityXev4cYHgvH1FHnu1jcrchhDbQuibJ3sV9E
        QE5jSwXmxeRadGgtfWqtOf4Z+ZD3/WlgEPz2aD6qThAXpX9jVQkhE3cuRhAyJ5a/61Bc4u
        6qhN9ZiA79BP7a4Xb2ag4AjzTRmzwmc1SP8IvDMPVeb+UH3rMAZsTwMlqw2N+xIsUfkhy3
        EXBjWZQwJFcnTHU8qpJQaxjKDYdttnxAbq4Vt0hAbnAf8oMJjbUpSQBHoMXiWZjqlhHv4w
        6h4Wrbk6xkl4EqMjd0ei4yLu0W4B1zweQI91iD0HNhP7XcpTm1AH7KcytX80Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIgzcClqdt8bamaPognH+cXAeOEvrwnEOvhbMvR50pI=;
        b=3fXbWMFJGw/M9KaXwDPYNFR+jv54S+zBhf1/bza8k/IwvV5O+hzcOaaXlbg/scKpgH5OZM
        HkOfm4v8ByGcDEDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 15/15] printk: console: remove unnecessary safe buffer usage
Date:   Wed,  3 Mar 2021 11:15:28 +0100
Message-Id: <20210303101528.29901-16-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon registering a console, safe buffers are activated when setting
up the sequence number to replay the log. However, these are already
protected by @console_sem and @syslog_lock. Remove the unnecessary
safe buffer usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 602de86d4e76..2f829fbf0a13 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2967,9 +2967,7 @@ void register_console(struct console *newcon)
 		/*
 		 * console_unlock(); will print out the buffered messages
 		 * for us.
-		 */
-		printk_safe_enter_irqsave(flags);
-		/*
+		 *
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
 		 * the already-registered consoles.
@@ -2982,11 +2980,9 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 
 		/* Get a consistent copy of @syslog_seq. */
-		raw_spin_lock(&syslog_lock);
+		raw_spin_lock_irqsave(&syslog_lock, flags);
 		console_seq = syslog_seq;
-		raw_spin_unlock(&syslog_lock);
-
-		printk_safe_exit_irqrestore(flags);
+		raw_spin_unlock_irqrestore(&syslog_lock, flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.20.1

