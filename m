Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD323D7594
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhG0NGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhG0NGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:06:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5A6C061765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so1821187wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiBlCcOzel0izjaZsuvBnBiQfFmrrhFhPtWnG8B4Pd0=;
        b=fXC0hcKtDCMU8hsbHynMW3Aup1SkKP0kfhfU1yAwPL9xvR/w5F+aPpK1BDTMNYssTt
         TkkeX61ZoIeQz8kJVsx4xM390YGN4AB+fyuDWC5zdI7YezeEPLzkHqbJbKBQhQ3Btj9K
         CAtca/r44/nilSITKsxkLn+T/boFxo2XDi5L4hUTn1jxU3HO1M/ECoeALmZg+qWV9hjg
         gS12v2cuqgIkpGDQFu7WWucdkCWEOWhEquoCSJzIKwkuFw7Vs7lWfbfVZJjLTMSTSWI1
         kn6snfDHjvUuxTEF66ouHXSFRZEq28VjO70ZezZJURyz9ikHClyNGLLiLiFMm52WGfUx
         3ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiBlCcOzel0izjaZsuvBnBiQfFmrrhFhPtWnG8B4Pd0=;
        b=uEyBg/XCG7DLamBY29ACf/Ap36UIuixI5Eo77a62NIi67sLRJuaJarTA1qWtuMqPaI
         rsJoSzl1DokF0hikwxW6x811wKvDWnRcj04V9eb4JEdglE7y1Q6lm9kSsnDmrm92dXnT
         QM6KnJe51pY3N7N64RyJPFK9nZGkG/Ip8CtOmvdo8QSa0ny3aOEiOl5XhrEoM22vrXs6
         ZxAYFgJFlHTHPgI6aG6z7pPEm1f8wxDFQQzjymxjQ2Ts5GtRyNrTfcow4HaYXiAiYFZ+
         nTsshYTJoXu1SjCoLMQcp1q9HxJd6JR3ThEPkT0JX015Ol0AmcsqZzFmmXckwaQY7l5N
         MsGg==
X-Gm-Message-State: AOAM532aKs4/yV5+57arY085Ur3hFMUI+Au6KePyQ7NonHhRFTESI0qq
        lQqV0W2VHqQAsJgimpZXVL2JX0dW9hFxbN5F
X-Google-Smtp-Source: ABdhPJwpnLYktccBp57bwQl0wpMbH2VXEoh9Y3t4t+jInZGSdXKUs1zewSbD1AgFDyvXzE8DQ2fbJA==
X-Received: by 2002:a05:600c:35d1:: with SMTP id r17mr4112134wmq.98.1627391199018;
        Tue, 27 Jul 2021 06:06:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 104sm3421034wrc.4.2021.07.27.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:06:38 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 2/2] printk: Add printk.console_no_auto_verbose boot parameter
Date:   Tue, 27 Jul 2021 14:06:35 +0100
Message-Id: <20210727130635.675184-3-dima@arista.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727130635.675184-1-dima@arista.com>
References: <20210727130635.675184-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
which provides more information to debug a panic/oops.

Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
are configured to have 9600 baud rate. While verbose console messages
have their value to post-analyze crashes, on such setup they:
- may prevent panic/oops messages being printed
- take too long to flush on console resulting in watchdog reboot

In all our setups we use kdump which saves dmesg buffer after panic,
so in reality those extra messages on console provide no additional value,
but rather add risk of not getting to __crash_kexec().

Provide printk.console_no_auto_verbose boot parameter, which allows
to switch off printk being verbose on oops/panic/lockdep.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 include/linux/printk.h                          |  6 +-----
 kernel/printk/printk.c                          | 12 ++++++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..a4dd5814a83a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4167,6 +4167,15 @@
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 			default: disabled
 
+	printk.console_no_auto_verbose=
+			Disable console loglevel raise on oops, panic
+			or lockdep-detected issues (only if lock debug is on).
+			With an exception to setups with low baudrate on
+			serial console, keeping this 0 is a good choice
+			in order to provide more debug information.
+			Format: <bool>
+			default: 0 (auto_verbose is enabled)
+
 	printk.devkmsg={on,off,ratelimit}
 			Control writing to /dev/kmsg.
 			on - unlimited logging to /dev/kmsg from userspace
diff --git a/include/linux/printk.h b/include/linux/printk.h
index a63f468a8239..0484274158d2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -70,11 +70,7 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
-}
+extern void console_verbose(void);
 
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 142a58d124d9..a6b94c3c5ac5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,6 +2404,18 @@ module_param_named(console_suspend, console_suspend_enabled,
 MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
 	" and hibernate operations");
 
+static bool printk_console_no_auto_verbose;
+
+void console_verbose(void)
+{
+	if (console_loglevel && !printk_console_no_auto_verbose)
+		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+}
+EXPORT_SYMBOL_GPL(console_verbose);
+
+module_param_named(console_no_auto_verbose, printk_console_no_auto_verbose, bool, 0644);
+MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to highest on oops/panic/etc");
+
 /**
  * suspend_console - suspend the console subsystem
  *
-- 
2.32.0

