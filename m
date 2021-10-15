Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3097A42F856
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhJOQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbhJOQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A8C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so27311408wrd.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=megC4K92vDEP0q7uSIzXOLfeRzgx84LBgrmcKglZkqM=;
        b=WZKBfr35FkGbA8gTfrta42E2B6B4korGTJhCh48vS7CUOclzAcOu/Rt20jWoLiZRDn
         Z0NDg7T0pCUJVG5kqt2stE19qOIhfggoPKgYmex+h10f1n+S/Qja7V234gcRyMQVwC+G
         p/jKo0qKd/OwuKvNk7fRLE+R3vbQiXKYhmW5ScLMzQmR5TD8UhFb8ElBQ9hSUdAo8Mm6
         ZPFFbRe57qyTH6N60tpUNj/PpAFFeWVG/RKKItfo7N6ZuNj+01JB+cTUcctLkyhjVySD
         nSVg/WogO7JBeFqSqxFXkLzG6Efew2y4RedeQ7/wVy5LwFfXTOlsrxGioOak5XVNAf/x
         5STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=megC4K92vDEP0q7uSIzXOLfeRzgx84LBgrmcKglZkqM=;
        b=1xePzIWq9GnFDhBtyG6YCq7STP+cr/GcH/Y/iYfiuisRs9aZyI5AGB8lqODxzeCmKZ
         77U6A9BPF2bCmz1YXJUid7ZW/TG45iNFZg8yU88j+xW/GrUkjrr5tKB1i9B1FaQUyy0s
         T6UCCyYNIzaDAY49g8vsxk2LnM49oSIUvkvXP/FIwjtXUORrtze3HX9BBXPBuJ+5pREn
         g+jYwqGbLjbhPcnI7dHYSLDMCNL4zvjyoqZu5/NDRN67rG9n3t80CzflCX/61iBi79Gp
         9IGBebXcWjPMcprhQ3qy+FiE3azdC89/6yy7nWAiOsCtPlrl0MdAD5Ysmq7z8fBMOgXq
         m74w==
X-Gm-Message-State: AOAM532ZrC4xZChwBQS9MbCNuRUPxXBLtELNXVBH575c0QxAjEg+eGj2
        W9dDXZlyNw3C5dYcO4R2ctQkWbwRn5E=
X-Google-Smtp-Source: ABdhPJwzXqNx3nbM67b2OK/b9PkKEJXTbb9jUlYkb/75GJEpPdGNT8zZBhmbFNWQxpWEFZxi/eIx7g==
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr16170194wrv.268.1634315720367;
        Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()
Date:   Fri, 15 Oct 2021 18:35:07 +0200
Message-Id: <20211015163507.9091-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ODM_CmnInfoPtrArrayHook() there is only the case
ODM_CMNINFO_STA_STATUS and the function is called only with this value.
Remove ODM_CmnInfoPtrArrayHook() and fix the three places where it is
called.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 15 ---------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c       |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  5 +++--
 drivers/staging/r8188eu/include/odm.h           | 10 ----------
 4 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index a2cbe727f6e0..0987ff3e382a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -292,21 +292,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	}
 }
 
-void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, u16 Index, void *pValue)
-{
-	/*  Hook call by reference pointer. */
-	switch	(CmnInfo) {
-	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_STA_STATUS:
-		pDM_Odm->pODM_StaInfo[Index] = (struct sta_info *)pValue;
-		break;
-	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
-	default:
-		/* do nothing */
-		break;
-	}
-}
-
 /*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 1ca24a507d6d..f1a1015eedfb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -90,7 +90,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
 	for (i = 0; i < NUM_STA; i++)
-		ODM_CmnInfoPtrArrayHook(dm_odm, ODM_CMNINFO_STA_STATUS, i, NULL);
+		dm_odm->pODM_StaInfo[i] = NULL;
 }
 
 void rtl8188e_InitHalDm(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index dd8d6b4a9d48..8c00f2dd67da 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1671,13 +1671,14 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 	case HAL_ODM_STA_INFO:
 		{
 			struct sta_info *psta = (struct sta_info *)pValue1;
+
 			if (bSet) {
 				DBG_88E("### Set STA_(%d) info\n", psta->mac_id);
-				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, psta);
+				podmpriv->pODM_StaInfo[psta->mac_id] = psta;
 				ODM_RAInfo_Init(podmpriv, psta->mac_id);
 			} else {
 				DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
-				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
+				podmpriv->pODM_StaInfo[psta->mac_id] = NULL;
 		       }
 		}
 		break;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 6cbf64df9be7..841603b341bd 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -305,12 +305,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_BT_BUSY,			/* Check Bt is using or not */
 	ODM_CMNINFO_BT_DISABLE_EDCA,
 /* CALL BY VALUE-------------*/
-
-	/*  Dynamic ptr array hook itms. */
-	ODM_CMNINFO_STA_STATUS,
-	ODM_CMNINFO_PHY_STATUS,
-	ODM_CMNINFO_MAC_STATUS,
-	ODM_CMNINFO_MAX,
 };
 
 /*  2011/10/20 MH Define ODM support ability.  ODM_CMNINFO_ABILITY */
@@ -882,10 +876,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
 void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm,
 		     enum odm_common_info_def CmnInfo, void *pValue);
 
-void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm,
-			     enum odm_common_info_def CmnInfo,
-			     u16 Index, void *pValue);
-
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
 #endif
-- 
2.33.0

