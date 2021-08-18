Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95D3F0C54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHRUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:01:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:01:09 -0700 (PDT)
Received: from dslb-084-059-254-239.084.059.pools.vodafone-ip.de ([84.59.254.239] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mGRk9-000286-AM; Wed, 18 Aug 2021 22:00:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: ctrl vendor req value is always 0x05
Date:   Wed, 18 Aug 2021 22:00:40 +0200
Message-Id: <20210818200041.10870-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bRequest value for the vendor specific control requests sent by this
driver is always 0x05. Replace the function parameter with the define from
usb_ops.h.

This patch is an adaptation of commit eeb4661560ff ("staging: rtl8188eu:
ctrl vendor req value is always 0x05") for the new r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 33 +++++++--------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index b4edbfda9a18..2583e3a941fd 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -10,7 +10,7 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
 {
 	struct adapter	*adapt = pintfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
@@ -55,7 +55,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
 			memcpy(pIo_buf, pdata, len);
 		}
 
-		status = usb_control_msg(udev, pipe, request, reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
+					 reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
 		if (status == len) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
@@ -101,7 +102,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
 
 static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
@@ -110,14 +110,13 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 
 
 
-	request = 0x05;
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 
 
@@ -127,47 +126,42 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 
 static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
 	u16 len;
 	__le32 data;
 
-	request = 0x05;
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
 	u16 len;
 	__le32 data;
 
-	request = 0x05;
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
-	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 	return le32_to_cpu(data);
 }
 
 static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
@@ -176,20 +170,18 @@ static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 	int ret;
 
 
-	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
-	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 	return ret;
 }
 
 static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
@@ -199,7 +191,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 
 
-	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
@@ -208,7 +199,7 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 	data = cpu_to_le32(val & 0x0000ffff);
 
-	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 
 
@@ -217,7 +208,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
@@ -227,7 +217,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 
 
 
-	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
@@ -235,7 +224,7 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 	len = 4;
 	data = cpu_to_le32(val);
 
-	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
 
 
 
@@ -244,7 +233,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 
 static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
 {
-	u8 request;
 	u8 requesttype;
 	u16 wvalue;
 	u16 index;
@@ -254,7 +242,6 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 
 
 
-	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
@@ -262,7 +249,7 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 	len = length;
 	memcpy(buf, pdata, len);
 
-	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, buf, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, buf, len, requesttype);
 
 	return ret;
 }
-- 
2.20.1

