Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C435C2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhDLJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241373AbhDLJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35CC761247;
        Mon, 12 Apr 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220314;
        bh=bqEtBdOkvB/DNRA6H4F+NMJ2qqkMlorwIcznImbrFYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnBUps08cY4sxYvkhOiMh0HQ+gZKylUsOD4F56PdgXp1BScQfaZ50rP4pzbdjkh42
         RjOQd/o1+R03TqemMeFTM5igu+B1R5aBMH3F/dKRD4DUeshBkJMT/dBPd4Zzi99i1R
         wMSrnCUmkgisZ4CUZuK4tJLqG02X2onJh6pUBbLik2ppj4qCmGS9dN4tX/jxkaXtvp
         6kUaBfrLIiG/CLDu7gb9tMDPq1kPYq+/0wd/yYAPiCTygVIdmw5Ty099O+xhNUzrfT
         /t3DwQiOuOSeGR+WD3/M8CJ7TC8tTyiP3ghSJD1URSjFtJgs2kUxYb3SUUXXGT26bo
         MG2RKeKpVG/dw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVt1Y-0000Cr-Jo; Mon, 12 Apr 2021 11:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] USB: serial: ti_usb_3410_5052: drop drain delay for 3410
Date:   Mon, 12 Apr 2021 11:38:15 +0200
Message-Id: <20210412093815.736-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412093815.736-1-johan@kernel.org>
References: <20210412093815.736-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the TUSB5052, the TUSB3410 has an LSR TEMT bit to tell if both
the transmitter data and shift registers are empty.

Make sure to check also the shift register on TUSB3410 when waiting for
the transmit buffer to drain during close and drop the time-based
one-char delay which is otherwise needed (e.g. 90 ms at 110 bps).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 8ed64115987f..d9bffb2de8bf 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -121,6 +121,7 @@
 #define TI_LSR_ERROR			0x0F
 #define TI_LSR_RX_FULL			0x10
 #define TI_LSR_TX_EMPTY			0x20
+#define TI_LSR_TX_EMPTY_BOTH		0x40
 
 /* Line control */
 #define TI_LCR_BREAK			0x40
@@ -614,7 +615,8 @@ static int ti_port_probe(struct usb_serial_port *port)
 	 * The TUSB5052 LSR does not tell when the transmitter shift register
 	 * has emptied so add a one-character drain delay.
 	 */
-	port->port.drain_delay = 1;
+	if (!tport->tp_tdev->td_is_3410)
+		port->port.drain_delay = 1;
 
 	return 0;
 }
@@ -851,11 +853,20 @@ static int ti_chars_in_buffer(struct tty_struct *tty)
 static bool ti_tx_empty(struct usb_serial_port *port)
 {
 	struct ti_port *tport = usb_get_serial_port_data(port);
+	u8 lsr, mask;
 	int ret;
-	u8 lsr;
+
+	/*
+	 * TUSB5052 does not have the TEMT bit to tell if the shift register
+	 * is empty.
+	 */
+	if (tport->tp_tdev->td_is_3410)
+		mask = TI_LSR_TX_EMPTY_BOTH;
+	else
+		mask = TI_LSR_TX_EMPTY;
 
 	ret = ti_get_lsr(tport, &lsr);
-	if (!ret && !(lsr & TI_LSR_TX_EMPTY))
+	if (!ret && !(lsr & mask))
 		return false;
 
 	return true;
-- 
2.26.3

