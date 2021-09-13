Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774A1409BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbhIMSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346749AbhIMSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:11:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g21so15693810edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5wCXN8UMr0yeIliFqF4PlBTRBgABhGfIl5Cz/aUsug=;
        b=d1OcZ4AF4PYa4o+xzHZQQFqfZ10aqMcc0p6kjqxBkYuVWnM+rXSEECBnGpxOU+j+Ad
         VJbg8mIuAw78iDINmdvI+Y3PxzO778el2xsvDxaankxoTt65/1nD1gZnqp4ODYMMYUG8
         hjFjUaApv94RtS4CRacGWZ/hnk9maceFb9rtoEawKI6N9cm16RQtq20ij+h+7Zc1V676
         9hnsKc66k87vorTG+9SJTJY8pxGw0/NiIIp6maLpeH7ZVlThJ0rB6SX1K8k1djceK8+B
         XKzNzrhyggFlHTDPlpQwjcPM6ZiFprFTBQuENn/4l+qvmyy4cJLTymx8WojfesAbj5bm
         Nj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5wCXN8UMr0yeIliFqF4PlBTRBgABhGfIl5Cz/aUsug=;
        b=31HqI0wXz1BhsOxPBh2OyGs6ylKadmy6pxrnBIjyOjJnbaUWDyk9by1jZvmIryS4ey
         jExN0b1tQ+WzSZuGXnaeVONcrkk6Z4KV9KWDwnNLXUCcr2IVqkpehZKbDmDyDGsk9aNX
         bLctQ1nINQ45839uCG5JALadZ5z7XTDIinXbFHmwF8CS2Lqc/WTwlEW9ItGOxlTz4t8v
         JKJTjRD3itq534r5gfxyRJcrbTHoS2BX5ZmSY2Qe+TkpQRSTn1Rab6LdlihhicMMVS9D
         fNGpOwdaUlLd6S6k03ZOgrN1rDa7d88jPchbi5izSrIsKmp/5WZ1u6xmCUHVyqAHjoL6
         lMnQ==
X-Gm-Message-State: AOAM532Kl3DtTbh8NKYb6baiDiCZO4muex2TVvWGjaqW8YB10/s+MxKm
        vcZarFcKHU81UYAREHi5IQA=
X-Google-Smtp-Source: ABdhPJyEToAVRi2HwgHeQsKjG2kbyTw1/yYkzdHqgBbXx8PgpqCAhUCErULJ9/0nzYZchyhnJtwmGA==
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr14846912edv.386.1631556635758;
        Mon, 13 Sep 2021 11:10:35 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:10:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 03/18] staging: r8188eu: remove the helpers of rtw_read16()
Date:   Mon, 13 Sep 2021 20:09:47 +0200
Message-Id: <20210913181002.16651-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read16() and usb_read16() and embed their
code into the caller (i.e., rtw_read16()).

_rtw_read16() is a mere redefinition of rtw_read16() and it is unneeded.
usb_read16() was the only functions assigned to the (*_usb_read16) pointer,
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
index 4c43b6d00178..b5d1c8e52b22 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u16 _rtw_read16(struct adapter *adapter, u32 addr)
-{
-	u16 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
-
-	_read16 = pintfhdl->io_ops._read16;
-
-	r_val = _read16(pintfhdl, addr);
-
-	return r_val;
-}
-
 u32 _rtw_read32(struct adapter *adapter, u32 addr)
 {
 	u32 r_val;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8389deeb1182..8b4fc014d93a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -109,8 +109,10 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	return data;
 }
 
-static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
@@ -540,7 +542,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read16 = &usb_read16;
 	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 9dc32f7bcae8..527503d3ecc8 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -246,7 +246,7 @@ void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 u8 rtw_read8(struct adapter *adapter, u32 addr);
-u16 _rtw_read16(struct adapter *adapter, u32 addr);
+u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
-- 
2.33.0

