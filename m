Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73F440C582
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhIOMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhIOMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:45:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt8so5774982ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zDbV/uKcczVbZMRuBNAgynLRQJTh3fUO/7zgmWU9yo=;
        b=KNJdgpieSwFHrTsbGP13NsBjyIW2ktyAQIGjzFz5ntLZUK4baRqSgPOg/0IZvhuOCf
         THU1Lvt1dolu+9di8SXwRvP231KVYtDqujKE6VSL9CUjiEO6kUKuCqCa1dT5JW285DdB
         TabgZbyf22LDXQbevtiSqztQYpWa3hm/KpK6n3J22mDp63s45+BkmSzqw1muDdPW5GIF
         8DtSxe5jN2nesApRMkErVLcwj8KQM2zzG0mriTToJSTPYp801GqOVqD1RPsR4iJrjhfc
         TISarGWWvvQGhecsUomSt6zeGy0eVYPbM9E7ae7jFoTjtuU2FxZHA/4XFwbrDD/BiztD
         VLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zDbV/uKcczVbZMRuBNAgynLRQJTh3fUO/7zgmWU9yo=;
        b=w2J7wJdiUKC0lbMztQ1RcC1LaMWKWQYHOy3eKfuteSQAMLUnxLJ9bXr09jXMnXBxWE
         MYziMRMZWf4mhxoVhmXdP4pHzfFHuLb736dQHLFykLKqkkw0Jeg3GljaTd2HYRwgs9kp
         lfw3VlNEFIZ6gXArX8bEVSrWatmRTYvbVKlE22qA4t9rMiJoszrra5TxFr1ZMEVDgiCx
         UtTdz9ubvyRqt8n/fpWU1RrctgkjxBS/dOqdYIm8p2AdQi8S47LbxCrQKoJSWBW+x5KL
         vIzH9QgOZM8VTwze7qJI/VYlUr4SIxXZYwRaM9idzp6tixfTYNwQeOgvRxe1t8ljLbNP
         CyKg==
X-Gm-Message-State: AOAM531s3PhnOKU4ZXhTzLMHJerVclGTWVg4ZZRo19u32oAqwz7B+chx
        lbcL+03WCplxzCYu3fQ88Ffa3NhigOM=
X-Google-Smtp-Source: ABdhPJzQP9SyqrAul0V9TiPBwj8Y+nmU835zhPMNNmrId96HZht/8PlapWZj2a2+iiFMGATNG2XS3w==
X-Received: by 2002:a17:906:31d7:: with SMTP id f23mr24222976ejf.190.1631709853764;
        Wed, 15 Sep 2021 05:44:13 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:44:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 12/19] staging: r8188eu: remove the helpers of usb_write_port_cancel()
Date:   Wed, 15 Sep 2021 14:41:42 +0200
Message-Id: <20210915124149.27543-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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

