Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A7400D16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhIDVaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhIDV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 17:29:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC9C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 14:28:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t19so5257314ejr.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJVqHB9Vivy37vcOI9Lcc/lkvWZV+F0NexBFFrpqmBc=;
        b=RjZwbC0bM+q65U91XA1ANMieM2vUHw29QBtsgMf1GIG5RdQ7wZH9rzH0Lc2pU/nOgX
         CupK1rI8EQ5cM89NZSNu+MEG/btSyj1Muzzysb6gAZ9U/XajRAhYjiD6GN4aHcF6CRiJ
         T15n3CdwnQud9shnVL2iHPb7TyvK3IW/nUUFxs6OIvyHWXfLKpTAtgM1EO++dIhUmuuF
         Ul8EpH36nn0XGZMNvfo3NlQYLanhidNPcnl/fy4d067oWjsHePo6B+YnMG9xKFQ7ecrD
         j4aU3VgLRGi37izZg93vagG3/5OT0fRJ9fskPDQbytqUHxmFlooTmEP/5vobVdppUksR
         YfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJVqHB9Vivy37vcOI9Lcc/lkvWZV+F0NexBFFrpqmBc=;
        b=pScAD193szSYvKj03+s+pPFx6A/JEGGXszEwQSJCewC2N/7vp1TUaNFa+kRi12/q2Q
         PgUA+67COudNBlxXcA5nuR/Ba6poVMR8dIMiZou2ECe+8nF61ALmiEIVl7vO9GA8w9gf
         cqdh361FBC0uEsKgOAYN4Uptl4z6nBrVVIYGu1XFrlNsAu9RWTuz4rwWnYF346pMzFPi
         ZORO4Xbdz4LgXcPXjb/5bt40027wdzB+TJWaUU/214X63ZJrWK5yQyulaO2XU3BLeWyy
         Z7oqd98FrQgttY4PChscb8VXcXy74FMnpInfv28NIu17fCRIexx4RGo/1X9Ympgkw94Q
         1TNw==
X-Gm-Message-State: AOAM530aYEzQd+GytzB0U045rV0sip7a41yJ1UWBleMb8/DugYKqzP8A
        n+YjdrZi3sXYaaRSreJUE6U=
X-Google-Smtp-Source: ABdhPJyvvYjrl/VTBjt0NvzluJ6Z2WeRY8TTtWixFJhiJwXgMwmjO+Sw8hXT432APiTTWDfob+YLwQ==
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr5881134eje.296.1630790933639;
        Sat, 04 Sep 2021 14:28:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id n13sm1866699edq.91.2021.09.04.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 14:28:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
Date:   Sat,  4 Sep 2021 23:27:19 +0200
Message-Id: <20210904212719.11426-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904212719.11426-1-fmdefrancesco@gmail.com>
References: <20210904212719.11426-1-fmdefrancesco@gmail.com>
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

