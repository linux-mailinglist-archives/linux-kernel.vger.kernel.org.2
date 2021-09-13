Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E7409BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbhIMSO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347177AbhIMSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:14:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D303C061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v24so9501016eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqgqNFf+fV8jwPOMAjoPzlK6kg+1czy7uuQDOiE9SPA=;
        b=Zslj339YLyRq7aGEU560rW36G090XCmoCn5kD8tuV+5636azU55/pQ/WnHldQ8K9HO
         psrkcRF2aNgWJwrWoqeFVsHNVvhmH8uUpSPATz5i5SEwLPOAujle3ZjqEtnme0dcRoKJ
         X/eJZ+r+1f7RyAZF0Bp5tXkYG7QJUaSAkcHY42h9t0hq3euDkAlUkFllfXoFgkU9Gp1K
         4yCgkdulgNVMMcNqErNWAYZdhSf9IQi0fZ+v+c1VCuvRZrDZYZUe++4FdZwWQfzwUJEv
         KLDmSfPzO8+zM+GqtSA59gIgtvMgEUfDnFGGLpXn2BHNdE5j/8OJmyrNtJF3T26fViIn
         zv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqgqNFf+fV8jwPOMAjoPzlK6kg+1czy7uuQDOiE9SPA=;
        b=w62303NTbz51G4iqHh4WY37slH7QEhtYC4dNCeUlm3wluyLTuZvLA/qhHJx1X4gHVM
         tOX98u8AocNLT9zIAAA8uqlBJ6rCLBuVzSaPtpKAXXe6Sy9/XqsBMuWmQk5jBUkFouea
         4WBdN3/DpYkctvL3aAzjkFS0iy+R4nCcpcC1NA5KRGSfemZCST554YMTUS8Ifkh2j8qh
         1eGBCpAxbB9ZJkEDxfC04mQIwTybfeLIPtTqhAWLd0Yt3ArGMnJxWM/rFdArBX5jCHVp
         MOV5BY8luVN702n8EDVMSZ42u0RHyimto7YSfP6wBZNG65CzHVQ/tc4hxFcF4c5rDP77
         pXXg==
X-Gm-Message-State: AOAM532MMYASRnK7v7DXcvX7JeF8DT+jAvQaTqpLxENYc4Kb9EmlenPP
        cKBHLGcjgfYenDMxbkgcNWw=
X-Google-Smtp-Source: ABdhPJynxPW/zUnhPbWnAWpT3cAWHi20RE4JoIgftzl0V0YCy4uEnstw+cM6x/zkCKlbZyqyuK7phA==
X-Received: by 2002:a50:c90b:: with SMTP id o11mr14576291edh.216.1631556782624;
        Mon, 13 Sep 2021 11:13:02 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:13:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 16/18] staging: r8188eu: hal: Clean up rtw_read*() and rtw_write*()
Date:   Mon, 13 Sep 2021 20:10:00 +0200
Message-Id: <20210913181002.16651-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in usb_ops_linux.c
because some of their code will be reused in the following two patches of
this series. This cleanup is in preparation for shortening the call chains
of rtw_read{8,16,32}() and rtw_write{8,16,32,N}().
More insights can be found at
https://lore.kernel.org/lkml/5319192.FrU0QrjFp7@localhost.localdomain/

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v3->v4:
        Make this patch.
v2->v3:
        No changes.
v1->v2:
        No changes.

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 71 +++++++++++----------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2c7e92085a6e..04402bab805e 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -91,91 +91,92 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
 	u8 data;
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 address = (u16)(addr & 0xffff);
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);
 
 	return data;
 }
 
 u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
-	__le32 data;
+	__le16 data;
+	u16 address = (u16)(addr & 0xffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_READ);
 
-	return (u16)(le32_to_cpu(data) & 0xffff);
+	return le16_to_cpu(data);
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
+	u16 address = (u16)(addr & 0xffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
 
 	return le32_to_cpu(data);
 }
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
 	int ret;
+	u16 address = (u16)(addr & 0xffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
-	__le32 data = cpu_to_le32(val & 0x0000ffff);
 	int ret;
+	u16 address = (u16)(addr & 0xffff);
+	__le16 data = cpu_to_le16(val);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
-	__le32 data = cpu_to_le32(val);
 	int ret;
+	u16 address = (u16)(addr & 0xffff);
+	__le32 data = cpu_to_le32(val);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
-int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
+int rtw_writeN(struct adapter *adapter, u32 addr, u32 len, u8 *data)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
-	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
+	u16 address = (u16)(addr & 0xffff);
+	u16 length = (u16)(len & 0xffff);
+	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, pdata, length);
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	memcpy(buf, data, length);
+	ret = usbctrl_vendorreq(intfhdl, address, buf, length, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

