Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7E440F314
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhIQHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbhIQHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g21so26462955edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qgQJ7xNc9izh1E+ZRuYYXgrfWnQo/petfErCwvHbDs=;
        b=SsHi+T+Wcjk+pdiu5A1DkVH76RxTDyPlr1VqyxNmd+ORg9/5db/mhSJ/H7DebfqiH3
         v9fLKM/keYFrCiAFiiARhnR3Mw+8KlhEzrQs/N+C8+Rl25dN8oF0ZXAAxCyJTXuvLRF9
         C9QBBNdCdk53O/zIvT2/OP1cFd6l3KF9UkbBZ7ZcujpBsWs692hAZ3JmRvgql2D2Vgyg
         XK0XNg14IX6XDAIC4Hyev490iHN8Qg8KcedFz80V8pXCm4hkFMVKMtAHprZwklHKCARt
         mG3jOnerg51Q7Yj0kZ2RVnxqjHQNZtp0N+rW/Q1Yl7hv/ZTXrB0+KixMkeyQ/2U2Oeq7
         I8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qgQJ7xNc9izh1E+ZRuYYXgrfWnQo/petfErCwvHbDs=;
        b=NvJ2HRDQx9038e7rh1BXLeuVLlgo7wO8xGfQ0DHAxDV1tmk1aAep1dGNT6jDhjZfHT
         I/EYvb+D70dN0fXjp+gm232vKKuEemB/BkftJUbAc0HhjGN1Q2ES0yIzOWsMtTYkc2AU
         T4Yx8+HRMkl+vDulV2JC9t7CaIwfsUDlUlMrvwzo2uwRL06HJ/6nIEBRQGNQZfwDI3e6
         A+Id8AFyfDcXiiT9l4tdH2aSroQDJAtnhVNpIbpKkx1OK/XXJqx8bN7wLTOxRk3ILkWC
         wX3pjaAoDkkByvlaY4rg+Mcaf5u7wZxco3BquCOQJrVbWMQ4qPcupRRtGMcV6C81b14+
         3lYw==
X-Gm-Message-State: AOAM530BOM5xN9X6bISwNuyv3cNgbjxa1aUw6z/xE4mo1DTySg9mL6kl
        4poa++oguqmjxi12SH04e38=
X-Google-Smtp-Source: ABdhPJwQV4NEH3urmVVFFxxh7XNc5xwYv36ROYNgNOUP4qGGiGDswMh91XQkI3D7v1cPDup7IEdpRg==
X-Received: by 2002:a17:906:6d5a:: with SMTP id a26mr10824089ejt.162.1631863155133;
        Fri, 17 Sep 2021 00:19:15 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 11/19] staging: r8188eu: remove the helpers of usb_read_port_cancel()
Date:   Fri, 17 Sep 2021 09:18:29 +0200
Message-Id: <20210917071837.10926-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read_port_cancel() and usb_read_port_cancel()
and embed their code into the caller (i.e., rtw_read_port_cancel()).

_rtw_read_port_cancel() is a mere redefinition of rtw_read_port_cancel()
and it is unneeded. usb_read_port_cancel() was the only functions assigned
to the (*_usb_read_port_cancel) pointer, so we can simply remove it and
make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c           | 11 -----------
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  1 -
 drivers/staging/r8188eu/include/rtw_io.h        |  3 +--
 drivers/staging/r8188eu/include/usb_ops_linux.h |  2 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  |  6 ++----
 5 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 3a5e9dbfcb12..a57742057a65 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -75,17 +75,6 @@ int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-void _rtw_read_port_cancel(struct adapter *adapter)
-{
-	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-
-	_read_port_cancel = pintfhdl->io_ops._read_port_cancel;
-
-	if (_read_port_cancel)
-		_read_port_cancel(pintfhdl);
-}
 
 u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4fea21c0f7af..1865a26142bc 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -562,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
 
 }
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f2b1978b6e80..56e17e2a7ee2 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -250,7 +250,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void _rtw_read_port_cancel(struct adapter *adapter);
+void rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
 #define rtw_write8_async(adapter, addr, val)				\
 	_rtw_write8_async((adapter), (addr), (val))
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index bdc596fe5854..186c6b7628dc 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -28,8 +28,6 @@
 
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
-void usb_read_port_cancel(struct intf_hdl *pintfhdl);
-
 void usb_write_port_cancel(struct intf_hdl *pintfhdl);
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 36ef06f88fdd..a98ffdf92ed4 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -31,12 +31,10 @@ struct zero_bulkout_context {
 	void *padapter;
 };
 
-void usb_read_port_cancel(struct intf_hdl *pintfhdl)
+void rtw_read_port_cancel(struct adapter *padapter)
 {
 	int i;
-	struct recv_buf *precvbuf;
-	struct adapter	*padapter = pintfhdl->padapter;
-	precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
+	struct recv_buf *precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
 
 	DBG_88E("%s\n", __func__);
 
-- 
2.33.0

