Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FD35697B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbhDGKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350936AbhDGKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E294613CE;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=MYJodErwJtLvlMj+dEhMM1b5fX/LATb85PPnocm4wyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4efwDEAhpfHDrmN60UfUPuq4iYI1mZya9IWdbrJsenM+uQHv3fllGVKxmxYQFBx3
         RJhoCnF3H8vLa0JgKL9zPbP2Mxlrg1mAYnT0lbd7cnNTIgbhqhF8YUNJaQ16Jdv+Sd
         fSggtQeOh0p8ExZwA2u4PE+5i8ovFV26mIo7ogEXAAj8tgwc/qqvx6eO3rC1dODU/7
         BjNHMw8eEh01C8kbV6gS2MIn4Zjhzr4CZXizuSUdDKrFNXMAIahFde2XWdWN4Q2SMl
         /imWhiRhQL2GJknhnG+EYpYyJlXKGrknNAFl7JXatHjJKM/pt9aQooP5R32DAKswkg
         aCzNFhs9/pFWA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008RQ-BN; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 09/16] tty: amiserial: add missing TIOCSSERIAL jiffies conversions
Date:   Wed,  7 Apr 2021 12:23:27 +0200
Message-Id: <20210407102334.32361-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tty-port close_delay and closing_wait parameters set by TIOCSSERIAL
are specified in jiffies, while the values returned by TIOCGSERIAL are
specified in centiseconds.

Add the missing conversions so that TIOCSSERIAL works as expected also
if this code is ever reused on a system where HZ is not 100.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/amiserial.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index ec6802ba2bf8..ca48ce5a0862 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -937,15 +937,21 @@ static void rs_unthrottle(struct tty_struct * tty)
 static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct serial_state *state = tty->driver_data;
+	unsigned int close_delay, closing_wait;
 
 	tty_lock(tty);
+	close_delay = jiffies_to_msecs(state->tport.close_delay) / 10;
+	closing_wait = state->tport.closing_wait;
+	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		closing_wait = jiffies_to_msecs(closing_wait) / 10;
+
 	ss->line = tty->index;
 	ss->port = state->port;
 	ss->flags = state->tport.flags;
 	ss->xmit_fifo_size = state->xmit_fifo_size;
 	ss->baud_base = state->baud_base;
-	ss->close_delay = state->tport.close_delay;
-	ss->closing_wait = state->tport.closing_wait;
+	ss->close_delay = close_delay;
+	ss->closing_wait = closing_wait;
 	ss->custom_divisor = state->custom_divisor;
 	tty_unlock(tty);
 	return 0;
@@ -957,6 +963,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	struct tty_port *port = &state->tport;
 	bool change_spd;
 	int 			retval = 0;
+	unsigned int close_delay, closing_wait;
 
 	tty_lock(tty);
 	change_spd = ((ss->flags ^ port->flags) & ASYNC_SPD_MASK) ||
@@ -966,11 +973,16 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 		tty_unlock(tty);
 		return -EINVAL;
 	}
-  
+
+	close_delay = msecs_to_jiffies(ss->close_delay * 10);
+	closing_wait = ss->closing_wait;
+	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		closing_wait = msecs_to_jiffies(closing_wait * 10);
+
 	if (!serial_isroot()) {
 		if ((ss->baud_base != state->baud_base) ||
-		    (ss->close_delay != port->close_delay) ||
-		    (ss->closing_wait != port->closing_wait) ||
+		    (close_delay != port->close_delay) ||
+		    (closing_wait != port->closing_wait) ||
 		    (ss->xmit_fifo_size != state->xmit_fifo_size) ||
 		    ((ss->flags & ~ASYNC_USR_MASK) !=
 		     (port->flags & ~ASYNC_USR_MASK))) {
@@ -997,8 +1009,8 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	port->flags = ((port->flags & ~ASYNC_FLAGS) |
 			(ss->flags & ASYNC_FLAGS));
 	state->custom_divisor = ss->custom_divisor;
-	port->close_delay = ss->close_delay * HZ/100;
-	port->closing_wait = ss->closing_wait * HZ/100;
+	port->close_delay = close_delay;
+	port->closing_wait = closing_wait;
 
 check_and_exit:
 	if (tty_port_initialized(port)) {
-- 
2.26.3

