Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65BF40F308
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhIQHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhIQHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27529C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g8so26451460edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=You8MaiZD0k4r3ZqykdZJnjuRHcnRHz1gw23EWcK3Qk=;
        b=pM0EXSnPG9KFODdxT9mZIr8mm9tWt8wbWdA75REJ5NKOhh1G6iGfomL2ijz0COKkmc
         fepq++zxy/QBEk03BeTpVDAHI//0eH185HL3CiHCuJIBP1ND2GZlSKdZfmljJswsgMsI
         y5Lyc3SPglBay+ADcBT3k8PXg58czMFGpsHywHWp6yK+Qsg/K4igs9XIVpCAMwmqxUF9
         KtOqur/yfSr6yXwAGiTjFRwur3zj4eFMm/Up8G8ZEGW4ARHOwrSn2jt8iSWmCwqgGzNh
         Cd9C/QGEI8j6YfhJzOT3x15Hg8ebHbx9Z71ahhUvm7Uc2wc8S+2IM8JxHHaiFo5vbLFT
         rvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=You8MaiZD0k4r3ZqykdZJnjuRHcnRHz1gw23EWcK3Qk=;
        b=GQ3GnbHU6SO4pGM3ltycEJ0vooTK5omtsg4nyNQ89+U5ZXD7IgfebUOqQHhBrpbhos
         nNE7JsYG+dFzO8Fqn6SSQQ3hAGd/14H7IbWZp/MJuiqW9XHrDKMsL49EbnzhlQa66urh
         X3n0GdvMPYHeFyAdeED9pja+eVApAp0Dpt1FjkkLiboEkMigSto6h2dvMAr+ss0o0CF9
         egWRy2T9MR9cIB3nAAUQDNOpJHVj8mx7qY36y3pvgqrlkHYvYxxhwaoIxwnJAzY0dZ9/
         Tg6/pFtR0x4NguzBY2M95LuZLya82hx/AeYSUiSLu3QkSaXPx88rSXpFzDZqGxR1UTeg
         C69Q==
X-Gm-Message-State: AOAM531MGgZ/76YUkuXGDWzioTPX/a6sZ1ArUTr5HJvAu3AZ/7k811eZ
        //PuKc3Tz3cWf85OhyB3mA0=
X-Google-Smtp-Source: ABdhPJxoDD89poWSZAtHyBl4OydzFkRbtWm0iiYbT+6XfH8KI1OT0YkMe/6vNGxJAUkwKBs3gu/+tA==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr10698189eju.295.1631863139667;
        Fri, 17 Sep 2021 00:18:59 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:18:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 01/19] staging: r8188eu: remove usb_{read,write}_mem()
Date:   Fri, 17 Sep 2021 09:18:19 +0200
Message-Id: <20210917071837.10926-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove usb_{read,write}_mem() because they are unused.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
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

