Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C540CE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhIOVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhIOVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E73C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so8493410edn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHYtBovlDjhlHTuwO5h2vC2ttjXjn2hzJRjLpSYKx8Y=;
        b=AJFiXNAkkNhpW7eZ9JcDy8XDpPoEzVoMtH55xVws5bCs2i2QYG/61hp3i0HEWLMuTR
         QCA65IbDvED/6QpBRGthGxh80J2HDUmlS1YFKuBr0tc/MvsYDo2L2fyWk6jlOeHVR+DU
         neIDM6n6T6wlRVhg8VqV8Hl51pNibS0wyPIZjq1Wtyxd887l+QszjhX0zNATLRdZesPv
         jW4vWQ6KnxMhkUQJrrUcaZVHMRWe0FnG3ChkOANq0c02c3a28KcFspXxheM5oDzpYU5N
         I6n5WBK1eYYM1Aptp9DLBQfNW12gwGyNQx4EPPBV9y6ECCetj4w8biGxQwqFjpaNLijr
         BhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHYtBovlDjhlHTuwO5h2vC2ttjXjn2hzJRjLpSYKx8Y=;
        b=KC9kx9bNy5tSqEdFwv5zWJrobBaIyrF6iZITNzmFDBmkrETQh01HvgA+IjzavYuFd5
         8F6fAnEiYSr7m4PaKOXhFVpRF98JvEr/crDTUwMb7A74rF8sU8gImStlM6bJ+FATNDxc
         9h/1RGtOY7gJnCaHoYNpFfl+fgL//tDdR5ZlITBrH4W55HJNzw7X3Ko+Ajg8PiLq8bZ0
         uyGrkbU7TUSfNdfSkoDds36WrB2yfQ4Xbl2920QQwqMKpR+6karjt8ipydUWV0dp3hM7
         ekZt/18Xv3e5WX6Ec+O3awZJpMjXP1aSK5wwAuamTQJj34oJZUXcNXceiMqcIJIl6i8t
         8q8w==
X-Gm-Message-State: AOAM530YFaImG3/XUzRjF/dtsmnYMSMC30SHt+pe6pYxYtzoPD0cjKtE
        9XLySe4PTQEVpdgbuwLgFvk=
X-Google-Smtp-Source: ABdhPJx6q7NNKvUBN36waxSkanJ5WL1rAsJL4dowWe+emqvE+BD4j4V4w8KJfOVfo8+iMFMC1UtP9A==
X-Received: by 2002:a50:8d08:: with SMTP id s8mr2218418eds.211.1631740278347;
        Wed, 15 Sep 2021 14:11:18 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 01/19] staging: r8188eu: remove usb_{read,write}_mem()
Date:   Wed, 15 Sep 2021 23:10:45 +0200
Message-Id: <20210915211103.18001-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove usb_{read,write}_mem() because they are unused.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c         | 29 -------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  2 --
 drivers/staging/r8188eu/include/rtw_io.h      |  4 ---
 .../staging/r8188eu/include/usb_ops_linux.h   |  3 --
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  8 -----
 5 files changed, 46 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index cde0205816b1..e6f377377ab2 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -175,35 +175,6 @@ int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
-{
-	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-
-
-	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-	     return;
-	_read_mem = pintfhdl->io_ops._read_mem;
-	_read_mem(pintfhdl, addr, cnt, pmem);
-
-}
-
-void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
-{
-	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-
-
-
-	_write_mem = pintfhdl->io_ops._write_mem;
-
-	_write_mem(pintfhdl, addr, cnt, pmem);
-
-
-}
-
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
 {
 	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 065b0d8e030a..7f30b00b3ce6 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -541,13 +541,11 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 	pops->_read8 = &usb_read8;
 	pops->_read16 = &usb_read16;
 	pops->_read32 = &usb_read32;
-	pops->_read_mem = &usb_read_mem;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
 	pops->_write32 = &usb_write32;
 	pops->_writeN = &usb_writeN;
-	pops->_write_mem = &usb_write_mem;
 	pops->_write_port = &usb_write_port;
 	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 263a37d49b6e..5ef89c72cc83 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -270,8 +270,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 #define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
 #define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
-#define rtw_read_mem(adapter, addr, cnt, mem)				\
-	_rtw_read_mem((adapter), (addr), (cnt), (mem))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
@@ -290,8 +288,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_write16_async((adapter), (addr), (val))
 #define rtw_write32_async(adapter, addr, val)				\
 	_rtw_write32_async((adapter), (addr), (val))
-#define rtw_write_mem(adapter, addr, cnt, mem)				\
-	_rtw_write_mem((adapter), (addr), (cnt), (mem))
 #define rtw_write_port(adapter, addr, cnt, mem)				\
 	_rtw_write_port((adapter), (addr), (cnt), (mem))
 #define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index c357a3b1560e..37e0614fd15c 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -28,9 +28,6 @@
 
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
-void usb_read_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem);
-void usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
-
 void usb_read_port_cancel(struct intf_hdl *pintfhdl);
 
 u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 928730158450..9afb4df71969 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -31,14 +31,6 @@ struct zero_bulkout_context {
 	void *padapter;
 };
 
-void usb_read_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
-{
-}
-
-void usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
-{
-}
-
 void usb_read_port_cancel(struct intf_hdl *pintfhdl)
 {
 	int i;
-- 
2.33.0

