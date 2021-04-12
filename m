Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71AE35C2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbhDLJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239291AbhDLJjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF626124C;
        Mon, 12 Apr 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220314;
        bh=yaWMoh1oN0d0dzUD64dBH6HNKA51GCQDv/Tyy4bCSB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVU4TruWKRttYfsqbLq2Wh3TVWOkKwy/Lp88ouY0B+B0PPgOepR4920sHMMHwx+xk
         msqlb/ExSwzcmhAq58a8JQizuYfseChN8mZyHiqdC7Bgyns8887WIWiKf1ewqOXBBa
         24OchhzKrcubCAc+9lJ7kwQEqFOHN2HvNrNRTWnfoKyQT4s65cboevfoCQr/DYWjLv
         HFHFuBI5r4m3yijmI/0yNh2uQRpcb0mGi2e3AFFtHaeysKRJB4wLCiuWcMp2JU+dHq
         afjzx1AqkNG4XhZ+RHE/eHAXwCSjJYlN+BB6FjSxM7MS1SnPRV5uJemNT/0hDCi4oI
         Cqq+zY4DKRukg==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVt1Y-0000Co-Gv; Mon, 12 Apr 2021 11:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] USB: serial: ti_usb_3410_5052: reduce drain delay to one char
Date:   Mon, 12 Apr 2021 11:38:14 +0200
Message-Id: <20210412093815.736-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412093815.736-1-johan@kernel.org>
References: <20210412093815.736-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three-character drain delay was added by commit f1175daa5312 ("USB:
ti_usb_3410_5052: kill custom closing_wait") when removing the custom
closing-wait implementation, which used a fixed 20 ms poll period and
drain delay.

This was likely a bit too conservative as a one-character timeout (e.g.
33 ms at 300 bps) should be enough to compensate for the lack of a
transmitter empty bit in the TUSB5052 line-status register.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 03839289d6c0..8ed64115987f 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -610,7 +610,11 @@ static int ti_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, tport);
 
-	port->port.drain_delay = 3;
+	/*
+	 * The TUSB5052 LSR does not tell when the transmitter shift register
+	 * has emptied so add a one-character drain delay.
+	 */
+	port->port.drain_delay = 1;
 
 	return 0;
 }
-- 
2.26.3

