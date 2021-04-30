Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91C36FD22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhD3PAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhD3O7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD66C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id di13so726563edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=GJgYujNyvAjqxVDaGaulEgggkMlrt0qZEGY3YCRo/fezcmYyHOrb7ew0N5zG9YHals
         LRy6NGbtufaSGpEn/HpewqUehl9iXQtnOMH4dm7UmaSAIhIL33ZAEG40IDLSOrxGuLd0
         8rkae7KgOL2Gm2XT1hQLAQvmP/1xicmvO3AyEDFxMYRtxmTONVWOTvdzKP2YJy0rRUyk
         0DJc2P4Qlr9nlFbHxnNkC9RpUwHbUCDHoBkFhuKg2+OVm3K3yN2NnYY8T78F6JNGuLPA
         FlDlvDHrPXc/PiOMo5N4gKAOuz9XrEPqhmkg8yl7gGRh5b7XmjHMf2YgIkSRs2ffbY+L
         nlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=nPZmm+Wi/yPYLEn81ns0K3kC3EaJ910fTWNzGT6ddswjI00Gu6fMlSaaRYXu3GMyJX
         ELvce/cFz1dKAImvXmwGIFKXdPnvuoKa5RnfyyiurdJTJHE+oOFWxfPcZSHEEFHfz/lp
         PZfoLvuci7HnqF5N9ZeMj0/+27fb7AXMgHC+fuYsycP5pCh8jQBIIHxiPGiA3PHH3dtf
         2cNaDE2khzKVIV2eX7eJ81p1naASsVAO8Y7IWSgaXdfhy8sz+/X7b3rqIiSmVM2EGi4T
         ZFQRI8/31DCT6V7GnwaoEZMHHBIy7dc7NeSiJm+1O89ukN0vqcFHx+ytuWh5HsATn6mW
         36Bw==
X-Gm-Message-State: AOAM5310T62+sTKr3V0wF0BvLPATN+FDhgOF4d1wWpiDduuVi3H937Rc
        KEEMpxd2tyko6te3BFDvsIssFunU0TQ=
X-Google-Smtp-Source: ABdhPJxr7WxKZBHZsQymBJGCirOcSkAsSw4/7gvUQ2J2YvGO1Pj/WhKbNONNY0h1911gclCdljHOEA==
X-Received: by 2002:aa7:c412:: with SMTP id j18mr6509432edq.163.1619794690504;
        Fri, 30 Apr 2021 07:58:10 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id v4sm2278385ejj.84.2021.04.30.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 39/43] staging: rtl8723bs: remove ODM_InitDebugSetting() function
Date:   Fri, 30 Apr 2021 16:57:01 +0200
Message-Id: <6a8524b780674d05f33977eb86878d95c7338a1a.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove ODM_InitDebugSetting() function. It was
intended to initialize removed private debug
system. So remove it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c       |  2 --
 drivers/staging/rtl8723bs/hal/odm_debug.c | 35 -----------------------
 drivers/staging/rtl8723bs/hal/odm_debug.h |  2 --
 3 files changed, 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index fcd3f97e7df5..45e4038530c0 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -290,8 +290,6 @@ static void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm)
 	pDM_Odm->bCckHighPower = (bool) PHY_QueryBBReg(pDM_Odm->Adapter, ODM_REG(CCK_RPT_FORMAT, pDM_Odm), ODM_BIT(CCK_RPT_FORMAT, pDM_Odm));
 	pDM_Odm->RFPathRxEnable = (u8) PHY_QueryBBReg(pDM_Odm->Adapter, ODM_REG(BB_RX_PATH, pDM_Odm), ODM_BIT(BB_RX_PATH, pDM_Odm));
 
-	ODM_InitDebugSetting(pDM_Odm);
-
 	pDM_Odm->TxRate = 0xFF;
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.c b/drivers/staging/rtl8723bs/hal/odm_debug.c
index b35451bcb437..1a2e367bb306 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.c
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.c
@@ -7,38 +7,3 @@
 
 #include "odm_precomp.h"
 
-void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm)
-{
-	pDM_Odm->DebugLevel = ODM_DBG_LOUD;
-
-	pDM_Odm->DebugComponents =
-/* BB Functions */
-/* 		ODM_COMP_DIG					| */
-/* 		ODM_COMP_RA_MASK				| */
-/* 		ODM_COMP_DYNAMIC_TXPWR		| */
-/* 		ODM_COMP_FA_CNT				| */
-/* 		ODM_COMP_RSSI_MONITOR			| */
-/* 		ODM_COMP_CCK_PD				| */
-/* 		ODM_COMP_ANT_DIV				| */
-/* 		ODM_COMP_PWR_SAVE				| */
-/* 		ODM_COMP_PWR_TRAIN			| */
-/* 		ODM_COMP_RATE_ADAPTIVE		| */
-/* 		ODM_COMP_PATH_DIV				| */
-/* 		ODM_COMP_DYNAMIC_PRICCA		| */
-/* 		ODM_COMP_RXHP					| */
-/* 		ODM_COMP_MP					| */
-/* 		ODM_COMP_CFO_TRACKING		| */
-
-/* MAC Functions */
-/* 		ODM_COMP_EDCA_TURBO			| */
-/* 		ODM_COMP_EARLY_MODE			| */
-/* RF Functions */
-/* 		ODM_COMP_TX_PWR_TRACK		| */
-/* 		ODM_COMP_RX_GAIN_TRACK		| */
-/* 		ODM_COMP_CALIBRATION			| */
-/* Common */
-/* 		ODM_COMP_COMMON				| */
-/* 		ODM_COMP_INIT					| */
-/* 		ODM_COMP_PSD					| */
-0;
-}
diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index c7c7865dd7e2..94011343f7e7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -85,6 +85,4 @@
 #define ODM_COMP_COMMON				BIT30
 #define ODM_COMP_INIT				BIT31
 
-void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

