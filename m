Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4ED3D04EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGTWSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhGTWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:17:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:58:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f9so93953wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNPEMMUgoiehFtzKXEoJ63hPg6Ju+Bf/SAUPrXK8URU=;
        b=Cs7v4oCkpaQVlNpFvJz/H4CatVDhrRD/txMcHw+Ggu3rnfnZm5ioTVTuzoJr6w3QDD
         34cdVg46l5mADjlN+8D/h/GYDOA7xjt6NtD5/e0aYb3ti5RpIHPDOTmNCo+W97W11Hs9
         NyXArsKruE88y6y8srWfOp4q/hu95q8wMHSuv2xCl2wB658G2SP+mVT6Zp5ziet/U40c
         5DTy9IrQI9lPltIZ5Yi2cEaYmbIl5mS6XxmDW5acgZuk/6rC2+KOq7+ngM9ju/WOmn/5
         9fholoH9jNhQjQlrKK4/ciixttMy7+/hwh5J0gTB4lwYgpb1FuttPFYflvlp4zA/OH3d
         PN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNPEMMUgoiehFtzKXEoJ63hPg6Ju+Bf/SAUPrXK8URU=;
        b=Z87Qw8ju3CfNPqhaPDi9TbL4NDRDLMajZPDyKHR29hw+5IPWdYRXMa5i/RitjQe5dG
         xBMS75IPIT/j0FyFaoWq7iPZZ3MoFb6SZ9R6xJO/MmKU2yv+0Dmf47XYbmX1aJRnFy6l
         sdwyRKL8YGW8uac9Pot/pjVsdWp9zPUcmW8ng5ao377q4ROZbc4REOZ1qoXJtX32loY3
         XHSZwrGBgoHKjW922JIhvLOrvyIddk05XTy9iaZ9qaZDLsirP0GRqOv2FAcN2t0DKuiQ
         B7vZzvV1QqCmqRxcCnhMYFvGWiIWbqIMPISZVVrMwpVb4xJ9bSuCFNQSPGtGsu5AN0Ot
         B+Yw==
X-Gm-Message-State: AOAM531ue3rvC+6Qw7GA7I0GjDOJFvfH2Hy41RI9wWcuhmQNe1gTM9S8
        l1R8aPg49gaqgQyIJPGKQx0lkw==
X-Google-Smtp-Source: ABdhPJwWaA4jL2qnQ/MSpRxdH5K35wL4UQ4HDISUQ873rKnIipmE5PgkAA77m1UIfcQXYgPWX4+FQQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr38647106wrv.190.1626821907738;
        Tue, 20 Jul 2021 15:58:27 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id t15sm24354653wrx.17.2021.07.20.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:58:27 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8188eu: move hal/mac_cfg.c and rename function and array
Date:   Tue, 20 Jul 2021 23:58:26 +0100
Message-Id: <20210720225826.454516-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move source file hal/mac_cfg.c to the 'core' driver directory, and also
rename its array from array_MAC_REG_8188E to array_MAC_REG, as well as
renaming the function rtl88eu_phy_mac_config to phy_mac_config. Also
modify single call-site for this function to reflect new name.

This file contains no code which touches the adapter's HalData structure,
and is a good candidate for therefore moving out of 'hal'. Also, no
need for these signatures to include the model number as this driver
only supports RTL8188eu.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/Makefile                | 2 +-
 drivers/staging/rtl8188eu/{hal => core}/mac_cfg.c | 8 ++++----
 drivers/staging/rtl8188eu/hal/usb_halinit.c       | 2 +-
 drivers/staging/rtl8188eu/include/phy.h           | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/staging/rtl8188eu/{hal => core}/mac_cfg.c (93%)

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index 28b936e8be0a..2799ec5a7fda 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 r8188eu-y :=				\
+		core/mac_cfg.o		\
 		core/rtw_ap.o		\
 		core/rtw_cmd.o		\
 		core/rtw_efuse.o	\
@@ -18,7 +19,6 @@ r8188eu-y :=				\
 		core/rtw_wlan_util.o	\
 		core/rtw_xmit.o		\
 		hal/fw.o	\
-		hal/mac_cfg.o \
 		hal/bb_cfg.o \
 		hal/rf_cfg.o \
 		hal/pwrseqcmd.o \
diff --git a/drivers/staging/rtl8188eu/hal/mac_cfg.c b/drivers/staging/rtl8188eu/core/mac_cfg.c
similarity index 93%
rename from drivers/staging/rtl8188eu/hal/mac_cfg.c
rename to drivers/staging/rtl8188eu/core/mac_cfg.c
index 370aa5cc55a7..a94c6ad472c5 100644
--- a/drivers/staging/rtl8188eu/hal/mac_cfg.c
+++ b/drivers/staging/rtl8188eu/core/mac_cfg.c
@@ -10,7 +10,7 @@
 
 /* MAC_REG.TXT */
 
-static u32 array_MAC_REG_8188E[] = {
+static u32 array_MAC_REG[] = {
 		0x026, 0x00000041,
 		0x027, 0x00000035,
 		0x428, 0x0000000A,
@@ -103,14 +103,14 @@ static u32 array_MAC_REG_8188E[] = {
 		0x70B, 0x00000087,
 };
 
-bool rtl88eu_phy_mac_config(struct adapter *adapt)
+bool phy_mac_config(struct adapter *adapt)
 {
 	u32 i;
 	u32 arraylength;
 	u32 *ptrarray;
 
-	arraylength = ARRAY_SIZE(array_MAC_REG_8188E);
-	ptrarray = array_MAC_REG_8188E;
+	arraylength = ARRAY_SIZE(array_MAC_REG);
+	ptrarray = array_MAC_REG;
 
 	for (i = 0; i < arraylength; i += 2)
 		usb_write8(adapt, ptrarray[i], (u8)ptrarray[i + 1]);
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 05c67e7d23ad..2a47e9b444d5 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -684,7 +684,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	}
 	rtl8188e_InitializeFirmwareVars(Adapter);
 
-	rtl88eu_phy_mac_config(Adapter);
+	phy_mac_config(Adapter);
 
 	rtl88eu_phy_bb_config(Adapter);
 
diff --git a/drivers/staging/rtl8188eu/include/phy.h b/drivers/staging/rtl8188eu/include/phy.h
index 40901d6dcaf5..8ee13eb68a5a 100644
--- a/drivers/staging/rtl8188eu/include/phy.h
+++ b/drivers/staging/rtl8188eu/include/phy.h
@@ -5,7 +5,7 @@
 #define index_mapping_NUM_88E	    15
 #define AVG_THERMAL_NUM_88E	    4
 
-bool rtl88eu_phy_mac_config(struct adapter *adapt);
+bool phy_mac_config(struct adapter *adapt);
 bool rtl88eu_phy_rf_config(struct adapter *adapt);
 bool rtl88eu_phy_bb_config(struct adapter *adapt);
 
-- 
2.31.1

