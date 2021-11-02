Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF636443493
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhKBRdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:33:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAEDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 10:30:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x66so20160049pfx.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=xS8kpc+xRiwOGSFAyUf/L9Jmpay7a8DV5EtWJms3sD0=;
        b=gPwXVMCjxt0pnTZ2FivA+2m9i2jVVT+U5apy7WFgwvHnadXHuu/gf3bw7TrQ2V0JKC
         YpZt/c6gNL9pbpMy7MgXyAxIlCSmYZ6z52IWeSq1pfWiblscg/lENRXV6EFChJQ6gWUX
         eZCW0l8gLdYj7bkmjS1wYdc31xixgKk0xtDvAx7vg8Fa1kejUtocDQZRcwLAHlZYjNx4
         dQLBwUmWeo+teCuInFqVkUwSbrjIPPrAJGaR2cjOhGCgpCCRaPHOTms3qgavq8XmssxI
         DWENSkPSPF5LoYv9YXoFrxbgItgp7Hgoc7FHukm7OjPXr5mGdyJxuRZNeJ66Y30L5pZg
         WNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=xS8kpc+xRiwOGSFAyUf/L9Jmpay7a8DV5EtWJms3sD0=;
        b=iHD91xXPFUJDxoLQfd9g+4K2YUB+JFYOlviEvAcTv/y3fUFnqYwzuE8nThhD5/Jzcj
         yYUBR5SbySG/lEldfYLpJv8IkhqPwqcqFEgOXFbWP3zmED/KOqcS1Q8NZ6rKR9fFm681
         XP8G1bh/WIWKYkdUAfjC+VMv8r7p+JbiR8HXLPP1PwuWw6M8rGP3JTLWm2Lhxh38iyyt
         R4GpIRYc7yyZmCxiilYdoqQsl1rJ3Nx2lsGrxM+jPWV0nphEx2DRyICiN2OI2nRvYNvi
         WGFkJiUiLkqM2oKk+8zWIuSwlZ8ZeVQ4hi6SGj0nKTohsNbVrpKpgROz3Ibpkm338ohW
         18Ag==
X-Gm-Message-State: AOAM530EW2zYgYdgJROYm7gktSPpngkU0RbQHFtAIEFukC/TRZsT4Y5F
        9UWzzLeSXKjC5Me8oi8ZKMM=
X-Google-Smtp-Source: ABdhPJzC7uysNTuDxYYp61g6ZXzJnw2xOgZqigqzEaZ01xhIdq/fMovxeMBD8d14is29IuUeVTQQ2Q==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr28703237pgn.90.1635874245215;
        Tue, 02 Nov 2021 10:30:45 -0700 (PDT)
Received: from surfacebook2-fedora.. (36-233-20-55.dynamic-ip.hinet.net. [36.233.20.55])
        by smtp.gmail.com with ESMTPSA id ng5sm3353480pjb.51.2021.11.02.10.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:30:44 -0700 (PDT)
Message-ID: <618175c4.1c69fb81.bff5d.9cb8@mx.google.com>
X-Google-Original-Message-ID: <20211102173017.8890-1-Hoshinomori-Owari>
From:   hoshinomorimorimo@gmail.com
X-Google-Original-From: Hoshinomori-Owari
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Fix the style problem
Date:   Wed,  3 Nov 2021 01:30:17 +0800
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>

Fix block comment at
rtw_io.c:8:
rtw_io.c:139:
rtw_io.c:154:

Remove not useful filename at
rtw_io.c:9:

Add a blank line after declarations
rtw_io.c:147:

Issue found by checkpatch.pl

Signed-off-by: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c | 56 +++++++++++++------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 4d3c30ec93b5..6c46c6e295d5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -4,26 +4,27 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-/*
-
-The purpose of rtw_io.c
-
-a. provides the API
-
-b. provides the protocol engine
-
-c. provides the software interface between caller and the hardware interface
-
 
-Compiler Flag Option:
-
-1. CONFIG_SDIO_HCI:
-    a. USE_SYNC_IRP:  Only sync operations are provided.
-    b. USE_ASYNC_IRP:Both sync/async operations are provided.
-
-jackson@realtek.com.tw
-
-*/
+/*
+ *
+ *Purpose:
+ *
+ *	a. provides the API
+ *
+ *	b. provides the protocol engine
+ *
+ *	c. provides the software interface between caller and the hardware interface
+ *
+ *
+ *Compiler Flag Option:
+ *
+ *1. CONFIG_SDIO_HCI:
+ *	a. USE_SYNC_IRP:  Only sync operations are provided.
+ *	b. USE_ASYNC_IRP:Both sync/async operations are provided.
+ *
+ *jackson@realtek.com.tw
+ *
+ */
 
 #include <drv_types.h>
 #include <rtw_debug.h>
@@ -135,24 +136,25 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
 	return _SUCCESS;
 }
 
-/*
-* Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
-* @return true:
-* @return false:
-*/
+/**
+ * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
+ * @return true:
+ * @return false:
+ */
 int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 {
 	int ret = false;
 	int value = atomic_inc_return(&dvobj->continual_io_error);
+
 	if (value > MAX_CONTINUAL_IO_ERR)
 		ret = true;
 
 	return ret;
 }
 
-/*
-* Set the continual_io_error of this @param dvobjprive to 0
-*/
+/**
+ * Set the continual_io_error of this @param dvobjprive to 0
+ */
 void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
 {
 	atomic_set(&dvobj->continual_io_error, 0);
-- 
2.31.1

