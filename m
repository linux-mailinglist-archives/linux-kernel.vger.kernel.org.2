Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17FF40CEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhIOVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhIOVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA6C061766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h17so8537689edj.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uB8dyLhqOeVWNi6AmFE9xlJsVVknNBhXJA42Ly2Ec5k=;
        b=csZ5hxnAxoc1SEgM+JsEtUU8RyX8I/mMrD7WXTcZnNlO9D0FD0DxuHoNra2vd2tpvm
         MIeZYK3veLwpTeXxAZGUd3Dp54duiUXr2hiBqS6DDPiCY9RPkCUdKlFJ/ie8g2458cP8
         mxmW/cUGawOJaGZga/X+1RanaGs3u3ovCMDGvTzvU2coQlZaR03A987hDqU1Ewtr/XBz
         jjkPNKBgdDJ87Mc8v3fhiotS2h6UVcbrx0ZRESN21hkuIkFjR1vBtBJWpmisRXtoebQw
         S1C109VZKNgDTTdP9MeCniEHM3bi1Mf4Nn3fMLKcc842vIFg3u+sWHb44AzlUqGqDUZn
         mbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uB8dyLhqOeVWNi6AmFE9xlJsVVknNBhXJA42Ly2Ec5k=;
        b=Saqjl8oZG5j98RSzs+KdymPmtfaTdrDY+PJmdUn3tMBgdYsQ/UsyJ2kXeHj+5Zu+BY
         /6qUGeaKTCQZX9tEiPiMezTlVfD+oplxShNE4jf2pPrUBEPGuZvHC6wlfMyZ16jfg2TX
         +fcFpRWqoTJiMWVvj39a/ukMmY12uPyLChkSBMBjZiziLL6mO1DD9GWxheG8nRQerwTz
         akYuYrbI9/0n8fL2uP/PSORUwOBmhs9unjeu6pIeNXS7t5hSR/E1Vhbl6Nlbkm1x/H92
         yJwZ+HR69OjhPE25cnfisfO8jgWBEEM0Kqk/M+DtNK+4VAhGQAnKf8UU3f0dpxsrZBSn
         pk1A==
X-Gm-Message-State: AOAM533+mMWVsLNbD9UerBfAa/spv1iSzrF86uPkCwXsdWgToFzoS4v3
        wJTfQcIng2nsR4BhoBQbt1M=
X-Google-Smtp-Source: ABdhPJxB2liwg9tZ/Lwl2avW/walclssHETdjNfR1CdwBuFE1bU2AmmI6lJgICj4BXErgoVEFO/Q6w==
X-Received: by 2002:a05:6402:1424:: with SMTP id c4mr2304885edx.196.1631740286382;
        Wed, 15 Sep 2021 14:11:26 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 07/19] staging: r8188eu: remove the helpers of usb_write32()
Date:   Wed, 15 Sep 2021 23:10:51 +0200
Message-Id: <20210915211103.18001-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write32() and usb_write32() and embed their
code into the caller (i.e., rtw_write32()).

_rtw_write32() is a mere redefinition of rtw_write32() and it is unneeded.
usb_write32() was the only functions assigned to the (*_usb_write32)
pointer, so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 15 ---------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 10 +++++++---
 drivers/staging/r8188eu/include/rtw_io.h    |  4 +---
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 7547e25d870b..98c9823fe53b 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,21 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-	int ret;
-
-	_write32 = pintfhdl->io_ops._write32;
-
-	ret = _write32(pintfhdl, addr, val);
-
-
-	return RTW_STATUS_CODE(ret);
-}
-
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 128cdb178abc..73f90b21364e 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -158,12 +158,17 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
+int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val);
+	int ret;
 
-	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
+
+	return RTW_STATUS_CODE(ret);
 }
 
 static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
@@ -555,7 +560,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
 	pops->_read_port = &usb_read_port;
-	pops->_write32 = &usb_write32;
 	pops->_writeN = &usb_writeN;
 	pops->_write_port = &usb_write_port;
 	pops->_read_port_cancel = &usb_read_port_cancel;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 0cb1f626a549..83e2ed13b667 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -254,7 +254,7 @@ void _rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
-int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
+int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
 
 int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val);
@@ -271,8 +271,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
-#define  rtw_write32(adapter, addr, val)				\
-	_rtw_write32((adapter), (addr), (val))
 #define  rtw_writeN(adapter, addr, length, data)			\
 	_rtw_writeN((adapter), (addr), (length), (data))
 #define rtw_write8_async(adapter, addr, val)				\
-- 
2.33.0

