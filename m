Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7740C57D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhIOMof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhIOMoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:44:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25557C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:43:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt8so5768638ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUgkCP2UYAlfqAdkW8P+gLOI3BQI1WbOOt2/jNLuTzo=;
        b=Umd7wHYvyUIcFPLxldQzopafTHvU/kbgXyk7EDqM9Atc32z9ww6P6tOiOg5Zo2gxRZ
         l6WYP2v0SvgQP3Emd4mby/fql8jg2qZ06zHeLtUlJgVTKhBdtfdg8WKVBj7+56ujPgkT
         gwhSGeKehGHcAwPqrAkEasHxZdLugoBLzca2tn4qraY9ze1MACRZ/sFWP7+EfIXQpLZE
         SCfePG2vAHSfsEponwTqrCm0AHfWNc+UN7Ya98z3tKFD0szsQwE44r4Ik/7xe7BK4j7I
         eod6thoG1CYkyKugf8SybJUm0w6C7zd03327robhfvNV0mC/UmEgc1eaWxRC2uAQzuyB
         4uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUgkCP2UYAlfqAdkW8P+gLOI3BQI1WbOOt2/jNLuTzo=;
        b=e+4p6cqyDjXCXj5lUeoSrz0AY4/Kb4mbRqGqLtOELy88vUY9sKpiflnbqgd+zKWVat
         S4W82ITQuW5S9u3vIl//SuDRCOF2k7XmIEyAsvMJdsV09fhODAYx0dT9WRGrTQCXRXJ+
         fzak33e6BS8/4XZu+MRdPYNW7itCiPrMqDISFrwBsGzFh7v3KFCeTWVr0RrtOqqerGZG
         OqvApBRMyUUpAOYqdDKOwAsvgWZE3sizxFB0lWWFBEJHNVEBWZGrf8F0/83LrTKX/Y1Z
         yepxIh5vcHgatSpiSnYT/aZaDSzEkH6s20h2eKvH2lCzOts+IafKmjQ9ihUMBOPF/3Ft
         /khw==
X-Gm-Message-State: AOAM530/xksu6NUAZ2D6MtuBdsDVXdGep9oiwg+FutMS4sX3T7hUf78v
        WnsF3jovbZrSVGfpuL8UxhE=
X-Google-Smtp-Source: ABdhPJwFKQ6Tmh2yxUi8uYVfcr1TzqJ6fYRj5p6cwpSWHQx0Ich6T+HBZCM3XVaqipZ/jvgczB4mBw==
X-Received: by 2002:a17:906:3745:: with SMTP id e5mr25082534ejc.400.1631709793642;
        Wed, 15 Sep 2021 05:43:13 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:43:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 08/19] staging: r8188eu: remove the helpers of usb_writeN()
Date:   Wed, 15 Sep 2021 14:41:38 +0200
Message-Id: <20210915124149.27543-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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

