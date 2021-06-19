Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06E3AD9A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhFSKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhFSKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67778C061760
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so7029648wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a1RBDBYhuIJn1PW20GeA3uF2Znuq27Dnh+SWYloe64=;
        b=gL9u/pC2C+ekMuEHOtCYMZrzJbRnXoL75L6sL2DTufabWEwFHqKr7kOtaSwIirwtPw
         rI/clqY9CSuZsSR8+ObnTEa7KGGWqBr1L2o2SlyuG7gNvTgKdiTP1JaNwuBolcSSh/wQ
         SyfJmQd/Y13Gxa3ahUMh2jio+FHQtel4R2XJM2BZo/Ti9Hg/uKQm2j/RMi3/eldJcUdx
         U9f6GDNZuJ7Ea5G9mPEEjCZ1k3uZ/dh09aaekHrWn6TAjJYQbrMJvoRd+nSk+54S3BXk
         DI/TLoNWX0LbmfY1EiTakO5/49v/R9AZ91vdUW7CNeaQ55ZJffOuPP6oRhPZyZoyNI2e
         eOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a1RBDBYhuIJn1PW20GeA3uF2Znuq27Dnh+SWYloe64=;
        b=Cc17xJcRGlYyXhnggsjd54mC0h2441MKaTamwaASdK0Lac3o7EDR3O8ldpp2Bkw7nR
         EMJ2kPk/+xDpRVkkpwL7sBtBXrpxLJQ+ZXffYB9uv/tYWg6Ap7KH+VcmcueqqBLm0UjX
         tDjZVllPKTnGyuBZgzWRNOM2thpZsS0BDXzqA77/mmp5Vqs5/zuKvPhSBbXaUCohcCUm
         cjQbUWzQumFcIhwAml/iifokHdOnVdcnLgxyMIK4gct8AmaX9tX+2C9sc3RWtf9WMuGv
         OJmZkT+GP4iWE2wkc7CVGmiZ7DS34cOKMG159+PoXks6DJFRwQJHKd2hW+130kdt5CLt
         zGhA==
X-Gm-Message-State: AOAM530zAcfCDPK7AbLueYfIIcuU+LKM1TZB8U4fpPxvMcVMpBZsp/FL
        4rNkshZWFjX+J8mxA7+V328GEGUTiUtsYg==
X-Google-Smtp-Source: ABdhPJwgG8PPq6uVldQV7Ho5Vok1ADd+mpOx1+YcTuT6f6go64kMSqwSOVs5LhgjMkUEwnJZjXhBBA==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr16139123wmh.115.1624099656909;
        Sat, 19 Jun 2021 03:47:36 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id b11sm11567560wrf.43.2021.06.19.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] staging: rtl8723bs: remove some unused 5Ghz macro definitions
Date:   Sat, 19 Jun 2021 12:47:13 +0200
Message-Id: <e7a067fe3c22b8843ec2252b41a429c9d52f38f2.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove some unused 5Ghz macro definitions. Fix
comments accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h                | 1 -
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h | 2 --
 drivers/staging/rtl8723bs/include/hal_com_reg.h    | 1 -
 drivers/staging/rtl8723bs/include/hal_pg.h         | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 788fc1c068b5..afb36de7a4e5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -628,7 +628,6 @@ struct fat_t { /* _FAST_ANTENNA_TRAINNING_ */
 	u32 MinMaxRSSI;
 	u8 idx_AntDiv_counter_2G;
 	u8 idx_AntDiv_counter_5G;
-	u32 AntDiv_2G_5G;
 	u32 CCK_counter_main;
 	u32 CCK_counter_aux;
 	u32 OFDM_counter_main;
diff --git a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
index 4b3a7c051630..aad962548278 100644
--- a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
+++ b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
@@ -558,7 +558,6 @@
 
 #define		b3WireRFPowerDown			0x1	/*  Useless now */
 /* define bHWSISelect				0x8 */
-#define		b5GPAPEPolarity				0x40000000
 #define		b2GPAPEPolarity				0x80000000
 #define		bRFSW_TxDefaultAnt			0x3
 #define		bRFSW_TxOptionAnt			0x30
@@ -577,7 +576,6 @@
 #define		bRFSI_ANTSW				0x100
 #define		bRFSI_ANTSWB				0x200
 #define		bRFSI_PAPE					0x400
-#define		bRFSI_PAPE5G				0x800
 #define		bBandSelect					0x1
 #define		bHTSIG2_GI					0x80
 #define		bHTSIG2_Smoothing			0x01
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index b14585cb0233..b2f179b48019 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -717,7 +717,6 @@ Default: 00b.
 /*        BW_OPMODE bits				(Offset 0x603, 8bit) */
 /*  */
 #define BW_OPMODE_20MHZ			BIT2
-#define BW_OPMODE_5G				BIT1
 
 /*  */
 /*        CAM Config Setting (offset 0x680, 1 byte) */
diff --git a/drivers/staging/rtl8723bs/include/hal_pg.h b/drivers/staging/rtl8723bs/include/hal_pg.h
index 0b7a8adf5c74..2d8ccc9ddebb 100644
--- a/drivers/staging/rtl8723bs/include/hal_pg.h
+++ b/drivers/staging/rtl8723bs/include/hal_pg.h
@@ -16,10 +16,8 @@
 
 /*  For VHT series TX power by rate table. */
 /*  VHT TX power by rate off setArray = */
-/*  Band:-2G&5G = 0 / 1 */
 /*  RF: at most 4*4 = ABCD = 0/1/2/3 */
 /*  CCK = 0 OFDM = 1/2 HT-MCS 0-15 =3/4/56 VHT =7/8/9/10/11 */
-#define TX_PWR_BY_RATE_NUM_BAND			2
 #define TX_PWR_BY_RATE_NUM_RF			4
 #define TX_PWR_BY_RATE_NUM_RATE			84
 #define MAX_RF_PATH_NUM				2
-- 
2.20.1

