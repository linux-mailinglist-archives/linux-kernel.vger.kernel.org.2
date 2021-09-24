Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B54171DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhIXM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbhIXM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4202DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s17so16785784edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9dvMx8f/Z4m/SzmFytOVvKbWySM33RNIHwNKdB5FAg=;
        b=L+s5ogygb+r+JpD4LGPMG8WVHT7zj2kZDEfIhdXl5ydDcLOxp9EsgAl0JdEucFQAoT
         OE1Why0O+woiKfHWlFkIXc8xtSOujnEhgYZdXFljkpX8Ki4WNBfiGPOIGnAIRW9L8WFq
         WJ/awsBGQfwm9Psg5woJ8kXhjTutYEqtAfqFGFXQSO/GMktsyLZFzHVRasPaEBjl/rfs
         D/huUJYDy5gzwnjXpJRXoKc1MqDL3m1ASOY4DdWSQhc6cLACDtB3zVGY7YQuSG18OxU8
         O3NtYPsqsPVLcGgTq2Py5Cm4pqxhU5micVRASen/WQP1KmEZpqLuE8YXnzsv0ShY/APl
         2LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9dvMx8f/Z4m/SzmFytOVvKbWySM33RNIHwNKdB5FAg=;
        b=Jk3FCq/X0nv4MJbLvVGIJCygI61j/c5DNG95Ij105spGQ64hX05oh+cCaLN594jVZD
         FVBwYnmx7QGuL1Rixh5Pxd2o+Nef6RkoinDonKK+CF+ofhI7TrjmukIf4K9YJVaK7Ptk
         Yhnd86DUeELodhGDsBVxyPl4Q5xM7J2VNXg7aFhiV7+Dn32R1TFTo6+maRDT6aqnnhkj
         9erF/r1ILC2MWEP2evrQO+RqSnaejdycTR6olGMWGx9ATwuN4FurRrxIFwEEdiPEmmpZ
         DkVNbHYe1YR3Iyd1Al7Cge7hguLrfkb/c+4zuBnCvzhQ73zyZIaioQPT63WBMb10M4P0
         9tkA==
X-Gm-Message-State: AOAM5336X8vevvizmFuK1G+8ffpWBdpeLUNfGrJpIfbW2lD/+GG7NwEa
        IQh4AcHxYSkYNULLqw1TXk0=
X-Google-Smtp-Source: ABdhPJwlAD8W/4ikxAmszMgc9p6lUDNLewylhP6d/XqRZwcwsaC200CTMBcUJDfiX94/fWEpqlzbAA==
X-Received: by 2002:a50:e081:: with SMTP id f1mr4768519edl.65.1632486465817;
        Fri, 24 Sep 2021 05:27:45 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 14/16] staging: r8188eu: call new usb_write() from rtw_write{8,16,32,N}()
Date:   Fri, 24 Sep 2021 14:27:03 +0200
Message-Id: <20210924122705.3781-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and call new usb_write() instead of usbctrl_vendorreq() from
inside rtw_write{8,16,32,N}().

In old code, rtw_write{8,16,32,N}() called usbctrl_vendorreq() which in
turn uses usb_control_msg() from within a "while" loop to build a control
URB, send it off and wait for completion. usbctrl_vendorreq() was used
for both receiving and sending messages, depending on the "requesttype"
argument which is passed by callers.

Compared to usbctrl_vendorreq(), which manages both reads and writes
from and to the USB endpoint, the new usb_write() manages only writes.
For this purpose it uses the newer USB Core usb_control_msg_send() API.
The latter is preferred according both to suggestions by Greg Kroah-Hartman
and also to its actual design.

A noteworthy feature of usb_control_msg_send() is that the data pointer
can be made to a reference on the stack because it does not have the
restriction that usb_control_msg() has where the data pointer must be to
dynamically allocated memory.

usbctrl_vendorreq() used a "while" loop that we considered unnecessary
so that it is not in the new usb_write(). Furthermore, the latter has no
redundant checking, less obvious comments, no debug prints, and it manages
errors before success case. All in all, usb_write() is simpler than
usbctrl_vendorreq() and uses less lines of code.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 108 ++++++++------------
 1 file changed, 43 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a3dcd366c00c..88db7488b3a2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,85 +8,63 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 len, u8 requesttype)
+static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 {
 	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	int vendorreq_times = 0;
-	unsigned int pipe;
-	int status = 0;
-	u8 *io_buf;
+	int status;
+	u8 *io_buf; /* Pointer to I/O buffer */
 
-	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
 		status = -EPERM;
-		goto exit;
+		goto mutex_unlock;
 	}
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
 	/*  Acquire IO memory for vendorreq */
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (requesttype == REALTEK_USB_VENQT_READ)
-		pipe = usb_rcvctrlpipe(udev, 0);
-	else
-		pipe = usb_sndctrlpipe(udev, 0);
-
-	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		if (requesttype == REALTEK_USB_VENQT_READ)
-			memset(io_buf, 0, len);
-		else
-			memcpy(io_buf, data, len);
-
-		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, value,
+				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+				      GFP_KERNEL);
 
-		if (status == len) {
-			/*  success */
-			rtw_reset_continual_urb_error(dvobjpriv);
-			if (requesttype == REALTEK_USB_VENQT_READ)
-				memcpy(data, io_buf,  len);
-		} else {
-			/* error cases */
-			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
-				len, status, *(u32 *)data, vendorreq_times);
-
-			if (status < 0) {
-				if (status == -ESHUTDOWN || status == -ENODEV) {
-					adapt->bSurpriseRemoved = true;
-				} else {
-					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
-					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
-				}
-			} else {
-				/* status != len && status >= 0 */
-				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ)
-						memcpy(data, io_buf,  len);
-				}
-			}
+	if (status == -ESHUTDOWN ||
+	    status == -ENODEV ||
+	    status == -ENOENT) {
+		/*
+		 * device or controller has been disabled due to
+		 * some problem that could not be worked around,
+		 * device or bus doesn’t exist, endpoint does not
+		 * exist or is not enabled.
+		 */
+		adapt->bSurpriseRemoved = true;
+		goto mutex_unlock;
+	}
 
-			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
-				adapt->bSurpriseRemoved = true;
-				break;
-			}
+	if (status < 0) {
+		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
+			USB_VEN_REQ_CMD_FAIL;
 
-		}
+		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
+			adapt->bSurpriseRemoved = true;
 
-		/*  firmware download is checksumed, don't retry */
-		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
-			break;
+		goto mutex_unlock;
 	}
 
+	rtw_reset_continual_urb_error(dvobjpriv);
+	memcpy(data, io_buf, size);
+
+mutex_unlock:
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
-exit:
+
 	return status;
 }
 
-static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
+static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 {
 	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
@@ -101,8 +79,9 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
-				      REALTEK_USB_VENQT_READ, value,
+	memcpy(io_buf, data, size);
+	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_WRITE, value,
 				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
 				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
 				      GFP_KERNEL);
@@ -131,7 +110,6 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
-	memcpy(data, io_buf, size);
 
 mutex_unlock:
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
@@ -182,7 +160,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 	u16 value = addr & 0xffff;
 	int ret;
 
-	ret = usbctrl_vendorreq(intf, value, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intf, value, &val, 1);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -195,7 +173,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	__le16 data = cpu_to_le16(val);
 	int ret;
 
-	ret = usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intf, value, &data, 2);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -208,7 +186,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
-	ret = usbctrl_vendorreq(intf, value, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intf, value, &data, 4);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -223,7 +201,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	ret = usbctrl_vendorreq(intf, value, data, length, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intf, value, data, length);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

