Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251B409BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhIMSML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbhIMSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:12:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jg16so22965924ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+ffBmRs10V3xZhc5aJ3cOyIQMISqlnJH6NtMMm7ANY=;
        b=e8FyZbxWOrJyQXhLg6i16bI73rovpH3nMctSGGDlhMmJ7ysQ+7UX9i7/OnFSGfauTr
         jv+sGAhXKco+kyjlKpFjJzELtHu4Y5qd+YM6hNbTwebKrP9tMgaVnuK/86PDc/i6F60o
         /JVU45MtTqtgsSHaIDfRhiUkn6Y/EJf66mx6MYdYOVsN23pOOIlae5d/+nSqHr5sv8tB
         nVL0f9r0vkg6+mFu53vqqbBe6JuFcgl3hQX2bXUzEeoHB7YB0XzMUjQWDhhSWa21N+XS
         SPO3vAyvEs7YmyJQGz2WEeeVx6itqFZ4byhAHmtKcx1q442BEux8Xk2Cd0blsTudYASS
         +uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+ffBmRs10V3xZhc5aJ3cOyIQMISqlnJH6NtMMm7ANY=;
        b=XddFF3sn1rPruc//ZILfjhfoKjsAowOInKsmcYnsmzCOz7HSQ7ch+Nq+mY4LMZnbjC
         A5gUHdluXBWww0wtTNHp/HJNe6TNzQJ4z4AAozRyoZWXRGO8ooQpS4znKK9/nzC+AzO3
         t/upkB8HsEKiMfgrI+q8JuVF2c+luQczJy4XHynxHdncfOvzjNiepFB6vngQdQcULZx5
         3Zbccmr+4aI6874GxhTxywL7zWhfC5jk0wNUJL1ULcj264EfUXZVgLqkQg4pcZoPHOB+
         1PilqYD69Lx+uJiYsJFiIstaIEtSWeDBGiqDwC1N/v44I3F5//2EGaB6ps2YbkPT447v
         ruBw==
X-Gm-Message-State: AOAM531upqEyGxHP6uhRa+9XxtbStOx6p1kaSn57DI8SEVtHW3nLPLIL
        OQeyjpHLWQKT2wE7S7TShJc=
X-Google-Smtp-Source: ABdhPJyW0awvA3qK275I2eU3JdfKd1u6BL0AIMimAbmhgHQOjyyqHFPF11EKZPkNhKL0SUKDCrNJiw==
X-Received: by 2002:a17:907:2717:: with SMTP id w23mr14207566ejk.283.1631556652409;
        Mon, 13 Sep 2021 11:10:52 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:10:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 05/18] staging: r8188eu: remove the helpers of usb_write8
Date:   Mon, 13 Sep 2021 20:09:49 +0200
Message-Id: <20210913181002.16651-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write8() and usb_write8() and embed their
code into the caller (i.e., rtw_write8()).

_rtw_write8() is a mere redefinition of rtw_write8() and it is unneeded.
usb_write8() was the only functions assigned to the (*_usb_write8) pointer,
so we can simply remove it and make a direct call.

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
index cb24500cbc6e..69ab6e24a4b7 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,21 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-	int ret;
-
-	_write8 = pintfhdl->io_ops._write8;
-
-	ret = _write8(pintfhdl, addr, val);
-
-
-	return RTW_STATUS_CODE(ret);
-}
-
 int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 39fd9994787d..69e64863a5d1 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -133,11 +133,16 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	return le32_to_cpu(data);
 }
 
-static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
+int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
+	int ret;
+
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
 
-	return usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
+	return RTW_STATUS_CODE(ret);
 }
 
 static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
@@ -545,7 +550,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
 	pops->_read_port = &usb_read_port;
-	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
 	pops->_write32 = &usb_write32;
 	pops->_writeN = &usb_writeN;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index c53d9c8bd9a7..3b229027f094 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -252,7 +252,7 @@ void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
 
-int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
+int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
@@ -271,8 +271,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
-#define  rtw_write8(adapter, addr, val)					\
-	_rtw_write8((adapter), (addr), (val))
 #define  rtw_write16(adapter, addr, val)				\
 	_rtw_write16((adapter), (addr), (val))
 #define  rtw_write32(adapter, addr, val)				\
-- 
2.33.0

