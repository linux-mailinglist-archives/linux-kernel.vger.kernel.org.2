Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C83472D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhCXHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235632AbhCXHlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 415F0619FD;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=sbFt3AN2Cc9PLevym87kI+ODFUSQQQwmk1j9uuP5/Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjGuXqhRRBjvGBAFitKF9IoizGUL+qWVtl3qqblfgmMNoNkBlWHxJuwF1d6HpAi4Y
         48uDDQgs9OnFPfcQOVoO0ZZBP/J8b0pXB8enIU6LO1hUq5BYwPmCtlbvuPbS8Qkc0Z
         PRFIsaU9xqXLScVVtf8pEirR7AILHlbTJxMsUMzap2ejOEngANmsotR1u9zPt7urFI
         betIdE0dwSlyAB+pm4oXUVVw0t9y/TGUpkRbkdgukroE4oe65OegO8HYbjXukmTaoQ
         GCToL81IDV6JF0avwKokNozWJNSXhO65x5koYKdi4EDak0EQQvJEwOApNBwHXN++H8
         UnTfnEazafTxg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8h-000umi-Vc; Wed, 24 Mar 2021 08:41:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 6/7] USB: serial: xr: add support for XR2280X devices
Date:   Wed, 24 Mar 2021 08:41:10 +0100
Message-Id: <385b5ba7739fd1d67b9b2b8fd70187ab19e8d00e.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
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
index b1044dd3e994..72365ffbc1b8 100644
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
2.30.2

