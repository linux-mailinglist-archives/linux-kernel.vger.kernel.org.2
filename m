Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE03C67F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhGMBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhGMBSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:18:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB04C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f9so22469859wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15WCKrCeo8iz4/Y2k0yQkEL5+/MUdAYJeg4JDX49/FY=;
        b=MUpiGbFlqCdyJNO9hg850X3PvbS7T0bPJi2iDo+BIvruRIpvFFbLq0LDNA4eh1bFWk
         vFUYFI4stsNKovMzcnqHs7vUFKtg9iYEbFcQ7wU9EPLt2Z7+nPCR+pEwkNvbdUjd1aNR
         V7Tu2wVeoxXQDa2qvbNU2VJzixelQQbgHzGGuCYny2uzEKoh/r8+1rCgBRSwnk/lG8kE
         jfGAB/GHcdvt12c9/QAQjMOEm0mxndToCPCUZxc1KR8kiQdoD1LSEQr6MQ5ioq41pZrt
         ExuOm0bvbdRpD+V5GKJM3IMW+NieHv6z/aJlYzKEuXDdGGRIdDK2ftjEPJkUcPB2C3Zb
         ozKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15WCKrCeo8iz4/Y2k0yQkEL5+/MUdAYJeg4JDX49/FY=;
        b=plFRNw+EXGo3f0D3Q2r3yvoD1/NL0fzJm1YW3d83/Uz5xZhZlnmfjsr3wPd8Ogbfw1
         /8rPySmjfA0maPIdfcAUyAY3G83IlR3AZ5QEv8/V/nL6lxwzktJEni24ourpNZzOOfsp
         5zeLfWJ5P1z7Xnq2AVGv4ZwWSKGei9sk+Z7LA1HtJugWWXpkDjtR4JxNG2yjQqtD/DQO
         OUJ+SBQC3MwJ3exOv/Yd7wjoJmMMTG3eEG/lt4IjA6GCBxhJ4Bt8edebFJx4ibOv699G
         Caaa7oqoR4VOK1Qe2C8zJaSCywXhOVbQY4QIFE7Y+p3V29/xOd96XMT+YPdNLMHuc0Ba
         NlBA==
X-Gm-Message-State: AOAM5328FltLDzfkWPBG+NnHFRI0QWCJBQDR4SpJJAGsvbmtycEI1vNs
        mVUrxYfOJgkaP1LfUIzKkFH8a0Z+gvg8Zg==
X-Google-Smtp-Source: ABdhPJzVRzr2I6QBkNAtQIj3vxtic8fo+DOiJLtgw8Xdc91ek9slabflY4wMeKs9p5IRxzVq9OJRqg==
X-Received: by 2002:a05:6000:259:: with SMTP id m25mr2194809wrz.230.1626138915571;
        Mon, 12 Jul 2021 18:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x8sm8479566wrt.93.2021.07.12.18.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 18:15:15 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/2] printk: Add printk.console_verbose boot parameter
Date:   Tue, 13 Jul 2021 02:15:11 +0100
Message-Id: <20210713011511.215808-3-dima@arista.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713011511.215808-1-dima@arista.com>
References: <20210713011511.215808-1-dima@arista.com>
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

Provide printk.console_verbose boot parameter, which allows to switch off
printk being verbose on oops/panic/lockdep (making it boot parameter
instead of compile-option suggested-by Petr).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 include/linux/printk.h                          | 4 +++-
 kernel/printk/printk.c                          | 6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..9fae19b1edd8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4167,6 +4167,15 @@
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 			default: disabled
 
+	printk.console_verbose=
+			Raise console loglevel to highest on oops, panic or
+			lockdep-detected issues (only if lock debug is on).
+			With an exception to setups with low baudrate on
+			serial console, keeping this enabled is a good choice
+			in order to provide more debug information.
+			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+			default: enabled
+
 	printk.devkmsg={on,off,ratelimit}
 			Control writing to /dev/kmsg.
 			on - unlimited logging to /dev/kmsg from userspace
diff --git a/include/linux/printk.h b/include/linux/printk.h
index a63f468a8239..9d0b8133a03c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -70,9 +70,11 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+extern bool printk_console_verbose;
+
 static inline void console_verbose(void)
 {
-	if (console_loglevel)
+	if (console_loglevel && printk_console_verbose)
 		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 142a58d124d9..e321ee78855d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,6 +2404,12 @@ module_param_named(console_suspend, console_suspend_enabled,
 MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
 	" and hibernate operations");
 
+bool printk_console_verbose = true;
+EXPORT_SYMBOL(printk_console_verbose);
+
+module_param_named(console_verbose, printk_console_verbose, bool, 0644);
+MODULE_PARM_DESC(console_verbose, "Raise console loglevel to highest on oops/panic/etc");
+
 /**
  * suspend_console - suspend the console subsystem
  *
-- 
2.32.0

