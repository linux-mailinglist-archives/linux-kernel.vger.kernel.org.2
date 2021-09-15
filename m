Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCA40CE97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhIOVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhIOVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA1C0613E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z94so8526490ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANeHNn7POs/G03YATeZ1ZT4mndBnW4QYgMGP7VqB3i4=;
        b=DPh0n/4/FWYo3rDXuWhqgV5eTNJeRTPAPJpGf3CL+yXjickVLyjcOQ9yiotvMkiSZS
         T7nLSxDTATceUt6QkjUhCKSh/+8NId2pseiOG4Cn0OvBe3C+7lEaDEoZWknhgCPwFiMp
         gP2lrhTDhAESz6155Clb9Ybu8ZqF51op5fxYWDQIjQ3OHs+1TE+qvURUPLVy3LtDPLwi
         vtoJgLvK5IV638p9o3RGSxx10/CD9yjig8/ED0kn4i5WIMjBd3nosL+7QJH1NESWo7BF
         mFai1S/dh4ELZW2aQXFg0KYCocWYp5rCbF6uEzRLLved/kOUmDDWCchd8sjXkvJjdIAN
         3gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANeHNn7POs/G03YATeZ1ZT4mndBnW4QYgMGP7VqB3i4=;
        b=N8Zwtd9iFrIZjaMZaTMevL/KRIXY3E++4qEGo6QvxgCu8ltgPXf9uDbgOKliz/SRPy
         AmWTBEffrDpIrWo+1wgzneY/Pt2soRPZdhV7Q/F1yQBqmIBGpTqOxXQb/mXOxG1VHOQ/
         lTg86E4B63KiyU5Jl1SQ6jXbu39m/VrpwOzZkRIxSSkpFh1W+T2h6rfbqoDzlE1oWvW9
         KscrA2B/Sbz8rQ3VJWiEmP9eXTkPWGVVYyp0hZcsbIdp2d1huuAkWNbTg6KN4qiYTbEp
         AqZPQwfS6gVL1b2DULDu56wvyRLTklHK6e06x+yQEuSpz4j3+cDgcNgX928gqPtVe9bH
         qZuQ==
X-Gm-Message-State: AOAM530kkJHRTzSPy9IKyxXoh/0e0Sh8Jke4yxj0AI8lOSx458c9XO8x
        F0TbAwnFBU9LsRih/uATsoY=
X-Google-Smtp-Source: ABdhPJw4NOZ6t+y15R5w5EmVwg2Hj/Z8laHZb+rVcYqE0Xe8VEoTpvp2f0ubHyBAfqjekNm8b7TdQA==
X-Received: by 2002:a17:906:5685:: with SMTP id am5mr2325116ejc.64.1631740290428;
        Wed, 15 Sep 2021 14:11:30 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 10/19] staging: r8188eu: remove the helpers of usb_write_port()
Date:   Wed, 15 Sep 2021 23:10:54 +0200
Message-Id: <20210915211103.18001-11-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
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

