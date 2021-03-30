Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1234EAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhC3OkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhC3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CFFE619DA;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=SNuX/9wu8y5danGG2o3qQzLfx1jCj65Q9JoqdTNSx9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is95Vxyn67O07uTXXfO1KtQteX9ostr0HTUX1Np90KEj0OhFZ16hWduuoKclG0T0U
         yNoIV4V33El3m4v0HgfinozsbX88dMpA7vgt20MTJW6qe0zIfGaU+A8ZvX6/tJeSbA
         SdbH7ridnOl0Zn+7fmCQIYCsKXyRJxyyQhhmrOR29W6ws+BBSv2fSw3KpwRK3OeZ73
         DDU3gkiuaei3aZ/ppP9e2ILeNgfC4bClqNQmxL+23cx+vtafTPP4h77ygsUzZbEauH
         6mSX/jS0aOIV0qO1jNvpGXWhncdW5HNAcE5hWNtUOo3QYQ8Wgtd1qKz//lC7/kh7RD
         4is9FcEa4lB9Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002PU-Dc; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] USB: serial: xr: add type abstraction
Date:   Tue, 30 Mar 2021 16:39:31 +0200
Message-Id: <20210330143934.9197-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least four types of Maxlinear/Exar USB UARTs which differ
in various ways such as in their register layouts:

	XR21V141X
	XR21B142X
	XR21B1411
	XR22804

It is not clear whether the device type can be inferred from the
descriptors so encode it in the device-id table for now.

Add a type structure that can be used to abstract the register layout
and other features, and use it when accessing the XR21V141X UART
registers that are shared by all types.

Note that the currently supported XR21V141X type is the only type that
has a set of UART Manager registers and that these will need to be
handled specifically.

Similarly, XR21V141X is the only type which has the divisor registers
and that needs to use the format register when configuring the line
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 128 ++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index bbfe92fcabc0..003aa1e04c85 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -29,10 +29,16 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_MIN_SPEED		46U
 #define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
 
-/* USB Requests */
+/* USB requests */
 #define XR21V141X_SET_REQ		0
 #define XR21V141X_GET_REQ		1
 
+/* XR21V141X register blocks */
+#define XR21V141X_UART_REG_BLOCK	0
+#define XR21V141X_UM_REG_BLOCK		4
+#define XR21V141X_UART_CUSTOM_BLOCK	0x66
+
+/* XR21V141X UART registers */
 #define XR21V141X_CLOCK_DIVISOR_0	0x04
 #define XR21V141X_CLOCK_DIVISOR_1	0x05
 #define XR21V141X_CLOCK_DIVISOR_2	0x06
@@ -40,13 +46,9 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_TX_CLOCK_MASK_1	0x08
 #define XR21V141X_RX_CLOCK_MASK_0	0x09
 #define XR21V141X_RX_CLOCK_MASK_1	0x0a
+#define XR21V141X_REG_FORMAT		0x0b
 
-/* XR21V141X register blocks */
-#define XR21V141X_UART_REG_BLOCK	0
-#define XR21V141X_UM_REG_BLOCK		4
-#define XR21V141X_UART_CUSTOM_BLOCK	0x66
-
-/* XR21V141X UART Manager Registers */
+/* XR21V141X UART Manager registers */
 #define XR21V141X_UM_FIFO_ENABLE_REG	0x10
 #define XR21V141X_UM_ENABLE_TX_FIFO	0x01
 #define XR21V141X_UM_ENABLE_RX_FIFO	0x02
@@ -94,23 +96,42 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_MODE_RS485		0x3
 #define XR_GPIO_MODE_RS485_ADDR		0x4
 
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
+struct xr_type {
+	u8 uart_enable;
+	u8 flow_control;
+	u8 xon_char;
+	u8 xoff_char;
+	u8 tx_break;
+	u8 gpio_mode;
+	u8 gpio_direction;
+	u8 gpio_set;
+	u8 gpio_clear;
+	u8 gpio_status;
+};
+
+enum xr_type_id {
+	XR21V141X,
+	XR_TYPE_COUNT,
+};
+
+static const struct xr_type xr_types[] = {
+	[XR21V141X] = {
+		.uart_enable	= 0x03,
+		.flow_control	= 0x0c,
+		.xon_char	= 0x10,
+		.xoff_char	= 0x11,
+		.tx_break	= 0x14,
+		.gpio_mode	= 0x1a,
+		.gpio_direction	= 0x1b,
+		.gpio_set	= 0x1d,
+		.gpio_clear	= 0x1e,
+		.gpio_status	= 0x1f,
+	},
+};
 
 struct xr_data {
-	u8 channel;		/* zero-based index */
+	const struct xr_type *type;
+	u8 channel;			/* zero-based index */
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
@@ -202,6 +223,7 @@ static int xr_set_reg_um(struct usb_serial_port *port, u8 reg_base, u8 val)
  */
 static int xr_uart_enable(struct usb_serial_port *port)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
 	int ret;
 
 	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
@@ -209,25 +231,25 @@ static int xr_uart_enable(struct usb_serial_port *port)
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE,
+	ret = xr_set_reg_uart(port, data->type->uart_enable,
 			      XR_UART_ENABLE_TX | XR_UART_ENABLE_RX);
 	if (ret)
 		return ret;
 
 	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
 			    XR21V141X_UM_ENABLE_TX_FIFO | XR21V141X_UM_ENABLE_RX_FIFO);
-
 	if (ret)
-		xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+		xr_set_reg_uart(port, data->type->uart_enable, 0);
 
 	return ret;
 }
 
 static int xr_uart_disable(struct usb_serial_port *port)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
 	int ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_ENABLE, 0);
+	ret = xr_set_reg_uart(port, data->type->uart_enable, 0);
 	if (ret)
 		return ret;
 
@@ -239,10 +261,11 @@ static int xr_uart_disable(struct usb_serial_port *port)
 static int xr_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
 	u8 status;
 	int ret;
 
-	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_STATUS, &status);
+	ret = xr_get_reg_uart(port, data->type->gpio_status, &status);
 	if (ret)
 		return ret;
 
@@ -263,6 +286,8 @@ static int xr_tiocmget(struct tty_struct *tty)
 static int xr_tiocmset_port(struct usb_serial_port *port,
 			    unsigned int set, unsigned int clear)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
+	const struct xr_type *type = data->type;
 	u8 gpio_set = 0;
 	u8 gpio_clr = 0;
 	int ret = 0;
@@ -279,10 +304,10 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 
 	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
 	if (gpio_clr)
-		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_CLR, gpio_clr);
+		ret = xr_set_reg_uart(port, type->gpio_clear, gpio_clr);
 
 	if (gpio_set)
-		ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_SET, gpio_set);
+		ret = xr_set_reg_uart(port, type->gpio_set, gpio_set);
 
 	return ret;
 }
@@ -306,6 +331,8 @@ static void xr_dtr_rts(struct usb_serial_port *port, int on)
 static void xr_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	const struct xr_type *type = data->type;
 	u8 state;
 
 	if (break_state == 0)
@@ -315,7 +342,7 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 
 	dev_dbg(&port->dev, "Turning break %s\n",
 		state == XR21V141X_UART_BREAK_OFF ? "off" : "on");
-	xr_set_reg_uart(port, XR21V141X_REG_TX_BREAK, state);
+	xr_set_reg_uart(port, type->tx_break, state);
 }
 
 /* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
@@ -425,10 +452,12 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 			     struct usb_serial_port *port,
 			     struct ktermios *old_termios)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
+	const struct xr_type *type = data->type;
 	u8 flow, gpio_mode;
 	int ret;
 
-	ret = xr_get_reg_uart(port, XR21V141X_REG_GPIO_MODE, &gpio_mode);
+	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
 	if (ret)
 		return;
 
@@ -446,8 +475,8 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
 		flow = XR_UART_FLOW_MODE_SW;
 
-		xr_set_reg_uart(port, XR21V141X_REG_XON_CHAR, start_char);
-		xr_set_reg_uart(port, XR21V141X_REG_XOFF_CHAR, stop_char);
+		xr_set_reg_uart(port, type->xon_char, start_char);
+		xr_set_reg_uart(port, type->xoff_char, stop_char);
 	} else {
 		dev_dbg(&port->dev, "Disabling flow ctrl\n");
 		flow = XR_UART_FLOW_MODE_NONE;
@@ -458,10 +487,10 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	 * FLOW_CONTROL register.
 	 */
 	xr_uart_disable(port);
-	xr_set_reg_uart(port, XR21V141X_REG_FLOW_CTRL, flow);
+	xr_set_reg_uart(port, type->flow_control, flow);
 	xr_uart_enable(port);
 
-	xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, gpio_mode);
+	xr_set_reg_uart(port, type->gpio_mode, gpio_mode);
 
 	if (C_BAUD(tty) == B0)
 		xr_dtr_rts(port, 0);
@@ -585,17 +614,19 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 	if (ret)
 		return ret;
 
+	usb_set_serial_data(serial, (void *)id->driver_info);
+
 	return 0;
 }
 
-static int xr_gpio_init(struct usb_serial_port *port)
+static int xr_gpio_init(struct usb_serial_port *port, const struct xr_type *type)
 {
 	u8 mask, mode;
 	int ret;
 
 	/* Configure all pins as GPIO. */
 	mode = 0;
-	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, mode);
+	ret = xr_set_reg_uart(port, type->gpio_mode, mode);
 	if (ret)
 		return ret;
 
@@ -604,11 +635,11 @@ static int xr_gpio_init(struct usb_serial_port *port)
 	 * (active low), and configure RI, CD, DSR and CTS as inputs.
 	 */
 	mask = XR_GPIO_DTR | XR_GPIO_RTS;
-	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, mask);
+	ret = xr_set_reg_uart(port, type->gpio_direction, mask);
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_SET, mask);
+	ret = xr_set_reg_uart(port, type->gpio_set, mask);
 	if (ret)
 		return ret;
 
@@ -618,19 +649,26 @@ static int xr_gpio_init(struct usb_serial_port *port)
 static int xr_port_probe(struct usb_serial_port *port)
 {
 	struct usb_interface_descriptor *desc;
+	const struct xr_type *type;
 	struct xr_data *data;
+	enum xr_type_id type_id;
 	int ret;
 
+	type_id = (int)(unsigned long)usb_get_serial_data(port->serial);
+	type = &xr_types[type_id];
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->type = type;
+
 	desc = &port->serial->interface->cur_altsetting->desc;
 	data->channel = desc->bInterfaceNumber / 2;
 
 	usb_set_serial_port_data(port, data);
 
-	ret = xr_gpio_init(port);
+	ret = xr_gpio_init(port, type);
 	if (ret)
 		goto err_free;
 
@@ -649,10 +687,14 @@ static void xr_port_remove(struct usb_serial_port *port)
 	kfree(data);
 }
 
+#define XR_DEVICE(vid, pid, type)					\
+	USB_DEVICE_INTERFACE_CLASS((vid), (pid), USB_CLASS_COMM),	\
+	.driver_info = (type)
+
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE_INTERFACE_CLASS(0x04e2, 0x1410, USB_CLASS_COMM) }, /* XR21V1410 */
-	{ USB_DEVICE_INTERFACE_CLASS(0x04e2, 0x1412, USB_CLASS_COMM) }, /* XR21V1412 */
-	{ USB_DEVICE_INTERFACE_CLASS(0x04e2, 0x1414, USB_CLASS_COMM) }, /* XR21V1414 */
+	{ XR_DEVICE(0x04e2, 0x1410, XR21V141X) },
+	{ XR_DEVICE(0x04e2, 0x1412, XR21V141X) },
+	{ XR_DEVICE(0x04e2, 0x1414, XR21V141X) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.26.3

