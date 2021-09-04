Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE199400D4A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 00:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhIDWCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 18:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhIDWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 18:02:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BF9C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 15:01:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t19so5348117ejr.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIMWLaffYSoH4Zt5SkP/zr4UWJey5AoUiyXt6T+4tSY=;
        b=nvQftgFkUI10HpZOIMq8XegaQchYRCT8ofQtf2k1s7xmCoevy846TDgC+B62EOqssg
         Ujfk08VvOYJZPncvpCjnYaAxF+5qEzcj3qZfbdlhfP2AUHvfknvJkY0m5AcGZSaYMLYE
         mo8xeVY0sVv1s7rdylZ8ebHZRWzk9GJSY5SVPjlkY9E2wQsPOm+1XkjDfdFTtP7wEwVS
         6u9ZQGdKs1CAX8pB2vI7MPzBYWt0+riKuUwbbRuOfbCsDe1zWjg6Rn86cN7hRJONRKXO
         ER0P9l3nISxrxOFOMMZiXWAZJYJxQzMl6LrsJRcCczdSa7Gs8nH9LRc5RCzii814G2tc
         pAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIMWLaffYSoH4Zt5SkP/zr4UWJey5AoUiyXt6T+4tSY=;
        b=ovWc6Dr53zqED07g7JLFZ2O5NHSJSF/GRW1fq4looEbdWqbLrEXqFK94AIait5AnHj
         9mkugn6rcK3t2tcsl79M5/zQhODSrwoMg+RYfRzuTYANCmzsmjn5nmjyB5vVcRiBxsIM
         Uyjl5ZvSqCT0rDDMnLOIqrZVrvT14ZPZob5sg2hiLvGQsdDcgsOh5w5V9yxWY3H9cKI3
         mfnowG1oEjN3EhiFCy5XdOwj/0oc1BXDmyUW4kshjirwHUTbIFIInKQCId5JM+N4vbyW
         3Bo6z61moAzSXxk26GyQ6sE1Rzc+Osih5i9OG+9lYNADwN+aOSWb5UGYXShtzr1TAZz+
         19wA==
X-Gm-Message-State: AOAM532eoj6Yx3aLT3zEusTXP+AgsmRqjxA3sNkQdcjfb4RaxuXII0UJ
        92UvIe5fz53tI2r6papVdZCMe/UuPdY=
X-Google-Smtp-Source: ABdhPJxA1FPnDYy3SJL61LTgfAxTG4eoNL8K4JI3m4R79W4VNSyawk1d36eJTzZyF31v50hmnE6Vdw==
X-Received: by 2002:a17:907:1dcf:: with SMTP id og15mr6021115ejc.470.1630792860206;
        Sat, 04 Sep 2021 15:01:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id i4sm1940258edq.34.2021.09.04.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 15:00:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 3/3] staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
Date:   Sun,  5 Sep 2021 00:00:48 +0200
Message-Id: <20210904220048.12822-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904220048.12822-1-fmdefrancesco@gmail.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
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

v2->v3: Fix the version number of the patch.
 
v1->v2: Replace parameter REALTEK_USB_VENQT_READ with REALTEK_USB_VENQT_WRITE
in usb_control_msg_send(). More in-depth explanation at
https://lore.kernel.org/lkml/2791328.7pjKATJfGa@localhost.localdomain/T/#m1fc1ab2f7c1f463049ad88d5df5bb1b107b37260

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 130 ++++++++------------
 1 file changed, 53 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index f9c4fd5a2c53..e31d1b1fdb12 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,76 +8,51 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
+static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
 {
-	struct adapter	*adapt = pintfhdl->padapter;
-	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
+	u16 value = (u16)(addr & 0x0000ffff);
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
-	unsigned int pipe;
-	int status = 0;
-	u8 *pIo_buf;
+	int status;
+	u8 *io_buf;
 	int vendorreq_times = 0;
 
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
-	_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
-	pIo_buf = dvobjpriv->usb_vendor_req_buf;
+	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (!pIo_buf) {
-		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
+	if (!io_buf) {
+		DBG_88E("[%s] io_buf == NULL\n", __func__);
 		status = -ENOMEM;
 		goto release_mutex;
 	}
 
-	if (requesttype == REALTEK_USB_VENQT_READ)
-		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
-	else
-		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
-
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		if (requesttype == REALTEK_USB_VENQT_READ)
-			memset(pIo_buf, 0, len);
-		else
-			memcpy(pIo_buf, pdata, len);
-
-		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
-					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
-
-		if (status == len) {   /*  Success this control transfer. */
+		status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+					      REALTEK_USB_VENQT_READ, value,
+					      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+					      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+					      GFP_KERNEL);
+		if (!status) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
-			if (requesttype == REALTEK_USB_VENQT_READ)
-				memcpy(pdata, pIo_buf,  len);
+			memcpy(data, io_buf, size);
 		} else { /*  error cases */
-			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
-
-			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV) {
-					adapt->bSurpriseRemoved = true;
-				} else {
-					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
-					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
-				}
-			} else { /*  status != len && status >= 0 */
-				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ) {
-						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
-						memcpy(pdata, pIo_buf,  len);
-					}
-				}
+			DBG_88E("reg 0x%x, usb %s %u fail, status:%d vendorreq_times:%d\n",
+				value, "read", size, status, vendorreq_times);
+
+			if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				adapt->bSurpriseRemoved = true;
+			} else {
+				struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+				haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 			}
 
 			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
@@ -87,17 +62,18 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 
 		}
 
-		/*  firmware download is checksumed, don't retry */
-		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
+		/*  firmware download is checksummed, don't retry */
+		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || !status)
 			break;
 	}
+
 release_mutex:
-	_exit_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
 }
 
-static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
+static int usb_write(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
 {
 	u16 value = (u16)(addr & 0x0000ffff);
 	struct adapter *adapt = intfhdl->padapter;
@@ -123,15 +99,15 @@ static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
 		goto release_mutex;
 	}
 
+	memcpy(io_buf, data, size);
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
-		status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
-					      REALTEK_USB_VENQT_READ, value,
+		status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+					      REALTEK_USB_VENQT_WRITE, value,
 					      REALTEK_USB_VENQT_CMD_IDX, io_buf,
 					      size, RTW_USB_CONTROL_MSG_TIMEOUT,
 					      GFP_KERNEL);
 		if (!status) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
-			memcpy(data, io_buf, size);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d vendorreq_times:%d\n",
 				value, "read", size, status, vendorreq_times);
@@ -199,55 +175,55 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, value, &val, 1);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val & 0x0000ffff);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, value, &data, 2);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usb_write(intfhdl, value, &data, 4);
 
 	return RTW_STATUS_CODE(ret);
 }
 
-int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
+int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return -EINVAL;
 
-	memcpy(buf, pdata, length);
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	memcpy(buf, data, length);
+	ret = usb_write(intfhdl, value, buf, (length & 0xffff));
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

