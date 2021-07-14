Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44B3C8123
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhGNJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:16:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhGNJQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C7092059B;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JlFnYqEgNv8bD47/U44PZo65sU7hjCy4uMEacVRPTA=;
        b=0br3PVj2rF1QyXBPglOF4u2jMwpogxgGaSB4K5RW5it3oUcvMuM1ydw8ZOHViu1Ab+D4OB
        vttnqnjjh9H9pjiYMoHVxxdTJHAc5jTcrWEW3FwCACNe/BrDYzLD7Arf6cJOhWQu/BKJ21
        PhjD4UkMyJ5My0HLdpOKHIuH2CAlioo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JlFnYqEgNv8bD47/U44PZo65sU7hjCy4uMEacVRPTA=;
        b=P5LldfJjqv6ZRss2860YKTRjlAkPPukXy7wrb9GrAWwdZkCq8E/AORQheCsaqpJmwSQrr/
        q1E1EyimnlpIs+Cw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 224EBA3B81;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/11] amiserial: remove serial_state::xmit_fifo_size
Date:   Wed, 14 Jul 2021 11:13:07 +0200
Message-Id: <20210714091314.8292-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's always 1, so define a macro for it instead. Note that the check in
set_serial_info is doubled, hence remove the latter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 6edd2de01f39..0962b197e676 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -77,7 +77,6 @@ struct serial_state {
 
 	unsigned long		port;
 	int			baud_base;
-	int			xmit_fifo_size;
 	int			custom_divisor;
 	int			read_status_mask;
 	int			ignore_status_mask;
@@ -95,6 +94,8 @@ static struct tty_driver *serial_driver;
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
+#define XMIT_FIFO_SIZE 1
+
 static unsigned char current_ctl_bits;
 
 static void change_speed(struct tty_struct *tty, struct serial_state *info,
@@ -646,7 +647,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	if (!quot)
 		quot = baud_base / 9600;
 	info->quot = quot;
-	info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
+	info->timeout = (XMIT_FIFO_SIZE*HZ*bits*quot) / baud_base;
 	info->timeout += HZ/50;		/* Add .02 seconds of slop */
 
 	/* CTS flow control flag and modem status interrupts */
@@ -923,7 +924,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	ss->line = tty->index;
 	ss->port = state->port;
 	ss->flags = state->tport.flags;
-	ss->xmit_fifo_size = state->xmit_fifo_size;
+	ss->xmit_fifo_size = XMIT_FIFO_SIZE;
 	ss->baud_base = state->baud_base;
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
@@ -944,7 +945,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	change_spd = ((ss->flags ^ port->flags) & ASYNC_SPD_MASK) ||
 		ss->custom_divisor != state->custom_divisor;
 	if (ss->irq || ss->port != state->port ||
-			ss->xmit_fifo_size != state->xmit_fifo_size) {
+			ss->xmit_fifo_size != XMIT_FIFO_SIZE) {
 		tty_unlock(tty);
 		return -EINVAL;
 	}
@@ -958,7 +959,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 		if ((ss->baud_base != state->baud_base) ||
 		    (close_delay != port->close_delay) ||
 		    (closing_wait != port->closing_wait) ||
-		    (ss->xmit_fifo_size != state->xmit_fifo_size) ||
 		    ((ss->flags & ~ASYNC_USR_MASK) !=
 		     (port->flags & ~ASYNC_USR_MASK))) {
 			tty_unlock(tty);
@@ -1290,9 +1290,6 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
-	if (info->xmit_fifo_size == 0)
-		return; /* Just in case.... */
-
 	orig_jiffies = jiffies;
 
 	/*
@@ -1303,7 +1300,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
-	char_time = (info->timeout - HZ/50) / info->xmit_fifo_size;
+	char_time = (info->timeout - HZ/50) / XMIT_FIFO_SIZE;
 	char_time = char_time / 5;
 	if (char_time == 0)
 		char_time = 1;
@@ -1550,7 +1547,6 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	/* Hardware set up */
 
 	state->baud_base = amiga_colorclock;
-	state->xmit_fifo_size = 1;
 
 	/* set ISRs, and then disable the rx interrupts */
 	error = request_irq(IRQ_AMIGA_TBE, ser_tx_int, 0, "serial TX", state);
-- 
2.32.0

