Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2240F312
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhIQHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbhIQHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n10so25812771eda.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXuD54NIK9Ne9zWy8SxGneL0gCHGGEk7NRBIEDKoYhA=;
        b=oD75ZZCL0X7rup9OxrHl24dZq8P59FwXIjr2BdHRQ4XbdalJlZEBOJYovirZlnhGF+
         6hSy/eyazhEWalWNFFzOXRtSQXH3BaFcCOmX3W0/E5CIVwBRilKnRFXBo0UL+kO/9diN
         ZseSzEgaWg/4zxzJiS4UtcT+CaoJtTHvSoGC9izN2WgbU+J7qDlB4OCCo7msilQumLgn
         WLIUkVJrrx7737PGDhQos+iu3XPzRwThQZLDzebHi8mFQ/QG3UMqO3it1VWJDq7ouox6
         sg+QS73l47ImJyyuUcjDHRNbD4E+iDc0p99Bcp+3pVhfKq3DswkOQ7faz+YhIVNDK84c
         BPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXuD54NIK9Ne9zWy8SxGneL0gCHGGEk7NRBIEDKoYhA=;
        b=kb3AdVGmHILeMbyG/ypTClsWEwWGHkAQcc0Kow0KkOG4inM2/yCN+ICb3ZyA8ihF9h
         4aHYmRQe5DYu6FqZf4WqwBe31VoJQQJGmwRAaCuQh+4BJtzLihYJZOaksj7URz26lOWt
         z6/l7qECOKKlWEPIztcV+Tv9ZRi1kUEBIAazsQ5CMiX+0guJ1tW4W8SMKMamUZ980XBj
         trSPrwjtj83PlbbsMbmSLdUIXtFYYA5mVS7ANSxQwNqHwSiB5pOxj5Uem8wfzOkjh1c8
         IkMi2pWnXAGid1Qe6GVJKDdcBQBW7mbJ0AUGD+m6OCLWyKbfxiskPlw10Za2iB11R6Vs
         NKiQ==
X-Gm-Message-State: AOAM530gohI+s2uTz8NQoSgXw7H/BoBbZrVsSZn/LOb3doFHO8o9QPVT
        aGyK2xKDfvtMUJ1qtcMQfjv+WEHQmH8=
X-Google-Smtp-Source: ABdhPJyACGke2o0NwL4IF25MC/J6DlQ9emsqEwmydpxadHd8tSGMHIKcETCmFaLYZ6edg5ItK84ohw==
X-Received: by 2002:a17:906:4ccf:: with SMTP id q15mr10919766ejt.9.1631863152493;
        Fri, 17 Sep 2021 00:19:12 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 09/19] staging: r8188eu: remove the helpers of usb_read_port()
Date:   Fri, 17 Sep 2021 09:18:27 +0200
Message-Id: <20210917071837.10926-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
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

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
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
index dfaa0195dbc3..5133d533674f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1033,11 +1033,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	u8 i;
 	struct recv_buf *precvbuf;
 	uint	status;
-	struct intf_hdl *pintfhdl = &Adapter->iopriv.intf;
 	struct recv_priv *precvpriv = &Adapter->recvpriv;
-	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
-
-	_read_port = pintfhdl->io_ops._read_port;
 
 	status = _SUCCESS;
 
@@ -1046,7 +1042,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
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

