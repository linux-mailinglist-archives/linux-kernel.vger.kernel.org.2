Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC736FCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhD3OrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhD3Oq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA48C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a4so12288502ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=MCOl1y6XKihFqC1Za6SZpekw6tlQiT/6t0szArrpl9UzxqOok7LMiUFDvM6suEP/Lj
         nnbRB3F92xUdwMrJejobkgRUY6WJSXisQQazCgIXua7BtrNnKtcu1nwrFdEcyHl4uLXA
         vDSfO0DJgEIxjuQlpMBdpAyA9yP0+AuYIj5PFiXD37yxTqoIDTVRKh3YgnxV4ku4ciS/
         o3P3tiymLPLr2X8aMv/qDk2J+LH+pCDdcC/69wqrbkvA3BxGjQcsFpgjyJ7KbzCc8/4u
         FzVUzpED6cShbyeLImCUKNGb4eTALX8H/zActBqqvM/YWxfyW0sj9IP5Ise2wx4BfjTK
         gFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=DVdmdIp7n8UQtuPo7GuM9z/vEOqANmfsVcrH4hhGQ+eONwwV0g9olm9yp2mCzIo/xA
         Gh9LrP7psOJrvYRY6jdEVQTXCoec8u1Yo3/EiRVNiMmS+bbDw4cofSjp4FDmzLqoNf+U
         lQi2D32dC/ARr83l2HtqsRW8SHpNLA4v6B5VGTQlPYIzeowgev1z8RjfCADrf+FJhd2p
         rEJ7D3JoC/9M26/ly9EJ4XKK19BzTS82hMO7cDHGZoBySEm5gkNYfkd3A5+kJciplAPX
         Yj49ymd5gsB1C11oCLwzgX5yK/UE+fs1AZ1AWmnJbtwvipB/33AMrH0edu17auNfdNGP
         60+A==
X-Gm-Message-State: AOAM531m7/y63eHS/zIBlTp/TsE+PXxtNLG9gJo8479Np9HSL/pk8W0M
        EYTkQzAUhAd3eHxdTiqFfArsFHmEF+Y=
X-Google-Smtp-Source: ABdhPJxZuhJak/d5WrPLNiNZAsTp/P3BBN/Ut7MbbPEUQZMONfb2Skh/erGgG144/Kr2mroSy5U66A==
X-Received: by 2002:a17:907:2cc1:: with SMTP id hg1mr4882646ejc.453.1619793912609;
        Fri, 30 Apr 2021 07:45:12 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id z26sm2056671ejd.52.2021.04.30.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/43] staging: rtl8723bs: remove ODM_InitDebugSetting() function
Date:   Fri, 30 Apr 2021 16:44:09 +0200
Message-Id: <297fb4815ccdf3c9c68214b66dc85f78b9eedca9.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

