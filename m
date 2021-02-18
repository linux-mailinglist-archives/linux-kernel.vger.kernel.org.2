Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA731E83A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhBRJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBRITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565FC0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:18:27 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQVpm6/GtS3qQdRKAxLY1POMX/FeNAh+0ZeUb5oLxLQ=;
        b=sCeaEEqmjdD8JagTwVjw9Eh/Uks+xwkcoPMS75yuRFTzebH//6/FiEgHfbOUwKf8szvXMi
        fLjG0XC//ufz5GWnNvUtqAXDlkuAyHqoZUFyx56V5ByvKW4+KUc9kmVUPaV4sEMxnDNzH3
        8lx7mSxXnlAqaag4G/HaO7JTTygOwTiroa1w14ngKTVlIHN2B3jg7Fqdhlw03w1Us8W7We
        fF+oKmflx+2tl/2lrOuCMTEkuvAqoWHeUzsGmOG9fiaKj466yeINoo0o0jNr/IhGp7oOSh
        0V8JrqHk/f3PgNY5IuV/xzCKbzs9HYaLwxnq4iW1E9DrMSubZwgiwd/d/JI5HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQVpm6/GtS3qQdRKAxLY1POMX/FeNAh+0ZeUb5oLxLQ=;
        b=nJUx/9WxDsJLqe0igUgZicOIZloBlB4Iiv4VcNJne0ctlpfLG30VprdVThGNwSIFHb7CMv
        6WibwaKPuGIKxfCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 14/14] printk: console: remove unnecessary safe buffer usage
Date:   Thu, 18 Feb 2021 09:18:17 +0100
Message-Id: <20210218081817.28849-15-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 23d525e885e7..78eee6c553a5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2961,9 +2961,7 @@ void register_console(struct console *newcon)
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
@@ -2976,11 +2974,9 @@ void register_console(struct console *newcon)
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

