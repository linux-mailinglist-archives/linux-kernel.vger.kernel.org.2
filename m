Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF840CE99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIOVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIOVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g21so8572494edw.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zDbV/uKcczVbZMRuBNAgynLRQJTh3fUO/7zgmWU9yo=;
        b=lQNAzJlJDGcrs603ik5X5l1Tu7wfaSbtybECHiiME6GPiMlJ/lTxjC1L3zelPRZa8s
         F3EIbJiUlbKTjyEw/sfhz8W4OPj9U4h1R6SyxTxA6dg3y7BiyiojxbmyTdhD2/ptqNa/
         7MLPJPFyzvmJm3A6kH7+TrTP0FGmkMY/IhPv+2iU8PFzdOrwOAsde2LEj+s8vKzXTB6y
         IcdVOGO7TeBcRAttvdGpYMiYEhtaG5gSP2AWhxcAh0kK5TKirz7ZMAsHZDRCKxRxTp5O
         OsrVFTV7jWZwVarKmlw4fVlBgiIn7/smbDwPhQSh+266Lnmrr4pc3dcefx5LgEzFBauF
         gVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zDbV/uKcczVbZMRuBNAgynLRQJTh3fUO/7zgmWU9yo=;
        b=wWy7WurED+Z18umfxxEy8qht+JF9FbS6sDXyeD7npsripBrR2eG0AYW1l0GV620oNw
         SX1kFuUFwu3l0dNBeLWsiB4Kn8XCENZoKjR+iI2H8qj+vxQHTFMidVhW3a4ALaqK4wMp
         uqpUKPjqUFf6/PUt5rRDtfTHVTgyNXr1tmig1ihXf0IoPsFfQa6O9rtbMi75TbWH8JqL
         bmoxBja9uhONeBsIqkCp2FVagFcyOUVmLVwTx8Ko53kMD9wMxAsvvxcQZ3kqltSTk99A
         TNSb7r9jn+7r1DTO+j+Se+GqPVs6HVFpYOyiQkS4pq5qXd57n75KTwP9FNcoJDWZe34y
         9//Q==
X-Gm-Message-State: AOAM531xP/HzLP7UCSMttOIMcf2sMfzJhauaVzy9tSkM6aemfplumx1R
        6yd/itBhAvL6FXBq5yvtzgM=
X-Google-Smtp-Source: ABdhPJzwjzqFhaVG3MjjNNRQsqfm6iLuTiYXCUpb0eGNHbvl/wKAIqJ0YC3YdVRQp3ROwD44st32SA==
X-Received: by 2002:a17:907:3e21:: with SMTP id hp33mr2189383ejc.205.1631740293117;
        Wed, 15 Sep 2021 14:11:33 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 12/19] staging: r8188eu: remove the helpers of usb_write_port_cancel()
Date:   Wed, 15 Sep 2021 23:10:56 +0200
Message-Id: <20210915211103.18001-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
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

