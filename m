Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF1409BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbhIMSOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346995AbhIMSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:14:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jg16so22977197ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3V7DMKPJJvwehsD4WObT7K24OjngUt4B/EuDupEHMYU=;
        b=Oohbd2Xzcg+Z+Bkkty6F9zGo+1TB25o7ZSsiIoE8RB82qXfqxSOsZapyIbwHq1v0fT
         E8ssbazuxfvd9QWlHYaN0j4qrx2/0TcvNt3rAoVWGEso+wzPLktRFLSeHoZFNPiPUnAb
         eNza2nUSlc/KXkWVqgVMt36+Lbwbc8Q8QMTDlwzaYAlxNZucccIz8+l63OayVUltG8fK
         jTGR+42vrQwA0CU3gAmLgsx4KQBcMFqHXJNTTynIhvGMYZXnxT7roqpjp1BjUE/Nm2NR
         j7j0cKmrnBx9Bsj2QAN5MHzr+6RadUfti4nbEg2Pe+TRIv+xQJPf7ca0a9GwMpkGBV62
         EofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3V7DMKPJJvwehsD4WObT7K24OjngUt4B/EuDupEHMYU=;
        b=SJK8Hz2RY4RooJUJv1Xw/jafDkuUmBoDd5T8tVDTh5Hmmk6j1UhGUsAVd6uenbFcSS
         7oo8oLU+N5cIBV1S1fRv/R8TKPi8gZxLzG3EDdwqPqdY8QBjudS3v3V53nAwRioi4Yc4
         1Svj07jNGT2dlXg/xKX4HoCZY0Vmrr0VEi8/h+6+Nh/wOlPkNszrhrYGrKY3zpzQq6ky
         swXXjhgU+j74fqenpo8+hcMIfT2sqVEDFbixb9AeCukBj7CjIAHaP/aq9BAzJ+jMzbP1
         ZaVdNd2xVP3OfjBSARNAkJlHxNkO/PZuf75rhtXfps5kEoQxdT7G/gSaHeNUoOSGq6DS
         OO9Q==
X-Gm-Message-State: AOAM5323wIF4kr8+V/CDRCIap+mo0gw9Vna3yCbHLXDtYeD2Pw3wzrDO
        488XFT1S+4hB2Kv7ncpHYvAitu/GVWM=
X-Google-Smtp-Source: ABdhPJz8gkouX1rHc18REadd+Br5hIMPKjC30GQFshmduC48ac9nQe1IBpFzmH4dMdQR3msaJiNwmQ==
X-Received: by 2002:a17:907:2717:: with SMTP id w23mr14216415ejk.283.1631556771184;
        Mon, 13 Sep 2021 11:12:51 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:12:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 15/18] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Mon, 13 Sep 2021 20:09:59 +0200
Message-Id: <20210913181002.16651-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up usbctrl_vendorreq () in usb_ops_linux.c because some
of its code will be reused in this series. This cleanup is in
preparation for shortening the call chains of rtw_read{8,16,32}()
and rtw_write{8,16,32,N}(). More insights about the reasons why at
https://lore.kernel.org/lkml/5319192.FrU0QrjFp7@localhost.localdomain/

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v3->v4:
        Make this patch.
v2->v3:
        No changes.
v1->v2:
        No changes.

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 62 +++++++++------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 117213c9f984..2c7e92085a6e 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -8,15 +8,15 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
 {
-	struct adapter	*adapt = pintfhdl->padapter;
-	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
-	struct usb_device *udev = dvobjpriv->pusbdev;
-	unsigned int pipe;
 	int status = 0;
-	u8 *pIo_buf;
+	u8 *io_buf;
+	unsigned int pipe;
 	int vendorreq_times = 0;
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
 		status = -EPERM;
@@ -32,51 +32,44 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
-	pIo_buf = dvobjpriv->usb_vendor_req_buf;
-
-	if (!pIo_buf) {
-		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
-		status = -ENOMEM;
-		goto release_mutex;
-	}
+	io_buf = dvobjpriv->usb_vendor_req_buf;
 
 	if (requesttype == REALTEK_USB_VENQT_READ)
-		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
+		/* read in */
+		pipe = usb_rcvctrlpipe(udev, 0);
 	else
-		pipe = usb_sndctrlpipe(udev, 0);/* write_out */
+		/* write out */
+		pipe = usb_sndctrlpipe(udev, 0);
 
 	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
 		if (requesttype == REALTEK_USB_VENQT_READ)
-			memset(pIo_buf, 0, len);
+			memset(io_buf, 0, len);
 		else
-			memcpy(pIo_buf, pdata, len);
+			memcpy(io_buf, data, len);
 
 		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
 					 requesttype, value, REALTEK_USB_VENQT_CMD_IDX,
-					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+					 io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
 
-		if (status == len) {   /*  Success this control transfer. */
+		if (status == len) {
+			/*  success */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == REALTEK_USB_VENQT_READ)
-				memcpy(pdata, pIo_buf,  len);
-		} else { /*  error cases */
-			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
-				value, (requesttype == REALTEK_USB_VENQT_READ) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
-
+				memcpy(data, io_buf,  len);
+		} else {
+			/* errors */
 			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				if (status == (-ESHUTDOWN || -ENODEV)) {
 					adapt->bSurpriseRemoved = true;
 				} else {
-					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 				}
-			} else { /*  status != len && status >= 0 */
+			} else {
+				/*  status != len && status >= 0 */
 				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ) {
-						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
-						memcpy(pdata, pIo_buf,  len);
-					}
+					if (requesttype == REALTEK_USB_VENQT_READ)
+						memcpy(data, io_buf,  len);
 				}
 			}
 
@@ -86,12 +79,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 			}
 
 		}
-
-		/*  firmware download is checksumed, don't retry */
+		/*  firmware download is checksummed, don't retry */
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-release_mutex:
+
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
-- 
2.33.0

