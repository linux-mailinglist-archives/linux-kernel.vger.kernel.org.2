Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7940C57E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhIOMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhIOMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:44:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:43:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i21so5918887ejd.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQMl3MvaJGgLQQ5vv0xf9PyNyfOYahHGlNfnKNBtwwM=;
        b=KLuqjiuup5m8I4MKlIUsnh62VqehJJTQkp56jAoU+05DXC1fStRrxoFyRwc8Q1MKyt
         bh5uSkzWgBYo6gin8IVpuB5LiKWUZKIJF3uHVfANQONhp1ZYa43gl5AbcL2uOpdXtup8
         ISKp9buhx9056zpH2EcnGcV8/2ndBwrmweb6h5oFAGhXznCxF4vhwmgHkcnpij8AWt1F
         U4zIJH1wZItw8TDvSFBEBR5oD5A3+pN09m/CNMf43WDq6w7OMRyq02NmEnPSqMyTV6LY
         MS57mHrhQqEZNu9fAME81czu1oNn6MbzJn/F6Fp8L1FtiHnI37PzLHfiK0Os0/maA8qu
         VRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQMl3MvaJGgLQQ5vv0xf9PyNyfOYahHGlNfnKNBtwwM=;
        b=Pr9lppjOp67O+Hp1gEXBge7FhacA8iuTt0f9yAWJegNcCIbp0MZUEPhXSXaHTHLVEG
         akrs2byA9jL3xAj6sIu1hFrgUYqOf9A9Ip+OLuqWYZGQq1lVB36BLtLw2Y7SNBcXR+Ap
         dvzQ3WIXZnPpNAVggkIVicaCTvlSiG1nO1rmyHd8U6LyYNrJZrDz2CaMGmutjs8oKEh+
         6GT/TuLp6AvtrOeYFJ4FjynFrlUd9IslYuShOCLTtAWRiU6eb3a125uHzclkI3J/hCbX
         XbDvruvIoUaxpUbJ9mrE/q2m3EX2OQa9Oxx15jqMs9XsLBseeqRmrbBs2JlnEmGCUeb/
         bsaQ==
X-Gm-Message-State: AOAM530vdRaPi/stsUSlsr3PiLbhjb4KrTvm7LghjdFiP9dtK7dzDXVl
        GoEc8nAR78q88w22aw5BsWA=
X-Google-Smtp-Source: ABdhPJxhIXUBtq7vNhLoZi25MEPC0MAzBynF7N4Dk3jDP75X1snDdaqj3albs8AvenQei6QBxDGWfA==
X-Received: by 2002:a17:907:7703:: with SMTP id kw3mr24827268ejc.34.1631709809577;
        Wed, 15 Sep 2021 05:43:29 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:43:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 09/19] staging: r8188eu: remove the helpers of usb_read_port()
Date:   Wed, 15 Sep 2021 14:41:39 +0200
Message-Id: <20210915124149.27543-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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

