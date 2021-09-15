Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F141F40C58D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhIOMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbhIOMqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:46:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23154C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q3so4148922edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLkK8IrqMf+xb3m0l1Xi9Ye5sgUAy2dDoTlNY/x7DC8=;
        b=Evh3A345xOkKxA/1Wrgn+U3J3iRv5wc3Il0XSJf6AGJI/lDoSkfS7JlveB2+jeWOw9
         NQH8IyEqTAL5b22Rz37/fyB0sbX90lZfrKHFbPce1HM0+TFuUsyFkTztS4If8JtAUHYl
         fNsRYzYMktFOXUOoJnB2sQ4WVSDD/z44Gu1OEUhovsIDllz9RIuiOgLflLvAC+M04CsD
         aMwGbY90T6Fd6r3NbN3gNaRV8gXfVVfSOhwyq3FqddAvsjl4b8QSpqCxlWBypIXLn+a9
         M7zJUOotteasvI0yk0Dn0v8jLzITtus4r0fdVr/KWAbx7Ra9JZx20q1uH0DCUdLuUFnf
         8EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLkK8IrqMf+xb3m0l1Xi9Ye5sgUAy2dDoTlNY/x7DC8=;
        b=CbB6iQKZgC15Ir4aUYmhqjHnUvNSSRhVBSh/DUAN4hu4jldNG4ZLlmpeQ4hfe5dcjE
         JaGJLeMNJiEsTZF6s5KsInPCeJiU4054QEzZRnjlBXL2wltcEWZI7tyKvApnVs38JBD9
         leA6CzRpIfdTkTZ1gVCCBX4OralrOCaP2azVUsogZ4QuDm20/gMO3lvTK3s8HQxtHAOr
         zfJOqsLXmRi8keUFMcRN33XzdBYkMqx81StGUpJpBB+jxADUNfDPY4CynbpoeUyfSK1J
         XflQAqpoH7170Is+CpB+bEfP0RZXajTU3kMfMDlw/4Xnsmh2BirU27LvJZmxTb+TgHCd
         cvxw==
X-Gm-Message-State: AOAM5329N0rK31QpKp2QE5jnTnnIgwCvuNhuO2BOwJe6e/SuCPe9b1h9
        QVz6Qu/5G9fu3C5qlZMQvAU=
X-Google-Smtp-Source: ABdhPJz269kOH/kw60XOyaDFtjdfa1qAoIBOiVd/XAWxxKXVw+nGqTZPXpQzwAblvbbvCExBWDNAQw==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr25423577edp.209.1631709913678;
        Wed, 15 Sep 2021 05:45:13 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:45:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 17/19] staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
Date:   Wed, 15 Sep 2021 14:41:47 +0200
Message-Id: <20210915124149.27543-18-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32 into the new
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
index b48d8b5e95fd..28d639ba8e4e 100644
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

