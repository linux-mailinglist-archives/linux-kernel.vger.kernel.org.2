Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB953FE6B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhIBAjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhIBAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:39:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74629C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=x4ajywfeBRi9SX4pNgriNIDLFaHB3+o38BrpWTGR8eg=; b=SzgFc3midOwu7V0d0c6ttu5QpI
        2vqtO0N5e0rYmxIj3sqfhFWAXbZhdso3dErd0K04ACffTP/xSFgH+BgpSk0uy91QvpZC2GIK9k7lw
        9NRRdBfZ5GtmeNAc6d8HdFZ7Ofw0JPc7Ozm3VxXJqSFG0BN11jVHb40qlvQPZtVYnak4RgpyTIyPn
        1BdoOIeSB3mYI5gG9EYzxw2vwEgtjm50/eapOTPdq1OW8uPZffSUELWPfHGwSOuUqxC+7MiaehaFH
        OiTm7qTjN7Gkc6xULfo1MyzGTU+Z8EUc72gj1Ho25STadWmwwbEed2NWZ2NTX8QE/fzbviAMFlpr8
        WLgKuwcg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLak3-00817x-Pr; Thu, 02 Sep 2021 00:38:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Fulghum <paulkf@microgate.com>
Subject: [PATCH] tty: synclink_gt: rename a conflicting function name
Date:   Wed,  1 Sep 2021 17:38:06 -0700
Message-Id: <20210902003806.17054-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


'set_signals()' in synclink_gt.c conflicts with an exported symbol
in arch/um/, so change set_signals() to set_gtsignals(). Keep
the function names similar by also changing get_signals() to
get_gtsignals().

../drivers/tty/synclink_gt.c:442:13: error: conflicting types for ‘set_signals’
 static void set_signals(struct slgt_info *info);
             ^~~~~~~~~~~
In file included from ../include/linux/irqflags.h:16:0,
                 from ../include/linux/spinlock.h:58,
                 from ../include/linux/mm_types.h:9,
                 from ../include/linux/buildid.h:5,
                 from ../include/linux/module.h:14,
                 from ../drivers/tty/synclink_gt.c:46:
../arch/um/include/asm/irqflags.h:6:5: note: previous declaration of ‘set_signals’ was here
 int set_signals(int enable);
     ^~~~~~~~~~~

Fixes: 705b6c7b34f2 ("[PATCH] new driver synclink_gt")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Paul Fulghum <paulkf@microgate.com>
---
 drivers/tty/synclink_gt.c |   44 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-next-20210901.orig/drivers/tty/synclink_gt.c
+++ linux-next-20210901/drivers/tty/synclink_gt.c
@@ -438,8 +438,8 @@ static void reset_tbufs(struct slgt_info
 static void tdma_reset(struct slgt_info *info);
 static bool tx_load(struct slgt_info *info, const char *buf, unsigned int count);
 
-static void get_signals(struct slgt_info *info);
-static void set_signals(struct slgt_info *info);
+static void get_gtsignals(struct slgt_info *info);
+static void set_gtsignals(struct slgt_info *info);
 static void set_rate(struct slgt_info *info, u32 data_rate);
 
 static void bh_transmit(struct slgt_info *info);
@@ -720,7 +720,7 @@ static void set_termios(struct tty_struc
 	if ((old_termios->c_cflag & CBAUD) && !C_BAUD(tty)) {
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
 		spin_lock_irqsave(&info->lock,flags);
-		set_signals(info);
+		set_gtsignals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 
@@ -730,7 +730,7 @@ static void set_termios(struct tty_struc
 		if (!C_CRTSCTS(tty) || !tty_throttled(tty))
 			info->signals |= SerialSignal_RTS;
 		spin_lock_irqsave(&info->lock,flags);
-	 	set_signals(info);
+	 	set_gtsignals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 
@@ -1181,7 +1181,7 @@ static inline void line_info(struct seq_
 
 	/* output current serial signal states */
 	spin_lock_irqsave(&info->lock,flags);
-	get_signals(info);
+	get_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	stat_buf[0] = 0;
@@ -1281,7 +1281,7 @@ static void throttle(struct tty_struct *
 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals &= ~SerialSignal_RTS;
-		set_signals(info);
+		set_gtsignals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -1306,7 +1306,7 @@ static void unthrottle(struct tty_struct
 	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals |= SerialSignal_RTS;
-		set_signals(info);
+		set_gtsignals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -1477,7 +1477,7 @@ static int hdlcdev_open(struct net_devic
 
 	/* inform generic HDLC layer of current DCD status */
 	spin_lock_irqsave(&info->lock, flags);
-	get_signals(info);
+	get_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock, flags);
 	if (info->signals & SerialSignal_DCD)
 		netif_carrier_on(dev);
@@ -2229,7 +2229,7 @@ static void isr_txeom(struct slgt_info *
 		if (info->params.mode != MGSL_MODE_ASYNC && info->drop_rts_on_tx_done) {
 			info->signals &= ~SerialSignal_RTS;
 			info->drop_rts_on_tx_done = false;
-			set_signals(info);
+			set_gtsignals(info);
 		}
 
 #if SYNCLINK_GENERIC_HDLC
@@ -2394,7 +2394,7 @@ static void shutdown(struct slgt_info *i
 
  	if (!info->port.tty || info->port.tty->termios.c_cflag & HUPCL) {
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
-		set_signals(info);
+		set_gtsignals(info);
 	}
 
 	flush_cond_wait(&info->gpio_wait_q);
@@ -2422,7 +2422,7 @@ static void program_hw(struct slgt_info
 	else
 		async_mode(info);
 
-	set_signals(info);
+	set_gtsignals(info);
 
 	info->dcd_chkcount = 0;
 	info->cts_chkcount = 0;
@@ -2430,7 +2430,7 @@ static void program_hw(struct slgt_info
 	info->dsr_chkcount = 0;
 
 	slgt_irq_on(info, IRQ_DCD | IRQ_CTS | IRQ_DSR | IRQ_RI);
-	get_signals(info);
+	get_gtsignals(info);
 
 	if (info->netcount ||
 	    (info->port.tty && info->port.tty->termios.c_cflag & CREAD))
@@ -2667,7 +2667,7 @@ static int wait_mgsl_event(struct slgt_i
 	spin_lock_irqsave(&info->lock,flags);
 
 	/* return immediately if state matches requested events */
-	get_signals(info);
+	get_gtsignals(info);
 	s = info->signals;
 
 	events = mask &
@@ -3085,7 +3085,7 @@ static int tiocmget(struct tty_struct *t
  	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock,flags);
- 	get_signals(info);
+ 	get_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	result = ((info->signals & SerialSignal_RTS) ? TIOCM_RTS:0) +
@@ -3124,7 +3124,7 @@ static int tiocmset(struct tty_struct *t
 		info->signals &= ~SerialSignal_DTR;
 
 	spin_lock_irqsave(&info->lock,flags);
-	set_signals(info);
+	set_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 	return 0;
 }
@@ -3135,7 +3135,7 @@ static int carrier_raised(struct tty_por
 	struct slgt_info *info = container_of(port, struct slgt_info, port);
 
 	spin_lock_irqsave(&info->lock,flags);
-	get_signals(info);
+	get_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 	return (info->signals & SerialSignal_DCD) ? 1 : 0;
 }
@@ -3150,7 +3150,7 @@ static void dtr_rts(struct tty_port *por
 		info->signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
-	set_signals(info);
+	set_gtsignals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
@@ -3948,10 +3948,10 @@ static void tx_start(struct slgt_info *i
 
 		if (info->params.mode != MGSL_MODE_ASYNC) {
 			if (info->params.flags & HDLC_FLAG_AUTO_RTS) {
-				get_signals(info);
+				get_gtsignals(info);
 				if (!(info->signals & SerialSignal_RTS)) {
 					info->signals |= SerialSignal_RTS;
-					set_signals(info);
+					set_gtsignals(info);
 					info->drop_rts_on_tx_done = true;
 				}
 			}
@@ -4005,7 +4005,7 @@ static void reset_port(struct slgt_info
 	rx_stop(info);
 
 	info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
-	set_signals(info);
+	set_gtsignals(info);
 
 	slgt_irq_off(info, IRQ_ALL | IRQ_MASTER);
 }
@@ -4427,7 +4427,7 @@ static void tx_set_idle(struct slgt_info
 /*
  * get state of V24 status (input) signals
  */
-static void get_signals(struct slgt_info *info)
+static void get_gtsignals(struct slgt_info *info)
 {
 	unsigned short status = rd_reg16(info, SSR);
 
@@ -4489,7 +4489,7 @@ static void msc_set_vcr(struct slgt_info
 /*
  * set state of V24 control (output) signals
  */
-static void set_signals(struct slgt_info *info)
+static void set_gtsignals(struct slgt_info *info)
 {
 	unsigned char val = rd_reg8(info, VCR);
 	if (info->signals & SerialSignal_DTR)
