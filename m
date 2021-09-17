Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9406440F313
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbhIQHVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhIQHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BCC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v22so22161862edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZoNN9lvI9eI8fMC3zM8OiMiWDOwhXjr4L3QDikpRvC8=;
        b=ZvdUsLKSKgb5Ak50x5XPrzTNnM3/vdZYzd5pBzLwZhXzpnbprJIFoiu/kcFnG1NIaJ
         1pjP2JjeHMNA0jY0NBy+iZDsrUGJMafD45oI83IeCBk3xIGVQTQcCRGHy/jVnVA6YLiI
         GL1KkL8ZR2EFgFNlVOOwcLudJHkPVF0Vou8YUubPRWuWgWUXJLf4/XFQ3g4pT+bT8+FC
         u8junwWl8o6+k5UE7MsykZVHTzdwFQkmQTGReZ0gjrliZmcoNh8gQaAwXDQWSP6xys98
         LNiBdT6jEsXbMNlIyIp7DEleMzM6wWk5z6B+QkxSuI1Vs7nZaHP9tEQdvjyUCHZt2ePq
         KC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZoNN9lvI9eI8fMC3zM8OiMiWDOwhXjr4L3QDikpRvC8=;
        b=cgU+RkTXFepQoSmt6YZQWa/Q4qZkopxovgO3PyoEngZPRz6q1qiNmh4+DbbFRygKXT
         NQhLmCEGOnMcQZ2NbJ0V9ibvJifxXgphNyRmZ0hxXn9/KvFqH6oLy8qU8P4U2EY6J8an
         BlkenBfElqnAqtfve79cARZbNq4mUakSjLJSVYm6omV/BCZUkaVNGD/B16P6znvrz8UC
         yC29xPUuel+dsXvgWKp70jGcTkDEg43uojb2h/RFXRqUrJEAq4gktQ1TFNMnYS4TWoGj
         wXeSKcooLyV6HKRJLJXHvYgxbPl8LtiOcie/O6CM9IU+ASeXeErY/YfukCQkodHBa/Ja
         nAzQ==
X-Gm-Message-State: AOAM533E4t9kZeXauYxFgqOdxH6lw+/N7q+bHSfwGVfrl05JI3Q3t+jF
        G8fsYa26iCjxg9N0gTvry6w=
X-Google-Smtp-Source: ABdhPJzR2A76sQw1aLkh8OjYvl8YOhBNbZFoPbtiu+WAoB/bGilYbFwbrExGoOxNmefZQyCo1WidSg==
X-Received: by 2002:a17:907:7703:: with SMTP id kw3mr10662383ejc.34.1631863153813;
        Fri, 17 Sep 2021 00:19:13 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 10/19] staging: r8188eu: remove the helpers of usb_write_port()
Date:   Fri, 17 Sep 2021 09:18:28 +0200
Message-Id: <20210917071837.10926-11-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write_port() and usb_write_port() and embed
their code into the caller (i.e., rtw_write_port()).

_rtw_write_port() is a mere redefinition of rtw_write_port() and it is
unneeded. usb_write_port() was the only functions assigned to the
(*_usb_write_port) pointer, so we can simply remove it and make a direct
call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c         | 20 +------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  1 -
 drivers/staging/r8188eu/include/rtw_io.h      |  4 +---
 .../staging/r8188eu/include/usb_ops_linux.h   |  1 -
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  3 +--
 5 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index ac72f894da75..3a5e9dbfcb12 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -87,24 +87,6 @@ void _rtw_read_port_cancel(struct adapter *adapter)
 		_read_port_cancel(pintfhdl);
 }
 
-u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
-{
-	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32 ret = _SUCCESS;
-
-
-
-	_write_port = pintfhdl->io_ops._write_port;
-
-	ret = _write_port(pintfhdl, addr, cnt, pmem);
-
-
-
-	return ret;
-}
-
 u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
 {
 	int ret = _SUCCESS;
@@ -114,7 +96,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pme
 	rtw_sctx_init(&sctx, timeout_ms);
 	pxmitbuf->sctx = &sctx;
 
-	ret = _rtw_write_port(adapter, addr, cnt, pmem);
+	ret = rtw_write_port(adapter, addr, cnt, pmem);
 
 	if (ret == _SUCCESS)
 		ret = rtw_sctx_wait(&sctx);
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a104e3fac7d1..4fea21c0f7af 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -562,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_write_port = &usb_write_port;
 	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
 
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 600c6e7a375b..f2b1978b6e80 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -262,7 +262,7 @@ int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
 int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val);
 
 void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
@@ -275,8 +275,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_write16_async((adapter), (addr), (val))
 #define rtw_write32_async(adapter, addr, val)				\
 	_rtw_write32_async((adapter), (addr), (val))
-#define rtw_write_port(adapter, addr, cnt, mem)				\
-	_rtw_write_port((adapter), (addr), (cnt), (mem))
 #define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
 	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
 #define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index 37e0614fd15c..bdc596fe5854 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -30,7 +30,6 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
 void usb_read_port_cancel(struct intf_hdl *pintfhdl);
 
-u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
 void usb_write_port_cancel(struct intf_hdl *pintfhdl);
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 9afb4df71969..36ef06f88fdd 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -124,14 +124,13 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 
 }
 
-u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
+u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 {
 	unsigned long irqL;
 	unsigned int pipe;
 	int status;
 	u32 ret = _FAIL;
 	struct urb *purb = NULL;
-	struct adapter *padapter = (struct adapter *)pintfhdl->padapter;
 	struct dvobj_priv	*pdvobj = adapter_to_dvobj(padapter);
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)wmem;
-- 
2.33.0

