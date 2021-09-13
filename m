Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6C409BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbhIMSNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbhIMSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E569C061768
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o20so12331328ejd.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBYrnuojESWiOHnbX+d9CkChGCnhuoKS3C28woP3lTE=;
        b=JFtnkUm6Gegxov2SZR9qKhDUE8ofLmYRTEWBOL1CZW1mq089AhjGE4fqd+T7ckmArS
         8eQ6YT81vM1eWrmSDEYrxNXNycTctGlnsc7LOtyurwhMethtGAsY1px9IhEmMYggY3OM
         VBsfrMVfGP4b5aVMXV7tGMZcdrQmMjaOG1yabGFsbVr0z46WzIWHIc+a9n33mn6issjI
         WV330o0yhLDBnDlygfb5XJO/vvR9eZoonp31w8OKaXbJzQgeMre/yIwBAmNqJV7FWU5b
         tliw+EPZOLm6eEi2NMJoGQnwJZ1tXdAz/GtvULWNi2GAIId8RwoRMb1K7YVqy4XQizum
         dQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBYrnuojESWiOHnbX+d9CkChGCnhuoKS3C28woP3lTE=;
        b=sXyVzmS8hw24eQQmhD/2kqHJYG7tgMzZsp7YljEDVW6meL+Y5ubDalSfz+wNldPebb
         enqlxGTKPlY9nXVystTgWINLiaQkezZzUoUUmmNoRkgN4VwDlAMvgwtBLFJQu5+Z3sPG
         Fkbit1uaqU6mPleAvqQbmAkGg53b1bwmN9BgiHwDuGOalcBrttoEhMGCYjt8fWwobgw7
         BdqOAn97rNu71G955JbTfI6cBO1JDnSzZrPNryS/vqsLfW+Ioq0lKn5H/Slx3IhmUK39
         OmXZ7G5c89LVrFPkIHT/ZZHPJEYpxx3MbvjgQfLKyX7N4+HXgba8eU/EojD8vpyDOd3q
         R0qA==
X-Gm-Message-State: AOAM531kHzq3+GNddVBvXBYJ3vm8RT1hHmXbhYyCm7hnmX/pDDDu4Ptm
        cjPvYYNo1jufy5s8lz9TbAc=
X-Google-Smtp-Source: ABdhPJwtKlnbc3xoOPh7JfV6MnGzWbzie3yirCKWxulkqBgROrXwrESt8JyQayuAbEOQMGMUfXzG6g==
X-Received: by 2002:a17:906:114f:: with SMTP id i15mr14077043eja.534.1631556734746;
        Mon, 13 Sep 2021 11:12:14 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:12:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 12/18] staging: r8188eu: remove the helpers of rtw_write_port_cancel()
Date:   Mon, 13 Sep 2021 20:09:56 +0200
Message-Id: <20210913181002.16651-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

