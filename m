Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB79040C58A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhIOMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhIOMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:46:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x22so5841972ejj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixDgGsqX9W1VYO/nDUZ20WxVSp0y4x9Hzj8pWs5BAVg=;
        b=cD/vuqRdKkIhy+HlXdhcBzKpvhVWDeoMjr0bQf9XD7SAiyHe3WIWeOs+ntUqXeWtLI
         sw+2kiXu4+UK4ISzyyJVWu5RPoHBhUoPtFG26q7l4uAOiPvzU6Abs/vQevRDSuV2cL/k
         Ucgw7VPx0qANyETYeMQslx2hHgPUrNwWy8MBGyBs95CnVuOorTa1Qhqxzq8jA1iGZ6nd
         BiDVSp5IDHVBkkz5MgjksyBGDIN/isGrO8bavizWsR8qm4P/cc+MY0qDZSkFXP2pOxv1
         7rAROH458mwjitu8BG6s8Ka/pzdmdFJTQjHXR88VKr/xOL8UBEyXRaz1Xcm6H5X2ONbi
         GzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixDgGsqX9W1VYO/nDUZ20WxVSp0y4x9Hzj8pWs5BAVg=;
        b=nkux1SLRtvMEEsiYDG8IKU/XIfGlvi3854VfR7CY562RI5EJ4bRKRIettdI11yQN4t
         xiiRlB/l20b++RLhfhcIVIzQEA5ITuP+pzzIOi4o/gDq5RCWWcxc50Q+v1s3FjsG2cFo
         Dw3aoFdl0QGxnTn1FVrD5tuyztDwmCLwaFyiZ+EbBjGqElXg/KC0CoQu/hxTSM3OIyB2
         79l2uHA1GrXvDaSi0VOj9ZIh2gH20xVcCjvbOi5khulvEZ/btzNWpRQimTsG3UQdtOrC
         bTtLItUnwIJpJvDjAoQHrBcOHDJfAknZo/+bfPecQdBxRZX9XpyBUr/9H65YPNQMbvWn
         8H3A==
X-Gm-Message-State: AOAM532h3OPSUfH4CCeQJJncHcf1lnAnZI58m6EQIkzr7tgFL5ePuoq+
        tFKFbdDBwCfLekXHtw5GbNM=
X-Google-Smtp-Source: ABdhPJz2E0tWwnZebHKi+ye0xGIO9/DUCHderKMzIwc/K5QHZHJZn2KR//uafblRXawjrpM+w8nKNA==
X-Received: by 2002:a17:906:3685:: with SMTP id a5mr25276590ejc.144.1631709902590;
        Wed, 15 Sep 2021 05:45:02 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:45:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 16/19] staging: r8188eu: hal: Clean up rtw_read*() and rtw_write*()
Date:   Wed, 15 Sep 2021 14:41:46 +0200
Message-Id: <20210915124149.27543-17-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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
index 4385260185b2..b48d8b5e95fd 100644
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

