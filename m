Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDF40CE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhIOVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhIOVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB07AC0613D8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z94so8527771ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHysNSIHzdlKYM6By0UyN/gJoUUZL0PJ5U6+oumTvTU=;
        b=HDoZAbLB59S+VXwLwr128eQI8pxGi11fAK8ih4/QHuxOoJXY5C0mgmOHntZUvWbMZR
         bwKox1QEOyJ2qSWoBmE724wQCGACgNBN3HjAPmSmeBRu2w8bO7U3aQiC9qoBshuZJNLB
         riwScnr/gM3uHy1kNL6/Jni6DM2fuVSsi/R5Nt1qeVB7WUAhGniiAAqyRXPobxwLvd5W
         ksE1pDj/tzQnRmPWhANGCyKocaSSgcA3luZQm2JeLSI3y4eAt564r19FcWhc1Z2C/xhF
         90oIFJI1vRGbR1BEbtWbMaa2pyY/vDNPR/ZRUzIlFCEcsKPCKkg0kI5f+jVt+yfkhAB2
         hHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHysNSIHzdlKYM6By0UyN/gJoUUZL0PJ5U6+oumTvTU=;
        b=UWNpl/DO7QyzSOLBVvulk6fYl1we6stPnwF4iyKAihF+Zq1fwGyVSPw9S6jrU0udrD
         ofzcD0raoFi+NFNGmaz5lJzZYDCgeAIHigQphYZvI0vXt1bWRkwLskygF6mac1vqWxmA
         DyOduF+Y9bgFPFbJ7sdxTKaf5UAunwnEDrZuePttwOURU8RQKYRgV/8CTDU2UZ/kUuO9
         7xNSmq6fJt+fsNpyw69sMrXl2rBSgR1t8lwNj1dLkX4qMre09zHNMtYINfYUFdglnZdE
         BflN0+2DiT/6HnG2sghgWN/iiN5M+rAw/Rq4winVE546RrYNeulWp2qDVxPmrgALR30G
         0REw==
X-Gm-Message-State: AOAM533/Zgqyog9eQNu/crYe/JqLCYLMgXrZ6rb3DyRExR2mKr1CYGBH
        xy+do+qdDfba14gddbtcjl8=
X-Google-Smtp-Source: ABdhPJx1Ehh8NpGPSywlzFOVmM+8xXiN2HhD8pgmoIjksgCZ+6qqFconbIWh+bTjmgDzthDbIpDF8g==
X-Received: by 2002:a17:907:262f:: with SMTP id aq15mr1685794ejc.104.1631740298522;
        Wed, 15 Sep 2021 14:11:38 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:38 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 16/19] staging: r8188eu: Clean up rtw_read*() and rtw_write*()
Date:   Wed, 15 Sep 2021 23:11:00 +0200
Message-Id: <20210915211103.18001-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in usb_ops_linux.c.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 68 ++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2098ce935dc0..d87da84eca07 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -91,91 +91,91 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 address = addr & 0xffff;
 	u8 data;
-
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
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 address = addr & 0xffff;
+	__le16 data;
 
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
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 address = addr & 0xffff;
 	__le32 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
 
 	return le32_to_cpu(data);
 }
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 address = addr & 0xffff;
 	int ret;
 
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
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	__le16 data = cpu_to_le16(val);
+	u16 address = addr & 0xffff;
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 	__le32 data = cpu_to_le32(val);
+	u16 address = addr & 0xffff;
 	int ret;
 
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
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
+	u16 address = addr & 0xffff;
+	u16 length = len & 0xffff;
 	int ret;
 
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

