Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4422B35C33E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbhDLKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244813AbhDLJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C250B61352;
        Mon, 12 Apr 2021 09:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618221378;
        bh=93eu/ai965fIUGSREj8ExJtrJ3sNeihKwmSb0StfEPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwFX4UbCJuvCLr9o8F1/GHWBeEtZhuPd6Wyewi+Rz/cz+V5Mr9tAcegh3RMPYdazy
         L4hEto/XTQSHihwMV+e8SRcLiQv/UTrrTIACknYyHi9zfxHl1yyZPGRoemymq4/wk8
         pERZbiuXlNtHmIOOgWyNk9720uGyHU3ahclqaUGBl+NMKDzfz7JI3oH5CJ1ZGbZOiZ
         OqjXF2B/sj+A1As3txt8gYWiXw44zbU85bPQXUW0n4irLBcwUOpUaW2czfVHQI11UK
         K3Y+6pm0rwV4eQglj2A8De74db7xk7H/dtohtBXzkurtfWkj9mOZXSPJoJ8sBXzJ9U
         +KysoMN7nFGIQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVtIj-0000Kz-BR; Mon, 12 Apr 2021 11:56:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] USB: serial: xr: reset FIFOs on open
Date:   Mon, 12 Apr 2021 11:55:55 +0200
Message-Id: <20210412095557.1213-11-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412095557.1213-1-johan@kernel.org>
References: <20210412095557.1213-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the transmit and receive FIFOs before enabling the UARTs as part
of open() in order to flush any stale data.

Note that the XR21V141X needs a type-specific implementation due to its
UART Manager registers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 14dbda13ab4d..1b7b3c70a9b3 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -95,10 +95,13 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_MODE_TX_TOGGLE		0x100
 #define XR_GPIO_MODE_RX_TOGGLE		0x200
 
+#define XR_FIFO_RESET			0x1
+
 #define XR_CUSTOM_DRIVER_ACTIVE		0x1
 
 static int xr21v141x_uart_enable(struct usb_serial_port *port);
 static int xr21v141x_uart_disable(struct usb_serial_port *port);
+static int xr21v141x_fifo_reset(struct usb_serial_port *port);
 static void xr21v141x_set_line_settings(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios);
 
@@ -118,6 +121,8 @@ struct xr_type {
 	u16 gpio_set;
 	u16 gpio_clear;
 	u16 gpio_status;
+	u16 tx_fifo_reset;
+	u16 rx_fifo_reset;
 	u16 custom_driver;
 
 	bool have_5_6_bit_mode;
@@ -125,6 +130,7 @@ struct xr_type {
 
 	int (*enable)(struct usb_serial_port *port);
 	int (*disable)(struct usb_serial_port *port);
+	int (*fifo_reset)(struct usb_serial_port *port);
 	void (*set_line_settings)(struct tty_struct *tty,
 			struct usb_serial_port *port,
 			struct ktermios *old_termios);
@@ -158,6 +164,7 @@ static const struct xr_type xr_types[] = {
 
 		.enable			= xr21v141x_uart_enable,
 		.disable		= xr21v141x_uart_disable,
+		.fifo_reset		= xr21v141x_fifo_reset,
 		.set_line_settings	= xr21v141x_set_line_settings,
 	},
 	[XR21B142X] = {
@@ -176,6 +183,8 @@ static const struct xr_type xr_types[] = {
 		.gpio_set	= 0x0e,
 		.gpio_clear	= 0x0f,
 		.gpio_status	= 0x10,
+		.tx_fifo_reset	= 0x40,
+		.rx_fifo_reset	= 0x43,
 		.custom_driver	= 0x60,
 
 		.have_5_6_bit_mode	= true,
@@ -197,6 +206,8 @@ static const struct xr_type xr_types[] = {
 		.gpio_set	= 0xc0e,
 		.gpio_clear	= 0xc0f,
 		.gpio_status	= 0xc10,
+		.tx_fifo_reset	= 0xc80,
+		.rx_fifo_reset	= 0xcc0,
 		.custom_driver	= 0x20d,
 	},
 	[XR2280X] = {
@@ -215,6 +226,8 @@ static const struct xr_type xr_types[] = {
 		.gpio_set	= 0x4e,
 		.gpio_clear	= 0x4f,
 		.gpio_status	= 0x50,
+		.tx_fifo_reset	= 0x60,
+		.rx_fifo_reset	= 0x63,
 		.custom_driver	= 0x81,
 	},
 };
@@ -384,6 +397,40 @@ static int xr_uart_disable(struct usb_serial_port *port)
 	return __xr_uart_disable(port);
 }
 
+static int xr21v141x_fifo_reset(struct usb_serial_port *port)
+{
+	int ret;
+
+	ret = xr_set_reg_um(port, XR21V141X_UM_TX_FIFO_RESET, XR_FIFO_RESET);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_um(port, XR21V141X_UM_RX_FIFO_RESET, XR_FIFO_RESET);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int xr_fifo_reset(struct usb_serial_port *port)
+{
+	struct xr_data *data = usb_get_serial_port_data(port);
+	int ret;
+
+	if (data->type->fifo_reset)
+		return data->type->fifo_reset(port);
+
+	ret = xr_set_reg_uart(port, data->type->tx_fifo_reset, XR_FIFO_RESET);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, data->type->rx_fifo_reset, XR_FIFO_RESET);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int xr_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -781,6 +828,10 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	int ret;
 
+	ret = xr_fifo_reset(port);
+	if (ret)
+		return ret;
+
 	ret = xr_uart_enable(port);
 	if (ret) {
 		dev_err(&port->dev, "Failed to enable UART\n");
-- 
2.26.3

