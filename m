Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E80240CE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhIOVNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhIOVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE86C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so8496934edn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CImgLWn6vSufrfVAIeLXFPVaKBRrBWMPt1X4TdQ6dds=;
        b=e+1IpORv2iSIo2Ni0Rnx+Kru6YLk/7B6C1d5iv5583ixcC4Ee4KMlwPsFr3RHuy+9V
         Iu/MX50TvXhypjqQ8jC2tM0zS8MftqiMcLjACHBdlje72g+gQGKAjjLkT0TuvCLuRpvJ
         GbiBVA/EOHL/pfa6g1zeyLdm7gJ66/iLCcvv5RoC3V/45JH7/V1AzHKsZtbN3iGHqDFD
         oIVaAqvwg4vK8uUHipDhr3nfPzp74UiHazIeUinCU6X4QUJS1wzQExpr1woN62514o64
         pMrefYnomxcgk2PCRYw0qqG5jAWQ5+Wed+/QD1U6J4qEQ6atjAUbKFcGyyBXo9A0WKLU
         nvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CImgLWn6vSufrfVAIeLXFPVaKBRrBWMPt1X4TdQ6dds=;
        b=EUYDQCPrAyBZnoPsEZ/1L0q0a0HZSVdI0MoQxs+TyfSejjajsmtbJFnQ5BqybwO2Wu
         252VzQfmESIT9rT/2SuKQqZ5y4uCK8KBPVEF+u83HmGJjmMxbgY2RL5CVp/TOtHaP66J
         l990xZRFuiOvgiAGKinJLAa6r8cYxXK5XSDACXvO0MXsl8dqKoL9GxbrG5K2dU5b/jzV
         kreWCFEkoM5uQpeAWoVDc2biRGTLagmyFAjc0WxZuqtPgH4vUGbTzDSzzj53t0g0N6d1
         yxgAT3oCOQ3ApVMaNSJSeNTavPFaNQPNfMmoqhTfRwgk5TQVzn6Z9u/alJllfc+W1bx2
         8lRA==
X-Gm-Message-State: AOAM532FuOaQFqD5+p8Z1EtmTRmo6EORVlJcuA/uP1vVR3vOWXfb6HTR
        A6ID3QKyuYYh08tmqoXzJHU=
X-Google-Smtp-Source: ABdhPJz4ycIP3Y0WjFzNvPGzzGIoLHbNyN6tHDl2Aln3TfT3oWuaNHOwcf/x+I8Av5YEoyjvg4Dy+Q==
X-Received: by 2002:aa7:ca0a:: with SMTP id y10mr2220419eds.329.1631740301136;
        Wed, 15 Sep 2021 14:11:41 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 18/19] staging: r8188eu: Shorten calls chains of rtw_write*()
Date:   Wed, 15 Sep 2021 23:11:02 +0200
Message-Id: <20210915211103.18001-19-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the calls chains of rtw_write8/16/32() down to the actual writes.
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
index ef35358cf2d3..656f3a774e48 100644
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
-				if (status == -ESHUTDOWN || status == -ENODEV) {
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

