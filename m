Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14740F310
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhIQHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbhIQHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616AC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v5so26116659edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5tmD/IVMf4aMEAC96PyvYI1EMja5j9e4mVGo0AQTFY=;
        b=KdQfihRLaHE1Ttmh96cRAX4/0TgwKHbvIypM0kBo5a6a7JOKj3jlBd4Gw4DS9qzpha
         H6LOJHtnYNXk3m3lps6MbhZDFXawOE+Vb1Ubmb4BnBR1yXPcmBQZZXQP98gl6WkAPytH
         ogMxCL47zTLhROxe6yEJIyX3iK0SqdFMIcPdot9E+ZdQ1U/0kZXNTLg0BxqwvhDy634F
         FTtrD2s0GIFjzI3VoGbjUpNF4ewt9OfdGaCgvjyNQ9GH9MGkAoyHWcvGJR6vkZiuzSiQ
         YwZFljmbR3v5mtRmUSoBdq+hy1pegfcUECcRMVieJbOKbZQHlcx1Qr1mx9VEIGz+i3vo
         JYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5tmD/IVMf4aMEAC96PyvYI1EMja5j9e4mVGo0AQTFY=;
        b=j8O/5jWTxOPbX6pWMAijhFjJul24yYXCFO0Hy1r6MzO/pbOC2bg9FRaRpPAxoMTyAv
         N8dFCy5CdCsAWf6w5o0TlfuwwPVGGPi6aDW8b8Q1PvWzY/o2Jjb5XCQuPeW0ipG6SUn/
         kRMK38/8XjZJtkMKTNE7M5yrmABVVExBXvwKzTM7zGDmuEB91HK9ZYOnz3+Bt4z0nCw9
         Koz5j5YB3wP8q33Oh9won3Am7pYdEaNsDb2Kqf5JNPSxJoafpsSacKXnhuHaLrazb8N8
         aRCxEQ/YixvaWH6TTUGyvFaBZTREysNdAcyG0kqsqF/qJoxhOgutSZtJxZpS/oFTo/UY
         +F8A==
X-Gm-Message-State: AOAM530qPVwi/C82WUvq7cMUSJaARPdz2Erafv6foSBGthqG3PV0iCH2
        oKXrndqpdQeX4GRdbQZc+J4=
X-Google-Smtp-Source: ABdhPJxWSv/Pin0o96QRwG8D8tN3dmWJRcZ88LQGOjCO9IHyTCq+JfMb2sgWozu8YxDZZefKFgOOEw==
X-Received: by 2002:a17:906:19d8:: with SMTP id h24mr10780111ejd.490.1631863149748;
        Fri, 17 Sep 2021 00:19:09 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 07/19] staging: r8188eu: remove the helpers of usb_write32()
Date:   Fri, 17 Sep 2021 09:18:25 +0200
Message-Id: <20210917071837.10926-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
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

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
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

