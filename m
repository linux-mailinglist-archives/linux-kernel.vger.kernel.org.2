Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5E40F311
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhIQHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbhIQHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90799C0613DE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h17so26473118edj.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93LBAfNwlIIBHTnOSTCnrKU16NrNRJ4oRZoZZhjX9iM=;
        b=d4XMhDm27F/9AIeuh9WmR4PjcvdXwCZu1BV1CmaHfzThCfRBGlrHYTo93/ybtdP8aK
         GcFOFl2HiloHTllvrgDelQWc6gh7n3N/kndesf6H9UoORiTboiOrfVuCoxRNFIE/QOyN
         lLdW/nUKLezReurGufYJNlFV9j6Wm+rWbg180aCBHI4b1n41r1bdxQOYMt9eSUFczKGL
         MQ7VQwWYD/Ku9YXGte5WVrrpfVvq+L3uFAbFE9jgpQKI4z9CG4zxRrQ0SOZr6GiKZjTT
         Ao9rNA9AkBbGJ/EtAouYS45EpyUvMDKrbnPuBTAgtk2Cphl6lwtQgVXlPRx2P19wy2F9
         hNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93LBAfNwlIIBHTnOSTCnrKU16NrNRJ4oRZoZZhjX9iM=;
        b=OVQF4MEqihKHWgwDGgWgLgxlwmkorfo9VbrpJM7IFMzEt4McsOS1wOEuc44IqHfcHp
         rn9Bde3RX9kdzWUvzwp1iSk1qa+gjWMR0jquMpizafJt9WaUaH2nfgTvN5JyghYT1nkL
         YR6SH0UaxJlIaKCtbKk/hPm6sskAcEGfuXgUaiucq7JNtMQBRVLexqPtp15rMJDhEQvV
         ieSgOi6m28cmikeqD1u7cPLuxEMZd3Mnh3MLoJLM3j2o3Dm14Gdm6L/L2n7SXH/B1bDX
         jJZC2Dtw3k71PHWfgi7+HLXXb8SV0NVVNsP/5yroy4xR1+PSB8e9mLG7ktKqyPVr9m4e
         9X0Q==
X-Gm-Message-State: AOAM530tdBzuhs8n2WD6nwFhIzfAJyhQzEx32kblfn9n2cQs9YFMc5Ho
        mdoAUm954b7Rr1//QNnIdEI=
X-Google-Smtp-Source: ABdhPJyRNQw0lXMfVkpRw9uyRryaMugYcF+FVhI7DSzuzQQYsopeCBm0CskfN97FqWKLXRnQaizdPg==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr10338406ejb.364.1631863151123;
        Fri, 17 Sep 2021 00:19:11 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 08/19] staging: r8188eu: remove the helpers of usb_writeN()
Date:   Fri, 17 Sep 2021 09:18:26 +0200
Message-Id: <20210917071837.10926-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_writeN() and usb_writeN() and embed their
code into the caller (i.e., rtw_writeN()).

_rtw_writeN() is a mere redefinition of rtw_writeN() and it is unneeded.
usb_writeN() was the only functions assigned to the (*_usb_writeN) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 11 +++++++----
 drivers/staging/r8188eu/include/rtw_io.h    |  4 +---
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 98c9823fe53b..b2e41fa48d81 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl *pintfhdl = (struct intf_hdl *)(&pio_priv->intf);
-	int (*_writeN)(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata);
-	int ret;
-
-	_writeN = pintfhdl->io_ops._writeN;
-
-	ret = _writeN(pintfhdl, addr, length, pdata);
-
-
-	return RTW_STATUS_CODE(ret);
-}
 int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 73f90b21364e..90fb46c75159 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -171,17 +171,21 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
+int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
+	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
-		return -EINVAL;
+		return _FAIL;
 
 	memcpy(buf, pdata, length);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
 
-	return usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	return RTW_STATUS_CODE(ret);
 }
 
 static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
@@ -560,7 +564,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
 	pops->_read_port = &usb_read_port;
-	pops->_writeN = &usb_writeN;
 	pops->_write_port = &usb_write_port;
 	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 83e2ed13b667..1123017cac65 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -255,7 +255,7 @@ void _rtw_read_port_cancel(struct adapter *adapter);
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
-int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
+int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
 
 int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val);
 int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
@@ -271,8 +271,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
-#define  rtw_writeN(adapter, addr, length, data)			\
-	_rtw_writeN((adapter), (addr), (length), (data))
 #define rtw_write8_async(adapter, addr, val)				\
 	_rtw_write8_async((adapter), (addr), (val))
 #define rtw_write16_async(adapter, addr, val)				\
-- 
2.33.0

