Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627C03583CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhDHMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhDHMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D00061154;
        Thu,  8 Apr 2021 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886327;
        bh=6pbd0nXLY8Em2co7kCx6DQsk3Z5dd3HVVMZhuXcuDrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZ+1mM9+kQHmRwJ7IQOak9HZV6z8/1q2+40vfaDMn2eVLhxZu4m8RCd4gZ6nPv69X
         j+eD+LpWDMN+kFHclxxQqb0g8nYKhwGFIcgMHZ3v/U/nLROP6UALnidvVdT/RHg4+7
         JH4rS4GBRKH8zOFdbaSxo+ZZSOSW6tMSdVGfkVnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 05/13] tty: remove tty_warn()
Date:   Thu,  8 Apr 2021 14:51:26 +0200
Message-Id: <20210408125134.3016837-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove users of tty_warn() and replace them with calls to dev_warn()
which provides more information about the tty that has the error and
uses the standard formatting logic.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_tty.c       | 2 +-
 drivers/tty/tty.h         | 1 -
 drivers/tty/tty_io.c      | 8 ++++----
 drivers/tty/tty_jobctrl.c | 2 +-
 drivers/tty/tty_port.c    | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index dbe208342258..39a448ef0aed 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1200,7 +1200,7 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
 	ldata->num_overrun++;
 	if (time_after(jiffies, ldata->overrun_time + HZ) ||
 			time_after(ldata->overrun_time, jiffies)) {
-		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
+		dev_warn(tty->dev, "%d input overrun(s)\n", ldata->num_overrun);
 		ldata->overrun_time = jiffies;
 		ldata->num_overrun = 0;
 	}
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 0323bc2cd6ba..45b15cc250e8 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -10,7 +10,6 @@
 	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
 
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
 
 #define tty_info_ratelimited(tty, f, ...) \
 		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0079ffd0cb9c..2c3efa854ba5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -295,7 +295,7 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 	if (tty_port_kopened(tty->port))
 		kopen_count++;
 	if (tty->count != (count + kopen_count)) {
-		tty_warn(tty, "%s: tty->count(%d) != (#fd's(%d) + #kopen's(%d))\n",
+		dev_warn(tty->dev, "%s: tty->count(%d) != (#fd's(%d) + #kopen's(%d))\n",
 			 routine, tty->count, count, kopen_count);
 		return (count + kopen_count);
 	}
@@ -1823,7 +1823,7 @@ int tty_release(struct inode *inode, struct file *filp)
 
 		if (once) {
 			once = 0;
-			tty_warn(tty, "read/write wait queue active!\n");
+			dev_warn(tty->dev, "read/write wait queue active!\n");
 		}
 		schedule_timeout_killable(timeout);
 		if (timeout < 120 * HZ)
@@ -1834,12 +1834,12 @@ int tty_release(struct inode *inode, struct file *filp)
 
 	if (o_tty) {
 		if (--o_tty->count < 0) {
-			tty_warn(tty, "bad slave count (%d)\n", o_tty->count);
+			dev_warn(tty->dev, "bad slave count (%d)\n", o_tty->count);
 			o_tty->count = 0;
 		}
 	}
 	if (--tty->count < 0) {
-		tty_warn(tty, "bad tty->count (%d)\n", tty->count);
+		dev_warn(tty->dev, "bad tty->count (%d)\n", tty->count);
 		tty->count = 0;
 	}
 
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0728730d38d1..19ec43a6ef76 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -61,7 +61,7 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 	rcu_read_unlock();
 
 	if (!tty_pgrp)
-		tty_warn(tty, "sig=%d, tty->pgrp == NULL!\n", sig);
+		dev_warn(tty->dev, "sig=%d, tty->pgrp == NULL!\n", sig);
 
 	return ret;
 }
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 303c198fbf5c..575fe3933ff9 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -567,12 +567,12 @@ int tty_port_close_start(struct tty_port *port,
 
 	spin_lock_irqsave(&port->lock, flags);
 	if (tty->count == 1 && port->count != 1) {
-		tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
+		dev_warn(tty->dev, "%s: tty->count = 1 port count = %d\n", __func__,
 			 port->count);
 		port->count = 1;
 	}
 	if (--port->count < 0) {
-		tty_warn(tty, "%s: bad port count (%d)\n", __func__,
+		dev_warn(tty->dev, "%s: bad port count (%d)\n", __func__,
 			 port->count);
 		port->count = 0;
 	}
-- 
2.31.1

