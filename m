Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB340CE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhIOVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhIOVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF963C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h17so8540149edj.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDwYiDOns8dNazua/uS9cfYsJtzSJs0ViVitlyXDhbo=;
        b=eYUkHFBD1eNFaNoahes3at3r4s2smwnIzAGAn9T+LvBF8EsvTB2jVCZ9rQuPk29Sal
         bDodOLITtRoEBMQgenqVe7VyeKHLxRKzJ2YvofTFirbdWSxCzXuofiVqJOnonRtvTa1D
         NItc7cSbppM/A2n4zpEIbecnnUnIF8Ha9MQxJ7hRfH/ava/z+9spN3sDMzXjZO1WWjhM
         hT7JRwlTUlLtCAvS+ZddHBSLMVthr4DnG+2fzUJ3yhH6N6+2EqUGEAlXgWe3ETLTXjRW
         egRZWkvI1uLIl/be/vpjfOBkIpHxYtwrcgThiKpJKm2ZIH4voMJdwh4aJig/CBsT5xRH
         L2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDwYiDOns8dNazua/uS9cfYsJtzSJs0ViVitlyXDhbo=;
        b=zuFZsMUUTABFdwUzwqztrvYbOhRjejA/RNDLTr2mqwHgj8J5dC0yyhhTLumKGJ3v2G
         wk4+5Z4AV+H7756VZ3zTUw74YmmgFBOv3rskaBkjzTrNUuEZWw7ePof7iBV0X1yT1E4h
         5rGJrfWF7rh8tOSBkObOhCtrz84JawuhHWnYGk/t09ViVpQ7gKT7mXP0O+0vxNo40k6X
         pJHc2rdIvwzIQWRtxkKJKkYTcyn0Hn8WZaRNY8v4V2zou136xa1aqaD5/Xhk44iJZAo3
         lsPx48I25NaIltAT1+kY0jwpYJ5f6FydiHIBUlmsoxOwhJHNblAXDI4yjTeUE5opeJZ2
         0PNA==
X-Gm-Message-State: AOAM532Ea2lhxb2JFlRvYh0HwgyOggtC5t2eP8acUE1Zqbw52SJ/J8E1
        4kN81pd9Z2aDQlzWqN4mxgo=
X-Google-Smtp-Source: ABdhPJzv91Khu3T8JGsbir4dmZ0pANnDunv8BNJgRVbq/tQXtw8xv1sZoj+aAS6qMdbydeCCxXIEzw==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr2197830ejr.398.1631740302515;
        Wed, 15 Sep 2021 14:11:42 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 19/19] staging: r8188eu: remove shared buffer for USB requests
Date:   Wed, 15 Sep 2021 23:11:03 +0200
Message-Id: <20210915211103.18001-20-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
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
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 29 ++++++++++-----------
 drivers/staging/r8188eu/include/drv_types.h |  5 ----
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 29 +--------------------
 3 files changed, 15 insertions(+), 48 deletions(-)

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
index 306325818a9a..7603cb026368 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -73,29 +73,6 @@ static struct rtw_usb_drv rtl8188e_usb_drv = {
 
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
@@ -158,9 +135,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		DBG_88E("NON USB_SPEED_HIGH\n");
 	}
 
-	if (rtw_init_intf_priv(pdvobjpriv) == _FAIL)
-		goto free_dvobj;
-
 	/* 3 misc */
 	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
 	rtw_reset_continual_urb_error(pdvobjpriv);
@@ -169,7 +143,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 
 	status = _SUCCESS;
 
-free_dvobj:
 	if (status != _SUCCESS && pdvobjpriv) {
 		usb_set_intfdata(usb_intf, NULL);
 		kfree(pdvobjpriv);
@@ -200,7 +173,7 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 				usb_reset_device(interface_to_usbdev(usb_intf));
 			}
 		}
-		rtw_deinit_intf_priv(dvobj);
+
 		kfree(dvobj);
 	}
 
-- 
2.33.0

