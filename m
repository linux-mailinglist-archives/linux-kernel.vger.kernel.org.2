Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F6458F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhKVNad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:30:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbhKVNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B45541FD39;
        Mon, 22 Nov 2021 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637587632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OW9+Sak7NkAWcd37pQboamvgd/d7/4SbMZWYKQREx5M=;
        b=D0Ne1ETHYU6gNkBv+WaXMrOZDeXFGsHJ/jCvAkT86BNuO9BRxERpOrLKn7T4TpueCKMvQw
        7YPFNlZaNsD+LPs3+r8R+ETTAyc37PnXvkT1BNJBnvKCxGHA3EDxQvD9iYWCKqZXogHhn0
        /8BE0A74zB2+DQpOYh9d7OrgZ+T0SVo=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 8EBCAA3B85;
        Mon, 22 Nov 2021 13:27:12 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/5] printk/console: Rename has_preferred_console to need_default_console
Date:   Mon, 22 Nov 2021 14:26:46 +0100
Message-Id: <20211122132649.12737-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211122132649.12737-1-pmladek@suse.com>
References: <20211122132649.12737-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic around the variable @has_preferred_console made my head
spin many times. Part of the problem is the ambiguous name.

There is the variable @preferred_console. It points to the last
non-braille console in @console_cmdline array. This array contains
consoles preferred via the command line, device tree, or SPCR.

Then there is the variable @has_preferred_console. It is set to
"true" when @preferred_console is enabled or when a console with
tty binding gets enabled by default.

It might get reset back by the magic condition:

	if (!has_preferred_console || bcon || !console_drivers)
		has_preferred_console = preferred_console >= 0;

It is a puzzle. Dumb explanation is that it gets re-evaluated
when:

	+ it was not set before (see above when it gets set)
	+ there is still an early console enabled (bcon)
	+ there is no console enabled (!console_drivers)

This is still a puzzle.

It gets more clear when we see where the value is checked. The only
meaning of the variable is to decide whether we should try to enable
the new console by default.

Rename the variable according to the single situation where
the value is checked.

The rename requires an inverted logic. Otherwise, it is a simple
search & replace. It does not change the functionality.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1acbe39dd47c..4c5f496877b0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -280,7 +280,7 @@ static struct console *exclusive_console;
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
-static bool has_preferred_console;
+static bool need_default_console = true;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2894,7 +2894,7 @@ static int try_enable_preferred_console(struct console *newcon,
 		newcon->flags |= CON_ENABLED;
 		if (i == preferred_console) {
 			newcon->flags |= CON_CONSDEV;
-			has_preferred_console = true;
+			need_default_console = false;
 		}
 		return 0;
 	}
@@ -2923,7 +2923,7 @@ static void try_enable_default_console(struct console *newcon)
 
 	if (newcon->device) {
 		newcon->flags |= CON_CONSDEV;
-		has_preferred_console = true;
+		need_default_console = false;
 	}
 }
 
@@ -2974,15 +2974,15 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (!has_preferred_console || bcon || !console_drivers)
-		has_preferred_console = preferred_console >= 0;
+	if (need_default_console || bcon || !console_drivers)
+		need_default_console = preferred_console < 0;
 
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (!has_preferred_console)
+	if (need_default_console)
 		try_enable_default_console(newcon);
 
 	/* See if this console matches one we selected on the command line */
-- 
2.26.2

