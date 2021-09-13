Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438CA409BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbhIMSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346658AbhIMSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:11:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so15679685edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRkSEdmKhZkmtWj1sVEEnWpQxrvDTUfUkNwSp9Cxv3M=;
        b=eJPOmCK+oPg4EtUiwPG4PZD9Erj88lpwPgcY3M4RwJjUgc1+3PlZDG9uqg1v7gHoWc
         km/fNdpoE73dRNNZjEjBySoH+2DW75SDdMAvW/ZusdaiHkJZJZ5v/LCicvE74XPXUXXB
         Rn4VrRygkl+QqjcXViclOwGK5AxP8CYEJ1hF6djMFpI4wbJznRVof4OLdSE6ggSEbH5I
         4e7HzHQhHenPPOEeSb4hL6733rL2Kvf8y3+9pR4YfQdp8h5AQndhpOLVj9BcwEo3ympb
         DOtWkFfKgnP31wTAuSPHkEFOTWW9M40LEZ3jzGN24uwAlgwxw90SseLf5Xk282Q6v7bz
         J7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRkSEdmKhZkmtWj1sVEEnWpQxrvDTUfUkNwSp9Cxv3M=;
        b=J6wk3TWLp1CbpRuSZ5ARbSU14O45F72mpMrbdWYAwug6lbvaXfxU3qs2TgdoCY0eiU
         ii4kMNcG//fj4VUDgGQtmNIJSTbbFqLaD9TsJnR6e+I8dkrQSmaBPwpfWljUxawZYSqu
         WGugmTs9QzDQ+BRj5u202jAcPWT1YUPfsg6Qy/E1LYEOyZW4yjeodx/AboFB3Ifn6f3P
         ugVIgDwtnLYpFSl/zmsmepHv23fnC1O6ug/jw+xVLBfxl1zE9UCFA/c10l2qn4Vq14Av
         x3+ZR2nJj/gTG4/ZeX3e1BeRwyX5Zu/M1Smo8aHzJhlbeVm4Nyd10toQARhc6Qd8Qvuv
         XgvQ==
X-Gm-Message-State: AOAM5325hCRJoXXOcuWsku+SynMiTEhK5NSEJ7OW/nlhQgk7HmXmaR7T
        6WZj7NgnXLaKe0MerTrrHf11Cjy8FvI=
X-Google-Smtp-Source: ABdhPJynrHEn/VSRpqV6dfZAt26xhoCvQltuVsvSc7pa+ilu3Uw8VN0JiwKJgWcWwOsDDP9sOhqNzA==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr10882377edc.14.1631556629450;
        Mon, 13 Sep 2021 11:10:29 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:10:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 02/18] staging: r8188eu: remove the helpers of rtw_read8()
Date:   Mon, 13 Sep 2021 20:09:46 +0200
Message-Id: <20210913181002.16651-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read8() and usb_read8() and embed their
code into the caller (i.e., rtw_read8()).

_rtw_read8() is a mere redefinition of rtw_read8() and it is unneeded.
usb_read8() was the only functions assigned to (*_usb_read8) pointer,
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

 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  5 +++--
 drivers/staging/r8188eu/include/rtw_io.h    |  3 +--
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index e6f377377ab2..4c43b6d00178 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr)
-{
-	u8 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl *pintfhdl = &pio_priv->intf;
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
-
-
-	_read8 = pintfhdl->io_ops._read8;
-	r_val = _read8(pintfhdl, addr);
-
-	return r_val;
-}
-
 u16 _rtw_read16(struct adapter *adapter, u32 addr)
 {
 	u16 r_val;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 7f30b00b3ce6..8389deeb1182 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -97,8 +97,10 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	return status;
 }
 
-static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	u8 data;
 
@@ -538,7 +540,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read8 = &usb_read8;
 	pops->_read16 = &usb_read16;
 	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 5ef89c72cc83..9dc32f7bcae8 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -245,7 +245,7 @@ void unregister_intf_hdl(struct intf_hdl *pintfhdl);
 void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr);
+u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 _rtw_read16(struct adapter *adapter, u32 addr);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
 #define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
-- 
2.33.0

