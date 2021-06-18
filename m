Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F73AC396
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhFRGTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:19:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhFRGRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC8B421B63;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdHJiYFLEsbDOMQIptWXqcPojbfcv3AmVx69LGNxAPQ=;
        b=wPO4iVOOpi5QjgLE93oQzht05KVVo/1wbH5aXv+R4ukDAgBjNfVthlcrKaHbYejJetmKaw
        XRxrVaJgCuV9sd9CbZ9bjfoDluy8GVDoHYwwUgeoH7tqKiufxIdurrnCMN2pagykrNAshe
        3PlYoBFJaEVRdlHa/gfKLHBhJJjQRPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdHJiYFLEsbDOMQIptWXqcPojbfcv3AmVx69LGNxAPQ=;
        b=E2oD3KC8if9ESGFvG93tb1GOImwGPLZNoOA8sN5R9KEEdxnXopnPt74Qy10w4l0r/1bvfs
        M23mipdXvzYnr4Ag==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3F39A3B9E;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/70] mxser: drop mxser_port::custom_divisor
Date:   Fri, 18 Jun 2021 08:14:42 +0200
Message-Id: <20210618061516.662-37-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's an once-set constant, so define a macro for the constant
(MXSER_CUSTOM_DIVISOR) and use it in the code instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 204b71c4d1ae..c4ee5cb6952e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -157,6 +157,7 @@
 #define WAKEUP_CHARS		256
 
 #define MXSER_BAUD_BASE		921600
+#define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
 
 #define PCI_DEVICE_ID_POS104UL	0x1044
 #define PCI_DEVICE_ID_CB108	0x1080
@@ -284,8 +285,6 @@ struct mxser_port {
 
 	unsigned char ldisc_stop_rx;
 
-	int custom_divisor;
-
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
 	unsigned int timeout;
 
@@ -1226,7 +1225,7 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	ss->baud_base = MXSER_BAUD_BASE,
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
-	ss->custom_divisor = info->custom_divisor,
+	ss->custom_divisor = MXSER_CUSTOM_DIVISOR,
 	mutex_unlock(&port->mutex);
 	return 0;
 }
@@ -1285,7 +1284,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
 				(ss->baud_base != MXSER_BAUD_BASE ||
 				ss->custom_divisor !=
-				info->custom_divisor)) {
+				MXSER_CUSTOM_DIVISOR)) {
 			if (ss->custom_divisor == 0) {
 				mutex_unlock(&port->mutex);
 				return -EINVAL;
@@ -2019,7 +2018,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 
 		process_txrx_fifo(info);
 
-		info->custom_divisor = MXSER_BAUD_BASE * 16;
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
 		spin_lock_init(&info->slock);
-- 
2.32.0

