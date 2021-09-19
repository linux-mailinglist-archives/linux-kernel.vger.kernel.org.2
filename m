Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63E410DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhISX6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhISXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF3C061766
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n10so53228518eda.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ri1NGHOG1/eUxwxuj66t52qxfLBq7eT7c9whTDsFICk=;
        b=kj3LSv7Kg7Pqois4YLVgxLnXphihuBOcPnrbPy/xD51rxEDU8b5ipNZlSjIDKPsNsq
         pja+LJEpqV9kqU63kvpGQT/j1A/lUiyQOBVySc+G3CtUCpZJ1s6LAvJqdW2cMF1ZTaXK
         g5LGehSUiEacFYgDvsUsBsV1k/l8B5m1Aq3Ei+jx+lRkauNPCj5JL9243rx1nj8K0HP0
         2YjeZvJRNbZPBBMVZTFNgaE++H1MjONEdtCOgRO+LjCdu0RaLGZ7Js7NO6PZ/Umrakxc
         HolhZba7cPxASqwGYXIIeoLiidvMzshHfS0tL1FgzamAh3h4sozYXaax2MpbtiSmTsep
         tkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ri1NGHOG1/eUxwxuj66t52qxfLBq7eT7c9whTDsFICk=;
        b=53jX4IAN1GHyEBISLwkyHvljOOIyzAlD1rcMIezTwAiB77KbGoX97RSpCZVPQXJnCK
         oe5eM2RiDg7PLbkVwyuoA6YgPLDZb4vaIjDiwmGRHp35OPdShi6Vz9zTA8Wt/30tVkHi
         nf2CMZuP+YuJ4xBtn/URy3zG4e4JdjvIIwzZDwK43e7GqSKLGUJn2xeszk6AXQJYiQfl
         BH78AwuxIiqREq/RV89/qtotuP/3FEOHv5BQFo00sfLhh9fzrfLAe8eWS4F440pgTF7l
         mGO+PQ4eyrPLYroTjp1vw1hBouucThkDDMYDMcFQt0hMm7Ls7wC3w4/ns1R7QKgEDJyv
         jZPw==
X-Gm-Message-State: AOAM533QIU+etrzB9DUQKc55PkbHg+mh/uSgB9Zr6D7L2aXgHwC4mCuC
        e0F4RBBrjVYCo2+TDUK+CsA=
X-Google-Smtp-Source: ABdhPJxTfFNVhT+0E7UROTJQeAi3NmIKs3E+pt2Den1kOK3vV5kunFAumMhYS2fANzJ5lv4DxNl0tQ==
X-Received: by 2002:a17:906:6953:: with SMTP id c19mr17824409ejs.286.1632095666966;
        Sun, 19 Sep 2021 16:54:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 19/19] staging: r8188eu: remove usb_vendor_req_mutex
Date:   Mon, 20 Sep 2021 01:53:56 +0200
Message-Id: <20210919235356.4151-20-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

This mutex was used to protect shared buffer for USB requests. Since
buffer was removed in previous patch we can remove this mutex as well.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 18 ++++-------------
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 22 ++-------------------
 2 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 75500c28d6e6..19a37fd6a4b4 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -16,8 +16,6 @@ static int usb_read(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[4];
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
 	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
 		return -EPERM;
 
@@ -37,7 +35,7 @@ static int usb_read(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		return status;
 	}
 
 	if (status < 0) {
@@ -47,15 +45,12 @@ static int usb_read(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
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
 
@@ -67,8 +62,6 @@ static int usb_write(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
 	int status;
 	u8 io_buf[VENDOR_CMD_MAX_DATA_LEN];
 
-	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
-
 	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
 		return -EPERM;
 
@@ -89,7 +82,7 @@ static int usb_write(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
 		 * exist or is not enabled.
 		 */
 		adapt->bSurpriseRemoved = true;
-		goto mutex_unlock;
+		return status;
 	}
 
 	if (status < 0) {
@@ -99,14 +92,11 @@ static int usb_write(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
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

