Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6834EA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhC3OkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhC3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 503A1619CE;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=XavjB/y+uDK8bs3HXUhhEQ0GH5i/U+Jdhi5O/wBQGQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT9ZSBNxXqUiYxi4zOrBK6geaDyMVDTMLF1jzHXjHc+Kw2i99wvSka73mwC/mT9NP
         t0R9ffmPihLYudafShZ1E1Zhb/iDlZLiWRDCspBAZiI1ts0A4qk+IbJAM+0Xm/ov3c
         xfWiIRC3AyYWJcpxpZg1gBHH4SVEJOzaOLys9b11oJ6ihB37o1swL24BO4KByM/H5+
         TF0jsVpE4SgwwJZC27MihH2xrsW/dnZDIToBzmgVfLg/W89EKWpraOQiZlNjpHErQQ
         14oJM4URYoZpKnqISvK6S6g7L9sN9gqlgkLYAMDLs45F+QMoUPx5U5qGDASnwbLvKe
         luT7xGNX8wBCw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002PR-AF; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] USB: serial: xr: drop type prefix from shared defines
Date:   Tue, 30 Mar 2021 16:39:30 +0200
Message-Id: <20210330143934.9197-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for further types, drop the type
prefix from defines that are not specific to XR21V141X.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 122 ++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 542c1dc060cc..bbfe92fcabc0 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -54,45 +54,45 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_UM_RX_FIFO_RESET	0x18
 #define XR21V141X_UM_TX_FIFO_RESET	0x1c
 
-#define XR21V141X_UART_ENABLE_TX	0x1
-#define XR21V141X_UART_ENABLE_RX	0x2
+#define XR_UART_ENABLE_TX		0x1
+#define XR_UART_ENABLE_RX		0x2
 
-#define XR21V141X_GPIO_RI		BIT(0)
-#define XR21V141X_GPIO_CD		BIT(1)
-#define XR21V141X_GPIO_DSR		BIT(2)
-#define XR21V141X_GPIO_DTR		BIT(3)
-#define XR21V141X_GPIO_CTS		BIT(4)
-#define XR21V141X_GPIO_RTS		BIT(5)
+#define XR_GPIO_RI			BIT(0)
+#define XR_GPIO_CD			BIT(1)
+#define XR_GPIO_DSR			BIT(2)
+#define XR_GPIO_DTR			BIT(3)
+#define XR_GPIO_CTS			BIT(4)
+#define XR_GPIO_RTS			BIT(5)
 
 #define XR21V141X_UART_BREAK_ON		0xff
 #define XR21V141X_UART_BREAK_OFF	0
 
-#define XR21V141X_UART_DATA_MASK	GENMASK(3, 0)
-#define XR21V141X_UART_DATA_7		0x7
-#define XR21V141X_UART_DATA_8		0x8
-
-#define XR21V141X_UART_PARITY_MASK	GENMASK(6, 4)
-#define XR21V141X_UART_PARITY_SHIFT	4
-#define XR21V141X_UART_PARITY_NONE	(0x0 << XR21V141X_UART_PARITY_SHIFT)
-#define XR21V141X_UART_PARITY_ODD	(0x1 << XR21V141X_UART_PARITY_SHIFT)
-#define XR21V141X_UART_PARITY_EVEN	(0x2 << XR21V141X_UART_PARITY_SHIFT)
-#define XR21V141X_UART_PARITY_MARK	(0x3 << XR21V141X_UART_PARITY_SHIFT)
-#define XR21V141X_UART_PARITY_SPACE	(0x4 << XR21V141X_UART_PARITY_SHIFT)
-
-#define XR21V141X_UART_STOP_MASK	BIT(7)
-#define XR21V141X_UART_STOP_SHIFT	7
-#define XR21V141X_UART_STOP_1		(0x0 << XR21V141X_UART_STOP_SHIFT)
-#define XR21V141X_UART_STOP_2		(0x1 << XR21V141X_UART_STOP_SHIFT)
-
-#define XR21V141X_UART_FLOW_MODE_NONE	0x0
-#define XR21V141X_UART_FLOW_MODE_HW	0x1
-#define XR21V141X_UART_FLOW_MODE_SW	0x2
-
-#define XR21V141X_GPIO_MODE_MASK	GENMASK(2, 0)
-#define XR21V141X_GPIO_MODE_RTS_CTS	0x1
-#define XR21V141X_GPIO_MODE_DTR_DSR	0x2
-#define XR21V141X_GPIO_MODE_RS485	0x3
-#define XR21V141X_GPIO_MODE_RS485_ADDR	0x4
+#define XR_UART_DATA_MASK		GENMASK(3, 0)
+#define XR_UART_DATA_7			0x7
+#define XR_UART_DATA_8			0x8
+
+#define XR_UART_PARITY_MASK		GENMASK(6, 4)
+#define XR_UART_PARITY_SHIFT		4
+#define XR_UART_PARITY_NONE		(0x0 << XR_UART_PARITY_SHIFT)
+#define XR_UART_PARITY_ODD		(0x1 << XR_UART_PARITY_SHIFT)
+#define XR_UART_PARITY_EVEN		(0x2 <<	XR_UART_PARITY_SHIFT)
+#define XR_UART_PARITY_MARK		(0x3 << XR_UART_PARITY_SHIFT)
+#define XR_UART_PARITY_SPACE		(0x4 << XR_UART_PARITY_SHIFT)
+
+#define XR_UART_STOP_MASK		BIT(7)
+#define XR_UART_STOP_SHIFT		7
+#define XR_UART_STOP_1			(0x0 << XR_UART_STOP_SHIFT)
+#define XR_UART_STOP_2			(0x1 << XR_UART_STOP_SHIFT)
+
+#define XR_UART_FLOW_MODE_NONE		0x0
+#define XR_UART_FLOW_MODE_HW		0x1
+#define XR_UART_FLOW_MODE_SW		0x2
+
+#define XR_GPIO_MODE_MASK		GENMASK(2, 0)
+#define XR_GPIO_MODE_RTS_CTS		0x1
+#define XR_GPIO_MODE_DTR_DSR		0x2
+#define XR_GPIO_MODE_RS485		0x3
+#define XR_GPIO_MODE_RS485_ADDR		0x4
 
 #define XR21V141X_REG_ENABLE		0x03
 #define XR21V141X_REG_FORMAT		0x0b
@@ -210,7 +210,7 @@ static int xr_uart_enable(struct usb_serial_port *port)
 		return ret;
 
 	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE,
-			      XR21V141X_UART_ENABLE_TX | XR21V141X_UART_ENABLE_RX);
+			      XR_UART_ENABLE_TX | XR_UART_ENABLE_RX);
 	if (ret)
 		return ret;
 
@@ -250,12 +250,12 @@ static int xr_tiocmget(struct tty_struct *tty)
 	 * Modem control pins are active low, so reading '0' means it is active
 	 * and '1' means not active.
 	 */
-	ret = ((status & XR21V141X_GPIO_DTR) ? 0 : TIOCM_DTR) |
-	      ((status & XR21V141X_GPIO_RTS) ? 0 : TIOCM_RTS) |
-	      ((status & XR21V141X_GPIO_CTS) ? 0 : TIOCM_CTS) |
-	      ((status & XR21V141X_GPIO_DSR) ? 0 : TIOCM_DSR) |
-	      ((status & XR21V141X_GPIO_RI) ? 0 : TIOCM_RI) |
-	      ((status & XR21V141X_GPIO_CD) ? 0 : TIOCM_CD);
+	ret = ((status & XR_GPIO_DTR) ? 0 : TIOCM_DTR) |
+	      ((status & XR_GPIO_RTS) ? 0 : TIOCM_RTS) |
+	      ((status & XR_GPIO_CTS) ? 0 : TIOCM_CTS) |
+	      ((status & XR_GPIO_DSR) ? 0 : TIOCM_DSR) |
+	      ((status & XR_GPIO_RI) ? 0 : TIOCM_RI) |
+	      ((status & XR_GPIO_CD) ? 0 : TIOCM_CD);
 
 	return ret;
 }
@@ -269,13 +269,13 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 
 	/* Modem control pins are active low, so set & clr are swapped */
 	if (set & TIOCM_RTS)
-		gpio_clr |= XR21V141X_GPIO_RTS;
+		gpio_clr |= XR_GPIO_RTS;
 	if (set & TIOCM_DTR)
-		gpio_clr |= XR21V141X_GPIO_DTR;
+		gpio_clr |= XR_GPIO_DTR;
 	if (clear & TIOCM_RTS)
-		gpio_set |= XR21V141X_GPIO_RTS;
+		gpio_set |= XR_GPIO_RTS;
 	if (clear & TIOCM_DTR)
-		gpio_set |= XR21V141X_GPIO_DTR;
+		gpio_set |= XR_GPIO_DTR;
 
 	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
 	if (gpio_clr)
@@ -433,24 +433,24 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		return;
 
 	/* Set GPIO mode for controlling the pins manually by default. */
-	gpio_mode &= ~XR21V141X_GPIO_MODE_MASK;
+	gpio_mode &= ~XR_GPIO_MODE_MASK;
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-		gpio_mode |= XR21V141X_GPIO_MODE_RTS_CTS;
-		flow = XR21V141X_UART_FLOW_MODE_HW;
+		gpio_mode |= XR_GPIO_MODE_RTS_CTS;
+		flow = XR_UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
 		u8 start_char = START_CHAR(tty);
 		u8 stop_char = STOP_CHAR(tty);
 
 		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
-		flow = XR21V141X_UART_FLOW_MODE_SW;
+		flow = XR_UART_FLOW_MODE_SW;
 
 		xr_set_reg_uart(port, XR21V141X_REG_XON_CHAR, start_char);
 		xr_set_reg_uart(port, XR21V141X_REG_XOFF_CHAR, stop_char);
 	} else {
 		dev_dbg(&port->dev, "Disabling flow ctrl\n");
-		flow = XR21V141X_UART_FLOW_MODE_NONE;
+		flow = XR_UART_FLOW_MODE_NONE;
 	}
 
 	/*
@@ -491,37 +491,37 @@ static void xr_set_termios(struct tty_struct *tty,
 			termios->c_cflag |= CS8;
 
 		if (C_CSIZE(tty) == CS7)
-			bits |= XR21V141X_UART_DATA_7;
+			bits |= XR_UART_DATA_7;
 		else
-			bits |= XR21V141X_UART_DATA_8;
+			bits |= XR_UART_DATA_8;
 		break;
 	case CS7:
-		bits |= XR21V141X_UART_DATA_7;
+		bits |= XR_UART_DATA_7;
 		break;
 	case CS8:
 	default:
-		bits |= XR21V141X_UART_DATA_8;
+		bits |= XR_UART_DATA_8;
 		break;
 	}
 
 	if (C_PARENB(tty)) {
 		if (C_CMSPAR(tty)) {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_MARK;
+				bits |= XR_UART_PARITY_MARK;
 			else
-				bits |= XR21V141X_UART_PARITY_SPACE;
+				bits |= XR_UART_PARITY_SPACE;
 		} else {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_ODD;
+				bits |= XR_UART_PARITY_ODD;
 			else
-				bits |= XR21V141X_UART_PARITY_EVEN;
+				bits |= XR_UART_PARITY_EVEN;
 		}
 	}
 
 	if (C_CSTOPB(tty))
-		bits |= XR21V141X_UART_STOP_2;
+		bits |= XR_UART_STOP_2;
 	else
-		bits |= XR21V141X_UART_STOP_1;
+		bits |= XR_UART_STOP_1;
 
 	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
 	if (ret)
@@ -603,7 +603,7 @@ static int xr_gpio_init(struct usb_serial_port *port)
 	 * Configure DTR and RTS as outputs and make sure they are deasserted
 	 * (active low), and configure RI, CD, DSR and CTS as inputs.
 	 */
-	mask = XR21V141X_GPIO_DTR | XR21V141X_GPIO_RTS;
+	mask = XR_GPIO_DTR | XR_GPIO_RTS;
 	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, mask);
 	if (ret)
 		return ret;
-- 
2.26.3

