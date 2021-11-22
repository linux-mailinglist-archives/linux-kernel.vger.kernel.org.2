Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693F5458F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhKVNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:30:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32978 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhKVNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CABE21FD58;
        Mon, 22 Nov 2021 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637587634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AZibCGij3y/JvMKMitR5GfZ45pYMOdGxKzJnjs1Mxo=;
        b=estj9cBq3F8LHzD3euGwdN9Mtztzcj0eB9ExRg+trFmnfs9QJUcdZQtgY3D/uu/Z7NAIKD
        Rhg9mqwgH6VTSgEaQ1abo5uVRK5PD2OIy1k+dl3Ca0btnyrh8ef1YR7S2S4asRinOWpPxU
        7g5O+sX1G9puTipo5SrQ2KKKkSqTnKI=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id A0F5AA3B89;
        Mon, 22 Nov 2021 13:27:14 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4/5] printk/console: Remove need_default_console variable
Date:   Mon, 22 Nov 2021 14:26:48 +0100
Message-Id: <20211122132649.12737-5-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211122132649.12737-1-pmladek@suse.com>
References: <20211122132649.12737-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable @need_default_console is used to decide whether a newly
registered console should get enabled by default.

The logic is complicated. It can be modified in a register_console()
call. But it is always re-evaluated in the next call by the following
condition:

	if (need_default_console || bcon || !console_drivers)
		need_default_console = preferred_console < 0;

In short, the value is updated when either of the condition is valid:

  + the value is still, or again, "true"
  + boot/early console is still the first in @console_driver list
  + @console_driver list is empty

The value is updated according to @preferred_console. In particular,
it is set to "false" when a @preferred_console was set by
__add_preferred_console(). This happens when a non-braille console
was added via the command line, device tree, or SPCR.

It far from clear what this all means together. Let's look at
@need_default_console from another angle:

1. The value is "true" by default. It means that it is always set
   according to @preferred_console during the first register_console()
   call.

   By other words, the first register_console() call will register
   the console by default only when none non-braille console was defined
   via the command line, device tree, or SPCR.

2. The value will always stay "false" when @preferred_console is set.

   By other words, try_enable_default_console() will never get called
   when a non-braille console is explicitly required.

4. The value might be set to "false" in try_enable_default_console()
   when a console with tty binding (driver) gets enabled.

   In this case CON_CONSDEV is set as well. It causes that the console
   will be inserted as first into the list @console_driver. It might
   be either real or boot/early console.

5. The value will be set _back_ to "true" in the next register_console()
   call when:

      + The console added by the previous register_console() had been
	a boot/early one.

      + The last console has been unregistered in the meantime and
	a boot/early console became first in @console_drivers list
	again. Or the list became empty.

   By other words, the value will stay "false" only when the last
   registered console was real, had tty binding, and was not removed
   in the mean time.

The main logic looks clear:

  + Consoles are enabled by default only when no one is preferred
    via the command line, device tree, or SPCR.

  + By default, any console is enabled until a real console
    with tty binding gets registered.

The behavior when the real console with tty binding is later removed
is a bit unclear:

  + By default, any new console is registered again only when there
    is no console or the first console in the list is a boot one.

The question is why the code is suddenly happy when a real console
without tty binding is the first in the list. It looks like an overlook
and bug.

Conclusion:

The state of @preferred_console and the first console in @console_driver
list should be enough to decide whether we need to enable the given console
by default.

The rules are simple. New consoles are _not_ enabled by default
when either of the following conditions is true:

  + @preferred_console is set. It means that a non-braille console
    is explicitly configured via the command line, device tree, or SPCR.

  + A real console with tty binding is registered. Such a console will
    have CON_CONSDEV flag set and will always be the first in
    @console_drivers list.

Note:

The new code does not use @bcon variable. The meaning of the variable
is far from clear. The direct check of the first console in the list
makes it more clear that only real console fulfills requirements
of the default console.

Behavior change:

As already discussed above. There was one situation where the original
code worked a strange way. Let's have:

	+ console A: real console without tty binding
	+ console B: real console with tty binding

and do:

	register_console(A);	/* 1st step */
	register_console(B);	/* 2nd step */
	unregister_console(B);	/* 3rd step */
	register_console(B);	/* 4th step */

The original code will not register the console B in the 4th step.
@need_default_console is set to "false" in 2nd step. The real console
with tty binding (driver) is then removed in the 3rd step.
But @need_default_console will stay "false" in the 4th step because
there is no boot/early console and @registered_consoles list is not
empty.

The new code will register the console B in the 4th step because
it checks whether the first console has tty binding (->driver)

This behavior change should acceptable:

  1. The scenario requires manual intervention (console removal).
     The system should boot with the same consoles as before.

  2. Console B is registered again probably because the user wants
     to use it. The most likely scenario is that the related
     module is reloaded.

  3. It makes the behavior more consistent and predictable.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3f845daa3a4a..6591da285a83 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -280,7 +280,6 @@ static struct console *exclusive_console;
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 
 static int preferred_console = -1;
-static bool need_default_console = true;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
@@ -2919,10 +2918,8 @@ static void try_enable_default_console(struct console *newcon)
 
 	newcon->flags |= CON_ENABLED;
 
-	if (newcon->device) {
+	if (newcon->device)
 		newcon->flags |= CON_CONSDEV;
-		need_default_console = false;
-	}
 }
 
 /*
@@ -2972,16 +2969,24 @@ void register_console(struct console *newcon)
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
-	if (need_default_console || bcon || !console_drivers)
-		need_default_console = preferred_console < 0;
-
 	/*
-	 *	See if we want to use this console driver. If we
-	 *	didn't select a console we take the first one
-	 *	that registers here.
+	 * See if we want to enable this console driver by default.
+	 *
+	 * Nope when a console is preferred by the command line, device
+	 * tree, or SPCR.
+	 *
+	 * The first real console with tty binding (driver) wins. More
+	 * consoles might get enabled before the right one is found.
+	 *
+	 * Note that a console with tty binding will have CON_CONSDEV
+	 * flag set and will be first in the list.
 	 */
-	if (need_default_console)
-		try_enable_default_console(newcon);
+	if (preferred_console < 0) {
+		if (!console_drivers || !console_drivers->device ||
+		    console_drivers->flags & CON_BOOT) {
+			try_enable_default_console(newcon);
+		}
+	}
 
 	/* See if this console matches one we selected on the command line */
 	err = try_enable_preferred_console(newcon, true);
-- 
2.26.2

