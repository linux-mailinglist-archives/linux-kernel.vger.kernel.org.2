Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F73458F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhKVNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:30:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbhKVNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6185221910;
        Mon, 22 Nov 2021 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637587631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgDu+zmIUSJ3es9E2L+WjsfRzdC3UJEhdodvSrFGzsI=;
        b=J6nEus+BF4XYNRXJe0dsl/9HPVlQ1bU77WiqZtoHcxSZulg9z2oMYl7VZVjHYWmYYphN3s
        AUvZpoxPQ+SvZzZv7dWekI2+L/tRvwdNEHM0tCq55ODlcvqbuSFVj24tq570WFsc1IJYK3
        LlLm++eBiY7gX9bGEHwGjbjZGoybdiA=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 37A19A3B84;
        Mon, 22 Nov 2021 13:27:11 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/5] printk/console: Split out code that enables default console
Date:   Mon, 22 Nov 2021 14:26:45 +0100
Message-Id: <20211122132649.12737-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211122132649.12737-1-pmladek@suse.com>
References: <20211122132649.12737-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the code enabling a console by default into a separate function
called try_enable_default_console().

Rename try_enable_new_console() to try_enable_preferred_console() to
make the purpose of the different variants more clear.

It is a code refactoring without any functional change.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..1acbe39dd47c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2861,7 +2861,8 @@ early_param("keep_bootcon", keep_bootcon_setup);
  * Care need to be taken with consoles that are statically
  * enabled such as netconsole
  */
-static int try_enable_new_console(struct console *newcon, bool user_specified)
+static int try_enable_preferred_console(struct console *newcon,
+					bool user_specified)
 {
 	struct console_cmdline *c;
 	int i, err;
@@ -2909,6 +2910,23 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 	return -ENOENT;
 }
 
+/* Try to enable the console unconditionally */
+static void try_enable_default_console(struct console *newcon)
+{
+	if (newcon->index < 0)
+		newcon->index = 0;
+
+	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
+		return;
+
+	newcon->flags |= CON_ENABLED;
+
+	if (newcon->device) {
+		newcon->flags |= CON_CONSDEV;
+		has_preferred_console = true;
+	}
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2964,25 +2982,15 @@ void register_console(struct console *newcon)
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (!has_preferred_console) {
-		if (newcon->index < 0)
-			newcon->index = 0;
-		if (newcon->setup == NULL ||
-		    newcon->setup(newcon, NULL) == 0) {
-			newcon->flags |= CON_ENABLED;
-			if (newcon->device) {
-				newcon->flags |= CON_CONSDEV;
-				has_preferred_console = true;
-			}
-		}
-	}
+	if (!has_preferred_console)
+		try_enable_default_console(newcon);
 
 	/* See if this console matches one we selected on the command line */
-	err = try_enable_new_console(newcon, true);
+	err = try_enable_preferred_console(newcon, true);
 
 	/* If not, try to match against the platform default(s) */
 	if (err == -ENOENT)
-		err = try_enable_new_console(newcon, false);
+		err = try_enable_preferred_console(newcon, false);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-- 
2.26.2

