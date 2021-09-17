Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE00F40F31B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhIQHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbhIQHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89788C061787
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n10so25814607eda.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sEUjUUuxHdMPhHnLo8c60yT4HrAvH94MxLwugCdDt4=;
        b=iAdekIQuG2UKVkperbyF6nJPfB5cCWsv0f1Z2Ed3Q642HQtxhgU6Bc3I6Y4HaUQgzC
         3UI06X7pFZuodWlEGcgrm4Fqn4T2B9yImCeH0QXd4dv0cz6wWaQJ4nmhrJ+IQCccaEV+
         DL1efuaJ3QJWK/zio9c6Y/vZfdwFeNfPjxvHcDJ5rGwplBXqSk5AObNXXdDyMcJOkeP7
         6ijGQ2XDdqQ4xYEHOMDZw1LTQzU1RdWcHzyHFpljr/ASjHCKpOxO3l7J+PSahYdnx1Zy
         yc6Czc5TgoDzCUde7NaJC3/4XQXpeSErM0LzMG1TE11HcsVXhyqgjbzOZ9/9a5AcFVoQ
         itDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sEUjUUuxHdMPhHnLo8c60yT4HrAvH94MxLwugCdDt4=;
        b=E5H5dAM6FHqW7XXI8i1dUsSs4g4fXv3nP2Pmt1igVXEZW1Huip/m9bd4a6JQwedoz5
         DDnOSOipbVMp2jVuTI3eIvLY7zraEN3t/BH1ra0+9ncF4QuyfLqZAVD1oTdeVkUKuxNS
         PTBDFhnrvMVueCl21+fcsvFbxfgtY93C2CyRwXH+0eRk3xPSIND5hT4vauWGKr6Efajv
         dF6PGmeEaHmBMr3B/G1t4TnRYMzzSLQIFmtfk+qU1qe7OpYdc8rOKDmuLz9iCiNAF5pY
         09TkgTGR5+6QmO4MI7GCSF5daNife529h20dJW75zHiFIEELkmQI+7jmZTw9wcX2fnlR
         KPiQ==
X-Gm-Message-State: AOAM531mnLhffu3oJOtYPWr+YGh6YDW9GtyHICjRFp/jngHQHfWSrPFu
        AuVXdgMEtGgSd9octKSDdK9OBtaERKk=
X-Google-Smtp-Source: ABdhPJwwRZ82gNTZhiH5g12cxNtmhD+6SSHLWt6aY6THfq0g+yHjqPOaXUbYTZ4X8wY++q6dQhVQRA==
X-Received: by 2002:a17:906:2bcf:: with SMTP id n15mr10812130ejg.414.1631863163166;
        Fri, 17 Sep 2021 00:19:23 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of rtw_read{8,16,32}()
Date:   Fri, 17 Sep 2021 09:18:35 +0200
Message-Id: <20210917071837.10926-18-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
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
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 59 +++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2d5e9b3ba538..ef35358cf2d3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -89,6 +89,59 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
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
@@ -96,7 +149,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	u16 address = addr & 0xffff;
 	u8 data;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 1);
 
 	return data;
 }
@@ -108,7 +161,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	u16 address = addr & 0xffff;
 	__le16 data;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 2);
 
 	return le16_to_cpu(data);
 }
@@ -120,7 +173,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	u16 address = addr & 0xffff;
 	__le32 data;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

