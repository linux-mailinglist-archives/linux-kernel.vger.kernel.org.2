Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1C326358
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZNaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhBZN3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 485FF64EF6;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=FXbEtuBNOIxXV3zp2gvD1/CtfKYy+mgKCqYpFpp1Pc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1nHjoNWWEwXM3gPZpWJrKigGjjEdC+048ysl13rT5ex8VUdh17biLaMUz3hMauHD
         OVNhXyMldYyc7vRGrFgCzWNoFOZz/VPODggt7VtIx8gslQItCCUr2QUhW2O9Iaw0Pd
         pPuPF7XKYxfS4j4bs7LJZW881NJgj8RzP+lnHVXLnO2r3gWSBGX+um7zF3s5ge9KiX
         rwdkHVlGfL9ysPUpEzNC31Dec17LDJRVnqn+VwL384dckZGg6TU6bvwIBSO8qT8ZMN
         n3xOTtppDIF/EEgYpuMUJyfGQwPz7GYgWy+Z08gJVKx6gQpvz9nJXeZxznzr3RavSy
         tgp+szO30YxyA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nbs-JO; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/7] USB: serial: xr: use a table for device-specific settings
Date:   Fri, 26 Feb 2021 14:28:28 +0100
Message-Id: <7277c90d546f63b9ca69e6381a2f342e7054befd.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614345081.git.mchehab+huawei@kernel.org>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same driver is used by a wide range of MaxLinear devices.

Other models are close enough to use the same driver, but they
use a different register set.

So, instead of having the registers hardcoded at the driver,
use a table. This will allow further patches to add support for
other devices.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 151 ++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 169c7ef11d73..10f7fb40d9ae 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -28,10 +28,6 @@ struct xr_txrx_clk_mask {
 #define MIN_SPEED			46U
 #define MAX_SPEED			XR_INT_OSC_HZ
 
-/* USB Requests */
-#define SET_REQ				0
-#define GET_REQ				1
-
 #define CLOCK_DIVISOR_0			0x04
 #define CLOCK_DIVISOR_1			0x05
 #define CLOCK_DIVISOR_2			0x06
@@ -93,29 +89,73 @@ struct xr_txrx_clk_mask {
 #define UART_MODE_RS485			0x3
 #define UART_MODE_RS485_ADDR		0x4
 
-#define XR21V141X_REG_ENABLE		0x03
-#define XR21V141X_REG_FORMAT		0x0b
-#define XR21V141X_REG_FLOW_CTRL		0x0c
-#define XR21V141X_REG_XON_CHAR		0x10
-#define XR21V141X_REG_XOFF_CHAR		0x11
-#define XR21V141X_REG_LOOPBACK		0x12
-#define XR21V141X_REG_TX_BREAK		0x14
-#define XR21V141X_REG_RS845_DELAY	0x15
-#define XR21V141X_REG_GPIO_MODE		0x1a
-#define XR21V141X_REG_GPIO_DIR		0x1b
-#define XR21V141X_REG_GPIO_INT_MASK	0x1c
-#define XR21V141X_REG_GPIO_SET		0x1d
-#define XR21V141X_REG_GPIO_CLR		0x1e
-#define XR21V141X_REG_GPIO_STATUS	0x1f
+enum xr_model {
+	XR21V141X,
+	MAX_XR_MODELS
+};
+
+enum xr_hal_type {
+	REG_ENABLE,
+	REG_FORMAT,
+	REG_FLOW_CTRL,
+	REG_XON_CHAR,
+	REG_XOFF_CHAR,
+	REG_TX_BREAK,
+	REG_RS485_DELAY,
+	REG_GPIO_MODE,
+	REG_GPIO_DIR,
+	REG_GPIO_SET,
+	REG_GPIO_CLR,
+	REG_GPIO_STATUS,
+	REG_GPIO_INT_MASK,
+	REG_CUSTOMIZED_INT,
+	REG_GPIO_PULL_UP_ENABLE,
+	REG_GPIO_PULL_DOWN_ENABLE,
+	REG_LOOPBACK,
+	REG_LOW_LATENCY,
+	REG_CUSTOM_DRIVER,
+
+	REQ_SET,
+	REQ_GET,
+
+	MAX_XR_HAL_TYPE
+};
+
+static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
+	[XR21V141X] = {
+		[REG_ENABLE] =				0x03,
+		[REG_FORMAT] =				0x0b,
+		[REG_FLOW_CTRL] =			0x0c,
+		[REG_XON_CHAR] =			0x10,
+		[REG_XOFF_CHAR] =			0x11,
+		[REG_LOOPBACK] =			0x12,
+		[REG_TX_BREAK] =			0x14,
+		[REG_RS485_DELAY] =			0x15,
+		[REG_GPIO_MODE] =			0x1a,
+		[REG_GPIO_DIR] =			0x1b,
+		[REG_GPIO_INT_MASK] =			0x1c,
+		[REG_GPIO_SET] =			0x1d,
+		[REG_GPIO_CLR] =			0x1e,
+		[REG_GPIO_STATUS] =			0x1f,
+
+		[REQ_SET] =				0,
+		[REQ_GET] =				1,
+	}
+};
+
+struct xr_port_private {
+	enum xr_model model;
+};
 
 static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	struct usb_serial *serial = port->serial;
 	int ret;
 
 	ret = usb_control_msg(serial->dev,
 			      usb_sndctrlpipe(serial->dev, 0),
-			      SET_REQ,
+			      xr_hal_table[port_priv->model][REQ_SET],
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      val, reg | (block << 8), NULL, 0,
 			      USB_CTRL_SET_TIMEOUT);
@@ -129,6 +169,7 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 
 static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	struct usb_serial *serial = port->serial;
 	u8 *dmabuf;
 	int ret;
@@ -139,7 +180,7 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 
 	ret = usb_control_msg(serial->dev,
 			      usb_rcvctrlpipe(serial->dev, 0),
-			      GET_REQ,
+			      xr_hal_table[port_priv->model][REQ_GET],
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0, reg | (block << 8), dmabuf, 1,
 			      USB_CTRL_GET_TIMEOUT);
@@ -182,6 +223,7 @@ static int xr_set_reg_um(struct usb_serial_port *port, u8 reg, u8 val)
  */
 static int xr_uart_enable(struct usb_serial_port *port)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	int ret;
 
 	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG,
@@ -189,7 +231,7 @@ static int xr_uart_enable(struct usb_serial_port *port)
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE,
+	ret = xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_ENABLE],
 			      UART_ENABLE_TX | UART_ENABLE_RX);
 	if (ret)
 		return ret;
@@ -198,16 +240,18 @@ static int xr_uart_enable(struct usb_serial_port *port)
 			    UM_ENABLE_TX_FIFO | UM_ENABLE_RX_FIFO);
 
 	if (ret)
-		xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+		xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_ENABLE], 0);
 
 	return ret;
 }
 
 static int xr_uart_disable(struct usb_serial_port *port)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	int ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+	ret = xr_set_reg_uart(port,
+			      xr_hal_table[port_priv->model][REG_ENABLE], 0);
 	if (ret)
 		return ret;
 
@@ -219,10 +263,13 @@ static int xr_uart_disable(struct usb_serial_port *port)
 static int xr_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 status;
 	int ret;
 
-	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_STATUS, &status);
+	ret = xr_get_reg_uart(port,
+			      xr_hal_table[port_priv->model][REG_GPIO_STATUS],
+			      &status);
 	if (ret)
 		return ret;
 
@@ -243,6 +290,7 @@ static int xr_tiocmget(struct tty_struct *tty)
 static int xr_tiocmset_port(struct usb_serial_port *port,
 			    unsigned int set, unsigned int clear)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 gpio_set = 0;
 	u8 gpio_clr = 0;
 	int ret = 0;
@@ -259,10 +307,14 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 
 	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
 	if (gpio_clr)
-		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_CLR, gpio_clr);
+		ret = xr_set_reg_uart(port,
+				      xr_hal_table[port_priv->model][REG_GPIO_CLR],
+				      gpio_clr);
 
 	if (gpio_set)
-		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_SET, gpio_set);
+		ret = xr_set_reg_uart(port,
+				      xr_hal_table[port_priv->model][REG_GPIO_SET],
+				      gpio_set);
 
 	return ret;
 }
@@ -286,6 +338,7 @@ static void xr_dtr_rts(struct usb_serial_port *port, int on)
 static void xr_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 state;
 
 	if (break_state == 0)
@@ -295,7 +348,8 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 
 	dev_dbg(&port->dev, "Turning break %s\n",
 		state == UART_BREAK_OFF ? "off" : "on");
-	xr_set_reg_uart(port, XR21V141X_REG_TX_BREAK, state);
+	xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_TX_BREAK],
+			state);
 }
 
 /* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
@@ -405,10 +459,11 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 			     struct usb_serial_port *port,
 			     struct ktermios *old_termios)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 flow, gpio_mode;
 	int ret;
 
-	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_MODE, &gpio_mode);
+	ret = xr_get_reg_uart(port, xr_hal_table[port_priv->model][REG_GPIO_MODE], &gpio_mode);
 	if (ret)
 		return;
 
@@ -426,8 +481,8 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
 		flow = UART_FLOW_MODE_SW;
 
-		xr_set_reg_uart(port, XR21V141X_REG_XON_CHAR, start_char);
-		xr_set_reg_uart(port, XR21V141X_REG_XOFF_CHAR, stop_char);
+		xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_XON_CHAR], start_char);
+		xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_XOFF_CHAR], stop_char);
 	} else {
 		dev_dbg(&port->dev, "Disabling flow ctrl\n");
 		flow = UART_FLOW_MODE_NONE;
@@ -438,10 +493,10 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	 * FLOW_CONTROL register.
 	 */
 	xr_uart_disable(port);
-	xr_set_reg_uart(port, XR21V141X_REG_FLOW_CTRL, flow);
+	xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_FLOW_CTRL], flow);
 	xr_uart_enable(port);
 
-	xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, gpio_mode);
+	xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_GPIO_MODE], gpio_mode);
 
 	if (C_BAUD(tty) == B0)
 		xr_dtr_rts(port, 0);
@@ -453,9 +508,9 @@ static void xr_set_termios(struct tty_struct *tty,
 			   struct usb_serial_port *port,
 			   struct ktermios *old_termios)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	struct ktermios *termios = &tty->termios;
 	u8 bits = 0;
-	int ret;
 
 	if (!old_termios || (tty->termios.c_ospeed != old_termios->c_ospeed))
 		xr_set_baudrate(tty, port);
@@ -498,15 +553,16 @@ static void xr_set_termios(struct tty_struct *tty,
 	else
 		bits |= UART_STOP_1;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
-	if (ret)
-		return;
+	xr_set_reg_uart(port,
+			xr_hal_table[port_priv->model][REG_FORMAT],
+			bits);
 
 	xr_set_flow_mode(tty, port, old_termios);
 }
 
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 gpio_dir;
 	int ret;
 
@@ -521,7 +577,7 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 	 * inputs.
 	 */
 	gpio_dir = UART_MODE_DTR | UART_MODE_RTS;
-	xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, gpio_dir);
+	xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_GPIO_DIR], gpio_dir);
 
 	/* Setup termios */
 	if (tty)
@@ -545,15 +601,33 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
+	struct xr_port_private *port_priv;
+
 	/* Don't bind to control interface */
 	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
 		return -ENODEV;
 
+	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
+	if (!port_priv)
+		return -ENOMEM;
+
+	port_priv->model = id->driver_info;
+
+	usb_set_serial_data(serial, port_priv);
+
 	return 0;
 }
 
+static void xr_disconnect(struct usb_serial *serial)
+{
+	struct xr_port_private *port_priv = usb_get_serial_data(serial);
+
+	kfree(port_priv);
+	usb_set_serial_data(serial, 0);
+}
+
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
+	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
@@ -566,6 +640,7 @@ static struct usb_serial_driver xr_device = {
 	.id_table		= id_table,
 	.num_ports		= 1,
 	.probe			= xr_probe,
+	.disconnect		= xr_disconnect,
 	.open			= xr_open,
 	.close			= xr_close,
 	.break_ctl		= xr_break_ctl,
-- 
2.29.2

