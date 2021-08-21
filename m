Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25FA3F3B82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhHUQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHUQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:50:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF2C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:50:01 -0700 (PDT)
Received: from dslb-178-004-175-162.178.004.pools.vodafone-ip.de ([178.4.175.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mHUBu-0002Ch-5U; Sat, 21 Aug 2021 18:49:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: rtl8188eu: use actual request type as parameter
Date:   Sat, 21 Aug 2021 18:48:52 +0200
Message-Id: <20210821164859.4351-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, usbctrl_vendorreq's requesttype parameter must be set to
1 for reading and 0 for writing. It's then converted to the actual
bmRequestType for the USB control request. We can simplify the code and
avoid this conversion if the caller passes the actual bmRequestType.

This patch is an adaptation of commit 788fde031027 ("staging: rtl8188eu:
use actual request type as parameter") for the new r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 46 ++++++---------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a11a0597e515..dccb9fd34777 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -15,7 +15,6 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	unsigned int pipe;
 	int status = 0;
-	u8 reqtype;
 	u8 *pIo_buf;
 	int vendorreq_times = 0;
 
@@ -44,26 +43,24 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		memset(pIo_buf, 0, len);
 
-		if (requesttype == 0x01) {
+		if (requesttype == REALTEK_USB_VENQT_READ) {
 			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-			reqtype =  REALTEK_USB_VENQT_READ;
 		} else {
 			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
-			reqtype =  REALTEK_USB_VENQT_WRITE;
 			memcpy(pIo_buf, pdata, len);
 		}
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
+					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
 					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
 		if (status == len) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
-			if (requesttype == 0x01)
+			if (requesttype == REALTEK_USB_VENQT_READ)
 				memcpy(pdata, pIo_buf,  len);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (requesttype == 0x01) ? "read" : "write",
+				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
 				len, status, *(u32 *)pdata, vendorreq_times);
 
 			if (status < 0) {
@@ -75,7 +72,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 				}
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
-					if (requesttype == 0x01) {
+					if (requesttype == REALTEK_USB_VENQT_READ) {
 						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
 						memcpy(pdata, pIo_buf,  len);
 					}
@@ -101,19 +98,16 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 
 static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 data = 0;
 
 
 
-	requesttype = 0x01;/* read_in */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 
 
@@ -123,57 +117,49 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 
 static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x01;/* read_in */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x01;/* read_in */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 	return le32_to_cpu(data);
 }
 
 static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 data;
 	int ret;
 
 
-	requesttype = 0x00;/* write_out */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 
 	return ret;
 }
 
 static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
@@ -181,14 +167,12 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 
 
-	requesttype = 0x00;/* write_out */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 
 	data = cpu_to_le32(val & 0x0000ffff);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 
 
 
@@ -197,7 +181,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
@@ -205,13 +188,11 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 
 
 
-	requesttype = 0x00;/* write_out */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 
 
 
@@ -220,7 +201,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 
 static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
@@ -228,13 +208,11 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 
 
 
-	requesttype = 0x00;/* write_out */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = length;
 	memcpy(buf, pdata, len);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, REALTEK_USB_VENQT_WRITE);
 
 	return ret;
 }
-- 
2.20.1

