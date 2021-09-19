Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF1410DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhISX6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhISXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A869C0613E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v22so49632071edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JEk2K1K4M/i8MrJCWz0iboALmvwcIaipy98kVBW/xE=;
        b=VE11v5bGWsf2B/wzG4fmht5c7AZhkRQ5V1cUFlxHvB/YTvHbdXivXLL/ymFaJ7px+J
         MTT3VIWfp3ZU0YDkbuDgdKcZN9O8AJojlaWoKuLaQvbVOH77nxCvtMidGZrITVKtFJDh
         x0OwuthkTeaIALdajulKS0Bp7O66OyX3fpiUy/iuIaaNKXjmL9aI39Z71NZBtIKxXKD5
         kuQ92A2ukel0o9GIOsm1xwmZMb+cFLkxCDakmNO0nWYy75ibxk3fVJIlKdBz55sIHEPN
         PXmXlxKqnJX8rsVpsGsfKiH7JZRXu8GQWUMOJv6e4A+M76ZqgOTBnhOMB5uP1XRjTUT2
         UZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JEk2K1K4M/i8MrJCWz0iboALmvwcIaipy98kVBW/xE=;
        b=VhOfT6u3v4cS9Jg1Mg3AUuz6bwolrMbBm9l7HrjsBkAJj/ZfAEVrQBd8l/mgGJcjiG
         mPhaeyabvLKhrawV35X8m7+YnkDDDtfjuVfd7/XRS6B5IudljPgCBPTt5ETM9Ty1qBGD
         mifMfcW3mAaTuljP0chjLb1VPRtjV8A1NPRe8h6M/aKq2ohpUyPkIZexx+vH+ODbXGSp
         mZbcEZhbyTPQxmNWY3isx2NxgObDmL3ekitWBXimxU6LKeg5ScQQSn1zzz6jvbSN8fiM
         2P6ZA+0XXGfSuWile+JMulkSIDfsvjuGJV8hlLyhGgbHUYNiY2ziy/6l6WKRJa9jrfsn
         PsfQ==
X-Gm-Message-State: AOAM5328jHNXJ0yRTSCauWUmeGbWVYZlyjyaWBQOMwjBvFT7ULxG2Bgm
        c1bDG9LLwFCcg5/u294v5xg=
X-Google-Smtp-Source: ABdhPJz2hCUjhGVUN4n/KdmVW7xIWplq5H6NPuk+5T9ZmOnjPKHKTlk4MI3t+qramRJwECOVrwySww==
X-Received: by 2002:a05:6402:3186:: with SMTP id di6mr25402720edb.225.1632095663087;
        Sun, 19 Sep 2021 16:54:23 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 16/19] staging: r8188eu: call the new usb_read() from rtw_read{8,16,32}()
Date:   Mon, 20 Sep 2021 01:53:53 +0200
Message-Id: <20210919235356.4151-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
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
index c378b5740353..53704b7c1059 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -94,6 +94,59 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	return status;
 }
 
+static int usb_read(struct intf_hdl *intfhdl, u16 value, void *data, u8 size)
+{
+	struct adapter *adapt = intfhdl->padapter;
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
@@ -101,7 +154,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	u8 data;
 
-	usbctrl_vendorreq(intfhdl, value, &data, 1, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 1);
 
 	return data;
 }
@@ -113,7 +166,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	__le16 data;
 
-	usbctrl_vendorreq(intfhdl, value, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 2);
 
 	return le16_to_cpu(data);
 }
@@ -125,7 +178,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	u16 value = addr & 0xffff;
 	__le32 data;
 
-	usbctrl_vendorreq(intfhdl, value, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

