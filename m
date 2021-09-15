Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F6140CE96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhIOVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhIOVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so8514057edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUgkCP2UYAlfqAdkW8P+gLOI3BQI1WbOOt2/jNLuTzo=;
        b=XLntiq110eGkjm2MCq19ex/zqRAVC0xp4gl/w2yuU+4DoxoKH+6ISBkP7Si0zw6cuE
         YnwlvDYvZJw+xsVFt2QFYCdlxQuZuLiZm2kK5fLTMdx6u4Swnrm46+Dy132hllU4Wk+0
         WieRNUrIEaUwDEfxtSgWAEkWqyJBqAjkTd1NSap3ZW+Kp9EyK6tV6eOlW26krh7/6se7
         WNaVlDDgHlq/QiuYuNYbIJEqjhWngsHtKxLrvzTT6iMoDodQU/IczE+FYYqPXYABLZEC
         CR/PXYmktBllQpU7xCoi5JI40JFiXGm5aYYtAmGNT4l7UMmDqjDY70tJWweFjhV/jigu
         FecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUgkCP2UYAlfqAdkW8P+gLOI3BQI1WbOOt2/jNLuTzo=;
        b=KoEOmLh5W3MR5RxHfOo/qFVwuAAH5q39Kwudz0r4opOw8eGXWOg/6kuod+E5fuKTdk
         9rqvbaGdv5gi2aD5vG+j+arWoUsS8Rk+5O6j9F1A+1snLHD0uxyDcnS6HbgJ7gbIvUFi
         p+B5n+RgLQMTJx11IWPq4WoXyuDCvzABeJ9BYZ+VNVuY2BK96C2Nc14+qsqkuRz7w52s
         iO4pqcVwf6oIyAIc79yE5l+LAyyvYkm8hw25RGC2U2Xc0y2wcU57tpxYE2UjAgqSLMLt
         h+YGYuJxc0USUn3znWqHz5daiCKnNudphLvy27FN42z9pGqVkm10Pf2loWLvd0OAlMmU
         l9CQ==
X-Gm-Message-State: AOAM532Wgdv/wL4X84O4hFCgQYnxiEhDwEXfUDU1yO3yMZtEhXkBbLLP
        CDUKRFnnymectLTIn3wjnzTLdrxR7uQ=
X-Google-Smtp-Source: ABdhPJzP0e2Ny/tGWfNT82Fuvx+LjlAGgkAbhrEGfNLAH/t5zWBpoqxVawMVy1CELbElkLIwkh3/bA==
X-Received: by 2002:a17:906:6547:: with SMTP id u7mr2178565ejn.544.1631740287796;
        Wed, 15 Sep 2021 14:11:27 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 08/19] staging: r8188eu: remove the helpers of usb_writeN()
Date:   Wed, 15 Sep 2021 23:10:52 +0200
Message-Id: <20210915211103.18001-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
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

