Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BB3AC3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFRGVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:21:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhFRGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D2FC21B78;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFSZYeDrwRYRWTUYjDH02bF7eRx8Ylf2/6cryqmW8hI=;
        b=vf/6BUaDWoGsbBwpGCqNoZRebAnlqtAxZaRNxl6X8GC263QWW0TEEX9VfUgi2r/sbpmRzb
        1qcSXCIxRbYvYzDgu8OvZCIpxzbpfg6CxERmb+/YREluGt2U+O0KAVuauPqMyjuxGaeT45
        QHtkgE2mv75/3HJWHveAxTCg69/Qajo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFSZYeDrwRYRWTUYjDH02bF7eRx8Ylf2/6cryqmW8hI=;
        b=39CBZUQmhzGrX0jEbKtQglOvrMgpwyl7WSMa9F8xLBcs4vc844JjYQ6EOkSDb67M9ThdPO
        7Jaicelc4UoPyeAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D869A3BA7;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 66/70] mxser: introduce mxser_16550A_or_MUST helper
Date:   Fri, 18 Jun 2021 08:15:12 +0200
Message-Id: <20210618061516.662-67-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check is used in the code on many places. Either in positive or
negative form. So introduce a helper called mxser_16550A_or_MUST for
this purpose. And replace all the occurrences.

This simplifies many ifs in there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f238d17d6fdf..900ccb2ca166 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -398,6 +398,11 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 	return MOXA_OTHER_UART;
 }
 
+static bool mxser_16550A_or_MUST(struct mxser_port *info)
+{
+	return info->type == PORT_16550A || info->board->must_hwid;
+}
+
 static void mxser_process_txrx_fifo(struct mxser_port *info)
 {
 	unsigned int i;
@@ -537,8 +542,7 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 		if (cts) {
 			tty->hw_stopped = 0;
 
-			if (info->type != PORT_16550A &&
-					!info->board->must_hwid)
+			if (!mxser_16550A_or_MUST(info))
 				__mxser_start_tx(info);
 			tty_wakeup(tty);
 		}
@@ -547,7 +551,7 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 		return;
 
 	tty->hw_stopped = 1;
-	if (info->type != PORT_16550A && !info->board->must_hwid)
+	if (!mxser_16550A_or_MUST(info))
 		__mxser_stop_tx(info);
 }
 
@@ -626,7 +630,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 	tty_port_set_cts_flow(&info->port, cflag & CRTSCTS);
 	if (cflag & CRTSCTS) {
 		info->IER |= UART_IER_MSI;
-		if ((info->type == PORT_16550A) || (info->board->must_hwid)) {
+		if (mxser_16550A_or_MUST(info)) {
 			info->MCR |= UART_MCR_AFE;
 		} else {
 			mxser_handle_cts(tty, info,
@@ -962,11 +966,10 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 		total += c;
 	}
 
-	if (info->xmit_cnt && !tty->flow.stopped) {
-		if (!tty->hw_stopped || info->type == PORT_16550A ||
-				info->board->must_hwid)
+	if (info->xmit_cnt && !tty->flow.stopped)
+		if (!tty->hw_stopped || mxser_16550A_or_MUST(info))
 			mxser_start_tx(info);
-	}
+
 	return total;
 }
 
@@ -996,8 +999,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 	struct mxser_port *info = tty->driver_data;
 
 	if (!info->xmit_cnt || tty->flow.stopped || !info->port.xmit_buf ||
-			(tty->hw_stopped && info->type != PORT_16550A &&
-			 !info->board->must_hwid))
+			(tty->hw_stopped && !mxser_16550A_or_MUST(info)))
 		return;
 
 	mxser_start_tx(info);
@@ -1655,9 +1657,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		return;
 
 	if (!port->xmit_cnt || tty->flow.stopped ||
-			(tty->hw_stopped &&
-			(port->type != PORT_16550A) &&
-			(!port->board->must_hwid))) {
+			(tty->hw_stopped && !mxser_16550A_or_MUST(port))) {
 		__mxser_stop_tx(port);
 		return;
 	}
-- 
2.32.0

