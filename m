Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C140F318
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhIQHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbhIQHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0DC0613E9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v5so26118287edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dj+fGl7pkjpxxZpBogFBXeRvnmxr8u09lZRRilOSE+M=;
        b=mY3prbXeiV8SFABYagUekBHc4iHIOpFzHD3A9R4pksJQtGuKn3w4PMPXcfEKd5d00H
         jLFk9eXT1jPCkYJ20qPlHcOK5QLeRrhU2Y9JGWiMrB8ywGNxVM7u+uzgWhOuduIWGieS
         nNRI5vZLx7VoBItR9NUV5IW+Bx5UoG6D3suSW3wCEekGCob1V47Am5IxSSMGlujguutA
         0Gykvm4WVLWQrmhbQOaan2IxQD9tcGAMzkzkbbGqrQ99L7fmYAIpPA7AHIk0QPtWaSbu
         qgr9tPITb0Rya41hfA37PMyy54dnZWNWqWfNGyHEn8xf0ZwefDYfuuaeWzqYq+cVxqEe
         orAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dj+fGl7pkjpxxZpBogFBXeRvnmxr8u09lZRRilOSE+M=;
        b=zG6ZemE8poTluRGgTNZMxI360VQD9bxz+EnJh7RHhbk5O4hxEW8ykypgZb9YQOwDSa
         c0iXXSoidqJRFtR/Yqgx/dyqnyQgxuuq2IAiQd0RhFV+fkHoXaPOyh8+QDs+HJAO5Xuj
         vt+MpfrhBw5SeNiQmldKHAOiGuslEqiKrgYx/OldIQq73NqJRJMtXwJZCEufYM2yi7Un
         q7hsi8sg9NMM2CNGenNf+w9Q+p1e8JLFRy5jlnM6+buTlAO8xxkY7IuHCmBF5D9IhDpR
         0OmaPjwMEx30zzco1TY636XijOHQUVYQT+VyrU3JK9ktCXoZvKyrYHJtJh2lVLarzVh0
         v0Aw==
X-Gm-Message-State: AOAM5319EsIcsBIWCDcXaQO24dZu2Y/JkkFcaAj0yQ4bTjz+XSyJGn/O
        tjZN0l9V0SM5L9B5ZNMPrVg=
X-Google-Smtp-Source: ABdhPJyVN26F7p2807LuPZZxzLpLcr3HX0VgCCcNmGqJJWK4b/47+3qpXl9d0p7UWdWbIsMuB+XzrQ==
X-Received: by 2002:a17:907:785a:: with SMTP id lb26mr10944726ejc.77.1631863160448;
        Fri, 17 Sep 2021 00:19:20 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 15/19] staging: r8188eu: clean up usbctrl_vendorreq()
Date:   Fri, 17 Sep 2021 09:18:33 +0200
Message-Id: <20210917071837.10926-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up usbctrl_vendoreq() in usb_ops_linux.c.

List of changes:

1) Rename variables:
	pdata => data
        pio_priv => io_priv
        pintfhdl => intfhdl
        wvalue => address.
2) Reorder variables declarations according to the "Reverse Xmas Tree"
   style.
3) Remove unncecessary test for "!pIo_buf".
4) Move comments one line below code.
5) Remove unnecessary excess parentheses.
6) Remove unnecessary extra spaces.
7) Remove unnecessary comments.
8) Fix grammar errors (checksumed => checksummed).

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 60 +++++++++------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 117213c9f984..2098ce935dc0 100644
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
+				if (status == -ESHUTDOWN || status == -ENODEV) {
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

