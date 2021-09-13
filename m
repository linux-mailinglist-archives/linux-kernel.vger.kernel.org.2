Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C969D409BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346824AbhIMSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbhIMSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:12:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A36C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jg16so22968348ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpF4k6058jVmO58U8HM7bmsbmxv1pOyTBy7BlwDeUoA=;
        b=mEWXN5ySv5ryty6rNaPAKwDVSXA1L2Bsm1O6L8zCyXJBJNSpUvHqSvQdLIbjZ5U/H1
         A+q49NWY5Oa1RqoJucA4O3PqJBgN6NF/QR9E+g6MUvD5rhMzoolWy4mF/eVTbRSqrfuH
         rN8RHgEEJpvMrdjcUqi04VFePgqrmqfl3f30OiE6MLG59RAch6CcjDNNGukBl/RzLkgf
         iKAlLmOhF7KRy5Sq7SCIXY71IEstPSxtgAogwaiZjc466CyaHlWVBaPklzr3bK8TMvPQ
         3LGRUan5eCnBq1l6AxasOYC2noJcK1KZGEDV2YnlIg/3kF2I45CTdIZeBxgIY++wTS7T
         5bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpF4k6058jVmO58U8HM7bmsbmxv1pOyTBy7BlwDeUoA=;
        b=F1OqL919W9Ji4qrIBHE+ghqfsGjFEwhg3gaSnxXqPCb7VvTWSQ2d8M8Mhaiy3Z7nV7
         zRbwZGyHbcgbDKkfSoycoV3vYJcsdB3k/RlboSATEU6uVuOXJwZLTAa6SsjiTB8nOAeL
         77787E/ubYyjcasxGbJVOzGvlu7V7vJce2Al/ww40bqBS9m1mwnloZqJtFBwuLMHuzzz
         yTRLrjLaL9kZsingeJeMl3Qi3liMNxH3MVp5PSj10g/7+9bZ6FjTBjpoDK/SF9eSDPZP
         pTtkzQ5MBogc5bjtf8h8ieYlu+s63qbr0XCaXLHdkZHLC/JSrmp+DLPxD6LTLw5BpRBU
         h/og==
X-Gm-Message-State: AOAM533DxiWos8bFW46wSb8cplsevI/TuM7ZwUMEFEN38ODhSWr8UKIM
        l/VlvGkMq3fY/KjAQrZ1awc=
X-Google-Smtp-Source: ABdhPJw4pZhLK/U0xebxwNyhYRwCF1eU3pdKLF1HJSSxZLAUNsvd3U0rbNZMOTKd/tmbD+vR0LmtMg==
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr13753440ejc.511.1631556678797;
        Mon, 13 Sep 2021 11:11:18 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:11:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 07/18] staging: r8188eu: remove the helpers of usb_write32()
Date:   Mon, 13 Sep 2021 20:09:51 +0200
Message-Id: <20210913181002.16651-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

v3->v4:
        Split a patch into fourteen.
v2->v3:
        No changes.
v1->v2:
        No changes.

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

