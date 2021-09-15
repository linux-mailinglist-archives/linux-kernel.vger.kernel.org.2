Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFD40C589
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhIOMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhIOMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:46:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z24so5889089ejf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV6Bva6KO7vnoa1fmXgtLRJy5UVZEIDHUKWfdZaOf0c=;
        b=Aw1fgB1aPb7dfG+N/GFxFu5RkxFwVvHIak0HHJN1uxpabOPk1i/P3F383JAzcCsC0C
         kbYFeWD9qrSS/ATrpXpEREng4ya+0cvVv9wTo+5uhYV+6Fl/rccL3sOVEDQiL6YzHWLF
         1008aOXp4tf0lcwBJjgj5c0qpPwT4jf11Dk9JUlseFRnQ8h+VlCSPB7UK5bDg3srWASl
         45Qnbf8gK733riX++DxbMfnhr2dEBTq7QEXXzMmk2E7jk3bTRZe/cyBAsDoSfsvnQyOF
         iMtRSM+N2Obc/7uZbAN8UHzj6kxwdfpLGFS7x+EflqkcURp+Re/QvacOqQ70X4K8cgfU
         4Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV6Bva6KO7vnoa1fmXgtLRJy5UVZEIDHUKWfdZaOf0c=;
        b=c7W6tWv7zLcAsSxjYREdzOk6pdy/CKgJ9lXv2eNSbRdWXP1+zSTwmAZXOmis+eroog
         oRFuPgVzK/nuRU3cv2PPElu7zWRABpaMP7+T1QKYZJPbcqWa9R4bh6MC5rvrbZsS98KS
         WbGiJrgTLmlS2XiW2Zqw+RXdtXzaM+n7AecAljdyllIdAPBoXEFtM2bX84xD+jMwvdxO
         CYTvUXyTAf7MqpY2JkoSjRTkDfEpQl3iUCItiFCxT37f/tOr58OCWo6V7bZ3GaEakHjc
         xXWvptRkQD4gOE2FGUBRQxF717xd+BQkmCr9kcXmJHEEBKdpR/CrCAAvlXruCK7eCmYT
         Ub2w==
X-Gm-Message-State: AOAM531B5STv2L0y39D4c7ORRsXb8odddJnWVl7dr5VaUyQMBfRyt5ao
        I0tW4LNz0cfHcviaKKwWCpA=
X-Google-Smtp-Source: ABdhPJx1MdgOEmcrE50O6eppRf05YATiTOzYImSXW6XqtgXts2DsIpf/y7DgtxOQZIGAuv33d+Z7LA==
X-Received: by 2002:a17:907:76b2:: with SMTP id jw18mr25218797ejc.120.1631709890441;
        Wed, 15 Sep 2021 05:44:50 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:44:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 15/19] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Wed, 15 Sep 2021 14:41:45 +0200
Message-Id: <20210915124149.27543-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up usbctrl_vendoreq () in usb_ops_linux.c. Eventually this function
will be deleted but some of the code will be reused later. This cleanup
makes code reuse easier.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 60 +++++++++------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 117213c9f984..4385260185b2 100644
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
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
+	int vendorreq_times = 0;
 	unsigned int pipe;
 	int status = 0;
-	u8 *pIo_buf;
-	int vendorreq_times = 0;
+	u8 *io_buf;
 
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

