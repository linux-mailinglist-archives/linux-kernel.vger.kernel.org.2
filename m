Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA23B4171D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbhIXM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbhIXM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v24so35442756eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9uk2e2IKdO7Pb1pzmi/avFTaNQi83dwy0jtHQ9iWbU=;
        b=QgZjfA55Zx/kYLbEkP12oFsFCjmA36pZ26JY+nuC731WP1JtRTKSDgyI7cqe3GDHHr
         jiY3p20h8fcIbcFhZ1Uj3WXD2IV/V0ZwyBGjH89AuEVdid92Ck0lWVKMoBX1ncc+vcdh
         WsrAduCEBbL3plDtbUeWV32vxp5rzOSyAkClsT54PPw+Az+tPQYicLVW7KE4eYTV/HR8
         XajpgICs2IjRQhuUDV6lBphuvbSxLX2ZCBTXigu3GLgP+ocTreTtxdsooddQXr3x91FR
         11T9A3SCbUh5sktpRREQOctV4HX5hxRhk4/5b1Jcpp5QHxQr0CURkSekNpfrnyxngPuV
         t1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9uk2e2IKdO7Pb1pzmi/avFTaNQi83dwy0jtHQ9iWbU=;
        b=ulmy+JcKrybCi31CludyWY1R+r9IQ5LD0G4EdYD8UfzAWslIVZ4Mr2Vy0a2VTKoyDn
         zXXyWl3fuZObXdf8NfdkHZC/8+fakQvYCrgsZDLu4jbN+IXAaMPxOYTtdsd6XHdN0RV3
         HnzCGlUr+nE++z/ahCYCZeT8YtuUAXT5AUF4Jrk4dvpBq6VP9Q+4r/neZGxwddHQEB76
         c4tkLSvpcj+qr0e3LJecRLeVr8PnVFLmQWds6Sckz8jrMkY6+VXlszEjeNM4nMGc3Pud
         GdjZ/QhKSibyNJo9RJTx8jIahrVtdq5cUzpySgnz27CegMZN5Fx0mHC79r4tJZJhem2e
         VOvQ==
X-Gm-Message-State: AOAM530eTpgEzSrr7F0UQNcciQ9/tYcykU9cdlpvaC3nQyONKkOCGRim
        P62vsRDJ0r5lmLGClXVhjJ8=
X-Google-Smtp-Source: ABdhPJy7ZwiUdlHkUMRVS0DJqEftf+u2Ase7A7YXeW58TKDtI1rXTMOzF6RG4T1VYusF/4bzTQ2xrA==
X-Received: by 2002:a05:6402:142e:: with SMTP id c14mr4697212edx.121.1632486464347;
        Fri, 24 Sep 2021 05:27:44 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:43 -0700 (PDT)
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
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 13/16] staging: r8188eu: call new usb_read() from rtw_read{8,16,32}()
Date:   Fri, 24 Sep 2021 14:27:02 +0200
Message-Id: <20210924122705.3781-14-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and call new usb_read() instead of usbctrl_vendorreq() from
inside rtw_read{8,16,32}().

In old code, rtw_read{8,16,32}() called usbctrl_vendorreq() which in
turn uses usb_control_msg() from within a "while" loop to build a control
URB, send it off and wait for completion. usbctrl_vendorreq() was used for
both receiving and sending messages, depending on the "requesttype"
argument which was passed by callers.

Compared to usbctrl_vendorreq(), which managed both reads and writes
from and to the USB endpoint, the new usb_read() manages only reads. For
this purpose it uses the newer USB Core usb_control_msg_recv() API. The
latter is preferred according both to a suggestion by Greg Kroah-Hartman
and also to its actual design.

Two noteworthy features of usb_control_msg_recv() are that (1) the data
pointer can be made to a reference on the stack because it does not have
the restriction that usb_control_msg() has where the data pointer must be
to dynamically allocated memory, and that (2) the whole message must be
properly received from the device in order for this function to be
successfuli (if a device returns less than the expected amount of data,
then the function will fail).

usbctrl_vendorreq() uses a "while" loop that we considered unnecessary
so that it is not in the new usb_read(). Furthermore, the latter has no
redundant checking, less obvious comments, and it manages errors before
success cases. All in all, usb_read() is simpler than
usbctrl_vendorreq() and uses less lines of code.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 59 +++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index b3f8a76b5db2..a3dcd366c00c 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -86,6 +86,59 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	return status;
 }
 
+static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
+{
+	struct adapter *adapt = intf->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
+	int status;
+	u8 *io_buf; /* Pointer to I/O buffer */
+
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
+		return -EPERM;
+
+	io_buf = dvobjpriv->usb_vendor_req_buf;
+
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, value,
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
@@ -93,7 +146,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	u8 data;
 
-	usbctrl_vendorreq(intf, value, &data, 1, REALTEK_USB_VENQT_READ);
+	usb_read(intf, value, &data, 1);
 
 	return data;
 }
@@ -105,7 +158,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	__le16 data;
 
-	usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intf, value, &data, 2);
 
 	return le16_to_cpu(data);
 }
@@ -117,7 +170,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	__le32 data;
 
-	usbctrl_vendorreq(intf, value, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intf, value, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

