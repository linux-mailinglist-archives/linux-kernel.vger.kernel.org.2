Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F13583D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhDHMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhDHMwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 564E761159;
        Thu,  8 Apr 2021 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886332;
        bh=vx/wGBpP3DrgUURWISJDCUfKFuEUjtmal8/Sd7LVam0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGzWlv7gtxScWv83SyP9EoLwvjci79Pk0gQX858TkZXuljQcEJhscnRHDcwUEGt5Y
         MQpXqJpmMvuXysBvaHM1JpQ2JIkytM1Xc/HHmaIwgJLQYnrcMfoFZHDbEmfe2P/ma8
         hhVAL4G+zXMSBZaWC8L61dZbg3Yu1TN8p2gKZtOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 07/13] tty: remove tty_debug()
Date:   Thu,  8 Apr 2021 14:51:28 +0200
Message-Id: <20210408125134.3016837-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove users of tty_debug() and replace them with calls to dev_dbg()
which provides more information about the tty that has the error and
uses the standard formatting logic.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/pty.c         |  2 +-
 drivers/tty/tty.h         |  5 -----
 drivers/tty/tty_io.c      | 14 +++++++-------
 drivers/tty/tty_ioctl.c   |  2 +-
 drivers/tty/tty_jobctrl.c |  4 ++--
 drivers/tty/tty_ldisc.c   |  2 +-
 6 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 6c90d3fd2d51..5695c78fbe55 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -33,7 +33,7 @@
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
-# define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
+# define tty_debug_hangup(tty, f, args...)	dev_dbg(tty->dev, f, ##args)
 #else
 # define tty_debug_hangup(tty, f, args...)	do {} while (0)
 #endif
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index a2084b58d4f3..e9cb918348cf 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -6,9 +6,4 @@
 #ifndef _TTY_INTERNAL_H
 #define _TTY_INTERNAL_H
 
-#define tty_msg(fn, tty, f, ...) \
-	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
-
-#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-
 #endif
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 91062fcc6667..1c480c04374c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -112,7 +112,7 @@
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
-# define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
+# define tty_debug_hangup(tty, f, args...)	dev_dbg(tty->dev, f, ##args)
 #else
 # define tty_debug_hangup(tty, f, args...)	do { } while (0)
 #endif
@@ -1639,7 +1639,7 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 {
 #ifdef TTY_PARANOIA_CHECK
 	if (idx < 0 || idx >= tty->driver->num) {
-		tty_debug(tty, "bad idx %d\n", idx);
+		dev_dbg(tty->dev, "bad idx %d\n", idx);
 		return -1;
 	}
 
@@ -1648,20 +1648,20 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 		return 0;
 
 	if (tty != tty->driver->ttys[idx]) {
-		tty_debug(tty, "bad driver table[%d] = %p\n",
-			  idx, tty->driver->ttys[idx]);
+		dev_dbg(tty->dev, "bad driver table[%d] = %p\n",
+			idx, tty->driver->ttys[idx]);
 		return -1;
 	}
 	if (tty->driver->other) {
 		struct tty_struct *o_tty = tty->link;
 
 		if (o_tty != tty->driver->other->ttys[idx]) {
-			tty_debug(tty, "bad other table[%d] = %p\n",
-				  idx, tty->driver->other->ttys[idx]);
+			dev_dbg(tty->dev, "bad other table[%d] = %p\n",
+				idx, tty->driver->other->ttys[idx]);
 			return -1;
 		}
 		if (o_tty->link != tty) {
-			tty_debug(tty, "bad link = %p\n", o_tty->link);
+			dev_dbg(tty->dev, "bad link = %p\n", o_tty->link);
 			return -1;
 		}
 	}
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 4de1c6ddb8ff..053290ab5cb8 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -28,7 +28,7 @@
 #undef TTY_DEBUG_WAIT_UNTIL_SENT
 
 #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
-# define tty_debug_wait_until_sent(tty, f, args...)    tty_debug(tty, f, ##args)
+# define tty_debug_wait_until_sent(tty, f, args...)    dev_dbg(tty->dev, f, ##args)
 #else
 # define tty_debug_wait_until_sent(tty, f, args...)    do {} while (0)
 #endif
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 19ec43a6ef76..bbc404255291 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -109,8 +109,8 @@ static void __proc_set_tty(struct tty_struct *tty)
 	tty->session = get_pid(task_session(current));
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 	if (current->signal->tty) {
-		tty_debug(tty, "current tty %s not NULL!!\n",
-			  current->signal->tty->name);
+		dev_dbg(tty->dev, "current tty %s not NULL!!\n",
+			current->signal->tty->name);
 		tty_kref_put(current->signal->tty);
 	}
 	put_pid(current->signal->tty_old_pgrp);
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 2e8da820c303..b2e821e14a13 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -24,7 +24,7 @@
 #undef LDISC_DEBUG_HANGUP
 
 #ifdef LDISC_DEBUG_HANGUP
-#define tty_ldisc_debug(tty, f, args...)	tty_debug(tty, f, ##args)
+#define tty_ldisc_debug(tty, f, args...)	dev_dbg(tty->dev, f, ##args)
 #else
 #define tty_ldisc_debug(tty, f, args...)
 #endif
-- 
2.31.1

