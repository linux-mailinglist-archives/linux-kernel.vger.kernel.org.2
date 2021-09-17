Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05640F30D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhIQHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhIQHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC31C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg28so3425278edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN95sxh1zvGkTMygvWBnMqoQziu3ijBziuNJtNGKfsI=;
        b=gW55OA5gq2vr3NgfUp7+4fc4fVDNPZE8FdnwCLKEK+yEMQpMyljr270Ah+CLpcmrGt
         wrXIIHy11clELUoUKjcmBOrM/jOPjjssKGVk4ZI0zPoQ+/lozqpbxJbehSCwUKyf9Oe/
         i2SPRvXCQX3wPePW1qdibg2t+/Te42wMuNFfZf3cFMUMepZxuWCk0NSmOkGQ95mfa04F
         cXGs21Nb/ev7pQ+p4pzYSnXnss2dYODJpnCgi7SNKVfGEc0JyzZQj0LLB92rw0p7vSvD
         ib/po2Hsn6bycea3+z9TOC/zvJiasy74mbqH2Ld8HmR4fdlDyExAGKBjlfmv0M9MXRcW
         LmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN95sxh1zvGkTMygvWBnMqoQziu3ijBziuNJtNGKfsI=;
        b=59Ag09mH5AHNcE2MXVK9AwiVCPcXO7C17gs+cc4fdlDv+Ys209WcH4f1A2hR6tpoSr
         Y0w4F9bl7JF2xxjfa7vFubAVGZw34geAMSIlFslIYfgFt7M+WMLd7Kb1TZVa1izkqkUI
         gvQL+tjqWNGM8q66slbbh0iWZsME+iGWq6MEeJBhFSILsOdO629oozIsg8qKv9mcMrRw
         Lu7qGR6QC2lF6OCfuKThy6QocxJr31tWKQKDTPpRmRjrHybP2f+aqh63KjgpjL7Acq0r
         nYj0xPoaouEI5muJ435ffYRhiQqfAU8tkSEM2l3sec5/AL9LFslfV4SzmdgvArwWOd0p
         bkEQ==
X-Gm-Message-State: AOAM53060mfIclZff6Lmem000Pcd3DujT9YTmSLOiHVn2VbaA8msNNN+
        JPWisn2mK+WmRR+KrjssGE8=
X-Google-Smtp-Source: ABdhPJzZbYeD/4YP3v3rT1I2VwD7bgX27ls2N+yO+QRS6md/hgKgwwEXmrxVLMtopbtEda3he2Jorw==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr11094679edt.282.1631863145749;
        Fri, 17 Sep 2021 00:19:05 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 04/19] staging: r8188eu: remove the helpers of rtw_read32()
Date:   Fri, 17 Sep 2021 09:18:22 +0200
Message-Id: <20210917071837.10926-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_readr32() and usb_read32() and embed their
code into the caller (i.e., rtw_read32()).

_rtw_read32() is a mere redefinition of rtw_read32() and it is unneeded.
usb_read32() was the only functions assigned to the (*_usb_read32) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  5 +++--
 drivers/staging/r8188eu/include/rtw_io.h    |  3 +--
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index b5d1c8e52b22..cb24500cbc6e 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u32 _rtw_read32(struct adapter *adapter, u32 addr)
-{
-	u32 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
-
-	_read32 = pintfhdl->io_ops._read32;
-
-	r_val = _read32(pintfhdl, addr);
-
-	return r_val;
-}
-
 int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8b4fc014d93a..39fd9994787d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -121,8 +121,10 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
@@ -542,7 +544,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 527503d3ecc8..c53d9c8bd9a7 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -247,7 +247,7 @@ void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 rtw_read16(struct adapter *adapter, u32 addr);
-u32 _rtw_read32(struct adapter *adapter, u32 addr);
+u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
-- 
2.33.0

