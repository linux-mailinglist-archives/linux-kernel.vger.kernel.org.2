Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB363472E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhCXHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235658AbhCXHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43DF0619FF;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=t6MK9iK7kL66BZ+vw3Np/c16NJlFPvbQ8QBKjxKOGeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaKhWh4JfY4JFPzSZ7nsgUP5cUvx4YqMchsXw6Ij4Ng6WWOKf/8+MjB+C2KWjMELp
         eCQEtyQD2+PQmNJDkfqrBaSTk/a3C1QLOkshuJgbdzoSzz/sKBNpjCzjKi2dkgsIxj
         9mDvlh9VHSsnRCzfUW8y+VpPVEoprf5SMdgR22qpzq234x2zqPomy/AE/Hp1Hx+JQc
         OzNTwvBWX9leu1KK0rA1G+x+bhEdFAeh/ZlG2VI3/3LpJgacRw8eMuIhRA/x4FShgl
         RSpiS7ZMUZvXFCm2R+nehDnJJRhtOmmrshjFF3UnPLpuNd/gcOG8t6aJZfQt7gQCPC
         gxXhDHsynwGUQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8h-000umd-TW; Wed, 24 Mar 2021 08:41:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 4/7] USB: serial: xr: add support for XR21B142X devices
Date:   Wed, 24 Mar 2021 08:41:08 +0100
Message-Id: <09e02f7ef0ce3ba4a064d3213cf3923ad14a34d0.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those devices can have 1, 2 or 4 ports. They're similar to
XR21B141X models, except for:

- the register numbers and reqs are different;
- some settings are done via the control interface, by
  using CDC commands.
- a few other minor differences.

The same way as XR21B141X, the control and data interfaces
are grouped via CDC union, where the even interface is for
control, and the subsequent one for data. So, on XR21B142X,

      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1

        bDataInterface          1

      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1

        bDataInterface          1

      CDC Union:
        bMasterInterface        2
        bSlaveInterface         3

        bDataInterface          3

      CDC Union:
        bMasterInterface        4
        bSlaveInterface         5

        bDataInterface          5

      CDC Union:
        bMasterInterface        6
        bSlaveInterface         7

        bDataInterface          7

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 235 ++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index f161394d9b2d..058624d15505 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/usb.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
 
 struct xr_txrx_clk_mask {
@@ -89,8 +90,17 @@ struct xr_txrx_clk_mask {
 #define UART_MODE_RS485			0x3
 #define UART_MODE_RS485_ADDR		0x4
 
+/* Used on devices that need the CDC control interface */
+#define URM_RESET_RX_FIFO_BASE		0x18
+#define URM_RESET_TX_FIFO_BASE		0x1c
+
+#define CDC_DATA_INTERFACE_TYPE		0x0a
+
+#define VIA_CDC_REGISTER		-1
+
 enum xr_model {
 	XR21V141X,
+	XR21B142X,
 	MAX_XR_MODELS
 };
 
@@ -140,12 +150,37 @@ static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
 
 		[REQ_SET] =				0,
 		[REQ_GET] =				1,
+	},
+	[XR21B142X] = {
+		[REG_ENABLE] =				0x00,
+		[REG_FORMAT] =				VIA_CDC_REGISTER,
+		[REG_FLOW_CTRL] =			0x06,
+		[REG_XON_CHAR] =			0x07,
+		[REG_XOFF_CHAR] =			0x08,
+		[REG_TX_BREAK] =			0x0a,
+		[REG_RS485_DELAY] =			0x0b,
+		[REG_GPIO_MODE] =			0x0c,
+		[REG_GPIO_DIR] =			0x0d,
+		[REG_GPIO_SET] =			0x0e,
+		[REG_GPIO_CLR] =			0x0f,
+		[REG_GPIO_STATUS] =			0x10,
+		[REG_GPIO_INT_MASK] =			0x11,
+		[REG_CUSTOMIZED_INT] =			0x12,
+		[REG_GPIO_PULL_UP_ENABLE] =		0x14,
+		[REG_GPIO_PULL_DOWN_ENABLE] =		0x15,
+		[REG_LOOPBACK] =			0x16,
+		[REG_LOW_LATENCY] =			0x46,
+		[REG_CUSTOM_DRIVER] =			0x60,
+
+		[REQ_SET] =				0,
+		[REQ_GET] =				0,
 	}
 };
 
 struct xr_port_private {
 	enum xr_model model;
 	unsigned int channel;
+	struct usb_interface *control_if;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
@@ -159,6 +194,9 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 		if (port_priv->channel)
 			reg |= (port_priv->channel - 1) << 8;
 		break;
+	case XR21B142X:
+		reg |= (port_priv->channel - 4) << 1;
+		break;
 	default:
 		return -EINVAL;
 	};
@@ -192,6 +230,9 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 		if (port_priv->channel)
 			reg |= (port_priv->channel - 1) << 8;
 		break;
+	case XR21B142X:
+		reg |= (port_priv->channel - 4) << 1;
+		break;
 	default:
 		return -EINVAL;
 	};
@@ -215,6 +256,43 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 	return ret;
 }
 
+static int xr_usb_serial_ctrl_msg(struct usb_serial_port *port,
+				  int request, int val,
+				  void *buf, int len)
+{
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
+	int if_num = port_priv->control_if->altsetting[0].desc.bInterfaceNumber;
+	struct usb_serial *serial = port->serial;
+	u8 *dmabuf = NULL;
+	int ret;
+
+	if (len) {
+		dmabuf = kmemdup(buf, len, GFP_KERNEL);
+		if (!dmabuf)
+			return -ENOMEM;
+	}
+
+	ret = usb_control_msg(serial->dev,
+			      usb_rcvctrlpipe(serial->dev, 0),
+			      request,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			      val,
+			      if_num, dmabuf, len,
+			      USB_CTRL_GET_TIMEOUT);
+
+	if (ret < 0) {
+		dev_err(&port->dev, "Failed to send a control msg: %d\n", ret);
+	} else {
+		if (dmabuf)
+			memcpy(buf, dmabuf, len);
+		ret = 0;
+	}
+
+	kfree(dmabuf);
+
+	return ret;
+}
+
 static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u8 val)
 {
 	return xr_set_reg(port, UART_REG_BLOCK, reg, val);
@@ -243,6 +321,11 @@ static int xr_uart_enable(struct usb_serial_port *port)
 	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	int ret;
 
+	if (port_priv->model != XR21V141X)
+		return xr_set_reg_uart(port,
+				       xr_hal_table[port_priv->model][REG_ENABLE],
+				       UART_ENABLE_TX | UART_ENABLE_RX);
+
 	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG,
 			    UM_ENABLE_TX_FIFO);
 	if (ret)
@@ -272,11 +355,37 @@ static int xr_uart_disable(struct usb_serial_port *port)
 	if (ret)
 		return ret;
 
+	if (port_priv->model != XR21V141X)
+		return 0;
+
 	ret = xr_set_reg_um(port, UM_FIFO_ENABLE_REG, 0);
 
 	return ret;
 }
 
+static int fifo_reset(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
+	int channel = port_priv->channel;
+	int ret = 0;
+
+	if (port_priv->model != XR21V141X)
+		return 0;
+
+	if (channel)
+		channel--;
+
+	ret = xr_set_reg_um(port,
+			    URM_RESET_RX_FIFO_BASE + channel, 0xff);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_um(port,
+			    URM_RESET_TX_FIFO_BASE + channel, 0xff);
+
+	return ret;
+}
+
 static int xr_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -358,6 +467,12 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	u8 state;
 
+	if (port_priv->model != XR21V141X) {
+		xr_usb_serial_ctrl_msg(port, USB_CDC_REQ_SEND_BREAK, state,
+				       NULL, 0);
+		return;
+	}
+
 	if (break_state == 0)
 		state = UART_BREAK_OFF;
 	else
@@ -505,6 +620,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		flow = UART_FLOW_MODE_NONE;
 	}
 
+	/*
+	 * Add support for the TXT and RXT function for 0x1420, 0x1422, 0x1424,
+	 * by setting GPIO_MODE [9:8] = '11'
+	 */
+	if (port_priv->model == XR21B142X)
+		gpio_mode |= 0x300;
+
 	/*
 	 * As per the datasheet, UART needs to be disabled while writing to
 	 * FLOW_CONTROL register.
@@ -521,9 +643,55 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 		xr_dtr_rts(port, 1);
 }
 
-static void xr_set_termios(struct tty_struct *tty,
-			   struct usb_serial_port *port,
-			   struct ktermios *old_termios)
+static void xr_set_termios_cdc(struct tty_struct *tty,
+			       struct usb_serial_port *port,
+			       struct ktermios *old_termios)
+{
+	struct ktermios *termios = &tty->termios;
+	struct usb_cdc_line_coding line = { 0 };
+	int clear, set;
+
+	line.dwDTERate = cpu_to_le32(tty_get_baud_rate(tty));
+	line.bCharFormat = termios->c_cflag & CSTOPB ? 1 : 0;
+	line.bParityType = termios->c_cflag & PARENB ?
+			   (termios->c_cflag & PARODD ? 1 : 2) +
+			   (termios->c_cflag & CMSPAR ? 2 : 0) : 0;
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+		line.bDataBits = 5;
+		break;
+	case CS6:
+		line.bDataBits = 6;
+		break;
+	case CS7:
+		line.bDataBits = 7;
+		break;
+	case CS8:
+	default:
+		line.bDataBits = 8;
+		break;
+	}
+
+	if (!line.dwDTERate) {
+		line.dwDTERate = tty->termios.c_ospeed;
+		clear = UART_MODE_DTR;
+	} else {
+		set = UART_MODE_DTR;
+	}
+
+	if (clear || set)
+		xr_tiocmset_port(port, set, clear);
+
+	xr_set_flow_mode(tty, port, old_termios);
+
+	xr_usb_serial_ctrl_msg(port, USB_CDC_REQ_SET_LINE_CODING, 0,
+			       &line, sizeof(line));
+}
+
+static void xr_set_termios_format_reg(struct tty_struct *tty,
+				      struct usb_serial_port *port,
+				      struct ktermios *old_termios)
 {
 	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
 	struct ktermios *termios = &tty->termios;
@@ -532,6 +700,8 @@ static void xr_set_termios(struct tty_struct *tty,
 	if (!old_termios || (tty->termios.c_ospeed != old_termios->c_ospeed))
 		xr_set_baudrate(tty, port);
 
+	/* For models with a private CHARACTER_FORMAT register */
+
 	switch (C_CSIZE(tty)) {
 	case CS5:
 	case CS6:
@@ -577,6 +747,28 @@ static void xr_set_termios(struct tty_struct *tty,
 	xr_set_flow_mode(tty, port, old_termios);
 }
 
+static void xr_set_termios(struct tty_struct *tty,
+			   struct usb_serial_port *port,
+			   struct ktermios *old_termios)
+{
+	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
+
+	/*
+	 * Different models have different ways to setup character format:
+	 *
+	 * - XR2280X and XR21V141X have their on private register. On
+	 *   such models, 5-6 bits is not supported;
+	 * - The other models use a standard CDC register.
+	 *
+	 * As we need to do different things with regards to 5-6 bits,
+	 * the actual implementation is made on two different functions.
+	 */
+	if (xr_hal_table[port_priv->model][REG_FORMAT] == VIA_CDC_REGISTER)
+		xr_set_termios_cdc(tty, port, old_termios);
+	else
+		xr_set_termios_format_reg(tty, port, old_termios);
+}
+
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	struct xr_port_private *port_priv = usb_get_serial_data(port->serial);
@@ -596,6 +788,13 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 	gpio_dir = UART_MODE_DTR | UART_MODE_RTS;
 	xr_set_reg_uart(port, xr_hal_table[port_priv->model][REG_GPIO_DIR], gpio_dir);
 
+	ret = fifo_reset(port);
+	if (ret) {
+		dev_err(&port->dev, "Failed to reset FIFO\n");
+		return ret;
+	}
+
+
 	/* Setup termios */
 	if (tty)
 		xr_set_termios(tty, port, NULL);
@@ -618,25 +817,39 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
+	struct usb_driver *driver = serial->type->usb_driver;
 	struct usb_interface *intf = serial->interface;
 	struct usb_endpoint_descriptor *data_ep;
+	struct usb_device *udev = serial->dev;
 	struct xr_port_private *port_priv;
-	int ifnum;
+	struct usb_interface *ctrl_intf;
+	int ifnum, ctrl_ifnum;
 
 	/* Attach only data interfaces */
 	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	if (!(ifnum % 2))
 		return -ENODEV;
 
+	/* Control interfaces are the even numbers */
+	ctrl_ifnum = ifnum - ifnum % 2;
+
 	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
 	if (!port_priv)
 		return -ENOMEM;
 
 	data_ep = &intf->cur_altsetting->endpoint[0].desc;
+	ctrl_intf = usb_ifnum_to_if(udev, ctrl_ifnum);
 
+	port_priv->control_if = usb_get_intf(ctrl_intf);
 	port_priv->model = id->driver_info;
 	port_priv->channel = data_ep->bEndpointAddress;
 
+	/* Wake up control interface */
+	pm_suspend_ignore_children(&ctrl_intf->dev, false);
+	if (driver->supports_autosuspend)
+		pm_runtime_enable(&ctrl_intf->dev);
+	else
+	    pm_runtime_set_active(&ctrl_intf->dev);
 	usb_set_serial_data(serial, port_priv);
 
 	return 0;
@@ -645,6 +858,15 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 static void xr_disconnect(struct usb_serial *serial)
 {
 	struct xr_port_private *port_priv = usb_get_serial_data(serial);
+	struct usb_driver *driver = serial->type->usb_driver;
+	struct usb_interface *ctrl_intf = port_priv->control_if;
+
+	if (driver->supports_autosuspend)
+		pm_runtime_disable(&ctrl_intf->dev);
+
+	pm_runtime_set_suspended(&ctrl_intf->dev);
+
+	usb_put_intf(ctrl_intf);
 
 	usb_set_serial_data(serial, 0);
 	kfree(port_priv);
@@ -654,6 +876,11 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
 	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = XR21V141X},
 	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = XR21V141X},
+
+	{ USB_DEVICE(0x04e2, 0x1420), .driver_info = XR21B142X},
+	{ USB_DEVICE(0x04e2, 0x1422), .driver_info = XR21B142X},
+	{ USB_DEVICE(0x04e2, 0x1424), .driver_info = XR21B142X},
+
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.30.2

