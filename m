Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06D409BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbhIMSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346872AbhIMSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47012C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b10so16266493ejg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vytz1NRjOos419rKklFIjlFFo6GGTtdN5a/4OCZmxxU=;
        b=kgtihqUBTHgtiCz5IeYRwDEfoR2TBGXobwO18QBoM9RKpyCVlKhUT6fGm6+uNu9XwU
         S2bIt20d0BOh9optdF+PGRFuwJ/or1p2KC5E4f+3joyLq9d/y7c3cj4cmsdIGOWJQp/2
         uq2TRIZcrkrbtCcS1GWpkTtQra7JJKbHyELu4iQMpmfm3XDF2Yaoz1z50iCaVHLb4hMA
         aYjQO//WbKg3tcgJEhhSfR8q7uQdqXOA9JROugUK9taTlf1fq1gGK8HPhJTHBv7Vd14D
         SL7ACeweLm7R9gcz75i6NvU84X1HVPvU9He6pnFB2XlWWx1Au5IfmyberGEKNKQyddoP
         OC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vytz1NRjOos419rKklFIjlFFo6GGTtdN5a/4OCZmxxU=;
        b=cejydV4RKLOxzWDfk8nQuaeUq5TcG508u+0aXfjHa/dlcwZHapcYZbwNzUciSVfCS0
         8f58v5Kn2lqHEfNDxOqP5PLjyzcQriPsPqTXCIAjMOknwFKLeQxmhP/yEinEgxJUmgSV
         5pIfzXfgVv947/37KZSHyq1/ZqRkiqJawkQQET843vctEqHRAsfj2unMIhktwFuaLZzL
         r5U27T0yeLjVzq96hE4Nv6hSixvCuqD6dcLUqioUQ8XrtevmDAh4xymSLJNKPubILmnV
         7sqLo0igXsWB/NGnDb0Wjp5VY5z9NYEUa879JoYL2wE6pCMeYiw7WwSvelDCbw33CqaV
         9xqA==
X-Gm-Message-State: AOAM531Z5n7Hz8XcKOOGyOSgnA930gH9nKfZKkgtdBCDYgCK+aT9eCL+
        rf/bxZi0iamQjhOs9H6o6Tk=
X-Google-Smtp-Source: ABdhPJwhNMUBztqMiwVN2dsHTKcnRqmy0krtxuBSeWUp12lS8QvKT8v3RWhDINdyEFQAoIOqfiiMEw==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr14316449ejk.290.1631556711826;
        Mon, 13 Sep 2021 11:11:51 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:11:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 10/18] staging: r8188eu: remove the helpers of rtw_write_port()
Date:   Mon, 13 Sep 2021 20:09:54 +0200
Message-Id: <20210913181002.16651-11-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

v3->v4:
        Split a patch into fourteen.
v2->v3:
        No changes.
v1->v2:
        No changes.

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

