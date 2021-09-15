Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335040CE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhIOVNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhIOVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE4C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so8583320edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xca9hMCcCGihExcS8iqDIOPoctxFCad15pPN5IZ1PIk=;
        b=BtVnhAu/4w9dK7wbH/I/6IVr+KarZT5U4hWP5Y6iHeyHyC2uf78FYgrSUsT7jMYYY1
         AqIxW+aU7vCkyqfo3QN89XYzRTniZLxgMKQDZhE5jqUZQMIECdEctlE9u+78r/E8byjz
         xx8pN3rN1AavWuk3YeQYB7N9LJMOAnbuxkWLWGhzw3ZAWYvC2dO28d/RaZlJkvMiyJU3
         HKhpmmoYw7Do4YI2kOaggG81tKAqseX6mKfiMnlgIdbyXO+rY+flLI1osauM5vbPzGsy
         BCDC+38bGV/tY1cVbIoyBaXWNyFuiEBXeAnLrvl5s9jtXg/WhTyIEYlpYRN9ZQxkv9eE
         8r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xca9hMCcCGihExcS8iqDIOPoctxFCad15pPN5IZ1PIk=;
        b=bcW8Hx6cZYc9tlkWjLpO3NvnstwZd7lUSMo2PX+c2y7gwB2RV7NeLN7Z2py6Q46lAH
         99fDR+Mkk2PVzHj4+PNMSSPvftfdEaWAJP2Wm6boopfo8Dc7IvU6FcYqk+f4sEPtjbeD
         0ibaI2DAFqOEL/Se2wTRzHbdQWNDgW0B87e7s0Owax5kOzVFNg95TIZaa1Sb5J9mQ7Ra
         AbmSHMDDaWPlRVo+8U+yNw2+iXKIo1De7oRrM8myNSdtGPFJwgCLt9mRgvbmucrJuCpv
         uK3gd0/AmgJwcmKTUB1al9fXsyA0ljJ9VOpTT2ASzWLyBc0XUi93KthmdxW0wbLGU/dC
         MWYQ==
X-Gm-Message-State: AOAM530kZH5RiZpghLmjTie1d3f7qG6jy14z/2AUYQGWZoTKzsRr04CY
        uLCrzlWE0kI52NGSZkmmlAk=
X-Google-Smtp-Source: ABdhPJxu7QBVPW3Rgij1x/jCE+alA9S2oIgzLPVlOla8RUREFBGWpwrjoJMmrxLYrgEJaSLIG4B5Ug==
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr2193053ejb.310.1631740299830;
        Wed, 15 Sep 2021 14:11:39 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 17/19] staging: r8188eu: Shorten calls chains of rtw_read*()
Date:   Wed, 15 Sep 2021 23:11:01 +0200
Message-Id: <20210915211103.18001-18-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the calls chains of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32() into the new
usb_read(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_read() and use in it the new
usb_control_msg_recv() API of USB Core.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 60 +++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index d87da84eca07..ef35358cf2d3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -89,13 +89,67 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	return status;
 }
 
+static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
+{
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
+	int status;
+	u8 *io_buf; /* Pointer to I/O buffer */
+
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+		return -EPERM;
+
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+
+	io_buf = dvobjpriv->usb_vendor_req_buf;
+
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, addr,
+				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+				      GFP_KERNEL);
+
+	if (status == -ESHUTDOWN ||
+	    status == -ENODEV ||
+	    status == -ENOENT) {
+		/*
+		 * device or controller has been disabled due to
+		 * some problem that could not be worked around,
+		 * device or bus doesn’t exist, endpoint does not
+		 * exist or is not enabled.
+		 */
+		adapt->bSurpriseRemoved = true;
+		goto mutex_unlock;
+	}
+
+	if (status < 0) {
+		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =
+			USB_VEN_REQ_CMD_FAIL;
+
+		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
+			adapt->bSurpriseRemoved = true;
+
+		goto mutex_unlock;
+	}
+
+	rtw_reset_continual_urb_error(dvobjpriv);
+	memcpy(data, io_buf, size);
+
+mutex_unlock:
+	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
+
+	return status;
+}
+
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 	u16 address = addr & 0xffff;
 	u8 data;
-	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);
+
+	usb_read(intfhdl, address, &data, 1);
 
 	return data;
 }
@@ -107,7 +161,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	u16 address = addr & 0xffff;
 	__le16 data;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 2);
 
 	return le16_to_cpu(data);
 }
@@ -119,7 +173,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	u16 address = addr & 0xffff;
 	__le32 data;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

