Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF540F315
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhIQHVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbhIQHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE384C0613E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q3so26473794edt.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWuaCq0xj5a6Lo+6wUMXgZ3jX5w7PHCSC44vzqbApX8=;
        b=O9sxBsWLtnEYYsUSuPKyYYHOhMlHEdDjSK2G7F4lv8o/v60EQ6L053e4YrGfebnSCn
         CtWH865IlfjAiHxtBtYCF8sw6i337lConjmuSA8RsI9mHR324sPtr0PXcxk4gmQzkVe1
         0VVqU55Yji5NcxDYc9xEpyb8MvTKwaamSukn1i/ThZgZBhFSPmBHCFuhFjHg0xUQ/GAc
         yiuJMZ4lYKfTyo85Ib5HR4qJfK0xAyfTDR+Ng8kXbQ4GlJJfsPTRSn/rkVKGT6a8HJyI
         ppKo74KtUbWFBuF1ljk5HAbc2DzFCjQ6FJtDraHYutEszywgMUs2zL3a4eM1W26z7t6p
         2XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWuaCq0xj5a6Lo+6wUMXgZ3jX5w7PHCSC44vzqbApX8=;
        b=GDbD5u2D2s6AiuS7No/svBCM+vYzYcmL4cU2AOuKjUGvsiEE5l0LWsFvnWeGu/xE1v
         6yFJF3jg66QeEV47K/OUbPKzuWH9n0528/8r+s5ryAkBTz8CwNfHwaDekRXBTQUA8m+x
         jozXo/D+U4u//pyhuph6fzpZABeZxbpvItxz9YDANEkDuDOrrbIZEaVBJbKJ0y9H5g/w
         I9HIn+5yVL1gNSR+GWwpcdQUEloNgZUOuwqrsEuVYXr2CHnBKgEImiQ6ClXsyWmoPJT0
         xyVKOJ9HcjiXrHQORHSZHRguyb5yQEhOc0RC8vGPT1ptSSC8f7+TOWER8Fr3CBjeBy1i
         /QoQ==
X-Gm-Message-State: AOAM533ydCCzKO7CZqP20YlX+HDo5vV/YhhUsl7jlCLU6/at03HKeXrj
        q7bRxrm6XNyYmR8uHjnyYI0=
X-Google-Smtp-Source: ABdhPJx2pjUJF6tLQi6SrUWMAKK2fMlQVVkQ7XL3HkvUbZrCerAEc3ddfC2C++6ZG8i1kWn/4dhH8Q==
X-Received: by 2002:a17:907:11c5:: with SMTP id va5mr10368078ejb.215.1631863156486;
        Fri, 17 Sep 2021 00:19:16 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 12/19] staging: r8188eu: remove the helpers of usb_write_port_cancel()
Date:   Fri, 17 Sep 2021 09:18:30 +0200
Message-Id: <20210917071837.10926-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write_port_cancel() and usb_write_port_cancel()
and embed their code into the caller (i.e., rtw_write_port_cancel()).

_rtw_write_port_cancel() is a mere redefinition of rtw_write_port_cancel()
and it is unneeded. usb_write_port_cancel() was the only functions
assigned to the (*_usb_write_port_cancel) pointer, so we can simply remove
it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c           | 12 ------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  2 --
 drivers/staging/r8188eu/include/rtw_io.h        |  3 +--
 drivers/staging/r8188eu/include/usb_ops_linux.h |  2 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  |  3 +--
 5 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index a57742057a65..74b02ff8e44d 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -93,18 +93,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pme
 	return ret;
 }
 
-void _rtw_write_port_cancel(struct adapter *adapter)
-{
-	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-
-	_write_port_cancel = pintfhdl->io_ops._write_port_cancel;
-
-	if (_write_port_cancel)
-		_write_port_cancel(pintfhdl);
-}
-
 int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct _io_ops *pops))
 {
 	struct io_priv	*piopriv = &padapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 1865a26142bc..2516cfc464a9 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -562,8 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_write_port_cancel = &usb_write_port_cancel;
-
 }
 
 void rtl8188eu_set_hw_type(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 56e17e2a7ee2..4f4678a55687 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -265,7 +265,7 @@ void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
-void _rtw_write_port_cancel(struct adapter *adapter);
+void rtw_write_port_cancel(struct adapter *adapter);
 
 
 #define rtw_write8_async(adapter, addr, val)				\
@@ -276,7 +276,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_write32_async((adapter), (addr), (val))
 #define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
 	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
-#define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
 
 /* ioreq */
 void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index 186c6b7628dc..641f059ffaf7 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -28,6 +28,4 @@
 
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
-void usb_write_port_cancel(struct intf_hdl *pintfhdl);
-
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index a98ffdf92ed4..4085f3e6067d 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -211,10 +211,9 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 	return ret;
 }
 
-void usb_write_port_cancel(struct intf_hdl *pintfhdl)
+void rtw_write_port_cancel(struct adapter *padapter)
 {
 	int i, j;
-	struct adapter	*padapter = pintfhdl->padapter;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
 	DBG_88E("%s\n", __func__);
-- 
2.33.0

