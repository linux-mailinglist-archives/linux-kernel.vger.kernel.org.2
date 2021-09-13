Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B60409BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhIMSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbhIMSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:14:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52211C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ho42so22954156ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZftnuC9Ts5UGktOluBokQ4z+ZFLseyMcc6ou05/NKI=;
        b=hOoRgVLHOVlHcDwmmGDoB8TQMQ+PW3XoukkUasVZN1cL1LniYsFPQxOe1a3oMXWRD2
         yEvPQzxmC08IxFd4oyogB7TVExrInS9uxDVDwNHhfNWJq6vhfcb4bqKwFqn2OtSux4ho
         jk5brz8LP2666z71alXDgUqQxlzImhUm3fByb/F1OgI3FrpczJA9Aoffki+w37/tQpZ0
         gaLsYE8M3RZFzX6TCMp5HQWDcrqr5q+3RZnnl2GHnyyknrCWiN4ksR4S4eNQPdoiKpYh
         +gKWnC4W9U1SnK7x05rFpS5Sg+1ACPbCp/F09DrXK8J9utZAmIDlY3lKIcyW1O02SOT5
         8UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZftnuC9Ts5UGktOluBokQ4z+ZFLseyMcc6ou05/NKI=;
        b=ztotn4LJLaTWUgkCPW8cVWoHmRV3z+FWR3PjpDO5+HOjfNz8qCz2+leI4D8dUvjbro
         MbF0F+81wMxW7/V1oHvFkRSV7dL9fNYTzhxrThLlrdg02OhzD0Owzn1Pz1t9DUt/4g0y
         Wx7t7/3mkQnfvgDNUaJqyWR9uXOR1QRJhJVoqSaH5OGDIctmNiqv27BtZRK+bdjDkJy4
         vQQ4Gi4YME9QwEX+DTnqUQDiBKU7QqN3nKy0Eu6qxi1iJ5LGD5DBQoh7AjrZv+l1/TBW
         TqWcMGBKufUgJbTEH0Yyuqrk5pMVowwa3pCoWqJTSc50WIbP6TVshQit+IOSTE4YrSAj
         tLvw==
X-Gm-Message-State: AOAM532cd8UGSKmoBrsyUoFLF1ZNJFCWq5Ija3pBX66zwKmbWZOKzbYk
        F6pw8Lgca9unOCHYoY7W9V4=
X-Google-Smtp-Source: ABdhPJyd0g3LXblrGyIWzT+TX8GS/qEKhmp6JP87md5sYYoFkeOMBfnEBVc019JzXm0c1yuSbGYRzw==
X-Received: by 2002:a17:906:fa04:: with SMTP id lo4mr14223355ejb.560.1631556814860;
        Mon, 13 Sep 2021 11:13:34 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:13:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 18/18] staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
Date:   Mon, 13 Sep 2021 20:10:02 +0200
Message-Id: <20210913181002.16651-19-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

v3->v4:
        Make some changes according to a first review of Greg
        Kroah-Hartman; remove unnecessary 'while' loop and a couple of
        'if' test; handle the errors returned by usb_control_msg_send().

v2->v3: Fix the version number of the patch.
 
v1->v2: Replace parameter REALTEK_USB_VENQT_READ with REALTEK_USB_VENQT_WRITE
	in usb_control_msg_send(). More in-depth explanation at
	https://lore.kernel.org/lkml/2791328.7pjKATJfGa@localhost.localdomain/T/#m1fc1ab2f7c1f463049ad88d5df5bb1b107b37260

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 111 +++++++-------------
 1 file changed, 39 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 75475b0083db..cf27c84c3c90 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,88 +8,57 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
+static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 {
-	int status = 0;
-	u8 *io_buf;
-	unsigned int pipe;
-	int vendorreq_times = 0;
+	int status;
+	u8 *io_buf; /* pointer to I/O buffer */
 	struct adapter *adapt = intfhdl->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 
-	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
 		status = -EPERM;
 		goto exit;
 	}
 
-	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
-		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
-		status = -EINVAL;
-		goto exit;
-	}
-
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
-
-		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
-
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
-
-			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
-				adapt->bSurpriseRemoved = true;
-				break;
-			}
-
-		}
-		/*  firmware download is checksummed, don't retry */
-		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
-			break;
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, addr,
+				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+				      GFP_KERNEL);
+	if (!status) {
+		/*  Success this control transfer. */
+		rtw_reset_continual_urb_error(dvobjpriv);
+		memcpy(data, io_buf, size);
+		goto mutex_unlock;
 	}
-
+	/*  error cases */
+	if (status == (-ESHUTDOWN || -ENODEV || -ENOENT)) {
+		/*
+		 * device or controller has been disabled due to
+		 * some problem that could not be worked around,
+		 * device or bus doesn’t exist, endpoint does not
+		 * exist or is not enabled.
+		 */
+		adapt->bSurpriseRemoved = true;
+			goto mutex_unlock;
+	}
+	GET_HAL_DATA(adapt)->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
+	if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
+		adapt->bSurpriseRemoved = true;
+		goto mutex_unlock;
+	}
+mutex_unlock:
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
 }
 
-static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
+static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 {
 	int status;
 	u8 *io_buf; /* pointer to I/O buffer */
@@ -105,16 +74,16 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
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
 	if (!status) {
 		/*  Success this control transfer. */
 		rtw_reset_continual_urb_error(dvobjpriv);
-		memcpy(data, io_buf, size);
 		goto mutex_unlock;
 	}
 	/*  error cases */
@@ -182,7 +151,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &val, 1);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -195,7 +164,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &data, 2);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -208,7 +177,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, &data, 4);
 
 	return RTW_STATUS_CODE(ret);
 }
@@ -218,15 +187,13 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 len, u8 *data)
 	int ret;
 	u16 address = (u16)(addr & 0xffff);
 	u16 length = (u16)(len & 0xffff);
-	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, data, length);
-	ret = usbctrl_vendorreq(intfhdl, address, buf, length, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, address, data, length);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

