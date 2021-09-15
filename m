Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2240C585
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhIOMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhIOMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:45:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jg16so5937959ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSxmsENFFnP77CFLhDRz/PZebczbIxhG0S379e7wmks=;
        b=Tciz2kmHwVo+bI9ZDsBNlj9mRh0neIbsupLnmKn433t1Jh9w42vebscBaQo+iqgfyB
         PBgu2LCPVz1F6wprLNL+BWAULCpAXo4QI7O8CZgRrpmMDGxzpui10PKbo0Jpue5Ox1km
         BGSKBdbVgO7lCmIPgqDxW2XDFVKkRUaCbVH+eyRhh+y5zhl6N1WHELhD0HdCx6wTE9fp
         b/w6JQulMM3Ovs08WDGF88yWhaxIZDo6jpHU18kFEjxvR2CbDLoUU4mTgGGo/RDIKFA9
         m/P/f1LkdMtyHeHIW5igXFNYdG3xthRcV87EPP4t+LlpHjz7uMQXpFWpTfE3NP89AOC6
         Hoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSxmsENFFnP77CFLhDRz/PZebczbIxhG0S379e7wmks=;
        b=UniApK9idTfszdsBd+mH07fHXKv8UaqDzVwuJvVF3uBqxvwm+9J41lQZxU+6coXECT
         h1liQnlVDWSIA673tcDCENeLlufVnKhd2kWTktobQpS/bI9tS1ICRLMrsLTg9U7CLwDz
         OxV9deqlvu7RB9PHmtJ1geHGqaBXNhgkjPFCRi73c4RboVthBaYlFBvw3vwsi4sDQYf5
         rGNqhV/aa1kNrbWKYGnHbDliA5PnLk5X5+U1qMdfTYW8B0WvHbSNvL2RiVVCRG6lq9fp
         kzUjNawHoQlBjqW8dWpdLlvZGnK8v+4exIfvy1J0ktRDUsVcij8O3OPzaiuVA6b+Zzkf
         f7jA==
X-Gm-Message-State: AOAM533zEVf1WoKNhnDWSQwgD820YTV401/YaOadVAlcB2Llu0bg6Dna
        pz6SClknq8NRX4JrXdZeZl8=
X-Google-Smtp-Source: ABdhPJwfJ/durxnt/Nx1BbXOOpxbYpBtgaaK/DxjeyiCe97y++NGDdArZcFF1nCZfGWhvjtemmGc3g==
X-Received: by 2002:a17:906:289a:: with SMTP id o26mr9938358ejd.243.1631709870602;
        Wed, 15 Sep 2021 05:44:30 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:44:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 13/19] staging: r8188eu: remove core/rtw_io.c
Date:   Wed, 15 Sep 2021 14:41:43 +0200
Message-Id: <20210915124149.27543-14-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

There are only unused functions and macros and one function which can be
open-coded.

So, removed core/rtw_io.c at all, removed core/rtw_io.c from Makefile
and open-coded rtw_init_io_priv

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/Makefile          |   1 -
 drivers/staging/r8188eu/core/rtw_io.c     | 111 ----------------------
 drivers/staging/r8188eu/include/rtw_io.h  |  19 +---
 drivers/staging/r8188eu/os_dep/usb_intf.c |   8 +-
 4 files changed, 8 insertions(+), 131 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_io.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index aebaf29990fd..4ca48fe628fd 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -78,7 +78,6 @@ rtk_core :=				\
 		core/rtw_debug.o	\
 		core/rtw_efuse.o	\
 		core/rtw_ieee80211.o	\
-		core/rtw_io.o		\
 		core/rtw_ioctl_set.o	\
 		core/rtw_iol.o		\
 		core/rtw_led.o		\
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
deleted file mode 100644
index 74b02ff8e44d..000000000000
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-/*
-
-The purpose of rtw_io.c
-
-a. provides the API
-
-b. provides the protocol engine
-
-c. provides the software interface between caller and the hardware interface
-
-Compiler Flag Option:
-
-USB:
-   a. USE_ASYNC_IRP: Both sync/async operations are provided.
-
-Only sync read/rtw_write_mem operations are provided.
-
-jackson@realtek.com.tw
-
-*/
-
-#define _RTW_IO_C_
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-#include "../include/rtw_io.h"
-#include "../include/osdep_intf.h"
-#include "../include/usb_ops.h"
-
-#define rtw_le16_to_cpu(val)		le16_to_cpu(val)
-#define rtw_le32_to_cpu(val)		le32_to_cpu(val)
-#define rtw_cpu_to_le16(val)		cpu_to_le16(val)
-#define rtw_cpu_to_le32(val)		cpu_to_le32(val)
-
-int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-	int ret;
-
-	_write8_async = pintfhdl->io_ops._write8_async;
-
-	ret = _write8_async(pintfhdl, addr, val);
-
-
-	return RTW_STATUS_CODE(ret);
-}
-
-int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
-	int ret;
-
-	_write16_async = pintfhdl->io_ops._write16_async;
-	ret = _write16_async(pintfhdl, addr, val);
-
-	return RTW_STATUS_CODE(ret);
-}
-
-int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-	int ret;
-
-	_write32_async = pintfhdl->io_ops._write32_async;
-	ret = _write32_async(pintfhdl, addr, val);
-
-	return RTW_STATUS_CODE(ret);
-}
-
-
-u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
-{
-	int ret = _SUCCESS;
-	struct xmit_buf *pxmitbuf = (struct xmit_buf *)pmem;
-	struct submit_ctx sctx;
-
-	rtw_sctx_init(&sctx, timeout_ms);
-	pxmitbuf->sctx = &sctx;
-
-	ret = rtw_write_port(adapter, addr, cnt, pmem);
-
-	if (ret == _SUCCESS)
-		ret = rtw_sctx_wait(&sctx);
-
-	return ret;
-}
-
-int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct _io_ops *pops))
-{
-	struct io_priv	*piopriv = &padapter->iopriv;
-	struct intf_hdl *pintf = &piopriv->intf;
-
-	if (!set_intf_ops)
-		return _FAIL;
-
-	piopriv->padapter = padapter;
-	pintf->padapter = padapter;
-	pintf->pintf_dev = adapter_to_dvobj(padapter);
-
-	set_intf_ops(&pintf->io_ops);
-
-	return _SUCCESS;
-}
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 4f4678a55687..2b9b64f1ac80 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -257,25 +257,11 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
 
-int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val);
-int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
-int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val);
-
 void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
-			     u8 *pmem, int timeout_ms);
 void rtw_write_port_cancel(struct adapter *adapter);
 
-
-#define rtw_write8_async(adapter, addr, val)				\
-	_rtw_write8_async((adapter), (addr), (val))
-#define rtw_write16_async(adapter, addr, val)				\
-	_rtw_write16_async((adapter), (addr), (val))
-#define rtw_write32_async(adapter, addr, val)				\
-	_rtw_write32_async((adapter), (addr), (val))
-#define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
-	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
+void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
 
 /* ioreq */
 void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
@@ -317,9 +303,6 @@ void async_write32(struct adapter *adapter, u32 addr, u32 val,
 void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-int rtw_init_io_priv(struct adapter *padapter,
-		     void (*set_intf_ops)(struct _io_ops *pops));
-
 uint alloc_io_queue(struct adapter *adapter);
 void free_io_queue(struct adapter *adapter);
 void async_bus_io(struct io_queue *pio_q);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index d04d2f658ce0..306325818a9a 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -448,6 +448,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	struct adapter *padapter = NULL;
 	struct net_device *pnetdev = NULL;
 	int status = _FAIL;
+	struct io_priv *piopriv;
+	struct intf_hdl *pintf;
 
 	padapter = vzalloc(sizeof(*padapter));
 	if (!padapter)
@@ -479,7 +481,11 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	padapter->intf_stop = &usb_intf_stop;
 
 	/* step init_io_priv */
-	rtw_init_io_priv(padapter, usb_set_intf_ops);
+	piopriv = &padapter->iopriv;
+	pintf = &piopriv->intf;
+	piopriv->padapter = padapter;
+	pintf->padapter = padapter;
+	pintf->pintf_dev = adapter_to_dvobj(padapter);
 
 	/* step read_chip_version */
 	rtl8188e_read_chip_version(padapter);
-- 
2.33.0

