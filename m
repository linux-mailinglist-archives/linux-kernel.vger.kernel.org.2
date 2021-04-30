Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324A736F6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhD3Hrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhD3Hp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1CC061345
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n25so9412737edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=KQnMN/lQAUtrvUFNqVpjEMZe+tbTxrOyjozrUSeXVC0y4YQ5DgT4jRFMMvq798QgoZ
         AWYktPYYfyApR/AKTMBvxggADHLhu8FG2PgYJHSEnjde8sX5x+7dxJBIUKpaUxpSOQ5s
         IWgLSks2+/vyB3Ho9BXX0r6WP1pZFLhiKteqbHWHNm9pL7XqU3m4HKMGLrJNmUqpFNqw
         y9GVJfmVPAWaFtXn5Y0t0SAa85QnO6kzEg97deHGzf491qSadMy0ych4m+RqtmNjujdz
         C2+yyN2bw61uYOoi4MMHgQWKOn08R7TcMl+Ks0TBb9RShz9AvfLIIkisePtgQiL4Y4KI
         wE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl769BdnSt1skLLR67Pc8JYCPc0C5/Mlxx5Ssv8fz88=;
        b=tVPbs6BEjjOuKEKWm6o88ZuSLxKLJSag3z8vXW5uFVl3ZzKxyUcnAz4MC2lTOZ7IpF
         704JUje/7CnppNffO35wjSwnrad9N1fRz7eRPGKPA8KOdyaxxLWTGfFZGJpU5Y7B27w3
         3DTj/gNn8qXAAACXBhTUzuyeWD3yG1hDPjdEXlBomEbWawoYwYUUWPudK4Tmgzl61Kn6
         w3iBOfdHLtiGTPsj8gALaYj0aACit/ZafkFUFTcUKQZyy0lsT/McjNKQt2BMsvhRmS/7
         XzI1231JX8ASuy423NMnxehZD2Lst8mnFYBgXewVQw9pDoFDgvNG/me+VeLFQl+0HId+
         JEQQ==
X-Gm-Message-State: AOAM532SuaO9on7jToeiRu91NZbeKWVp6ZFVviVm9DShRxsYmMcYsETy
        qJQmk0M+iqLP5TfbLjnOCDh29kdMpHypyw==
X-Google-Smtp-Source: ABdhPJxztVMd9cfMgqwns4fbdR6q4D5eAt4sVTSxHWl6FnnvuyFU/XPh1kmvpNRpDrufPWtvUBj3mA==
X-Received: by 2002:a50:fc91:: with SMTP id f17mr4140318edq.23.1619768710227;
        Fri, 30 Apr 2021 00:45:10 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id b9sm666295edt.2.2021.04.30.00.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:09 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 39/43] staging: rtl8723bs: remove ODM_InitDebugSetting() function
Date:   Fri, 30 Apr 2021 09:43:57 +0200
Message-Id: <8495b9075594003c0909f66175c2b103f438daee.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

