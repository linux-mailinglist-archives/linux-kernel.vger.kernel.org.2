Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2073E458F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbhKVNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:30:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhKVNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CFA811FD59;
        Mon, 22 Nov 2021 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637587633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6+cmnjQH3C6FC97WRB47lRQSyHgDIAOCd6maYY/UfM=;
        b=ZjUuV3ooZk0GoD7JoTgmUv7+bJpjLEzpBRpVp//c8w/HCwuMbLJn9yk9XnPWY5kL1x5zou
        yuT1WG19IjzWt8TcE4806sjnd7bwd+3O3w+RNJmhX4sRzKDsTMpLVj6rC37JLnDyf4UKCw
        I2Nl01D3WIGFlVA2iSqiBGcHd76Gc7Y=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id A2616A3B87;
        Mon, 22 Nov 2021 13:27:13 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/5] printk/console: Remove unnecessary need_default_console manipulation
Date:   Mon, 22 Nov 2021 14:26:47 +0100
Message-Id: <20211122132649.12737-4-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211122132649.12737-1-pmladek@suse.com>
References: <20211122132649.12737-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to clear @need_default_console when a console
preferred by the command line, device tree, or SPCR, gets enabled.

The code is called only when some non-braille console matched a console
in @console_cmdline array. It means that a non-braille console was added
in __add_preferred_console() and the variable preferred_console is set
to a number >= 0. As a result, @need_default_console is always set to
"false" in the magic condition:

	if (need_default_console || bcon || !console_drivers)
		need_default_console = preferred_console < 0;

This is one small step in removing the above magic condition
that is hard to follow.

The patch removes one superfluous assignment and should not change
the functionality.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4c5f496877b0..3f845daa3a4a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2892,10 +2892,8 @@ static int try_enable_preferred_console(struct console *newcon,
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
-		if (i == preferred_console) {
+		if (i == preferred_console)
 			newcon->flags |= CON_CONSDEV;
-			need_default_console = false;
-		}
 		return 0;
 	}
 
-- 
2.26.2

