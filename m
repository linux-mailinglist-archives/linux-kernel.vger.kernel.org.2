Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90840CE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhIOVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhIOVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94414C061768
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c22so8496344edn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YaKTkldeUMURGHdd7K8xsfBhcYKhjvlUSC1d7lLbqs=;
        b=QjaMKiinrXMuQku/qjIZqFvHQQ8ofW3QPOI1nWUflOZDd0cNvWDzGvkcB/KL1OVT6s
         8iTZWANZPzOXpaprCUVFyANC0gpB9R+dy3A5rrh47M/rqvYz9POYwcILeiocfc7d9ab6
         VFlIjUvm4klr+GlJZ6QULH0yJYetNA4vZTnyuSbSdI8nwFkY17lZT/8hBsTHj1hATsHy
         K8rriklREOtiO+XyAiK9G1b1xhSbte28BzU9kpeE8Ov48V1Soi8y5fscpA0R3BFYofxB
         cA1r09I3tJVIE5EO75+fuuX0iHD6kb/zXrEnBDdkCMf90LFJ9/p/KgarFc2nCZ/f7Jen
         A3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YaKTkldeUMURGHdd7K8xsfBhcYKhjvlUSC1d7lLbqs=;
        b=smagKmrz8q33SRvQKEqVS6DEb1qto+XjBcNf24bjUxs+D8qg+8Ai/9OCCR6LfkXQM6
         km2Kkk/svOSFrw7bx3wq8PZV6Zo+D4ZCP2GehOBEHCDcNpJyfyff0+m8jHJH8iU69A9i
         MyS+uwGAebdUZZoJm0HJgFEn04dRGIAYMklPoxQHlqfzuEuJVWe0ysPtL/H9DulHBAv5
         tmHwGzciYGT4grZ0iVTMOxhFuKDY99uqGl/IRP0VJtE36L6emXtFRLJYOgn84Z6CTTsc
         NcgmyWdHnEHfQqNpFKibWlBnLgBTEFTSXZVNvzUdlPBmK0G7jznf0rfMLWqtrB5R3LgE
         t3XQ==
X-Gm-Message-State: AOAM530adfbf5+2uDoScHlSSNrd0D/eCxFrpXjDFgqtFbjMW56IVSYVp
        R9yVJVdHLvfzwxNQe5aFt5OvPYC0Q/c=
X-Google-Smtp-Source: ABdhPJzLGV0bw81pBwlVXe/6tqEzpqSkzolAyl/JPIBk/N0XssdmNocdMgLoy551sC1kuzVIEoI6PA==
X-Received: by 2002:a17:906:d52:: with SMTP id r18mr2214545ejh.47.1631740297123;
        Wed, 15 Sep 2021 14:11:37 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 15/19] staging: r8188eu: Clean up usbctrl_vendorreq()
Date:   Wed, 15 Sep 2021 23:10:59 +0200
Message-Id: <20210915211103.18001-16-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up usbctrl_vendoreq() in usb_ops_linux.c.

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

