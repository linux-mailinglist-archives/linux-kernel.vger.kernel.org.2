Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B934EAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhC3OkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhC3Oji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A3DF619CF;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=V9Az9SK1kudygBq678HHRwZCwk6BHQ3LDSAfFXCYOfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mp2ZKwGm+p6EJ6q91kRXjvDhM2qjHmH7rQRV731knt6RLy9QHAt0DI7K9BqHhJ3Hl
         ToRHtaiTKQe8ihzx/t+3g8y8LSH+v/z2xufDWpgqLLLCt74KG5gLjs50pPrE3dHR/8
         Kc4cTO2rbJHAbCAgUnq8nX5BuZAg4OGoNpJjCWs4VuL50wsC4xPsbAQG7m7SX5IXjm
         EioMHqxo0rdl2m2bdViHaOl7M2H7CO8UaNCn/YwBCL/1BKTtpC9LYe0Ymcvk3JV8k0
         hgBZylRxP6tyNR98/2aMLEjaXXNkliPn+T7uyIo17UiuKmZODs9RW3ep5t2iHwcz/C
         oXla4LD33AFQw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXE-0002PO-6Z; Tue, 30 Mar 2021 16:40:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] USB: serial: xr: move pin configuration to probe
Date:   Tue, 30 Mar 2021 16:39:29 +0200
Message-Id: <20210330143934.9197-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143934.9197-1-johan@kernel.org>
References: <20210330143934.9197-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to configure the pins on every open and judging from the
vendor driver and datasheet it can be done before enabling the UART.

Move pin configuration from open() to port probe and make sure to
deassert DTR and RTS after configuring all pins as GPIO.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 45 ++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index f5087a8b6c86..542c1dc060cc 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -532,7 +532,6 @@ static void xr_set_termios(struct tty_struct *tty,
 
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	u8 gpio_dir;
 	int ret;
 
 	ret = xr_uart_enable(port);
@@ -541,13 +540,6 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return ret;
 	}
 
-	/*
-	 * Configure DTR and RTS as outputs and RI, CD, DSR and CTS as
-	 * inputs.
-	 */
-	gpio_dir = XR21V141X_GPIO_DTR | XR21V141X_GPIO_RTS;
-	xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, gpio_dir);
-
 	/* Setup termios */
 	if (tty)
 		xr_set_termios(tty, port, NULL);
@@ -596,10 +588,38 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 	return 0;
 }
 
+static int xr_gpio_init(struct usb_serial_port *port)
+{
+	u8 mask, mode;
+	int ret;
+
+	/* Configure all pins as GPIO. */
+	mode = 0;
+	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_MODE, mode);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure DTR and RTS as outputs and make sure they are deasserted
+	 * (active low), and configure RI, CD, DSR and CTS as inputs.
+	 */
+	mask = XR21V141X_GPIO_DTR | XR21V141X_GPIO_RTS;
+	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, mask);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg_uart(port, XR21V141X_REG_GPIO_SET, mask);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int xr_port_probe(struct usb_serial_port *port)
 {
 	struct usb_interface_descriptor *desc;
 	struct xr_data *data;
+	int ret;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -610,7 +630,16 @@ static int xr_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, data);
 
+	ret = xr_gpio_init(port);
+	if (ret)
+		goto err_free;
+
 	return 0;
+
+err_free:
+	kfree(data);
+
+	return ret;
 }
 
 static void xr_port_remove(struct usb_serial_port *port)
-- 
2.26.3

