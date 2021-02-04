Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5272430FEA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBDUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBDUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:41:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0AC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:41:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1AC2542840;
        Thu,  4 Feb 2021 20:40:22 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple UARTs
Date:   Fri,  5 Feb 2021 05:39:38 +0900
Message-Id: <20210204203951.52105-6-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs are a distant descendant of Samsung designs and use yet
another variant of their UART style, with different interrupt handling.

In particular, this variant has the following differences with existing
ones:

* It includes a built-in interrupt controller with different registers,
  using only a single platform IRQ

* Internal interrupt sources are treated as edge-triggered, even though
  the IRQ output is level-triggered. This chiefly affects the TX IRQ
  path: the driver can no longer rely on the TX buffer empty IRQ
  immediately firing after TX is enabled, but instead must prime the
  FIFO with data directly.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 297 +++++++++++++++++++++++++++----
 include/linux/serial_s3c.h       |  16 ++
 include/uapi/linux/serial_core.h |   3 +
 3 files changed, 280 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 8ae3e03fbd8c..6d812ba1b748 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -56,6 +56,9 @@
 /* flag to ignore all characters coming in */
 #define RXSTAT_DUMMY_READ (0x10000000)
 
+/* IRQ number used when the handler is called in non-IRQ context */
+#define NO_IRQ -1
+
 struct s3c24xx_uart_info {
 	char			*name;
 	unsigned int		type;
@@ -144,6 +147,14 @@ struct s3c24xx_uart_port {
 #endif
 };
 
+enum s3c24xx_irq_type {
+	IRQ_DISCRETE = 0,
+	IRQ_S3C6400 = 1,
+	IRQ_APPLE = 2,
+};
+
+static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
+
 /* conversion functions */
 
 #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
@@ -231,11 +242,20 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 /*
  * s3c64xx and later SoC's include the interrupt mask and status registers in
  * the controller itself, unlike the s3c24xx SoC's which have these registers
- * in the interrupt controller. Check if the port type is s3c64xx or higher.
+ * in the interrupt controller. Apple SoCs use a different flavor of mask
+ * and status registers. This function returns the IRQ style to use.
  */
-static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
+static int s3c24xx_irq_type(struct uart_port *port)
 {
-	return to_ourport(port)->info->type == PORT_S3C6400;
+	switch (to_ourport(port)->info->type) {
+	case PORT_S3C6400:
+		return IRQ_S3C6400;
+	case PORT_APPLE:
+		return IRQ_APPLE;
+	default:
+		return IRQ_DISCRETE;
+	}
+
 }
 
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
@@ -289,10 +309,17 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	if (!ourport->tx_enabled)
 		return;
 
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	switch (s3c24xx_irq_type(port)) {
+	case IRQ_APPLE:
+		s3c24xx_clear_bit(port, APPLE_UCON_TXTHRESH_ENA, S3C2410_UCON);
+		break;
+	case IRQ_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
-	else
+		break;
+	default:
 		disable_irq_nosync(ourport->tx_irq);
+		break;
+	}
 
 	if (dma && dma->tx_chan && ourport->tx_in_progress == S3C24XX_TX_DMA) {
 		dmaengine_pause(dma->tx_chan);
@@ -315,8 +342,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	ourport->tx_mode = 0;
 }
 
-static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
-
 static void s3c24xx_serial_tx_dma_complete(void *args)
 {
 	struct s3c24xx_uart_port *ourport = args;
@@ -353,10 +378,17 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	u32 ucon;
 
 	/* Mask Tx interrupt */
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	switch (s3c24xx_irq_type(port)) {
+	case IRQ_APPLE:
+		WARN_ON(1); // No DMA
+		break;
+	case IRQ_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
-	else
+		break;
+	default:
 		disable_irq_nosync(ourport->tx_irq);
+		break;
+	}
 
 	/* Enable tx dma mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -369,6 +401,8 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	ourport->tx_mode = S3C24XX_TX_DMA;
 }
 
+static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id);
+
 static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
@@ -383,16 +417,30 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
 	ucon |= S3C64XX_UCON_TXMODE_CPU;
-	wr_regl(port,  S3C2410_UCON, ucon);
 
 	/* Unmask Tx interrupt */
-	if (s3c24xx_serial_has_interrupt_mask(port))
-		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
-				  S3C64XX_UINTM);
-	else
+	switch (s3c24xx_irq_type(port)) {
+	case IRQ_APPLE:
+		ucon |= APPLE_UCON_TXTHRESH_ENA_MSK;
+		break;
+	case IRQ_S3C6400:
+		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
+		break;
+	default:
 		enable_irq(ourport->tx_irq);
+		break;
+	}
+
+	wr_regl(port,  S3C2410_UCON, ucon);
 
 	ourport->tx_mode = S3C24XX_TX_PIO;
+
+	/*
+	 * The Apple version only has edge triggered TX IRQs, so we need
+	 * to kick off the process by sending some characters here.
+	 */
+	if (s3c24xx_irq_type(port) == IRQ_APPLE)
+		s3c24xx_serial_tx_chars(NO_IRQ, ourport);
 }
 
 static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
@@ -513,11 +561,18 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 
 	if (ourport->rx_enabled) {
 		dev_dbg(port->dev, "stopping rx\n");
-		if (s3c24xx_serial_has_interrupt_mask(port))
-			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
-					S3C64XX_UINTM);
-		else
-			disable_irq_nosync(ourport->rx_irq);
+		switch (s3c24xx_irq_type(port)) {
+		case IRQ_APPLE:
+			s3c24xx_clear_bit(port, APPLE_UCON_RXTHRESH_ENA, S3C2410_UCON);
+			s3c24xx_clear_bit(port, APPLE_UCON_RXTO_ENA, S3C2410_UCON);
+			break;
+		case IRQ_S3C6400:
+			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
+			break;
+		default:
+			disable_irq_nosync(ourport->tx_irq);
+			break;
+		}
 		ourport->rx_enabled = 0;
 	}
 	if (dma && dma->rx_chan) {
@@ -651,14 +706,18 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
-	ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
-			S3C64XX_UCON_EMPTYINT_EN |
-			S3C64XX_UCON_DMASUS_EN |
-			S3C64XX_UCON_TIMEOUT_EN |
-			S3C64XX_UCON_RXMODE_MASK);
-	ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
-			S3C64XX_UCON_TIMEOUT_EN |
-			S3C64XX_UCON_RXMODE_CPU;
+	ucon &= ~S3C64XX_UCON_RXMODE_MASK;
+	ucon |= S3C64XX_UCON_RXMODE_CPU;
+
+	/* Apple types use these bits for IRQ masks */
+	if (s3c24xx_irq_type(port) != IRQ_APPLE) {
+		ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
+				S3C64XX_UCON_EMPTYINT_EN |
+				S3C64XX_UCON_DMASUS_EN |
+				S3C64XX_UCON_TIMEOUT_EN);
+		ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
+				S3C64XX_UCON_TIMEOUT_EN;
+	}
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_mode = S3C24XX_RX_PIO;
@@ -831,7 +890,9 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	unsigned long flags;
 	int count, dma_count = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	/* Only lock if called from IRQ context */
+	if (irq != NO_IRQ)
+		spin_lock_irqsave(&port->lock, flags);
 
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
@@ -893,7 +954,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		s3c24xx_serial_stop_tx(port);
 
 out:
-	spin_unlock_irqrestore(&port->lock, flags);
+	if (irq != NO_IRQ)
+		spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -916,6 +978,26 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	return ret;
 }
 
+/* interrupt handler for Apple SoC's.*/
+static irqreturn_t apple_serial_handle_irq(int irq, void *id)
+{
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
+	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
+	irqreturn_t ret = IRQ_HANDLED;
+
+	if (pend & (APPLE_UTRSTAT_RXTHRESH | APPLE_UTRSTAT_RXTO)) {
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_RXTHRESH | APPLE_UTRSTAT_RXTO);
+		ret = s3c24xx_serial_rx_chars(irq, id);
+	}
+	if (pend & APPLE_UTRSTAT_TXTHRESH) {
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_TXTHRESH);
+		ret = s3c24xx_serial_tx_chars(irq, id);
+	}
+
+	return ret;
+}
+
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
@@ -1098,7 +1180,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (ourport->tx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
+		if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
 			free_irq(ourport->tx_irq, ourport);
 		ourport->tx_enabled = 0;
 		ourport->tx_claimed = 0;
@@ -1106,18 +1188,34 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	}
 
 	if (ourport->rx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
+		if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
 			free_irq(ourport->rx_irq, ourport);
 		ourport->rx_claimed = 0;
 		ourport->rx_enabled = 0;
 	}
 
 	/* Clear pending interrupts and mask all interrupts */
-	if (s3c24xx_serial_has_interrupt_mask(port)) {
+	switch (s3c24xx_irq_type(port)) {
+	case IRQ_APPLE: {
+		unsigned int ucon;
+
+		ucon = rd_regl(port, S3C2410_UCON);
+		ucon &= ~(APPLE_UCON_TXTHRESH_ENA_MSK |
+			APPLE_UCON_RXTHRESH_ENA_MSK |
+			APPLE_UCON_RXTO_ENA_MSK);
+		wr_regl(port, S3C2410_UCON, ucon);
+
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_ALL_FLAGS);
+
+		free_irq(port->irq, ourport);
+		break;
+	}
+	case IRQ_S3C6400:
 		free_irq(port->irq, ourport);
 
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTM, 0xf);
+		break;
 	}
 
 	if (ourport->dma)
@@ -1215,6 +1313,47 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+static int apple_serial_startup(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	unsigned long flags;
+	unsigned int ufcon;
+	int ret;
+
+	wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_ALL_FLAGS);
+
+	ret = request_irq(port->irq, apple_serial_handle_irq, IRQF_SHARED,
+			  s3c24xx_serial_portname(port), ourport);
+	if (ret) {
+		dev_err(port->dev, "cannot get irq %d\n", port->irq);
+		return ret;
+	}
+
+	/* For compatibility with s3c24xx Soc's */
+	ourport->rx_enabled = 1;
+	ourport->rx_claimed = 1;
+	ourport->tx_enabled = 0;
+	ourport->tx_claimed = 1;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	ufcon = rd_regl(port, S3C2410_UFCON);
+	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
+	if (!uart_console(port))
+		ufcon |= S3C2410_UFCON_RESETTX;
+	wr_regl(port, S3C2410_UFCON, ufcon);
+
+	enable_rx_pio(ourport);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	/* Enable Rx Interrupt */
+	s3c24xx_set_bit(port, APPLE_UCON_RXTHRESH_ENA, S3C2410_UCON);
+	s3c24xx_set_bit(port, APPLE_UCON_RXTO_ENA, S3C2410_UCON);
+
+	return ret;
+}
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -1544,6 +1683,8 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 		return "S3C2412";
 	case PORT_S3C6400:
 		return "S3C6400/10";
+	case PORT_APPLE:
+		return "APPLE";
 	default:
 		return NULL;
 	}
@@ -1868,9 +2009,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	/* setup info for port */
 	port->dev	= &platdev->dev;
 
+	switch (s3c24xx_irq_type(port)) {
+	/* Startup sequence is different for Apple SoC's */
+	case IRQ_APPLE:
+		s3c24xx_serial_ops.startup = apple_serial_startup;
+		break;
 	/* Startup sequence is different for s3c64xx and higher SoC's */
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	case IRQ_S3C6400:
 		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
+		break;
+	}
 
 	port->uartclk = 1;
 
@@ -1905,7 +2053,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	if (!s3c24xx_serial_has_interrupt_mask(port)) {
+	if (s3c24xx_irq_type(port) == IRQ_DISCRETE) {
 		ret = platform_get_irq(platdev, 1);
 		if (ret > 0)
 			ourport->tx_irq = ret;
@@ -1945,10 +2093,24 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		pr_warn("uart: failed to enable baudclk\n");
 
 	/* Keep all interrupts masked and cleared */
-	if (s3c24xx_serial_has_interrupt_mask(port)) {
+	switch (s3c24xx_irq_type(port)) {
+	case IRQ_APPLE: {
+		unsigned int ucon;
+
+		ucon = rd_regl(port, S3C2410_UCON);
+		ucon &= ~(APPLE_UCON_TXTHRESH_ENA_MSK |
+			APPLE_UCON_RXTHRESH_ENA_MSK |
+			APPLE_UCON_RXTO_ENA_MSK);
+		wr_regl(port, S3C2410_UCON, ucon);
+
+		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_ALL_FLAGS);
+		break;
+	}
+	case IRQ_S3C6400:
 		wr_regl(port, S3C64XX_UINTM, 0xf);
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
+		break;
 	}
 
 	dev_dbg(port->dev, "port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
@@ -2142,7 +2304,33 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 
 	if (port) {
 		/* restore IRQ mask */
-		if (s3c24xx_serial_has_interrupt_mask(port)) {
+		switch (s3c24xx_irq_type(port)) {
+		case IRQ_APPLE:
+			unsigned int ucon;
+
+			clk_prepare_enable(ourport->clk);
+			if (!IS_ERR(ourport->baudclk))
+				clk_prepare_enable(ourport->baudclk);
+
+			ucon = rd_regl(port, S3C2410_UCON);
+
+			ucon &= ~(APPLE_UCON_TXTHRESH_ENA_MSK |
+				APPLE_UCON_RXTHRESH_ENA_MSK |
+				APPLE_UCON_RXTO_ENA_MSK);
+
+			if (ourport->tx_enabled)
+				ucon |= APPLE_UCON_TXTHRESH_ENA_MSK;
+			if (ourport->rx_enabled)
+				ucon |= APPLE_UCON_RXTHRESH_ENA_MSK |
+					APPLE_UCON_RXTO_ENA_MSK;
+
+			wr_regl(port, S3C2410_UCON, ucon);
+
+			if (!IS_ERR(ourport->baudclk))
+				clk_disable_unprepare(ourport->baudclk);
+			clk_disable_unprepare(ourport->clk);
+			break;
+		case IRQ_S3C6400:
 			unsigned int uintm = 0xf;
 
 			if (ourport->tx_enabled)
@@ -2156,6 +2344,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 			if (!IS_ERR(ourport->baudclk))
 				clk_disable_unprepare(ourport->baudclk);
 			clk_disable_unprepare(ourport->clk);
+			break;
 		}
 	}
 
@@ -2556,6 +2745,34 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 #define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
 #endif
 
+#if defined(CONFIG_ARCH_APPLE)
+static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
+	.info = &(struct s3c24xx_uart_info) {
+		.name		= "Apple S5L UART",
+		.type		= PORT_APPLE,
+		.fifosize	= 16,
+		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
+		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
+		.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
+		.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
+		.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = &(struct s3c2410_uartcfg) {
+		.ucon		= APPLE_UCON_DEFAULT,
+		.ufcon		= S3C2410_UFCON_DEFAULT,
+	},
+};
+#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
+#else
+#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#endif
+
+
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c2410-uart",
@@ -2578,6 +2795,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos5433-uart",
 		.driver_data	= EXYNOS5433_SERIAL_DRV_DATA,
+	}, {
+		.name		= "s5l-uart",
+		.driver_data	= S5L_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2599,6 +2819,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = (void *)EXYNOS4210_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos5433-uart",
 		.data = (void *)EXYNOS5433_SERIAL_DRV_DATA },
+	{ .compatible = "AAPL,s5l-uart",
+		.data = (void *)S5L_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
@@ -2694,6 +2916,9 @@ static int __init s3c2410_early_console_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 			s3c2410_early_console_setup);
+/* Apple SoCs are close enough to s3c2410 for earlycon */
+OF_EARLYCON_DECLARE(s5l, "AAPL,s5l-uart",
+			s3c2410_early_console_setup);
 
 /* S3C2412, S3C2440, S3C64xx */
 static struct samsung_early_console_data s3c2440_early_console_data = {
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index ca2c5393dc6b..377c8c6e5b97 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -246,6 +246,22 @@
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
+
+#define APPLE_UCON_RXTO_ENA	9
+#define APPLE_UCON_RXTHRESH_ENA	12
+#define APPLE_UCON_TXTHRESH_ENA	13
+#define APPLE_UCON_RXTO_ENA_MSK		(1 << APPLE_UCON_RXTO_ENA)
+#define APPLE_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_UCON_RXTHRESH_ENA)
+#define APPLE_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_UCON_TXTHRESH_ENA)
+
+#define APPLE_UCON_DEFAULT	  S3C2410_UCON_RXFIFO_TOI
+
+#define APPLE_UTRSTAT_RXTHRESH	(1<<4)
+#define APPLE_UTRSTAT_TXTHRESH	(1<<5)
+#define APPLE_UTRSTAT_RXTO	(1<<9)
+#define APPLE_UTRSTAT_ALL_FLAGS	(0x3f0)
+
+
 #ifndef __ASSEMBLY__
 
 #include <linux/serial_core.h>
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 62c22045fe65..59d102b674db 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -277,4 +277,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* Apple Silicon (M1/T8103) UART (Samsung variant) */
+#define PORT_APPLE	123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.30.0

