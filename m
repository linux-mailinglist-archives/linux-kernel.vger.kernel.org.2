Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4F4139FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhIUSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhIUSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60113C061760
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v24so77734256eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTqvejltSg/bMxgdP11IHkbarmw4jl7hIyqp9NWXnIc=;
        b=fUQwlMBuQ1u+0H55lobZVU6lj2p8OKszoyYTfvIMV/Yj+n5SXmy1saAa2xQUAw2vgl
         PTD2nYKn/lTTZ9epA7sy4XgHYzCHgEsa4qJWxuGOBP2SnoIy7uDkrwxokdE3fDFyxURl
         /lISDBRm9ytrYzgeaDbhjNE/OChg126eegRJDC/rfljTfGWHC+3v0Mrxk9c03ZGsnD2w
         my7pQ/V7mS5s3PjWDPmwzS3JSAbQzzD7zqyaXCaL9vuuhln46mjT1joorLEM8uls+62u
         NC3MqKa+OzZB4uZQRDIIWqJSLPHIbaBpNvti975o8BN91z3H9O3Tf4XB0rYaIX9KwXl/
         nfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTqvejltSg/bMxgdP11IHkbarmw4jl7hIyqp9NWXnIc=;
        b=G4TkczgR9YBLiTEEOlWPL8WJAWndTa4/5reo4ENpt5gXAir+oQaKfpibI7fU/W1at5
         P8F4FuRC3nVssVT+bzlX3Kt7RMmr1aW9rz3luKwVG8c5XU3tQWIgTbTIKvDAIWgxO1kN
         3QSWnA8TldvCMB1w9K1i0R/zh8TuYdJle0lujJHyMKVTow27cESUBfVWIZK4qD4mZaFw
         PIJ39ubDCUnfuYgXbjzjld7zxT7SLK4PxfWEjrRU0eo+vtfxZB+fgE3kOmx6u8uEN1D7
         htTq/9GdDLnTjsv2221uNoh/r84vfCvLmIoSzR0tkAElVrxTsA6GFCyuU0SCgX8fgav8
         4BJg==
X-Gm-Message-State: AOAM530MAmM4pOlXWtNKDeKu5LLFSzSuixc17GDCe4ZKgsxG3Sv1yVH3
        +vOIvsZXV8uz8ufVEWfj5AQ=
X-Google-Smtp-Source: ABdhPJw/j3hGMiQhWE5pb6OLARzTD1DEF/jgZLT+XT0R1ww+xHoZajTR61gBgKAkX9v93GYqPl4cOQ==
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr35697554ejb.134.1632248353914;
        Tue, 21 Sep 2021 11:19:13 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 16/16] staging: r8188eu: remove usb_vendor_req_mutex
Date:   Tue, 21 Sep 2021 20:18:34 +0200
Message-Id: <20210921181834.29677-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

This mutex was used to protect shared buffer for USB requests. Since
buffer was removed in previous patch we can remove this mutex as well.

Furthermore, because it was used to serialize the calls to the Core USB 
API, we thoroughly tested the enabling of concurrent firing of USB requests
without the mutex and found no problems of any kind in common use cases.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 30 ++++++---------------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 22 ++-------------
 2 files changed, 10 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3ede93cd68d6..c15a75513c8c 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -16,12 +16,8 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[4];
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
-	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
-		status = -EPERM;
-		goto mutex_unlock;
-	}
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+		return -EPERM;
 
 	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
 				      REALTEK_USB_VENQT_READ, value,
@@ -39,7 +35,7 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		return status;
 	}
 
 	if (status < 0) {
@@ -49,15 +45,12 @@ static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
-		goto mutex_unlock;
+		return status;
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
 	memcpy(data, io_buf, size);
 
-mutex_unlock:
-	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
-
 	return status;
 }
 
@@ -69,12 +62,8 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[VENDOR_CMD_MAX_DATA_LEN];
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
-	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
-		status = -EPERM;
-		goto mutex_unlock;
-	}
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+		return -EPERM;
 
 	memcpy(io_buf, data, size);
 	status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
@@ -93,7 +82,7 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		return status;
 	}
 
 	if (status < 0) {
@@ -103,14 +92,11 @@ static int usb_write(struct intf_hdl *intf, u16 value, void *data, u8 size)
 		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
 			adapt->bSurpriseRemoved = true;
 
-		goto mutex_unlock;
+		return status;
 	}
 
 	rtw_reset_continual_urb_error(dvobjpriv);
 
-mutex_unlock:
-	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
-
 	return status;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 5ab42d55207f..2e6e6070c304 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -73,21 +73,9 @@ static struct rtw_usb_drv rtl8188e_usb_drv = {
 
 static struct rtw_usb_drv *usb_drv = &rtl8188e_usb_drv;
 
-static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
-{
-	mutex_init(&dvobj->usb_vendor_req_mutex);
-	return _SUCCESS;
-}
-
-static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
-{
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
@@ -146,19 +134,13 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
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
+	if (pdvobjpriv) {
 		usb_set_intfdata(usb_intf, NULL);
 		kfree(pdvobjpriv);
 		pdvobjpriv = NULL;
@@ -188,7 +170,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
-		rtw_deinit_intf_priv(dvobj);
+
 		kfree(dvobj);
 	}
 
-- 
2.33.0

