Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C1C3583B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhDHMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhDHMvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:51:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 652E961159;
        Thu,  8 Apr 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886303;
        bh=90bDJLQDfMB6rgu3acv0e55uB5+ai1ICqOxdDLACW/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0EmQFR76M0eK/I1a27tW7oDCzHAMuYPADKBnSBEg69LEMs5epgeW0m/CrjPINA73
         J6OCy87SKwXxKeozvcq/nKiSUygek+52gYmB/Zk+tP7Qqw9dzZTsoi1hGFdy5yXizc
         nOoal/+MZEAz934bt3ulocbgzA4FAKn7RHaDXYCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 01/13] tty: create internal tty.h file
Date:   Thu,  8 Apr 2021 14:51:22 +0200
Message-Id: <20210408125134.3016837-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of functions and #defines in include/linux/tty.h that
do not belong there as they are private to the tty core code.

Create an initial drivers/tty/tty.h file and copy the odd "tty logging"
macros into it to seed the file with some initial things that we know
nothing outside of the tty core should be calling.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_tty.c       |  1 +
 drivers/tty/pty.c         |  1 +
 drivers/tty/tty.h         | 21 +++++++++++++++++++++
 drivers/tty/tty_io.c      |  1 +
 drivers/tty/tty_jobctrl.c |  1 +
 drivers/tty/tty_ldisc.c   |  1 +
 drivers/tty/tty_port.c    |  1 +
 include/linux/tty.h       | 12 ------------
 8 files changed, 27 insertions(+), 12 deletions(-)
 create mode 100644 drivers/tty/tty.h

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 87ec15dbe10d..ff1b3154ba0c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
+#include "tty.h"
 
 /*
  * Until this number of characters is queued in the xmit buffer, select will
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 5e2374580e27..6c90d3fd2d51 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -29,6 +29,7 @@
 #include <linux/file.h>
 #include <linux/ioctl.h>
 #include <linux/compat.h>
+#include "tty.h"
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
new file mode 100644
index 000000000000..f4cd20261e91
--- /dev/null
+++ b/drivers/tty/tty.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TTY core internal functions
+ */
+
+#ifndef _TTY_INTERNAL_H
+#define _TTY_INTERNAL_H
+
+#define tty_msg(fn, tty, f, ...) \
+	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
+
+#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
+#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
+#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
+#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
+#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
+
+#define tty_info_ratelimited(tty, f, ...) \
+		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
+
+#endif
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 391bada4cedb..c95f72085cdb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -108,6 +108,7 @@
 
 #include <linux/kmod.h>
 #include <linux/nsproxy.h>
+#include "tty.h"
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 4b751b9285ad..0728730d38d1 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -11,6 +11,7 @@
 #include <linux/tty.h>
 #include <linux/fcntl.h>
 #include <linux/uaccess.h>
+#include "tty.h"
 
 static int is_ignored(int sig)
 {
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 1ba74d6f5e5c..2e8da820c303 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/ratelimit.h>
+#include "tty.h"
 
 #undef LDISC_DEBUG_HANGUP
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 346d20f4a486..303c198fbf5c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
+#include "tty.h"
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95fc2f100f12..fd8308a1f37e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -772,16 +772,4 @@ static inline void proc_tty_register_driver(struct tty_driver *d) {}
 static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
 #endif
 
-#define tty_msg(fn, tty, f, ...) \
-	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
-
-#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
-#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
-#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
-#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
-
-#define tty_info_ratelimited(tty, f, ...) \
-		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
-
 #endif
-- 
2.31.1

