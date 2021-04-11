Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FA35B280
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhDKI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:58:09 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:59372 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235189AbhDKI6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:58:08 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id VVucl8Pb0tpGHVVuglptFY; Sun, 11 Apr 2021 10:57:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1618131471; bh=RJGMGVLgxB4Slxzughjjm7TfB5RnGYXHJgoL7O/+O2s=;
        h=From;
        b=V1DPSXqbGKfbejUXtTlOKNdg1l4yBU53SnBP5//8/Wo0Jhcguy+HXSmWyiMr0RNiJ
         gpk8dWGtdI6qdbwv8gYQtieUMJL1HIb5OA6KfzE5QxlMaahR9TdFqbuanH1wKgpouK
         Iddhm0m+cZC/5MHrz9FL0fw+PreCnYudMj7wGtys8rWatWOAl+hvTLoRCZtaczFlLb
         VLCjPVhUA950cQ/QhIU0xk1zUnuhBDeDSfm96aYvjHaYi3IXlfmHwQ8bT2eqbzYuEd
         dgI4i9xHxYrzekP0V3ZI6bx5NQ7pNdo+SGyQ1HYwu+mFFAalpc0OOsb4VjE+ISB7Az
         yp4vwHMGbrmIw==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=6072ba0f cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=49ILBaynaru_GK_EE9QA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] serial: omap: don't disable rs485 if rts gpio is missing
Date:   Sun, 11 Apr 2021 10:57:43 +0200
Message-Id: <20210411085743.510-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfIoECLqNhuTXeLp+SAq2SoAQkQSPujoOyyjSuut6oyQggEgOWYrDzsX+sHHs/yNv/5LnT6OaQbVQXg8rKu3I+tZiDdmAOZAIqLcwse3nL5eZ8ZAR5juI
 m2dN4c71/KTWXkC7aqjNlmcX/7IPOMzqWSxz95Dui9ZMVzILIbxvgyR+lhk305nvPtHm+NedsP6ggNg8aORJq6WmY4hMKbQNn/ZBg2Y+P3HJ3aMYg31jmoKA
 5oAYP+qCR7NdqfCkZ7R3mr8glqwpcFRv9uEoubl4ASnPH1kByEX9L6uDl2fC5CelWvOHRtzE63OEuiUCtjcJt2rSxnVezcZID+MDmV1K0j0fTqjYILcyqvTe
 ENOD7WlPP+TQeHxhiAEhl8quNT5GCnyu40/sPcBpixn9MyDx5Yc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are rs485 transceivers (e.g. MAX13487E/MAX13488E) which
automatically disable or enable the driver and receiver to keep the bus
in the correct state.
In these cases we don't need a GPIO for flow control.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

 drivers/tty/serial/omap-serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 76b94d0ff586..1583e93b2202 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -302,7 +302,8 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			serial_out(up, UART_OMAP_SCR, up->scr);
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
-			if (gpiod_get_value(up->rts_gpiod) != res) {
+			if (up->rts_gpiod &&
+			    gpiod_get_value(up->rts_gpiod) != res) {
 				if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
@@ -411,7 +412,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 		/* if rts not already enabled */
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
-		if (gpiod_get_value(up->rts_gpiod) != res) {
+		if (up->rts_gpiod && gpiod_get_value(up->rts_gpiod) != res) {
 			gpiod_set_value(up->rts_gpiod, res);
 			if (port->rs485.delay_rts_before_send > 0)
 				mdelay(port->rs485.delay_rts_before_send);
@@ -1407,18 +1408,13 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	/* store new config */
 	port->rs485 = *rs485;
 
-	/*
-	 * Just as a precaution, only allow rs485
-	 * to be enabled if the gpio pin is valid
-	 */
 	if (up->rts_gpiod) {
 		/* enable / disable rts */
 		val = (port->rs485.flags & SER_RS485_ENABLED) ?
 			SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
 		val = (port->rs485.flags & val) ? 1 : 0;
 		gpiod_set_value(up->rts_gpiod, val);
-	} else
-		port->rs485.flags &= ~SER_RS485_ENABLED;
+	}
 
 	/* Enable interrupts */
 	up->ier = mode;
-- 
2.17.1

