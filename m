Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D713F355D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbhDFUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245514AbhDFUtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:49:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F1C06174A;
        Tue,  6 Apr 2021 13:49:16 -0700 (PDT)
Received: from ipservice-092-217-067-214.092.217.pools.vodafone-ip.de ([92.217.67.214] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lTsdM-0005Yc-2d; Tue, 06 Apr 2021 22:49:12 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/11] staging: rtl8188eu: use actual request type as parameter
Date:   Tue,  6 Apr 2021 22:48:22 +0200
Message-Id: <20210406204829.18130-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210406204829.18130-1-martin@kaiser.cx>
References: <20210406204829.18130-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, usbctrl_vendorreq's requesttype parameter must be set to 1
for reading and 0 for writing. It's then converted to the actual
bmRequestType for the USB control request. We can simplify the code and
avoid this conversion if the caller passes the actual bmRequestType.

We already have defines for the read and write request types. Move them to
usb_ops_linux.c, they're used only inside this file. Replace the numeric
values with USB constants to make their meaning clearer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/rtl8188eu/include/usb_ops_linux.h |  3 --
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  | 52 +++++++------------
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index 70d729742839..4e0e48cb5c8e 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -16,9 +16,6 @@
 
 #define RTW_USB_BULKOUT_TIME	5000/* ms */
 
-#define REALTEK_USB_VENQT_READ		0xC0
-#define REALTEK_USB_VENQT_WRITE		0x40
-
 #define ALIGNMENT_UNIT			16
 #define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
 #define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index b760636f03d3..205a15dd67a5 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -10,6 +10,9 @@
 #include <recv_osdep.h>
 #include <rtw_sreset.h>
 
+#define REALTEK_USB_VENQT_READ	(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define REALTEK_USB_VENQT_WRITE	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+
 #define REALTEK_USB_VENQT_CMD_REQ	0x05
 #define REALTEK_USB_VENQT_CMD_IDX	0x00
 
@@ -202,13 +205,12 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 }
 
 static int
-usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 requesttype)
+usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 reqtype)
 {
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	unsigned int pipe;
 	int status = 0;
-	u8 reqtype;
 	u8 *pIo_buf;
 	int vendorreq_times = 0;
 
@@ -242,13 +244,14 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		memset(pIo_buf, 0, len);
 
-		if (requesttype == 0x01) {
+		if (reqtype == REALTEK_USB_VENQT_READ) {
 			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-			reqtype =  REALTEK_USB_VENQT_READ;
-		} else {
+		} else if (reqtype == REALTEK_USB_VENQT_WRITE) {
 			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
-			reqtype =  REALTEK_USB_VENQT_WRITE;
 			memcpy(pIo_buf, pdata, len);
+		} else {
+			status = -EINVAL;
+			goto free_buf;
 		}
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
@@ -256,11 +259,11 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
 		if (status == len) {   /*  Success this control transfer. */
-			if (requesttype == 0x01)
+			if (reqtype == REALTEK_USB_VENQT_READ)
 				memcpy(pdata, pIo_buf,  len);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (requesttype == 0x01) ? "read" : "write",
+				value, (reqtype == REALTEK_USB_VENQT_READ) ? "read" : "write",
 				len, status, *(u32 *)pdata, vendorreq_times);
 
 			if (status < 0) {
@@ -270,7 +273,7 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 					adapt->HalData->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
-					if (requesttype == 0x01) {
+					if (reqtype == REALTEK_USB_VENQT_READ) {
 						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
 						memcpy(pdata, pIo_buf,  len);
 					}
@@ -282,8 +285,9 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-	kfree(pIo_buf);
 
+free_buf:
+	kfree(pIo_buf);
 release_mutex:
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
@@ -292,49 +296,41 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 
 u8 usb_read8(struct adapter *adapter, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 data = 0;
 
-	requesttype = 0x01;/* read_in */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 	return data;
 }
 
 u16 usb_read16(struct adapter *adapter, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x01;/* read_in */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 u32 usb_read32(struct adapter *adapter, u32 addr)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x01;/* read_in */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
-	usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_READ);
 
 	return le32_to_cpu(data);
 }
@@ -502,49 +498,41 @@ void rtw_hal_inirp_deinit(struct adapter *padapter)
 
 int usb_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	u8 data;
 
-	requesttype = 0x00;/* write_out */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
-	return usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	return usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 }
 
 int usb_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x00;/* write_out */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 
 	data = cpu_to_le32(val & 0x0000ffff);
 
-	return usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	return usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 }
 
 int usb_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	u8 requesttype;
 	u16 wvalue;
 	u16 len;
 	__le32 data;
 
-	requesttype = 0x00;/* write_out */
-
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
 
-	return usbctrl_vendorreq(adapter, wvalue, &data, len, requesttype);
+	return usbctrl_vendorreq(adapter, wvalue, &data, len, REALTEK_USB_VENQT_WRITE);
 }
 
 static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
-- 
2.20.1

