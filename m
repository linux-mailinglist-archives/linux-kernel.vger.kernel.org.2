Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3132635B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBZNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhBZN32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:29:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56A8C64F1B;
        Fri, 26 Feb 2021 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614346117;
        bh=kobiy1qJ+rHthumaMqAwlA0j2LKrNJMLKbJHvLfZ+Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn0344StC6rVSYaqHW6IMD4UFFRJTELCnphpG/OJ1m8JKuC5r2z31wk6li7/vodr6
         txzhArOnCu9g+sOVTslJeihFcTbKKEuHiWu9xBuJ/6upbTUEPC5ugvUf0QzGs2W7HZ
         XHevzUZNKqs/1NCOwOoeoizY0mMeckOeT6jT1z0H56q/Iq/IxOV0+uT0sUUu8+8bzd
         SNwpHYy0lD4yXwZ76TJCIEoScrSFLF+nyN6+550xzNSFl/ZwVf+YQjRjRFHMF1uSL2
         i+5b5jp46pOUN33dRGFb3HFcQnvQbeKKZFujTplEzgvcBVuEoe7Y4Lh4advoUkjrt+
         nMYh65zVrsKUw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lFdAY-002nc0-N4; Fri, 26 Feb 2021 14:28:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 6/7] USB: serial: xr: add support for XR2280X devices
Date:   Fri, 26 Feb 2021 14:28:32 +0100
Message-Id: <95d517a2de1f2a1974fdcd2df757efac7781a59e.1614345081.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614345081.git.mchehab+huawei@kernel.org>
References: <cover.1614345081.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing special on those devices either. They just
use a different set of registers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 78722502da63..63a45a2451f9 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -99,6 +99,7 @@ struct xr_txrx_clk_mask {
 #define VIA_CDC_REGISTER		-1
 
 enum xr_model {
+	XR2280X,
 	XR21B1411,
 	XR21V141X,
 	XR21B142X,
@@ -133,6 +134,30 @@ enum xr_hal_type {
 };
 
 static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
+	[XR2280X] = {
+		[REG_ENABLE] =				0x40,
+		[REG_FORMAT] =				0x45,
+		[REG_FLOW_CTRL] =			0x46,
+		[REG_XON_CHAR] =			0x47,
+		[REG_XOFF_CHAR] =			0x48,
+		[REG_TX_BREAK] =			0x4a,
+		[REG_RS485_DELAY] =			0x4b,
+		[REG_GPIO_MODE] =			0x4c,
+		[REG_GPIO_DIR] =			0x4d,
+		[REG_GPIO_SET] =			0x4e,
+		[REG_GPIO_CLR] =			0x4f,
+		[REG_GPIO_STATUS] =			0x50,
+		[REG_GPIO_INT_MASK] =			0x51,
+		[REG_CUSTOMIZED_INT] =			0x52,
+		[REG_GPIO_PULL_UP_ENABLE] =		0x54,
+		[REG_GPIO_PULL_DOWN_ENABLE] =		0x55,
+		[REG_LOOPBACK] =			0x56,
+		[REG_LOW_LATENCY] =			0x66,
+		[REG_CUSTOM_DRIVER] =			0x81,
+
+		[REQ_SET] =				5,
+		[REQ_GET] =				5,
+	},
 	[XR21B1411] = {
 		[REG_ENABLE] =				0xc00,
 		[REG_FORMAT] =				VIA_CDC_REGISTER,
@@ -215,6 +240,7 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 	int ret;
 
 	switch (port_priv->model) {
+	case XR2280X:
 	case XR21B1411:
 		break;
 	case XR21V141X:
@@ -253,6 +279,7 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 		return -ENOMEM;
 
 	switch (port_priv->model) {
+	case XR2280X:
 	case XR21B1411:
 		break;
 	case XR21V141X:
@@ -902,6 +929,11 @@ static void xr_disconnect(struct usb_serial *serial)
 }
 
 static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x04e2, 0x1400), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1401), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1402), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1403), .driver_info = XR2280X},
+
 	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
 	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = XR21B1411},
 	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = XR21V141X},
-- 
2.29.2

