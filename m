Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5331B927
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBOMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:25:52 -0500
Received: from marcansoft.com ([212.63.210.85]:43122 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBOMUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:20:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5D4D542529;
        Mon, 15 Feb 2021 12:19:08 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/25] tty: serial: samsung_tty: IRQ rework
Date:   Mon, 15 Feb 2021 21:17:07 +0900
Message-Id: <20210215121713.57687-20-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
  where only the latter acquires the port lock.

* For S3C64xx, return IRQ_NONE if no flag bits were set, so the
  interrupt core can detect IRQ storms. Note that both IRQ handlers
  always return IRQ_HANDLED anyway, so 'or' logic isn't necessary here,
  if either handler ran we are always going to return IRQ_HANDLED.

* Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
  consistency with the above. All it does now is call two other
  functions anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 41 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 21955be680a4..821cd0e4f870 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -151,6 +151,9 @@ struct s3c24xx_uart_port {
 #endif
 };
 
+static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
+static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
+
 /* conversion functions */
 
 #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
@@ -316,8 +319,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	ourport->tx_mode = 0;
 }
 
-static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
-
 static void s3c24xx_serial_tx_dma_complete(void *args)
 {
 	struct s3c24xx_uart_port *ourport = args;
@@ -825,7 +826,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 
@@ -834,16 +835,12 @@ static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	return s3c24xx_serial_rx_chars_pio(dev_id);
 }
 
-static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
+static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
-	unsigned long flags;
 	int count, dma_count = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
 	if (ourport->dma && ourport->dma->tx_chan &&
@@ -860,7 +857,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		wr_reg(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		goto out;
+		return;
 	}
 
 	/* if there isn't anything more to transmit, or the uart is now
@@ -869,7 +866,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 		s3c24xx_serial_stop_tx(port);
-		goto out;
+		return;
 	}
 
 	/* try and drain the buffer... */
@@ -891,7 +888,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (!count && dma_count) {
 		s3c24xx_serial_start_tx_dma(ourport, dma_count);
-		goto out;
+		return;
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
@@ -902,8 +899,18 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
+}
+
+static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
+{
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	s3c24xx_serial_tx_chars(ourport);
 
-out:
 	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -914,14 +921,14 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
-	irqreturn_t ret = IRQ_HANDLED;
+	irqreturn_t ret = IRQ_NONE;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
-		ret = s3c24xx_serial_rx_chars(irq, id);
+		ret = s3c24xx_serial_rx_irq(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
 	}
 	if (pend & S3C64XX_UINTM_TXD_MSK) {
-		ret = s3c24xx_serial_tx_chars(irq, id);
+		ret = s3c24xx_serial_tx_irq(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
 	return ret;
@@ -1153,7 +1160,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->rx_enabled = 1;
 
-	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_chars, 0,
+	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_irq, 0,
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret != 0) {
@@ -1167,7 +1174,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->tx_enabled = 1;
 
-	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_chars, 0,
+	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_irq, 0,
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret) {
-- 
2.30.0

