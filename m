Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A431640C58F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhIOMqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbhIOMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:46:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z24so5892914ejf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMoMcbcxYtWohYPbBjFWnSvsJcrU4mK9w7DriOiH/g4=;
        b=WeVc3GwL9d17WNCTuQA5261NHxe9JS/pid89xAcrqvVbDl5zT3+xUPm3TPRITni/oO
         gwsf5NO52trYO8SMArDyuw4y2VGjm/ihb1BxRubaAR6l1w1AaB70uBdyfRrsDbEhLALL
         S8WCT0LNStZoYZJi75gPOFGA1wLHyGyDRqFsAbdUdEcStxg0W4Gj6Shxduj9rJmnvOfH
         7LL3DHZAotm8xjXcknRIjW1BiBhs6gbQRSipEXxcKmdBby8K4VGQTEz60uPzhlCkdV7G
         iVzkHsSBW/K1Xv9g+bUHfI8rIPr/M4EfwlXObNgjSeSQJpelKfjc6WQYhAmVXTRRkFBM
         NIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMoMcbcxYtWohYPbBjFWnSvsJcrU4mK9w7DriOiH/g4=;
        b=E0hn88Lts+bj0PWPmeRUVVfjyzVNOiImjSzejO24szGzf6Cr9r673CUZdlqxf3B6YA
         +349tRuKzaIDDl5J7emTR94zJ3NbhG4EO3jPJyGQxONXNIvlDhBKQbKAQGSfP0tv8mtn
         JQ0c5W16tzrcqwZdpfqw+RSfYRAAt2rO3Nj9a5OaQStJTYK+ym4V2NZrQ4CBjRm0dufE
         PqmQC9S4VNV4HFBmTlKXOdOzKc/i+lYMbyx5TWmUgRB0uk6s7Fj2vi59zV+45QcoIJ/j
         OWDeLA59Tb1J6n/YUCaJFAa6CIZ15M+Pd6vKiT9e8zxa4RGXpA7T13+Czc65yGoMknXg
         x7GA==
X-Gm-Message-State: AOAM533k1jIY3em8S5wRqjjkkjnNo6ymd0+73w6o2kVeFOMO9ONPitCv
        yQ+J4rXtYUZBaQf0HG3+5oE=
X-Google-Smtp-Source: ABdhPJw80Gc/Vs/BlaGjSMXRW3eJq+nYVHSPFLzZAQhOwHVB/ATtQhLxilE1Z2IUV/vT8pUj2w28Tg==
X-Received: by 2002:a17:906:130a:: with SMTP id w10mr25470296ejb.87.1631709928783;
        Wed, 15 Sep 2021 05:45:28 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:45:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 18/19] staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
Date:   Wed, 15 Sep 2021 14:41:48 +0200
Message-Id: <20210915124149.27543-19-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
For this purpose unify the four usb_write8/16/32/N() into the new
usb_write(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_write() and use in it the new
usb_control_msg_send() API of USB Core.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 112 +++++++-------------
 1 file changed, 41 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 28d639ba8e4e..656f3a774e48 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,88 +8,60 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
+static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 {
 	struct adapter *adapt = intfhdl->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	int vendorreq_times = 0;
-	unsigned int pipe;
-	int status = 0;
-	u8 *io_buf;
-
-	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
-		status = -EPERM;
-		goto exit;
-	}
+	int status;
+	u8 *io_buf; /* Pointer to I/O buffer */
 
-	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
-		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
-		status = -EINVAL;
-		goto exit;
-	}
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+		return -EPERM;
 
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
-	/*  Acquire IO memory for vendorreq */
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (requesttype == REALTEK_USB_VENQT_READ)
-		/* read in */
-		pipe = usb_rcvctrlpipe(udev, 0);
-	else
-		/* write out */
-		pipe = usb_sndctrlpipe(udev, 0);
-
-	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		if (requesttype == REALTEK_USB_VENQT_READ)
-			memset(io_buf, 0, len);
-		else
-			memcpy(io_buf, data, len);
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, addr,
+				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+				      GFP_KERNEL);
 
-		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
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
 
-		if (status == len) {
-			/*  success */
-			rtw_reset_continual_urb_error(dvobjpriv);
-			if (requesttype == REALTEK_USB_VENQT_READ)
-				memcpy(data, io_buf,  len);
-		} else {
-			/* errors */
-			if (status < 0) {
-				if (status == (-ESHUTDOWN || -ENODEV)) {
-					adapt->bSurpriseRemoved = true;
-				} else {
-					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
-					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
-				}
-			} else {
-				/*  status != len && status >= 0 */
-				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ)
-						memcpy(data, io_buf,  len);
-				}
-			}
+	if (status < 0) {
+		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
+			USB_VEN_REQ_CMD_FAIL;
 
-			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
-				adapt->bSurpriseRemoved = true;
-				break;
-			}
+		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
+			adapt->bSurpriseRemoved = true;
 
-		}
-		/*  firmware download is checksummed, don't retry */
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
 
-static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
+static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 {
 	struct adapter *adapt = intfhdl->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
@@ -103,9 +75,10 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	io_buf = dvobjpriv->usb_vendor_req_buf;
+	memcpy(io_buf, data, size);
 
-	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
-				      REALTEK_USB_VENQT_READ, addr,
+	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_WRITE, addr,
 				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
 				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
 				      GFP_KERNEL);
@@ -134,7 +107,6 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
-	memcpy(data, io_buf, size);
 
 mutex_unlock:
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
@@ -185,7 +157,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 	u16 address = addr & 0xffff;
 	int ret;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &val, 1);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -198,7 +170,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	u16 address = addr & 0xffff;
 	int ret;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &data, 2);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -211,7 +183,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 	u16 address = addr & 0xffff;
 	int ret;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &data, 4);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -220,7 +192,6 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 len, u8 *data)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	u16 address = addr & 0xffff;
 	u16 length = len & 0xffff;
 	int ret;
@@ -228,8 +199,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 len, u8 *data)
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, data, length);
-	ret = usbctrl_vendorreq(intfhdl, address, buf, length, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, data, length);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

