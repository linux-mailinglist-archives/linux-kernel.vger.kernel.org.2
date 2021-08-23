Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8423F536C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHWWjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhHWWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:38:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q3so28596648edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2st0E622CO/ULYAGBtWwvM8gaAWdHnZHZnHosgqqovg=;
        b=e0/hNkh14K8vDOFKOVGYrGGhGsN1gLbNp+ZSLhZL3sTEjTDQWyeLxUurFC2XMdb36m
         qBbci/cMAgtxDSFIoDtpLF3FeASr284aiQIBTN3jTOhZaEbobJJaeNFf+/xiose3qRCs
         /2gvzgAHlUgeBX/7rkXsbn1f/gk1yhdUmifFaAZDKf9ys9SbYt82Rx+FF0qKRQKsaLjo
         cYaLSofNfi402fhxFxhbT72Y82ulHJdBHxL++knE6pWvX3vpqT30saQNKtB5ABS5YX/P
         Xhf1/HUaes9Pdzu92XMlAxB1n/cdijgZhq4CcGDO4X0I2zTCRqdiLz6AyeN3VCX9Vy67
         2kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2st0E622CO/ULYAGBtWwvM8gaAWdHnZHZnHosgqqovg=;
        b=MIwZfd5QOxlWuExDFEcShookdLZFCpO5fYxfMYxf2txboePZCWzNMl27ZFk/PzNgIb
         iHQ3ssMLEe6znVAQQ9GLnTG9+Y9zuBqQzRKsbqzjsLdTyNQ+4qLMH3JgMb+AOBUC6BZf
         gja8Pj8SI1mC7wrePqjFpm9uEg8K1HJ+xJ+e33ap6t1niWeRscmTazziBz62xcsa0HK5
         zj1ugnuvl0E66gxUciH5wH3JgYPP6/G2b6FyUxHCD7O17MjT7bPXxDeD1Ln76zTSkIJF
         EquuweLY2MSL+58BLZ68USbqXySXEosN9Uy5Gze3UaYAlydU6Mn3Kwy6aE8q8D1i7NAY
         9TJQ==
X-Gm-Message-State: AOAM530ZXZZKZmZSsLbdASEH5QLY0rmYqh+mSdRYOu3XUp0qWEGvIfDP
        LRaA8QLwbwaG5lvxKW9L6Uk=
X-Google-Smtp-Source: ABdhPJyZZRHMlvkLxgL04X8fthsxBgX1NkkrzvfYwjf/avsw2PXxurlHQh3ENNXnJqxZ7gtukWvutw==
X-Received: by 2002:a05:6402:2158:: with SMTP id bq24mr40190162edb.8.1629758285075;
        Mon, 23 Aug 2021 15:38:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id p23sm10375326edw.94.2021.08.23.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 15:38:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 00:37:51 +0200
Message-Id: <20210823223751.25104-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823223751.25104-1-fmdefrancesco@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After replacing usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
variable that is passed as argument to the new API and remove the initial
'p' (that probably stands for "pointer") from the same pIo_buf and from
the pintfhdl and pdata arguments of usbctrl_vendorreq().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 26 ++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6f51660b967a..5ce31ae18ed8 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -10,14 +10,14 @@
 #include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
-static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata, u16 len, u8 requesttype)
+static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u16 len, u8 requesttype)
 {
-	struct adapter	*adapt = pintfhdl->padapter;
+	struct adapter	*adapt = intfhdl->padapter;
 	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
 	u8 pipe;
 	int status = 0;
-	u8 *pIo_buf;
+	u8 *io_buf;
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
@@ -34,10 +34,10 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
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
@@ -47,25 +47,25 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 			status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
 						      REALTEK_USB_VENQT_READ, value,
 						      REALTEK_USB_VENQT_CMD_IDX,
-						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
 						      GFP_KERNEL);
 		} else {
-			memcpy(pIo_buf, pdata, len);
+			memcpy(io_buf, data, len);
 			status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
 						      REALTEK_USB_VENQT_WRITE, value,
 						      REALTEK_USB_VENQT_CMD_IDX,
-						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
+						      io_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
 						      GFP_KERNEL);
 		}
 
 		if (!status) {   /*  Success this control transfer. */
 			rtw_reset_continual_urb_error(dvobjpriv);
 			if (requesttype == 0x01)
-				memcpy(pdata, pIo_buf,  len);
+				memcpy(data, io_buf,  len);
 		} else { /*  error cases */
 			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
 				value, (requesttype == 0x01) ? "read" : "write",
-				len, status, *(u32 *)pdata, vendorreq_times);
+				len, status, *(u32 *)data, vendorreq_times);
 
 			if (status < 0) {
 				if (status == (-ESHUTDOWN) || status == -ENODEV) {
@@ -77,8 +77,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == 0x01) {
-						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
-						memcpy(pdata, pIo_buf,  len);
+						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
+						memcpy(data, io_buf,  len);
 					}
 				}
 			}
-- 
2.32.0

