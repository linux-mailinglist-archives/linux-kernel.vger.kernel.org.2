Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C153472D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhCXHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235621AbhCXHlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DA4361A05;
        Wed, 24 Mar 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616571678;
        bh=9LzGbS75k390RLeX5KjGDyZ6m4h91qVwN6Sq85lg1rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bY0Rw4mpjpCGkQB5g7UGEzwGofhodqg19o4U58vVjg52i/KdF+/eQApPpmcyrRNS/
         czcf2bX8vh2B0LvfulIBMFqvFbvofNo95FS45yQjAwkplPOh5uuobYTAwaUM3sJa9B
         uT9yXJI3NDtM7+bCBfKorNXWAjHjls8ibmrm0gQVMBJwLQ0PnRl+mV5/A7ZswwU6/S
         IFFWdHHY3oc+FMecP3HQsH1k7pFFLZAYB55alxh1dP4tkVRurelqFanl/Z+uwJDNNh
         5IdM4dUoOmPFaPoqXAeFEXEBrkjvPASiQDNCS7rYL0bZsonI2VTtfTC9lPZp5H+nG6
         y2a4Tq8ajRttw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lOy8h-000umf-Um; Wed, 24 Mar 2021 08:41:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 5/7] USB: serial: xr: add support for XR21B1411
Date:   Wed, 24 Mar 2021 08:41:09 +0100
Message-Id: <b53d8889ed0f47c8ae12a8c65df7a970819e72fd.1616571453.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing special on this device: it has just one port.

The only difference is that it uses a different register set.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 058624d15505..b1044dd3e994 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -99,6 +99,7 @@ struct xr_txrx_clk_mask {
 #define VIA_CDC_REGISTER		-1
 
 enum xr_model {
+	XR21B1411,
 	XR21V141X,
 	XR21B142X,
 	MAX_XR_MODELS
@@ -132,6 +133,30 @@ enum xr_hal_type {
 };
 
 static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
+	[XR21B1411] = {
+		[REG_ENABLE] =				0xc00,
+		[REG_FORMAT] =				VIA_CDC_REGISTER,
+		[REG_FLOW_CTRL] =			0xc06,
+		[REG_XON_CHAR] =			0xc07,
+		[REG_XOFF_CHAR] =			0xc08,
+		[REG_TX_BREAK] =			0xc0a,
+		[REG_RS485_DELAY] =			0xc0b,
+		[REG_GPIO_MODE] =			0xc0c,
+		[REG_GPIO_DIR] =			0xc0d,
+		[REG_GPIO_SET] =			0xc0e,
+		[REG_GPIO_CLR] =			0xc0f,
+		[REG_GPIO_STATUS] =			0xc10,
+		[REG_GPIO_INT_MASK] =			0xc11,
+		[REG_CUSTOMIZED_INT] =			0xc12,
+		[REG_GPIO_PULL_UP_ENABLE] =		0xc14,
+		[REG_GPIO_PULL_DOWN_ENABLE] =		0xc15,
+		[REG_LOOPBACK] =			0xc16,
+		[REG_LOW_LATENCY] =			0xcc2,
+		[REG_CUSTOM_DRIVER] =			0x20d,
+
+		[REQ_SET] =				0,
+		[REQ_GET] =				1,
+	},
 	[XR21V141X] = {
 		[REG_ENABLE] =				0x03,
 		[REG_FORMAT] =				0x0b,
@@ -190,6 +215,8 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 	int ret;
 
 	switch (port_priv->model) {
+	case XR21B1411:
+		break;
 	case XR21V141X:
 		if (port_priv->channel)
 			reg |= (port_priv->channel - 1) << 8;
@@ -226,6 +253,8 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 		return -ENOMEM;
 
 	switch (port_priv->model) {
+	case XR21B1411:
+		break;
 	case XR21V141X:
 		if (port_priv->channel)
 			reg |= (port_priv->channel - 1) << 8;
@@ -874,6 +903,7 @@ static void xr_disconnect(struct usb_serial *serial)
 
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
+	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = XR21B1411},
 	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = XR21V141X},
 	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = XR21V141X},
 
-- 
2.30.2

