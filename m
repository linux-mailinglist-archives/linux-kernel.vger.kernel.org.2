Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6A32579A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhBYU1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:27:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38432 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhBYUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:29 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25Nb9FU9aH+GatIfh8D4CkRLNxjV/sleKuao93alH5I=;
        b=eQVWxCKsk24I2CFkedXm+m2gTO9pmqnTKetATfwp9qCeWeEOB4Gjf7ep9uCufFRgdcfmBB
        FbauBeokSNz+kW4Uk0d/hvYFBDMvf6C1tMHw73/nHxRpD8Fjo7ru7KcgSeXb0Gmb8UuuPC
        DBPmewFgDi69CyA1BCHCgTB3ogjQIMzkSyXOmGBomoYsDeekdTiTt6CiC68mPYHrDH5e4n
        EW974znZZoGJU2aHkEG/8eAjz30w4E8OBfMl9DOFpjn0Ode2Wnf6hLzXD8f5dAp6jYBaiy
        sQs0ulb7cT1ZuGDcTJ+kHOovsEnNCDmYKyx5Kfxb8xQ8AqeSwuyr6D7ugTVNHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25Nb9FU9aH+GatIfh8D4CkRLNxjV/sleKuao93alH5I=;
        b=YDcdxNBqmonVo03ukXN9E0BWcN20Yl1K9vwrKxIcvyPZDOtRwrqX90Db3z3NSfjqkKaeuf
        SaFAkU+lPZ11eWCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 15/15] printk: console: remove unnecessary safe buffer usage
Date:   Thu, 25 Feb 2021 21:24:38 +0100
Message-Id: <20210225202438.28985-16-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
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
index 15a9bc409e0a..27a748ed0bc7 100644
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

