Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED6336F6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhD3Hrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhD3HqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:46:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD9C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so25139456eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=Z4HM8QEXpablahlFozU8Ss2Byp+B/490xzlYGyHZY2uYrFWqYplzlf1WQ2we6i8iNT
         VvwsWyXXRGlplA8j/3cOM+gQnBoMZfsqkeF3QTGlDHaxU8PFHTCupTfmDyRB+LT3X2bB
         +cchwsroNcrPZZ7W67RHO82hS76FWgKXON1EUaLJX6fqkuAcKh4BgqWwbX13gbGD+xX7
         NtF+i7FuEX9WC6WAPs1FLN/pziKAs7T22ZKiiM2kkTPcCgH4lpqMYEOY++KmCwKlFIAb
         jR2R9v+EJapaceh0wpdXo5UJ4U4LGUnr2onYf2xxBdhxBr9kRcm0SPgkGyYyXAA9Pbvs
         gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=sGIWEOQ3egFg29UkdrwM2H60IRutQf8M8Zf67x7jNY/vPvvbWggU9UjxMhr8YN/EUN
         u6LKbw4Xt9+ZVWfEZz0GbVfmCeX1oFEO/9Zim5HARCyajHi1I0blEepRGX+1xRi2J+c2
         fxpdhZOQ40bJx+Yzhsa04os2e4Zoq9SnmrxK2mrGNbAu0SVNE7lH3Z4SvZ1CN42NBhTW
         U5rF0iAYKsgGMYjBmXXnnLHv+tqpdJvG3EbSWS5sOb281ciO/aDioqDD9cLPGZi+0wyw
         NY0JfJDdhVnR5dt1R/RH3ap0blBb3oc56MKgARvsEfdDjzeJounjspj++bL8Q9ez9s8u
         cLEA==
X-Gm-Message-State: AOAM53316d1OEH6C8j4ASBNq2K2K8YuCAwONe37h1t/xfQF7WUHsnRfe
        h/wR2lAYQQzuX+i9AbkMjdCraSzs71Iabg==
X-Google-Smtp-Source: ABdhPJwMq9TsG8yG6pKIz/rjDCEFFdJ5u3OpwBwF+0g3ahXuPz9rDwZSa6jRPe4yI2hWjhB/edeKyA==
X-Received: by 2002:a17:906:4d50:: with SMTP id b16mr2795575ejv.53.1619768713922;
        Fri, 30 Apr 2021 00:45:13 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id dv22sm1434714ejb.111.2021.04.30.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 41/43] staging: rtl8723bs: remove member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 09:43:59 +0200
Message-Id: <4842aa70acc63e9b7ae017f971eec4b7f15b10cb.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DebugComponent in dm_odm_t struct,
remove private debug component tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 10 ----------
 drivers/staging/rtl8723bs/hal/odm.c     |  4 ----
 drivers/staging/rtl8723bs/hal/odm.h     |  1 -
 3 files changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e82f59fc5e9b..8d1a18b5f914 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1093,13 +1093,6 @@ u8 SetHalDefVar(
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
-	case HW_DEF_FA_CNT_DUMP:
-		/* ODM_COMP_COMMON */
-		if (*((u8 *)value))
-			odm->DebugComponents |= (ODM_COMP_DIG | ODM_COMP_FA_CNT);
-		else
-			odm->DebugComponents &= ~(ODM_COMP_DIG | ODM_COMP_FA_CNT);
-		break;
 	case HAL_DEF_DBG_RX_INFO_DUMP:
 
 		if (odm->bLinked) {
@@ -1183,9 +1176,6 @@ u8 GetHalDefVar(
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
 		break;
-	case HW_DEF_ODM_DBG_FLAG:
-		*((u64 *)value) = odm->DebugComponents;
-		break;
 	case HW_DEF_ODM_DBG_LEVEL:
 		*((u32 *)value) = odm->DebugLevel;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 45e4038530c0..b867629a577b 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1172,10 +1172,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_DBG_COMP:
-		pDM_Odm->DebugComponents = Value;
-		break;
-
 	case ODM_CMNINFO_DBG_LEVEL:
 		pDM_Odm->DebugLevel = (u32)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index ba723ed7aa96..6b9865f5f283 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -709,7 +709,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	enum phy_reg_pg_type PhyRegPgValueType;
 	u8 PhyRegPgVersion;
 
-	u64	DebugComponents;
 	u32 DebugLevel;
 
 	u32 NumQryPhyStatusAll;	/* CCK + OFDM */
-- 
2.20.1

