Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640CC40CE93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhIOVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhIOVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B664C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v5so8456079edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o94ioH8+hQjK2lmFE9u/0gAl9iYxyQXZSnIFhRkzckg=;
        b=UiK7seazfk7FYXxSE76CZ46rQW6LtQ0BNPUzbSyGQtV1JwPtkVjAtiI3/MjG9UZxNM
         GNzYn3tU6ThVKdnPHwgjMRKV/NAvKr/OmV4O3iu/azpMtLeTRI9YDRuknZysSNkoq5af
         Sb10/sjVqG3dDP97ypDVAi9TUoKY7LWVOs1XYMszqutHtKaoru0B+gf7G/4lbL+16djA
         n9eDkc6hCOoeSnN5d4ZFwkFvnT3OD0boOmIN+lTUkCPWLAL/SLmap8MjL61SZpMrowWl
         dnVhb7yAChcGlKhdjJ2CO1ebCJ+OhFOCLY+8YFVEEsXrSuJe0Qm/340txRdQTIYobdFL
         1hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o94ioH8+hQjK2lmFE9u/0gAl9iYxyQXZSnIFhRkzckg=;
        b=qm49j5/l6U49TGXocF8x11X97f8O5NL3/7OPNq2ghDRzINIVgAFDgsu07iMxgVB1t7
         FLzMInUBlsXHF3AJauC5/95V/xwdkO0diMVIrwMWRx0lNCTjbGunHqxnNb6L3IXBx1vS
         U0AQkjSSjjuAx2qzhXvLLLw3TjQLXsuzTcyEHOkUaY2w/uSmOEz/PIz0RwjuwgsgtXc9
         LjVoKT8C+WnYS+0d2Hu49RoO+IHyqUoNEq9iB1kiA0Pe3WFQprdMMfqfG43fkIOUvBdV
         ASIIURKVTj7jVprsuqZdupe+3duYkIaEw49AE/DJ6/JgYF/lU4eyRKsEycznLLmVnnsT
         ND/w==
X-Gm-Message-State: AOAM531hmgNsEcscXmFtjUF0AL5sxDcHOSwDOt9OTAYvgGoN6YkB7ROv
        YcYSpdlu8sdZxSnW/AS8mBpNI4rIy+4=
X-Google-Smtp-Source: ABdhPJyoYQgKm22ObMh24dSc4C3P7sClA7HEmXKNKH/MZ1UHal/983aG9miu+RZcTBYyd5FrvSiWHg==
X-Received: by 2002:a17:906:4751:: with SMTP id j17mr2275712ejs.145.1631740285066;
        Wed, 15 Sep 2021 14:11:25 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 06/19] staging: r8188eu: remove the helpers of usb_write16()
Date:   Wed, 15 Sep 2021 23:10:50 +0200
Message-Id: <20210915211103.18001-7-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write16() and usb_write16() and embed their
code into the caller (i.e., rtw_write16()).

_rtw_write16() is a mere redefinition of rtw_write16() and it is unneeded.
usb_write16() was the only functions assigned to the (*_usb_write16)
pointer, so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 10 +++++++---
 drivers/staging/r8188eu/include/rtw_io.h    |  4 +---
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 69ab6e24a4b7..7547e25d870b 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
-	int ret;
-
-	_write16 = pintfhdl->io_ops._write16;
-
-	ret = _write16(pintfhdl, addr, val);
-
-
-	return RTW_STATUS_CODE(ret);
-}
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 69e64863a5d1..128cdb178abc 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -145,12 +145,17 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
+int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val & 0x0000ffff);
+	int ret;
 
-	return usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+
+	return RTW_STATUS_CODE(ret);
 }
 
 static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
@@ -550,7 +555,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
 	pops->_read_port = &usb_read_port;
-	pops->_write16 = &usb_write16;
 	pops->_write32 = &usb_write32;
 	pops->_writeN = &usb_writeN;
 	pops->_write_port = &usb_write_port;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 3b229027f094..0cb1f626a549 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -253,7 +253,7 @@ void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
-int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
+int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
 
@@ -271,8 +271,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
-#define  rtw_write16(adapter, addr, val)				\
-	_rtw_write16((adapter), (addr), (val))
 #define  rtw_write32(adapter, addr, val)				\
 	_rtw_write32((adapter), (addr), (val))
 #define  rtw_writeN(adapter, addr, length, data)			\
-- 
2.33.0

