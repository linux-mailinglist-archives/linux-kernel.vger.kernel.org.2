Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7174139FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhIUSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhIUSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r5so7748689edi.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9dvMx8f/Z4m/SzmFytOVvKbWySM33RNIHwNKdB5FAg=;
        b=GtyeaTpzYZYBfHf+aeY0pNF8k2p3eHhIOYMjoRQEPzrnmrd2MSREljqzznD4b8g1Yq
         1tls1hNw2LCDM0fSyTsYRkLw/mZeuU83jVSN39YFJexLkVVd9+m47nfDBHzVxj22PN89
         txet67m9oFJyqGxhpECMGbujBIXev9DU53RK02owZf4kSZSJTr6ztLUS7v/Y1lKe5BpX
         RUddXC+boFJoQu1aiZZclbczTa0nj/OsX04K8shO40M+2TQc0cT3AGPBD8LayN9kF0wi
         Nvd23SSMVRwmDgqRGDAvtXUGc7qmyreICBfGvzQ+EXcGJIYaSpzH2k9IKYLDYEoBWLXt
         SvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9dvMx8f/Z4m/SzmFytOVvKbWySM33RNIHwNKdB5FAg=;
        b=A0P8WdZMpdIiS7asoAHWigBP3X3lkP2EZpqzb5YzJPTG0ZSccVj2Pf13VOsQVYGSBq
         D0fl/joVz3CM5G0UfI+8HMI5RNTiq4ubTFRTffdHBpNcqwDRR1wcHEXKKjD9uNwvh/9D
         griXsAaybPxjB9kWtcsG+4Q+kSFq/3fIhInk1QybS7ZPcfLOUZwNEVP5GYvLiATKdEOu
         r1tXrxy9Wb0xUjMaICSFg478FkeoQvMKrkDd6dGcn36km4qzGlA94YX2dvkKO/BMTsdC
         3l+2iSJg86ioNfT+Cy+wC+thf0T7SIDAcii0KlHhQG4cBJh8lTaN4DqOrCpcXDIeaYpa
         eG4A==
X-Gm-Message-State: AOAM530Xq3OWGb4F1ch/No2BHdgmz9jpkZR/W5DQMOJ00KLPe4Zv9aAJ
        AtNmaMZHoHwgOv9ADoj0qJg=
X-Google-Smtp-Source: ABdhPJzXdg8gyFPlZL1c9h3Y0fS04NZAUc/xrB//v31Mv3l1z2YYVYBn6RSblFXgGtfrWb6mOtE1yQ==
X-Received: by 2002:a17:906:2691:: with SMTP id t17mr34913076ejc.522.1632248351439;
        Tue, 21 Sep 2021 11:19:11 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v9 14/16] staging: r8188eu: call new usb_write() from rtw_write{8,16,32,N}()
Date:   Tue, 21 Sep 2021 20:18:32 +0200
Message-Id: <20210921181834.29677-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
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

