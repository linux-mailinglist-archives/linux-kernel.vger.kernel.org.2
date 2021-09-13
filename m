Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D2409BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346874AbhIMSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbhIMSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:12:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F68C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so14286987edn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RF5yqvf+wJXK+pHJGaHkHVR9j4VwE+Q/IKIjNVXFUPM=;
        b=PnNPn/nYBnx9upQbQnTNdKm9t+VGitIOG5NLaq8u9CK2NPl1zE9y4otMs85MbBe7cu
         mS9Dzh49dpHuvl47J6Z5PKNdLvvXeQfXWJYep6w8s4FPeUNOKQANWJ+SNPb9Gik+Ou9o
         V0KKEqNJzBs10VfaxCW+iXrYawuPwOTlTTnIpfZFpMx6bdjt0CraAtfVAhvSbDhArSTH
         Fxp7b0PDS2jgjSsqUim29vJq8YunzjXbo6OD/5U3ERrHzesIi6xO4JhDiRMhJoHHT8xe
         xLoybSsmNrx9ZJxRLIWq0UoWuhuj6d8iibqI+TuEOGW25VYewpzz+Ws2hk6BqacNART8
         xHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF5yqvf+wJXK+pHJGaHkHVR9j4VwE+Q/IKIjNVXFUPM=;
        b=lOfeQdEbIjfzHhf6spU5FxkXjIit3Vh7JgVGZ6FC1OxZLZLFCrQHZppBhj7LoBTQ4A
         H3niWj6H3KoqQ2CrUMDFMmF6DpUXtuKNUQeAXucOFx2mbRmuY0dxTB3fYPeta3XyIC8C
         2HkyM6p23bazvsWsg06XayZUMogK5JVPEsZsP5vYYR/FATLA8mSyTIb5PaGs4AgTRPg1
         8j+Upr4e45+ZvDLXDKDWHoowcbVz4izynMMYO2jWoT5E7zOJc8Xw2F0lrrhs5Yokyv42
         zvUDWNvTr/XJ+R+8h4GK1rCEjZT92nCUcrm0fxMY//qryL3+2RWNhffZMcJ0tKqpbzQF
         mlpw==
X-Gm-Message-State: AOAM530P6v4SRhp5pPBylzPmZHhlJ56mn5EgARpF68gK5PG1M9rMzuzl
        luEdPAUKbhdq0KT3kq6S350=
X-Google-Smtp-Source: ABdhPJwkpX3CxpfxKBXYuWfSZvK3U7AU7YeS+4VXwLm5jS0C2jie8QygFewAjRfO1+2+D4zHBJfDhA==
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr14237826edw.269.1631556700708;
        Mon, 13 Sep 2021 11:11:40 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:11:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 09/18] staging: r8188eu: remove the helpers of rtw_read_port()
Date:   Mon, 13 Sep 2021 20:09:53 +0200
Message-Id: <20210913181002.16651-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read_port() and usb_read_port() and embed their
code into the caller (i.e., rtw_read_port()).

_rtw_read_port() is a mere redefinition of rtw_read_port() and it is
unneeded. usb_read_port() was the only functions assigned to the
(*_usb_read_port) pointer, so we can simply remove it and make a direct
call.

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

 drivers/staging/r8188eu/core/rtw_io.c       | 18 ------------------
 drivers/staging/r8188eu/hal/usb_halinit.c   |  6 +-----
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  4 +---
 drivers/staging/r8188eu/include/rtw_io.h    |  4 +---
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index b2e41fa48d81..ac72f894da75 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -75,24 +75,6 @@ int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
-{
-	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-
-
-
-	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-	     return;
-
-	_read_port = pintfhdl->io_ops._read_port;
-
-	_read_port(pintfhdl, addr, cnt, pmem);
-
-
-}
-
 void _rtw_read_port_cancel(struct adapter *adapter)
 {
 	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 0c317a8723ef..59a7af696121 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1047,11 +1047,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	u8 i;
 	struct recv_buf *precvbuf;
 	uint	status;
-	struct intf_hdl *pintfhdl = &Adapter->iopriv.intf;
 	struct recv_priv *precvpriv = &Adapter->recvpriv;
-	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-
-	_read_port = pintfhdl->io_ops._read_port;
 
 	status = _SUCCESS;
 
@@ -1060,7 +1056,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		if (!_read_port(pintfhdl, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf)) {
+		if (!rtw_read_port(Adapter, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf)) {
 			status = _FAIL;
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 90fb46c75159..a104e3fac7d1 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -456,11 +456,10 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 }
 
-static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
+u32 rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *rmem)
 {
 	struct urb *purb = NULL;
 	struct recv_buf	*precvbuf = (struct recv_buf *)rmem;
-	struct adapter		*adapter = pintfhdl->padapter;
 	struct dvobj_priv	*pdvobj = adapter_to_dvobj(adapter);
 	struct recv_priv	*precvpriv = &adapter->recvpriv;
 	struct usb_device	*pusbd = pdvobj->pusbdev;
@@ -563,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read_port = &usb_read_port;
 	pops->_write_port = &usb_write_port;
 	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 1123017cac65..600c6e7a375b 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -249,7 +249,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+u32 rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
@@ -267,8 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read_port(adapter, addr, cnt, mem)				\
-	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
 #define rtw_write8_async(adapter, addr, val)				\
-- 
2.33.0

