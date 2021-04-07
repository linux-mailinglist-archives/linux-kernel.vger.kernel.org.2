Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6D356A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351400AbhDGKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351171AbhDGKkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 813DF613D1;
        Wed,  7 Apr 2021 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=hxIJtit8EJ+Brug2ei0l8Ef85prFYKfb3oZE4LDPzpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVspfmEPa8er2cjfB+y3xA0dzojAAv5vX/qOnYHKDrAyjbk0RJ5V+u9XHOE9YvpgO
         7sYSVssG4GRB9stoIZzsGPT8iEd4PyRPDH8r5iflrm+ibpLvskZrpDEaMsYxHYi+Bz
         kdxPG4C7NcPTHF9IojRxDUlkpFbhDMSCu1LK+r3EXVTcANA5Ju4b6QGzIgSeFdT/y9
         +PwcyPo+s2RfJOFNHYZGMk4FrTRWZMbsRUTb9ftKFmoyfaCp2tSzWbrG+R0uXTZQXw
         0W33FDbp4fbwKozrqQ+bnRoFQ3SqJisSI7fsoTDn6NDxo7lrYSOvJV/f6Za4yt49+K
         uPkjbgG9rLmUA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b6-0000Fg-D7; Wed, 07 Apr 2021 12:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] USB: serial: ftdi_sio: clean up TIOCSSERIAL
Date:   Wed,  7 Apr 2021 12:39:25 +0200
Message-Id: <20210407103925.829-25-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIOCSSERIAL implementation needs to compare the old flag and divisor
settings with the new to detect ASYNC_SPD changes, but there's no need
to copy all driver state to the stack for that.

While at it, unbreak the function parameter list.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9228e56a91c0..6f2659e59b2e 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1486,15 +1486,13 @@ static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	ss->custom_divisor = priv->custom_divisor;
 }
 
-static int set_serial_info(struct tty_struct *tty,
-	struct serial_struct *ss)
+static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct ftdi_private old_priv;
+	int old_flags, old_divisor;
 
 	mutex_lock(&priv->cfg_lock);
-	old_priv = *priv;
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((ss->flags ^ priv->flags) & ~ASYNC_USR_MASK) {
@@ -1503,14 +1501,17 @@ static int set_serial_info(struct tty_struct *tty,
 		}
 	}
 
+	old_flags = priv->flags;
+	old_divisor = priv->custom_divisor;
+
 	priv->flags = ss->flags & ASYNC_FLAGS;
 	priv->custom_divisor = ss->custom_divisor;
 
 	write_latency_timer(port);
 
-	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK ||
+	if ((priv->flags ^ old_flags) & ASYNC_SPD_MASK ||
 			((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
-			 priv->custom_divisor != old_priv.custom_divisor)) {
+			 priv->custom_divisor != old_divisor)) {
 
 		/* warn about deprecation unless clearing */
 		if (priv->flags & ASYNC_SPD_MASK)
-- 
2.26.3

