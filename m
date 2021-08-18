Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976D53F0C55
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhHRUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhHRUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:01:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C4C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:01:14 -0700 (PDT)
Received: from dslb-084-059-254-239.084.059.pools.vodafone-ip.de ([84.59.254.239] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mGRkJ-000286-R6; Wed, 18 Aug 2021 22:01:07 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: ctrl vendor req index is not used
Date:   Wed, 18 Aug 2021 22:00:41 +0200
Message-Id: <20210818200041.10870-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818200041.10870-1-martin@kaiser.cx>
References: <20210818200041.10870-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index for r8188eu's vendor-specific control requests is not used.
Remove the index parameter from usbctrl_vendorreq and pass index 0 to
usb_control_msg.

This patch is an adaptation of commit 3d0be94f62fd ("staging: rtl8188eu:
ctrl vendor req index is not used") for the new r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 33 +++++++--------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2583e3a941fd..953fa05dc30c 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -10,7 +10,7 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
 {
 	struct adapter	*adapt = pintfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
@@ -56,7 +56,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, u16 index, vo
 		}
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
+					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
 		if (status == len) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
@@ -104,19 +105,17 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	u8 data = 0;
 
 
 
 	requesttype = 0x01;/* read_in */
-	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 
 
@@ -128,15 +127,13 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	__le32 data;
 
 	requesttype = 0x01;/* read_in */
-	index = 0;/* n/a */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
@@ -145,17 +142,15 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	__le32 data;
 
 	requesttype = 0x01;/* read_in */
-	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 	return le32_to_cpu(data);
 }
@@ -164,18 +159,16 @@ static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	u8 data;
 	int ret;
 
 
 	requesttype = 0x00;/* write_out */
-	index = 0;/* n/a */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 	return ret;
 }
@@ -184,7 +177,6 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	__le32 data;
 	int ret;
@@ -192,14 +184,13 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 
 
 	requesttype = 0x00;/* write_out */
-	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 
 	data = cpu_to_le32(val & 0x0000ffff);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 
 
@@ -210,7 +201,6 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	__le32 data;
 	int ret;
@@ -218,13 +208,12 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 
 
 	requesttype = 0x00;/* write_out */
-	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, &data, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
 
 
 
@@ -235,7 +224,6 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 {
 	u8 requesttype;
 	u16 wvalue;
-	u16 index;
 	u16 len;
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
@@ -243,13 +231,12 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 
 
 	requesttype = 0x00;/* write_out */
-	index = 0;/* n/a */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = length;
 	memcpy(buf, pdata, len);
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, index, buf, len, requesttype);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, len, requesttype);
 
 	return ret;
 }
-- 
2.20.1

