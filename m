Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFC326364
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBZNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhBZNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:30:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4842D64E02;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=EqAVE00Bhz2V0/BrUrgzI2CYbOwiHkLvZwBESOfbHNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8p3JYeVFnA9wIi8kzEOPMYMR2k6RHeUIqPsOZrYI36hh5FIzScJlhhvJ/kUCVRMI
         OMrVnaH3SohLY+DbfIKvUG31Jby8S4QV8hGVvuID3v0TEEqNbb5auDCcbyTPWNaxAq
         jwYt1/Fupbq2xYMsHoek/2JHemKC1zvDMnzEap26Uier2RbPqsz1uUzOwjzlYiZyMq
         PtkqDgL8QTu8UGgWBCxYOvEJSTnWOhANm2jhPaV91GVlN3j55uHT4q5Zybqisp1B54
         BV0RS7bhfUYs+26n8zlEVAnTmdm49Xf5JBeaF4Mr1Kv+Wo1XQRP+RMRoc3FFBfe2vU
         hdegWWszLodBw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nbq-IH; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/7] USB: serial: xr: simplify its namespace
Date:   Fri, 26 Feb 2021 14:28:27 +0100
Message-Id: <d8b3d2012b9cb82bfc6c2b13ecd58be0ff8171be.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614345081.git.mchehab+huawei@kernel.org>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several registers that work with different models
of this chipset. Simplify their namespaces.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 224 ++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 112 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 0ca04906da4b..169c7ef11d73 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -25,73 +25,73 @@ struct xr_txrx_clk_mask {
 };
 
 #define XR_INT_OSC_HZ			48000000U
-#define XR21V141X_MIN_SPEED		46U
-#define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
+#define MIN_SPEED			46U
+#define MAX_SPEED			XR_INT_OSC_HZ
 
 /* USB Requests */
-#define XR21V141X_SET_REQ		0
-#define XR21V141X_GET_REQ		1
-
-#define XR21V141X_CLOCK_DIVISOR_0	0x04
-#define XR21V141X_CLOCK_DIVISOR_1	0x05
-#define XR21V141X_CLOCK_DIVISOR_2	0x06
-#define XR21V141X_TX_CLOCK_MASK_0	0x07
-#define XR21V141X_TX_CLOCK_MASK_1	0x08
-#define XR21V141X_RX_CLOCK_MASK_0	0x09
-#define XR21V141X_RX_CLOCK_MASK_1	0x0a
-
-/* XR21V141X register blocks */
-#define XR21V141X_UART_REG_BLOCK	0
-#define XR21V141X_UM_REG_BLOCK		4
-#define XR21V141X_UART_CUSTOM_BLOCK	0x66
-
-/* XR21V141X UART Manager Registers */
-#define XR21V141X_UM_FIFO_ENABLE_REG	0x10
-#define XR21V141X_UM_ENABLE_TX_FIFO	0x01
-#define XR21V141X_UM_ENABLE_RX_FIFO	0x02
-
-#define XR21V141X_UM_RX_FIFO_RESET	0x18
-#define XR21V141X_UM_TX_FIFO_RESET	0x1c
-
-#define XR21V141X_UART_ENABLE_TX	0x1
-#define XR21V141X_UART_ENABLE_RX	0x2
-
-#define XR21V141X_UART_MODE_RI		BIT(0)
-#define XR21V141X_UART_MODE_CD		BIT(1)
-#define XR21V141X_UART_MODE_DSR		BIT(2)
-#define XR21V141X_UART_MODE_DTR		BIT(3)
-#define XR21V141X_UART_MODE_CTS		BIT(4)
-#define XR21V141X_UART_MODE_RTS		BIT(5)
-
-#define XR21V141X_UART_BREAK_ON		0xff
-#define XR21V141X_UART_BREAK_OFF	0
-
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
-#define XR21V141X_UART_MODE_GPIO_MASK	GENMASK(2, 0)
-#define XR21V141X_UART_MODE_RTS_CTS	0x1
-#define XR21V141X_UART_MODE_DTR_DSR	0x2
-#define XR21V141X_UART_MODE_RS485	0x3
-#define XR21V141X_UART_MODE_RS485_ADDR	0x4
+#define SET_REQ				0
+#define GET_REQ				1
+
+#define CLOCK_DIVISOR_0			0x04
+#define CLOCK_DIVISOR_1			0x05
+#define CLOCK_DIVISOR_2			0x06
+#define TX_CLOCK_MASK_0			0x07
+#define TX_CLOCK_MASK_1			0x08
+#define RX_CLOCK_MASK_0			0x09
+#define RX_CLOCK_MASK_1			0x0a
+
+/* Register blocks */
+#define UART_REG_BLOCK			0
+#define UM_REG_BLOCK			4
+#define UART_CUSTOM_BLOCK		0x66
+
+/* UART Manager Registers */
+#define UM_FIFO_ENABLE_REG		0x10
+#define UM_ENABLE_TX_FIFO		0x01
+#define UM_ENABLE_RX_FIFO		0x02
+
+#define UM_RX_FIFO_RESET		0x18
+#define UM_TX_FIFO_RESET		0x1c
+
+#define UART_ENABLE_TX			0x1
+#define UART_ENABLE_RX			0x2
+
+#define UART_MODE_RI			BIT(0)
+#define UART_MODE_CD			BIT(1)
+#define UART_MODE_DSR			BIT(2)
+#define UART_MODE_DTR			BIT(3)
+#define UART_MODE_CTS			BIT(4)
+#define UART_MODE_RTS			BIT(5)
+
+#define UART_BREAK_ON			0xff
+#define UART_BREAK_OFF			0
+
+#define UART_DATA_MASK			GENMASK(3, 0)
+#define UART_DATA_7			0x7
+#define UART_DATA_8			0x8
+
+#define UART_PARITY_MASK		GENMASK(6, 4)
+#define UART_PARITY_SHIFT		4
+#define UART_PARITY_NONE		(0x0 << UART_PARITY_SHIFT)
+#define UART_PARITY_ODD			(0x1 << UART_PARITY_SHIFT)
+#define UART_PARITY_EVEN		(0x2 << UART_PARITY_SHIFT)
+#define UART_PARITY_MARK		(0x3 << UART_PARITY_SHIFT)
+#define UART_PARITY_SPACE		(0x4 << UART_PARITY_SHIFT)
+
+#define UART_STOP_MASK			BIT(7)
+#define UART_STOP_SHIFT			7
+#define UART_STOP_1			(0x0 << UART_STOP_SHIFT)
+#define UART_STOP_2			(0x1 << UART_STOP_SHIFT)
+
+#define UART_FLOW_MODE_NONE		0x0
+#define UART_FLOW_MODE_HW		0x1
+#define UART_FLOW_MODE_SW		0x2
+
+#define UART_MODE_GPIO_MASK		GENMASK(2, 0)
+#define UART_MODE_RTS_CTS		0x1
+#define UART_MODE_DTR_DSR		0x2
+#define UART_MODE_RS485			0x3
+#define UART_MODE_RS485_ADDR		0x4
 
 #define XR21V141X_REG_ENABLE		0x03
 #define XR21V141X_REG_FORMAT		0x0b
@@ -115,7 +115,7 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 
 	ret = usb_control_msg(serial->dev,
 			      usb_sndctrlpipe(serial->dev, 0),
-			      XR21V141X_SET_REQ,
+			      SET_REQ,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      val, reg | (block << 8), NULL, 0,
 			      USB_CTRL_SET_TIMEOUT);
@@ -139,7 +139,7 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 
 	ret = usb_control_msg(serial->dev,
 			      usb_rcvctrlpipe(serial->dev, 0),
-			      XR21V141X_GET_REQ,
+			      GET_REQ,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, reg | (block << 8), dmabuf, 1,
 			      USB_CTRL_GET_TIMEOUT);
@@ -159,17 +159,17 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 
 static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u8 val)
 {
-	return xr_set_reg(port, XR21V141X_UART_REG_BLOCK, reg, val);
+	return xr_set_reg(port, UART_REG_BLOCK, reg, val);
 }
 
 static int xr_get_reg_uart(struct usb_serial_port *port, u8 reg, u8 *val)
 {
-	return xr_get_reg(port, XR21V141X_UART_REG_BLOCK, reg, val);
+	return xr_get_reg(port, UART_REG_BLOCK, reg, val);
 }
 
 static int xr_set_reg_um(struct usb_serial_port *port, u8 reg, u8 val)
 {
-	return xr_set_reg(port, XR21V141X_UM_REG_BLOCK, reg, val);
+	return xr_set_reg(port, UM_REG_BLOCK, reg, val);
 }
 
 /*
@@ -184,18 +184,18 @@ static int xr_uart_enable(struct usb_serial_port *port)
 {
 	int ret;
 
-	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
-			    XR21V141X_UM_ENABLE_TX_FIFO);
+	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG,
+			    UM_ENABLE_TX_FIFO);
 	if (ret)
 		return ret;
 
 	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE,
-			      XR21V141X_UART_ENABLE_TX | XR21V141X_UART_ENABLE_RX);
+			      UART_ENABLE_TX | UART_ENABLE_RX);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
-			    XR21V141X_UM_ENABLE_TX_FIFO | XR21V141X_UM_ENABLE_RX_FIFO);
+	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG,
+			    UM_ENABLE_TX_FIFO | UM_ENABLE_RX_FIFO);
 
 	if (ret)
 		xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
@@ -211,7 +211,7 @@ static int xr_uart_disable(struct usb_serial_port *port)
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG, 0);
+	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG, 0);
 
 	return ret;
 }
@@ -230,12 +230,12 @@ static int xr_tiocmget(struct tty_struct *tty)
 	 * Modem control pins are active low, so reading '0' means it is active
 	 * and '1' means not active.
 	 */
-	ret = ((status & XR21V141X_UART_MODE_DTR) ? 0 : TIOCM_DTR) |
-	      ((status & XR21V141X_UART_MODE_RTS) ? 0 : TIOCM_RTS) |
-	      ((status & XR21V141X_UART_MODE_CTS) ? 0 : TIOCM_CTS) |
-	      ((status & XR21V141X_UART_MODE_DSR) ? 0 : TIOCM_DSR) |
-	      ((status & XR21V141X_UART_MODE_RI) ? 0 : TIOCM_RI) |
-	      ((status & XR21V141X_UART_MODE_CD) ? 0 : TIOCM_CD);
+	ret = ((status & UART_MODE_DTR) ? 0 : TIOCM_DTR) |
+	      ((status & UART_MODE_RTS) ? 0 : TIOCM_RTS) |
+	      ((status & UART_MODE_CTS) ? 0 : TIOCM_CTS) |
+	      ((status & UART_MODE_DSR) ? 0 : TIOCM_DSR) |
+	      ((status & UART_MODE_RI) ? 0 : TIOCM_RI) |
+	      ((status & UART_MODE_CD) ? 0 : TIOCM_CD);
 
 	return ret;
 }
@@ -249,13 +249,13 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 
 	/* Modem control pins are active low, so set & clr are swapped */
 	if (set & TIOCM_RTS)
-		gpio_clr |= XR21V141X_UART_MODE_RTS;
+		gpio_clr |= UART_MODE_RTS;
 	if (set & TIOCM_DTR)
-		gpio_clr |= XR21V141X_UART_MODE_DTR;
+		gpio_clr |= UART_MODE_DTR;
 	if (clear & TIOCM_RTS)
-		gpio_set |= XR21V141X_UART_MODE_RTS;
+		gpio_set |= UART_MODE_RTS;
 	if (clear & TIOCM_DTR)
-		gpio_set |= XR21V141X_UART_MODE_DTR;
+		gpio_set |= UART_MODE_DTR;
 
 	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
 	if (gpio_clr)
@@ -289,12 +289,12 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 	u8 state;
 
 	if (break_state == 0)
-		state = XR21V141X_UART_BREAK_OFF;
+		state = UART_BREAK_OFF;
 	else
-		state = XR21V141X_UART_BREAK_ON;
+		state = UART_BREAK_ON;
 
 	dev_dbg(&port->dev, "Turning break %s\n",
-		state == XR21V141X_UART_BREAK_OFF ? "off" : "on");
+		state == UART_BREAK_OFF ? "off" : "on");
 	xr_set_reg_uart(port, XR21V141X_REG_TX_BREAK, state);
 }
 
@@ -345,7 +345,7 @@ static int xr_set_baudrate(struct tty_struct *tty,
 	if (!baud)
 		return 0;
 
-	baud = clamp(baud, XR21V141X_MIN_SPEED, XR21V141X_MAX_SPEED);
+	baud = clamp(baud, MIN_SPEED, MAX_SPEED);
 	divisor = XR_INT_OSC_HZ / baud;
 	idx = ((32 * XR_INT_OSC_HZ) / baud) & 0x1f;
 	tx_mask = xr21v141x_txrx_clk_masks[idx].tx;
@@ -361,37 +361,37 @@ static int xr_set_baudrate(struct tty_struct *tty,
 	 * oscillator and 19-bit programmable divisor. So theoretically it can
 	 * generate most commonly used baud rates with high accuracy.
 	 */
-	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_0,
+	ret = xr_set_reg_uart(port, CLOCK_DIVISOR_0,
 			      divisor & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_1,
+	ret = xr_set_reg_uart(port, CLOCK_DIVISOR_1,
 			      (divisor >>  8) & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_CLOCK_DIVISOR_2,
+	ret = xr_set_reg_uart(port, CLOCK_DIVISOR_2,
 			      (divisor >> 16) & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_TX_CLOCK_MASK_0,
+	ret = xr_set_reg_uart(port, TX_CLOCK_MASK_0,
 			      tx_mask & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_TX_CLOCK_MASK_1,
+	ret = xr_set_reg_uart(port, TX_CLOCK_MASK_1,
 			      (tx_mask >>  8) & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_RX_CLOCK_MASK_0,
+	ret = xr_set_reg_uart(port, RX_CLOCK_MASK_0,
 			      rx_mask & 0xff);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_RX_CLOCK_MASK_1,
+	ret = xr_set_reg_uart(port, RX_CLOCK_MASK_1,
 			      (rx_mask >>  8) & 0xff);
 	if (ret)
 		return ret;
@@ -413,24 +413,24 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		return;
 
 	/* Set GPIO mode for controlling the pins manually by default. */
-	gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
+	gpio_mode &= ~UART_MODE_GPIO_MASK;
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-		gpio_mode |= XR21V141X_UART_MODE_RTS_CTS;
-		flow = XR21V141X_UART_FLOW_MODE_HW;
+		gpio_mode |= UART_MODE_RTS_CTS;
+		flow = UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
 		u8 start_char = START_CHAR(tty);
 		u8 stop_char = STOP_CHAR(tty);
 
 		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
-		flow = XR21V141X_UART_FLOW_MODE_SW;
+		flow = UART_FLOW_MODE_SW;
 
 		xr_set_reg_uart(port, XR21V141X_REG_XON_CHAR, start_char);
 		xr_set_reg_uart(port, XR21V141X_REG_XOFF_CHAR, stop_char);
 	} else {
 		dev_dbg(&port->dev, "Disabling flow ctrl\n");
-		flow = XR21V141X_UART_FLOW_MODE_NONE;
+		flow = UART_FLOW_MODE_NONE;
 	}
 
 	/*
@@ -468,35 +468,35 @@ static void xr_set_termios(struct tty_struct *tty,
 		if (old_termios)
 			termios->c_cflag |= old_termios->c_cflag & CSIZE;
 		else
-			bits |= XR21V141X_UART_DATA_8;
+			bits |= UART_DATA_8;
 		break;
 	case CS7:
-		bits |= XR21V141X_UART_DATA_7;
+		bits |= UART_DATA_7;
 		break;
 	case CS8:
 	default:
-		bits |= XR21V141X_UART_DATA_8;
+		bits |= UART_DATA_8;
 		break;
 	}
 
 	if (C_PARENB(tty)) {
 		if (C_CMSPAR(tty)) {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_MARK;
+				bits |= UART_PARITY_MARK;
 			else
-				bits |= XR21V141X_UART_PARITY_SPACE;
+				bits |= UART_PARITY_SPACE;
 		} else {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_ODD;
+				bits |= UART_PARITY_ODD;
 			else
-				bits |= XR21V141X_UART_PARITY_EVEN;
+				bits |= UART_PARITY_EVEN;
 		}
 	}
 
 	if (C_CSTOPB(tty))
-		bits |= XR21V141X_UART_STOP_2;
+		bits |= UART_STOP_2;
 	else
-		bits |= XR21V141X_UART_STOP_1;
+		bits |= UART_STOP_1;
 
 	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
 	if (ret)
@@ -520,7 +520,7 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * Configure DTR and RTS as outputs and RI, CD, DSR and CTS as
 	 * inputs.
 	 */
-	gpio_dir = XR21V141X_UART_MODE_DTR | XR21V141X_UART_MODE_RTS;
+	gpio_dir = UART_MODE_DTR | UART_MODE_RTS;
 	xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, gpio_dir);
 
 	/* Setup termios */
-- 
2.29.2

