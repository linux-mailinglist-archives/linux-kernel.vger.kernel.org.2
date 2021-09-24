Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DC4171DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbhIXMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbhIXM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F285C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y89so24667883ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBjmp+TdyCNRpmkBBM6vbsQ1ywbXn3Qo6qFKStjh4lE=;
        b=oU0NVcP9eafIOjc22+oWqAFJVOIm3vWT69oEKuBqNFdBkdNa8HD20hg65xm6kWO/GO
         xcRY2z0iwPhfYWxFXdrY7BKgdtn8FhuBbbEzwBRMJGmdnF/fo4OybwymemoLAK+CWog4
         bXN5XT5OwBXc/Uhu26/EZeGtuQzUALLq4WC1RgUrbJ/PRRfMm8poh1FfR1HZpWMB37z4
         sWEOdK0+OD260W72/lVo13tmwVHzs2u06iGXazR9j3haiQyfWPN/BkGL3tHzKxBmlL3K
         C6V/rg+ycpP1rW0GyR73upUsFnvJywHFwQFXWHilzCD12v32Zr4OSaAWJ3ecUPXOM/mn
         WaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBjmp+TdyCNRpmkBBM6vbsQ1ywbXn3Qo6qFKStjh4lE=;
        b=4HCp6ddP3pzuxpbiyf2+M7RmB8Tt+McPCXiJkokW1URtMYPK2FuHTciPCcDBh2YGgM
         zPcA85+Dqzo9+4TOAWiZad9xZXL6BquasijUrTtsYh+xRiSI0Al7DuFc5NYvsOuKt4du
         uFKdJZKiOfxZ5C513zA8YNXVDuse2pvxQqNzYe655tC57vokmUfkh3/UmwBTIdJQFz1f
         YyHWCqToepB79rXrji2Vx2UrePWN/D7NQXK6r9QV//dHWbL19jHGVuEoaRXYYEBa1i6e
         eGpTlj1cjlVATcFgnKR1rjOeKNay1jPek9JxXq0+ap9nPdJ02i2vxlmwEXxgoMxgbQxs
         jjog==
X-Gm-Message-State: AOAM532RqJsS12tCx9osG4zlHkZCBuAkmjF69Y+qWeBW15a3j5bZmK79
        b/ECPH7vMu0ijyyRYqEaTfg=
X-Google-Smtp-Source: ABdhPJwIJeZ61yVikAO01doJXhH+drHjzLX5Mdlp5hVh2z9OYb2PC1kkMxP+2wUPfXF8Fn0Q92XmoQ==
X-Received: by 2002:a50:bec8:: with SMTP id e8mr4738289edk.231.1632486468586;
        Fri, 24 Sep 2021 05:27:48 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 16/16] staging: r8188eu: remove mutex 'usb_vendor_req_mutex'
Date:   Fri, 24 Sep 2021 14:27:05 +0200
Message-Id: <20210924122705.3781-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove mutex 'usb_vendor_req_mutex'.

It was used to protect a shared buffer for USB requests and, since that
buffer is removed in previous patch, this mutex is now useless.

Furthermore, because it was used to serialize the calls to the Core USB
API, we thoroughly tested the enabling of concurrent firing of USB requests
without the mutex and found no problems of any kind in common use cases.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 30 ++++++---------------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 24 -----------------
 2 files changed, 8 insertions(+), 46 deletions(-)

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
index 5ab42d55207f..1f51f96e4dfe 100644
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
@@ -146,23 +134,12 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
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
 exit:
 	return pdvobjpriv;
 }
@@ -188,7 +165,6 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
-		rtw_deinit_intf_priv(dvobj);
 		kfree(dvobj);
 	}
 
-- 
2.33.0

