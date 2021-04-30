Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44E36FCD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhD3OrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhD3Oqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4106C061345
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so105608167ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=qIkVfSSdzDS3GY8KG2rH4Fw4Q6wpI8r7lCRxDFoCL6jWiVFxJGKswDSEdz974XF4xS
         lzZp46k2UFffTdNlNb0gXcXsCNbOASHMkZzFVmA0HTMrZL+lpvNibgver6ym5w1KsDEj
         nb8EXNqND/SbAUa20bbEo6oNzy4iDnOz/MJ8fDePcVhoRRxBJDvR83WuTa4nUspkXgz0
         RgCplG4ioODyg9B8l4qbaq0aaOijOxZmfSlu0xtJyePeZh2H/uuHPpnpsrl6fX6zsyD+
         GFTDFx1w+6ojIr46Zq608S4Q9ovk69r3qlvp0ei3T5jk3qxYd6QIJENdham78Rhu6vkh
         /RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=l7Ul7SheofUO0zZjhc0LUK951vU80UBn0QgMQqgm1KG+Ngdl8BqmzI8TugGoTuZYsf
         RuQz9FjTk1DjHd0M7xmeQiuGKsh2ZOIACOz0xB8Sa0X+O4adKWqvA4qpUBSl5sTRCIZ5
         32kYTul34nCe6tuLi1TpELaM6eqtVvW6EnjJo5XyPaestLYVJHplFEQyB4xSn6t+8ilk
         CufC8i0LXAbW2xJlEKSQqzqpQS7GQZr7WBzhlqyF7HAh9GJ9nqAIsKusCFUJDQS6L+25
         00QwMdrt26syMNnHaIPeyQ3UEbZP/p7RogRcpfiKwX5I78qhuwGEUQ61Lb6Eb03J8CuD
         i1vg==
X-Gm-Message-State: AOAM530ov6xX4otLtlHxj63l6HxxAMGnw2GYn2b3ALuraGj3ON1iK0Cm
        KYXHtiF+fVsXauns1S2qTETXNUbqKnY=
X-Google-Smtp-Source: ABdhPJxPKNSM9ysHUZ32g0kLAlB6SiyzPwkkxloyBF7RmiwBujTrw26hqNjgDXVGoZVpRVpoAFutAg==
X-Received: by 2002:a17:906:a06:: with SMTP id w6mr4836565ejf.32.1619793915563;
        Fri, 30 Apr 2021 07:45:15 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id gt35sm1980576ejc.57.2021.04.30.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/43] staging: rtl8723bs: remove member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 16:44:11 +0200
Message-Id: <6f5a08eec8d7b2c8c7b20af97664ecbeb0591c9e.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

