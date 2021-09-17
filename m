Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3390840F31C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbhIQHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbhIQHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:21:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63641C061796
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v24so26376641eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Pd9BEB1H+dKnY5O/FsUTyxJH9fl3v4IKwDspjOfFB4=;
        b=LJL9StgAtpEGFBlwAidmiK8+FE7oow6WOmrA44z1H8Q1Jo/MQX/dwOsw5OiahIN43L
         IpduTQDrjZeHzr+csjOa87G384YLlLI9ZFuCA6/7zIIfm7DiMAOkaBnLOWFgffi/CsZr
         YWmIA5tcfM0Qc0jZuvuOf7BRbBSZ7NrHhDW2a3jVmIX3wT+KxWkjUCkc2w9h9YzW3w7j
         Q3CY7d93otfaNW0mvzfU0Y4dIGhx6bAjm1bmCYnusp+0a5xng5bADaiGaUoqLH+v+qrL
         YdkhYGnBWLw2Lezc47+vCn7qdfmS06t6vZnNDwz5xAQB8VrK03rXFWoLipNmx+bQPDce
         0m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Pd9BEB1H+dKnY5O/FsUTyxJH9fl3v4IKwDspjOfFB4=;
        b=73UCPuI0DHBWH73D+CxSy7nAvNfR2E4I8A+oHXIwdyWM3gx/joGBvQU9tOmq4WXmNO
         sLeWEZdJeLwrxKqOFXf28V+XQKlGtGwwVBQKSeye8xi9Wzp/9ejmzXRh1wGIpqmHQ9lx
         cVJMQtyyBKFZp8cAWgCxuBufzCrIZ2ul/9nd0u1pXTU6Sh0bK6v9D6u2uTK2jleD3VNv
         sVhotPYJCiP4OYTWWgFHUGGiZ0DFs88H70jqgTZzJ/71d+OLgI54BsPmAvNxla2P2TgI
         nmHdrWWx1RYXJoFiZD0hzwWcND7NzfbpPL6P7UEwPm5imoRHJbbaVcNr08vQOSMb+y2k
         /WOQ==
X-Gm-Message-State: AOAM5311hdI77Iw80xFmEFwpyQhNJ8ZBWGkydObN8EjcWq5DCRpFa8kU
        SIMBEb/GhKwYm9nmR1IvAxQ=
X-Google-Smtp-Source: ABdhPJx75fdwbyVIBiyF/OjDlQXHbIIcDpu7S2j+d7i+uMAxR6jV4x54yE/JhswNVJ1+YbklVsHG/Q==
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr11044077ede.351.1631863165776;
        Fri, 17 Sep 2021 00:19:25 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 19/19] staging: r8188eu: remove shared buffer for usb requests
Date:   Fri, 17 Sep 2021 09:18:37 +0200
Message-Id: <20210917071837.10926-20-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

This driver used shared buffer for usb requests. It led to using
mutexes, i.e no usb requests can be done in parallel.

USB requests can be fired in parallel since USB Core allows it. In
order to allow them, remove usb_vendor_req_buf from dvobj_priv (since
USB I/O is the only user of it) and remove also usb_vendor_req_mutex
(since there is nothing to protect).

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 29 ++++++++-------
 drivers/staging/r8188eu/include/drv_types.h |  5 ---
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 40 ++-------------------
 3 files changed, 16 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 656f3a774e48..0ed4e6c8b1f5 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -19,9 +19,9 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
 		return -EPERM;
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
-	io_buf = dvobjpriv->usb_vendor_req_buf;
+	io_buf = kmalloc(size, GFP_KERNEL);
+	if (!io_buf)
+		return -ENOMEM;
 
 	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
 				      REALTEK_USB_VENQT_READ, addr,
@@ -39,7 +39,7 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		goto end;
 	}
 
 	if (status < 0) {
@@ -49,15 +49,14 @@ static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
-		goto mutex_unlock;
+		goto end;
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
 	memcpy(data, io_buf, size);
 
-mutex_unlock:
-	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
-
+end:
+	kfree(io_buf);
 	return status;
 }
 
@@ -72,9 +71,10 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
 		return -EPERM;
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+	io_buf = kmalloc(size, GFP_KERNEL);
+	if (!io_buf)
+		return -ENOMEM;
 
-	io_buf = dvobjpriv->usb_vendor_req_buf;
 	memcpy(io_buf, data, size);
 
 	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
@@ -93,7 +93,7 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		goto end;
 	}
 
 	if (status < 0) {
@@ -103,14 +103,13 @@ static int usb_write(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
-		goto mutex_unlock;
+		goto end;
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
 
-mutex_unlock:
-	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
-
+end:
+	kfree(io_buf);
 	return status;
 }
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 626c6273be6f..499b2bce8cbe 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -168,11 +168,6 @@ struct dvobj_priv {
 	int	ep_num[5]; /* endpoint number */
 	int	RegUsbSS;
 	struct semaphore usb_suspend_sema;
-	struct mutex  usb_vendor_req_mutex;
-
-	u8 *usb_alloc_vendor_req_buf;
-	u8 *usb_vendor_req_buf;
-
 	struct usb_interface *pusbintf;
 	struct usb_device *pusbdev;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 306325818a9a..47568aa10494 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -73,33 +73,9 @@ static struct rtw_usb_drv rtl8188e_usb_drv = {
 
 static struct rtw_usb_drv *usb_drv = &rtl8188e_usb_drv;
 
-static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
-{
-	u8 rst = _SUCCESS;
-
-	mutex_init(&dvobj->usb_vendor_req_mutex);
-
-	dvobj->usb_alloc_vendor_req_buf = kzalloc(MAX_USB_IO_CTL_SIZE, GFP_KERNEL);
-	if (!dvobj->usb_alloc_vendor_req_buf) {
-		DBG_88E("alloc usb_vendor_req_buf failed... /n");
-		rst = _FAIL;
-		goto exit;
-	}
-	dvobj->usb_vendor_req_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(dvobj->usb_alloc_vendor_req_buf), ALIGNMENT_UNIT);
-exit:
-	return rst;
-}
-
-static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
-{
-	kfree(dvobj->usb_alloc_vendor_req_buf);
-	mutex_destroy(&dvobj->usb_vendor_req_mutex);
-}
-
 static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 {
 	int	i;
-	int	status = _FAIL;
 	struct dvobj_priv *pdvobjpriv;
 	struct usb_host_config		*phost_conf;
 	struct usb_config_descriptor	*pconf_desc;
@@ -110,7 +86,7 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 
 	pdvobjpriv = kzalloc(sizeof(*pdvobjpriv), GFP_KERNEL);
 	if (!pdvobjpriv)
-		goto exit;
+		return NULL;
 
 	pdvobjpriv->pusbintf = usb_intf;
 	pusbd = interface_to_usbdev(usb_intf);
@@ -158,24 +134,12 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		DBG_88E("NON USB_SPEED_HIGH\n");
 	}
 
-	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL)
-		goto free_dvobj;
-
 	/* 3 misc */
 	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
 	rtw_reset_continual_urb_error(pdvobjpriv);
 
 	usb_get_dev(pusbd);
 
-	status = _SUCCESS;
-
-free_dvobj:
-	if (status != _SUCCESS && pdvobjpriv) {
-		usb_set_intfdata(usb_intf, NULL);
-		kfree(pdvobjpriv);
-		pdvobjpriv = NULL;
-	}
-exit:
 	return pdvobjpriv;
 }
 
@@ -200,7 +164,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
-		rtw_deinit_intf_priv(dvobj);
+
 		kfree(dvobj);
 	}
 
-- 
2.33.0

