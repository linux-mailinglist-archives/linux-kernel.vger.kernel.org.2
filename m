Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6F3DEEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhHCNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhHCNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:20 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAgt43961jyij8yurqAZzMzspZ62E9WGA/zMDz6s0Qw=;
        b=YpPWs3o/B08aeOu2jZY5CcU8eMJIzia50ZUSkZ/lljJApVZApvJvxFCjM9HD1tup/y6yD3
        1mqq2hQTMEyZpivHFcbjLndetNDr01ZLTx51xYG8+DWxX4H6j+vENOSYsx73oK+qs8Xqm1
        /y84n45T2NHu0gArNlLAt8xIw2rRITjlNumNhCKAzNtNtvn5f4v6uKgbYQ+7pzQ7ez1nkL
        IvBy4DpkFnJO9CKGfLwUQYCUyyTyDIkvuZpZ4NUknW3dus4t5g3/bJfPrCzrktDssURZNg
        Hh0Q2F+rnnFDJRwDtV3im5RWA1QFD/HjZqrFcdf71xi3Ao4siI4dKwEnloFksA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAgt43961jyij8yurqAZzMzspZ62E9WGA/zMDz6s0Qw=;
        b=MCZ7OS/cK1rdoa45XNCSrdVh34SJf6UBPkwX7KPK88AHKgr7SUDhadj+wmCwcKhrWAa/DG
        4JjP66cVvCzqf8DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Cengiz Can <cengiz@kernel.wtf>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v1 09/10] kdb: if available, only use atomic consoles for output mirroring
Date:   Tue,  3 Aug 2021 15:19:00 +0206
Message-Id: <20210803131301.5588-10-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb uses the @oops_in_progress hack to mirror kdb output
to all active consoles from NMI context. Ignoring locks is unsafe.

Now that an NMI-safe atomic interface is available for consoles,
use only that interface to mirror kdb output if such a console is
available.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/debug/kdb/kdb_io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b718..871b89d6294b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -544,6 +544,7 @@ static int kdb_search_string(char *searched, char *searchfor)
 
 static void kdb_msg_write(const char *msg, int msg_len)
 {
+	bool atomic_console_available;
 	struct console *c;
 	const char *cp;
 	int len;
@@ -559,11 +560,26 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
+	atomic_console_available = have_atomic_console();
+
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
+
+		/*
+		 * If any atomic consoles are available, only atomic
+		 * consoles are used.
+		 */
+		if (atomic_console_available) {
+			if (c->write_atomic) {
+				c->write_atomic(c, msg, msg_len);
+				touch_nmi_watchdog();
+			}
+			continue;
+		}
+
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
-- 
2.20.1

