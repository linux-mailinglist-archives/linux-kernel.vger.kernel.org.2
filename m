Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9789F36FD25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhD3PAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhD3O72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CB5C061346
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f24so7146685ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=MxohnjtG4Zit/GrLrEHFDEM30Ex/Y29dnnNb6kclsj47wQVh7406niOegbn/m9s5Fx
         M4bd51RPknWNqmnFTKBgeIFttqGpxJM1qUUe1H8Hc04dZ2wkWpoJLhUOjeJlNxokwZbC
         dEoJEFVV+x2uG8MyL8RXRJ2fbx/PUWqvLFhz5+alg+o5P+5tUTFxhDIhG8g4BqOB/453
         GHqmwD0q+kdfcs0CU8QWLYEpmRwGF11oV1DcXOxoPW+Qtp3yD2cTFovny3quGAtPkEFD
         4eFXctnkVdUullwFoz2zQplEReWxRevEAUlf6L4DU6M7IFY33YPsEl0JE7mZlnFH8I/i
         T8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=c4Sl6b/r0syG5ciAvoKoWEM9uf1hiSfbn/L8FNMYBL6eAtRUDnZKsz15OYw2dRnzla
         p2oqT9t8cusxH3hmuFV00h9+vIxWgQmmfagwC2F/lDAA9yVdLn911DyzHTnx0AgokvPP
         g1TIeDdLTymuy6Ql4DYxf+cHUU7pEwPYTM4qIXYAy6qvb7/RuSoUsWjkyN7dUhUdasQg
         D0csHw50cf/wSxL0xKsuHgnwNCMgYN+XxaSFrULVJ7EbhPGXfdzsO169s2JptdL34pSr
         L8Lc8IFbAoWNF7nO6d9gso2tNV4FP1UYh0M8Bs3i4McHp67fI14IvNr5DG1tRHNcqCrA
         szZg==
X-Gm-Message-State: AOAM531KpyUMPcEQXGFrkoIPhHG7O8zhn4az0upWp65Zb64awGNbUakk
        5iaHCIV/925TG3h1BXgi6GymlYzXZ6k=
X-Google-Smtp-Source: ABdhPJxjGJ+Cca5lrtlEYXQLOBZWEVo/PjN4r1xsZLkefMs/OfhcBqgjJ36e1XF8a95Mupf7xlBJ+g==
X-Received: by 2002:a17:906:1e44:: with SMTP id i4mr4826580ejj.61.1619794695142;
        Fri, 30 Apr 2021 07:58:15 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id mp36sm2014260ejc.48.2021.04.30.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 42/43] staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 16:57:04 +0200
Message-Id: <ac4afb00f904511e0cbb23136f8e7a3e204ad7ed.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DebugLevel in dm_odm_t struct,
remove private debug level tracing.

remove unused variable as well to suppress compiler warning.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 4 ----
 drivers/staging/rtl8723bs/hal/odm.c     | 3 ---
 drivers/staging/rtl8723bs/hal/odm.h     | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 8d1a18b5f914..5eb3bd45a959 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1159,7 +1159,6 @@ u8 GetHalDefVar(
 )
 {
 	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &(hal_data->odmpriv);
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
@@ -1176,9 +1175,6 @@ u8 GetHalDefVar(
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
 		break;
-	case HW_DEF_ODM_DBG_LEVEL:
-		*((u32 *)value) = odm->DebugLevel;
-		break;
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)value) = hal_data->odmpriv.SupportAbility;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index b867629a577b..fa275138c983 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1172,9 +1172,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_DBG_LEVEL:
-		pDM_Odm->DebugLevel = (u32)Value;
-		break;
 	case ODM_CMNINFO_RA_THRESHOLD_HIGH:
 		pDM_Odm->RateAdaptive.HighRSSIThresh = (u8)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 6b9865f5f283..950e7850bac2 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -709,8 +709,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	enum phy_reg_pg_type PhyRegPgValueType;
 	u8 PhyRegPgVersion;
 
-	u32 DebugLevel;
-
 	u32 NumQryPhyStatusAll;	/* CCK + OFDM */
 	u32 LastNumQryPhyStatusAll;
 	u32 RxPWDBAve;
-- 
2.20.1

