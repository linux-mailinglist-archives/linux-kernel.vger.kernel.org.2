Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2434EAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhC3OkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231979AbhC3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92393619DC;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=xX6KJSyhMdx2dDHFxO00T003hL1XNNZTWnzaoHzUQqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmRTwpSuqn+GIdo65DyyoVhtsVOOXEs3xkSpVXpMoX4chkIr/4/CvGUO/zYo5+bgF
         wP1aPrktOOVxUFD6xDuIf+GlVrLkpbhknsbKc/vV3go4nfCqwRaymQBLSbASPHp0/M
         ffUjgMBXK+RymGzwTPnH2IUbqm6Mh/iTNxZr3gGRBenvlI9ozaBILWX+cZC7kEi7ZP
         ZHeNyrE16agsLpAGxdyyHbYWTg0lEj/bi+iBoHgAJ/uAclZx+7qJ69KQE7HY3E4VmM
         QZ7R+YB1IXAqvo3XwP6g7urmhzt5lmiz01keIiqLlT30ptitoByX9Q4B39NYJEGCnX
         7YnZmymlKFRbQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002PX-Hv; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] USB: serial: xr: add support for XR21B1421, XR21B1422 and XR21B1424
Date:   Tue, 30 Mar 2021 16:39:32 +0200
Message-Id: <20210330143934.9197-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XR21B1421, XR21B1422 and XR21B1424 are the one-, two- and four-port
models of a second XR21B142X type of the Maxlinear/Exar USB UARTs.

The XR21B142X type differs from XR21V141X in several ways, including:

	- register layout
	- register width (16-bit instead of 8-bit)
	- vendor register requests
	- UART enable/disable sequence
	- custom-driver mode flag
	- three additional GPIOs (9 instead of 6)

As for XR21V141X, the XR21B142X vendor requests encode the channel index
in the MSB of wIndex, but it lacks the UART Manager registers which
have been replaced by regular UART registers. The new type also uses the
interface number of the control interface (0, 2, 4, 6) as channel index
instead of the channel number (0, 1, 2, 3).

The XR21B142X lacks the divisor and format registers used by XR21V141X
and instead uses the CDC SET_LINE_CONTROL request to configure the line
settings.

Note that the currently supported XR21V141X type lacks the custom-driver
mode flag that prevents the device from entering CDC-ACM mode when a CDC
requests is received. This specifically means that the SET_LINE_CONTROL
request cannot be used with XR21V141X even though it is otherwise
supported.

The UART enable sequence for XR21B142X does not involve explicitly
enabling the FIFOs, but according to datasheet the UART must be disabled
when writing any register but GPIO_SET, GPIO_CLEAR, TX_BREAK and
ERROR_STATUS.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 338 +++++++++++++++++++++++++--------
 1 file changed, 262 insertions(+), 76 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 003aa1e04c85..32055c763147 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -29,10 +29,6 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_MIN_SPEED		46U
 #define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
 
-/* USB requests */
-#define XR21V141X_SET_REQ		0
-#define XR21V141X_GET_REQ		1
-
 /* XR21V141X register blocks */
 #define XR21V141X_UART_REG_BLOCK	0
 #define XR21V141X_UM_REG_BLOCK		4
@@ -65,9 +61,10 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_DTR			BIT(3)
 #define XR_GPIO_CTS			BIT(4)
 #define XR_GPIO_RTS			BIT(5)
-
-#define XR21V141X_UART_BREAK_ON		0xff
-#define XR21V141X_UART_BREAK_OFF	0
+#define XR_GPIO_CLK			BIT(6)
+#define XR_GPIO_XEN			BIT(7)
+#define XR_GPIO_TXT			BIT(8)
+#define XR_GPIO_RXT			BIT(9)
 
 #define XR_UART_DATA_MASK		GENMASK(3, 0)
 #define XR_UART_DATA_7			0x7
@@ -90,13 +87,27 @@ struct xr_txrx_clk_mask {
 #define XR_UART_FLOW_MODE_HW		0x1
 #define XR_UART_FLOW_MODE_SW		0x2
 
-#define XR_GPIO_MODE_MASK		GENMASK(2, 0)
-#define XR_GPIO_MODE_RTS_CTS		0x1
-#define XR_GPIO_MODE_DTR_DSR		0x2
-#define XR_GPIO_MODE_RS485		0x3
-#define XR_GPIO_MODE_RS485_ADDR		0x4
+#define XR_GPIO_MODE_SEL_MASK		GENMASK(2, 0)
+#define XR_GPIO_MODE_SEL_RTS_CTS	0x1
+#define XR_GPIO_MODE_SEL_DTR_DSR	0x2
+#define XR_GPIO_MODE_SEL_RS485		0x3
+#define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
+#define XR_GPIO_MODE_TX_TOGGLE		0x100
+#define XR_GPIO_MODE_RX_TOGGLE		0x200
+
+#define XR_CUSTOM_DRIVER_ACTIVE		0x1
+
+static int xr21v141x_uart_enable(struct usb_serial_port *port);
+static int xr21v141x_uart_disable(struct usb_serial_port *port);
+static void xr21v141x_set_line_settings(struct tty_struct *tty,
+		struct usb_serial_port *port, struct ktermios *old_termios);
 
 struct xr_type {
+	int reg_width;
+	u8 reg_recipient;
+	u8 set_reg;
+	u8 get_reg;
+
 	u8 uart_enable;
 	u8 flow_control;
 	u8 xon_char;
@@ -107,15 +118,30 @@ struct xr_type {
 	u8 gpio_set;
 	u8 gpio_clear;
 	u8 gpio_status;
+	u8 custom_driver;
+
+	bool have_xmit_toggle;
+
+	int (*enable)(struct usb_serial_port *port);
+	int (*disable)(struct usb_serial_port *port);
+	void (*set_line_settings)(struct tty_struct *tty,
+			struct usb_serial_port *port,
+			struct ktermios *old_termios);
 };
 
 enum xr_type_id {
 	XR21V141X,
+	XR21B142X,
 	XR_TYPE_COUNT,
 };
 
 static const struct xr_type xr_types[] = {
 	[XR21V141X] = {
+		.reg_width	= 8,
+		.reg_recipient	= USB_RECIP_DEVICE,
+		.set_reg	= 0x00,
+		.get_reg	= 0x01,
+
 		.uart_enable	= 0x03,
 		.flow_control	= 0x0c,
 		.xon_char	= 0x10,
@@ -126,25 +152,50 @@ static const struct xr_type xr_types[] = {
 		.gpio_set	= 0x1d,
 		.gpio_clear	= 0x1e,
 		.gpio_status	= 0x1f,
+
+		.enable			= xr21v141x_uart_enable,
+		.disable		= xr21v141x_uart_disable,
+		.set_line_settings	= xr21v141x_set_line_settings,
+	},
+	[XR21B142X] = {
+		.reg_width	= 16,
+		.reg_recipient	= USB_RECIP_INTERFACE,
+		.set_reg	= 0x00,
+		.get_reg	= 0x00,
+
+		.uart_enable	= 0x00,
+		.flow_control	= 0x06,
+		.xon_char	= 0x07,
+		.xoff_char	= 0x08,
+		.tx_break	= 0x0a,
+		.gpio_mode	= 0x0c,
+		.gpio_direction	= 0x0d,
+		.gpio_set	= 0x0e,
+		.gpio_clear	= 0x0f,
+		.gpio_status	= 0x10,
+		.custom_driver	= 0x60,
+
+		.have_xmit_toggle	= true,
 	},
 };
 
 struct xr_data {
 	const struct xr_type *type;
-	u8 channel;			/* zero-based index */
+	u8 channel;			/* zero-based index or interface number */
 };
 
-static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
+static int xr_set_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 val)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
+	const struct xr_type *type = data->type;
 	struct usb_serial *serial = port->serial;
 	int ret;
 
-	ret = usb_control_msg(serial->dev,
-			      usb_sndctrlpipe(serial->dev, 0),
-			      XR21V141X_SET_REQ,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      val, reg | (block << 8), NULL, 0,
-			      USB_CTRL_SET_TIMEOUT);
+	ret = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
+			type->set_reg,
+			USB_DIR_OUT | USB_TYPE_VENDOR | type->reg_recipient,
+			val, (channel << 8) | reg, NULL, 0,
+			USB_CTRL_SET_TIMEOUT);
 	if (ret < 0) {
 		dev_err(&port->dev, "Failed to set reg 0x%02x: %d\n", reg, ret);
 		return ret;
@@ -153,24 +204,33 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 	return 0;
 }
 
-static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
+static int xr_get_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 *val)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
+	const struct xr_type *type = data->type;
 	struct usb_serial *serial = port->serial;
 	u8 *dmabuf;
-	int ret;
+	int ret, len;
 
-	dmabuf = kmalloc(1, GFP_KERNEL);
+	if (type->reg_width == 8)
+		len = 1;
+	else
+		len = 2;
+
+	dmabuf = kmalloc(len, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
 
-	ret = usb_control_msg(serial->dev,
-			      usb_rcvctrlpipe(serial->dev, 0),
-			      XR21V141X_GET_REQ,
-			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0, reg | (block << 8), dmabuf, 1,
-			      USB_CTRL_GET_TIMEOUT);
-	if (ret == 1) {
-		*val = *dmabuf;
+	ret = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
+			type->get_reg,
+			USB_DIR_IN | USB_TYPE_VENDOR | type->reg_recipient,
+			0, (channel << 8) | reg, dmabuf, len,
+			USB_CTRL_GET_TIMEOUT);
+	if (ret == len) {
+		if (len == 2)
+			*val = le16_to_cpup((__le16 *)dmabuf);
+		else
+			*val = *dmabuf;
 		ret = 0;
 	} else {
 		dev_err(&port->dev, "Failed to get reg 0x%02x: %d\n", reg, ret);
@@ -183,24 +243,18 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 	return ret;
 }
 
-static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u8 val)
+static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u16 val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
-	u8 block;
-
-	block = XR21V141X_UART_REG_BLOCK + data->channel;
 
-	return xr_set_reg(port, block, reg, val);
+	return xr_set_reg(port, data->channel, reg, val);
 }
 
-static int xr_get_reg_uart(struct usb_serial_port *port, u8 reg, u8 *val)
+static int xr_get_reg_uart(struct usb_serial_port *port, u8 reg, u16 *val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
-	u8 block;
 
-	block = XR21V141X_UART_REG_BLOCK + data->channel;
-
-	return xr_get_reg(port, block, reg, val);
+	return xr_get_reg(port, data->channel, reg, val);
 }
 
 static int xr_set_reg_um(struct usb_serial_port *port, u8 reg_base, u8 val)
@@ -213,6 +267,21 @@ static int xr_set_reg_um(struct usb_serial_port *port, u8 reg_base, u8 val)
 	return xr_set_reg(port, XR21V141X_UM_REG_BLOCK, reg, val);
 }
 
+static int __xr_uart_enable(struct usb_serial_port *port)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	return xr_set_reg_uart(port, data->type->uart_enable,
+			XR_UART_ENABLE_TX | XR_UART_ENABLE_RX);
+}
+
+static int __xr_uart_disable(struct usb_serial_port *port)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	return xr_set_reg_uart(port, data->type->uart_enable, 0);
+}
+
 /*
  * According to datasheet, below is the recommended sequence for enabling UART
  * module in XR21V141X:
@@ -221,9 +290,8 @@ static int xr_set_reg_um(struct usb_serial_port *port, u8 reg_base, u8 val)
  * Enable Tx and Rx
  * Enable Rx FIFO
  */
-static int xr_uart_enable(struct usb_serial_port *port)
+static int xr21v141x_uart_enable(struct usb_serial_port *port)
 {
-	struct xr_data *data = usb_get_serial_port_data(port);
 	int ret;
 
 	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
@@ -231,25 +299,23 @@ static int xr_uart_enable(struct usb_serial_port *port)
 	if (ret)
 		return ret;
 
-	ret = xr_set_reg_uart(port, data->type->uart_enable,
-			      XR_UART_ENABLE_TX | XR_UART_ENABLE_RX);
+	ret = __xr_uart_enable(port);
 	if (ret)
 		return ret;
 
 	ret = xr_set_reg_um(port, XR21V141X_UM_FIFO_ENABLE_REG,
 			    XR21V141X_UM_ENABLE_TX_FIFO | XR21V141X_UM_ENABLE_RX_FIFO);
 	if (ret)
-		xr_set_reg_uart(port, data->type->uart_enable, 0);
+		__xr_uart_disable(port);
 
 	return ret;
 }
 
-static int xr_uart_disable(struct usb_serial_port *port)
+static int xr21v141x_uart_disable(struct usb_serial_port *port)
 {
-	struct xr_data *data = usb_get_serial_port_data(port);
 	int ret;
 
-	ret = xr_set_reg_uart(port, data->type->uart_enable, 0);
+	ret = __xr_uart_disable(port);
 	if (ret)
 		return ret;
 
@@ -258,11 +324,31 @@ static int xr_uart_disable(struct usb_serial_port *port)
 	return ret;
 }
 
+static int xr_uart_enable(struct usb_serial_port *port)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	if (data->type->enable)
+		return data->type->enable(port);
+
+	return __xr_uart_enable(port);
+}
+
+static int xr_uart_disable(struct usb_serial_port *port)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	if (data->type->disable)
+		return data->type->disable(port);
+
+	return __xr_uart_disable(port);
+}
+
 static int xr_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct xr_data *data = usb_get_serial_port_data(port);
-	u8 status;
+	u16 status;
 	int ret;
 
 	ret = xr_get_reg_uart(port, data->type->gpio_status, &status);
@@ -288,8 +374,8 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
-	u8 gpio_set = 0;
-	u8 gpio_clr = 0;
+	u16 gpio_set = 0;
+	u16 gpio_clr = 0;
 	int ret = 0;
 
 	/* Modem control pins are active low, so set & clr are swapped */
@@ -333,15 +419,15 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 	struct usb_serial_port *port = tty->driver_data;
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
-	u8 state;
+	u16 state;
 
 	if (break_state == 0)
-		state = XR21V141X_UART_BREAK_OFF;
+		state = 0;
 	else
-		state = XR21V141X_UART_BREAK_ON;
+		state = GENMASK(type->reg_width - 1, 0);
+
+	dev_dbg(&port->dev, "Turning break %s\n", state == 0 ? "off" : "on");
 
-	dev_dbg(&port->dev, "Turning break %s\n",
-		state == XR21V141X_UART_BREAK_OFF ? "off" : "on");
 	xr_set_reg_uart(port, type->tx_break, state);
 }
 
@@ -381,8 +467,7 @@ static const struct xr_txrx_clk_mask xr21v141x_txrx_clk_masks[] = {
 	{ 0xfff, 0xffe, 0xffd },
 };
 
-static int xr_set_baudrate(struct tty_struct *tty,
-			   struct usb_serial_port *port)
+static int xr21v141x_set_baudrate(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	u32 divisor, baud, idx;
 	u16 tx_mask, rx_mask;
@@ -454,19 +539,26 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
-	u8 flow, gpio_mode;
+	u16 flow, gpio_mode;
 	int ret;
 
 	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
 	if (ret)
 		return;
 
+	/*
+	 * According to the datasheets, the UART needs to be disabled while
+	 * writing to the FLOW_CONTROL register (XR21V141X), or any register
+	 * but GPIO_SET, GPIO_CLEAR, TX_BREAK and ERROR_STATUS (XR21B142X).
+	 */
+	xr_uart_disable(port);
+
 	/* Set GPIO mode for controlling the pins manually by default. */
-	gpio_mode &= ~XR_GPIO_MODE_MASK;
+	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-		gpio_mode |= XR_GPIO_MODE_RTS_CTS;
+		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
 		flow = XR_UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
 		u8 start_char = START_CHAR(tty);
@@ -482,32 +574,26 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		flow = XR_UART_FLOW_MODE_NONE;
 	}
 
-	/*
-	 * As per the datasheet, UART needs to be disabled while writing to
-	 * FLOW_CONTROL register.
-	 */
-	xr_uart_disable(port);
 	xr_set_reg_uart(port, type->flow_control, flow);
-	xr_uart_enable(port);
-
 	xr_set_reg_uart(port, type->gpio_mode, gpio_mode);
 
+	xr_uart_enable(port);
+
 	if (C_BAUD(tty) == B0)
 		xr_dtr_rts(port, 0);
 	else if (old_termios && (old_termios->c_cflag & CBAUD) == B0)
 		xr_dtr_rts(port, 1);
 }
 
-static void xr_set_termios(struct tty_struct *tty,
-			   struct usb_serial_port *port,
-			   struct ktermios *old_termios)
+static void xr21v141x_set_line_settings(struct tty_struct *tty,
+		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct ktermios *termios = &tty->termios;
 	u8 bits = 0;
 	int ret;
 
 	if (!old_termios || (tty->termios.c_ospeed != old_termios->c_ospeed))
-		xr_set_baudrate(tty, port);
+		xr21v141x_set_baudrate(tty, port);
 
 	switch (C_CSIZE(tty)) {
 	case CS5:
@@ -555,6 +641,88 @@ static void xr_set_termios(struct tty_struct *tty,
 	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
 	if (ret)
 		return;
+}
+
+static void xr_cdc_set_line_coding(struct tty_struct *tty,
+		struct usb_serial_port *port, struct ktermios *old_termios)
+{
+	struct usb_host_interface *alt = port->serial->interface->cur_altsetting;
+	struct usb_device *udev = port->serial->dev;
+	struct usb_cdc_line_coding *lc;
+	int ret;
+
+	lc = kzalloc(sizeof(*lc), GFP_KERNEL);
+	if (!lc)
+		return;
+
+	if (tty->termios.c_ospeed)
+		lc->dwDTERate = cpu_to_le32(tty->termios.c_ospeed);
+	else if (old_termios)
+		lc->dwDTERate = cpu_to_le32(old_termios->c_ospeed);
+	else
+		lc->dwDTERate = cpu_to_le32(9600);
+
+	if (C_CSTOPB(tty))
+		lc->bCharFormat = USB_CDC_2_STOP_BITS;
+	else
+		lc->bCharFormat = USB_CDC_1_STOP_BITS;
+
+	if (C_PARENB(tty)) {
+		if (C_CMSPAR(tty)) {
+			if (C_PARODD(tty))
+				lc->bParityType = USB_CDC_MARK_PARITY;
+			else
+				lc->bParityType = USB_CDC_SPACE_PARITY;
+		} else {
+			if (C_PARODD(tty))
+				lc->bParityType = USB_CDC_ODD_PARITY;
+			else
+				lc->bParityType = USB_CDC_EVEN_PARITY;
+		}
+	} else {
+		lc->bParityType = USB_CDC_NO_PARITY;
+	}
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+		lc->bDataBits = 5;
+		break;
+	case CS6:
+		lc->bDataBits = 6;
+		break;
+	case CS7:
+		lc->bDataBits = 7;
+		break;
+	case CS8:
+	default:
+		lc->bDataBits = 8;
+		break;
+	}
+
+	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			USB_CDC_REQ_SET_LINE_CODING,
+			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			0, alt->desc.bInterfaceNumber,
+			lc, sizeof(*lc), USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		dev_err(&port->dev, "Failed to set line coding: %d\n", ret);
+
+	kfree(lc);
+}
+
+static void xr_set_termios(struct tty_struct *tty,
+		struct usb_serial_port *port, struct ktermios *old_termios)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	/*
+	 * XR21V141X does not have a CUSTOM_DRIVER flag and always enters CDC
+	 * mode upon receiving CDC requests.
+	 */
+	if (data->type->set_line_settings)
+		data->type->set_line_settings(tty, port, old_termios);
+	else
+		xr_cdc_set_line_coding(tty, port, old_termios);
 
 	xr_set_flow_mode(tty, port, old_termios);
 }
@@ -621,11 +789,16 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 
 static int xr_gpio_init(struct usb_serial_port *port, const struct xr_type *type)
 {
-	u8 mask, mode;
+	u16 mask, mode;
 	int ret;
 
-	/* Configure all pins as GPIO. */
+	/*
+	 * Configure all pins as GPIO except for Receive and Transmit Toggle.
+	 */
 	mode = 0;
+	if (type->have_xmit_toggle)
+		mode |= XR_GPIO_MODE_RX_TOGGLE | XR_GPIO_MODE_TX_TOGGLE;
+
 	ret = xr_set_reg_uart(port, type->gpio_mode, mode);
 	if (ret)
 		return ret;
@@ -664,10 +837,20 @@ static int xr_port_probe(struct usb_serial_port *port)
 	data->type = type;
 
 	desc = &port->serial->interface->cur_altsetting->desc;
-	data->channel = desc->bInterfaceNumber / 2;
+	if (type_id == XR21V141X)
+		data->channel = desc->bInterfaceNumber / 2;
+	else
+		data->channel = desc->bInterfaceNumber;
 
 	usb_set_serial_port_data(port, data);
 
+	if (type->custom_driver) {
+		ret = xr_set_reg_uart(port, type->custom_driver,
+				XR_CUSTOM_DRIVER_ACTIVE);
+		if (ret)
+			goto err_free;
+	}
+
 	ret = xr_gpio_init(port, type);
 	if (ret)
 		goto err_free;
@@ -695,6 +878,9 @@ static const struct usb_device_id id_table[] = {
 	{ XR_DEVICE(0x04e2, 0x1410, XR21V141X) },
 	{ XR_DEVICE(0x04e2, 0x1412, XR21V141X) },
 	{ XR_DEVICE(0x04e2, 0x1414, XR21V141X) },
+	{ XR_DEVICE(0x04e2, 0x1420, XR21B142X) },
+	{ XR_DEVICE(0x04e2, 0x1422, XR21B142X) },
+	{ XR_DEVICE(0x04e2, 0x1424, XR21B142X) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.26.3

