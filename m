Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F068334EA95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhC3Oj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhC3Ojj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E75619E4;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=CO/OsevSE7pyEYTTXHabBKlXv95tMYgBZ8LKZvSgso8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3n3rpmOXYj8UY/+b1QuynDcPgaRNJBbkyDBxxiPt6PaAiqBHuk1Q50rborQiv46V
         w18HjfTYr9zTksn57wyvrkZ6L1p0hqbGLudl1Rpq2M9Lhqcx2LYp/GFW2Suzd2K94G
         wAGq9+VibP6vUCy9ICTi1E73DqRyLjxyq0NxfDdRQ1HnrD0PwCjZyITZyqQjQ1w5CE
         6hFQEfpJ4PG+X/9v6qzOX4K6H1bgDTbmnCbwXpDnZzGi/RHw16QYm0HW1RxlcZPC58
         7zf1wy39RUlCfR9ZD73VbtxcrMI4oa9dqxsLje2blKV70HOZxWCm52UditsBpUKj8o
         H355+/W+OKn5g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002Pa-Ln; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] USB: serial: xr: add support for XR21B1411
Date:   Tue, 30 Mar 2021 16:39:33 +0200
Message-Id: <20210330143934.9197-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single-port XR21B1411 is similar to the XR21B142X type but uses
12-bit registers and 16-bit register addresses, the register requests
are different and are directed at the device rather than interface, and
5 and 6-bit words are not supported.

The register layout is very similar to XR21B142X except that most
registers are offset by 0xc00 (corresponding to a channel index of 12 in
the MSB of wIndex). As the device is single-port so that the derived
channel index is 0, the current register accessors can be reused after
simply changing the address width.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 64 +++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 32055c763147..46e5e1b2f3c0 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -108,18 +108,19 @@ struct xr_type {
 	u8 set_reg;
 	u8 get_reg;
 
-	u8 uart_enable;
-	u8 flow_control;
-	u8 xon_char;
-	u8 xoff_char;
-	u8 tx_break;
-	u8 gpio_mode;
-	u8 gpio_direction;
-	u8 gpio_set;
-	u8 gpio_clear;
-	u8 gpio_status;
-	u8 custom_driver;
-
+	u16 uart_enable;
+	u16 flow_control;
+	u16 xon_char;
+	u16 xoff_char;
+	u16 tx_break;
+	u16 gpio_mode;
+	u16 gpio_direction;
+	u16 gpio_set;
+	u16 gpio_clear;
+	u16 gpio_status;
+	u16 custom_driver;
+
+	bool have_5_6_bit_mode;
 	bool have_xmit_toggle;
 
 	int (*enable)(struct usb_serial_port *port);
@@ -132,6 +133,7 @@ struct xr_type {
 enum xr_type_id {
 	XR21V141X,
 	XR21B142X,
+	XR21B1411,
 	XR_TYPE_COUNT,
 };
 
@@ -175,8 +177,27 @@ static const struct xr_type xr_types[] = {
 		.gpio_status	= 0x10,
 		.custom_driver	= 0x60,
 
+		.have_5_6_bit_mode	= true,
 		.have_xmit_toggle	= true,
 	},
+	[XR21B1411] = {
+		.reg_width	= 12,
+		.reg_recipient	= USB_RECIP_DEVICE,
+		.set_reg	= 0x00,
+		.get_reg	= 0x01,
+
+		.uart_enable	= 0xc00,
+		.flow_control	= 0xc06,
+		.xon_char	= 0xc07,
+		.xoff_char	= 0xc08,
+		.tx_break	= 0xc0a,
+		.gpio_mode	= 0xc0c,
+		.gpio_direction	= 0xc0d,
+		.gpio_set	= 0xc0e,
+		.gpio_clear	= 0xc0f,
+		.gpio_status	= 0xc10,
+		.custom_driver	= 0x20d,
+	},
 };
 
 struct xr_data {
@@ -184,7 +205,7 @@ struct xr_data {
 	u8 channel;			/* zero-based index or interface number */
 };
 
-static int xr_set_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 val)
+static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
@@ -204,7 +225,7 @@ static int xr_set_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 val)
 	return 0;
 }
 
-static int xr_get_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 *val)
+static int xr_get_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 *val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
@@ -243,14 +264,14 @@ static int xr_get_reg(struct usb_serial_port *port, u8 channel, u8 reg, u16 *val
 	return ret;
 }
 
-static int xr_set_reg_uart(struct usb_serial_port *port, u8 reg, u16 val)
+static int xr_set_reg_uart(struct usb_serial_port *port, u16 reg, u16 val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 
 	return xr_set_reg(port, data->channel, reg, val);
 }
 
-static int xr_get_reg_uart(struct usb_serial_port *port, u8 reg, u16 *val)
+static int xr_get_reg_uart(struct usb_serial_port *port, u16 reg, u16 *val)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 
@@ -646,6 +667,7 @@ static void xr21v141x_set_line_settings(struct tty_struct *tty,
 static void xr_cdc_set_line_coding(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct xr_data *data = usb_get_serial_port_data(port);
 	struct usb_host_interface *alt = port->serial->interface->cur_altsetting;
 	struct usb_device *udev = port->serial->dev;
 	struct usb_cdc_line_coding *lc;
@@ -683,6 +705,15 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
 		lc->bParityType = USB_CDC_NO_PARITY;
 	}
 
+	if (!data->type->have_5_6_bit_mode &&
+			(C_CSIZE(tty) == CS5 || C_CSIZE(tty) == CS6)) {
+		tty->termios.c_cflag &= ~CSIZE;
+		if (old_termios)
+			tty->termios.c_cflag |= old_termios->c_cflag & CSIZE;
+		else
+			tty->termios.c_cflag |= CS8;
+	}
+
 	switch (C_CSIZE(tty)) {
 	case CS5:
 		lc->bDataBits = 5;
@@ -876,6 +907,7 @@ static void xr_port_remove(struct usb_serial_port *port)
 
 static const struct usb_device_id id_table[] = {
 	{ XR_DEVICE(0x04e2, 0x1410, XR21V141X) },
+	{ XR_DEVICE(0x04e2, 0x1411, XR21B1411) },
 	{ XR_DEVICE(0x04e2, 0x1412, XR21V141X) },
 	{ XR_DEVICE(0x04e2, 0x1414, XR21V141X) },
 	{ XR_DEVICE(0x04e2, 0x1420, XR21B142X) },
-- 
2.26.3

