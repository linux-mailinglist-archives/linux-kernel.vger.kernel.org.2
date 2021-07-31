Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD83DC20E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhGaAkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhGaAjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70475C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so2554176wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhLBbamIIso3q24OfMYMwdZiHoUKSwGiscpw73oDofo=;
        b=19xH6pOtcRRwtZmE7NCtXRvC2pCTnqOnwIPYw8n9qKcIlBRCyPku5Vn4h0zX8yYZpy
         CbG5KRhYk2Zt8pE75JjAGkEOwsSwgVcQKQ4QlhBvldGcELdenOaR3ls8hta37UHn/EEw
         LeVjoM81wUkljKnW1OaGc33WaPXXI2ji8m1ZekKebbm0X7NTt+ZhljY/IG5L5CaZm1FA
         K1ojqkPAarY/0aLMS1FzISmORShimBHuV8ahjErnVGYvXFGmqu6NARQSjvN3jZVO/L7l
         ZbCYebIybMe0WvTRiQcPtWnQAUPiK/2k/dv/6OL5Lhk9dq6q2gLOy6ylYE7o+1FD4sJh
         l37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhLBbamIIso3q24OfMYMwdZiHoUKSwGiscpw73oDofo=;
        b=THV4h+WdkJKgXsMd/L7MgViyFZM9THKcKjRHvl8pufY3L04cSuORGjUfrR2rEuYHiL
         yDtrZkaDhQB6idf6c7eK51VZ84LUY/Qd70yY1vYZDaQ+RfnH7QefTc4jQmrqFYSyTYNw
         i0mF++u+Bm8Y9QKb46DZPYfK0IMqLXd3S6LL3LT7dR+MuLmvMNPl/7VA58WjgUjBKK3H
         8WWSHeUQ7Oq7fF343Nj05urRWEzc8gToyWJLNed4xdNg+5WEI1kEHe8YQz4HcjPKkd3I
         zVFHx0SNfF2/TlqSbA0Umtim59CPeJCcjzC1m4Lx5BB957NfV4k+pgg+2YHEZVuaMOle
         Mb3g==
X-Gm-Message-State: AOAM530wctSs6KaSS93FcU5zCCINnlLDaywkNjuQO3hQvHnUP8ET/O08
        qwhrNeOYBbAW7K2IYROpiVH/Lg==
X-Google-Smtp-Source: ABdhPJzfhUsdL2o+z7O4eD1nInZQLc4n7SpviBXD171uxnC/wnqx5THMMqgKWC1qSlyQt7IFJUtjrQ==
X-Received: by 2002:adf:de06:: with SMTP id b6mr5773117wrm.316.1627691986013;
        Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:45 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14 resent] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RTL8188E.c
Date:   Sat, 31 Jul 2021 01:39:32 +0100
Message-Id: <20210731003937.68615-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/odm_RTL8188E.c, as by removing these
calls in this file and others, we can ultimately then remove the macro
definition itself, which does not follow best practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 38 ++--------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index baa9c1c977c7..62219a908097 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -7,11 +7,8 @@ void ODM_DIG_LowerBound_88E(struct odm_dm_struct *dm_odm)
 {
 	struct rtw_dig *pDM_DigTable = &dm_odm->DM_DigTable;
 
-	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
+	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
 		pDM_DigTable->rx_gain_range_min = (u8) pDM_DigTable->AntDiv_RSSI_max;
-		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-			     ("ODM_DIG_LowerBound_88E(): pDM_DigTable->AntDiv_RSSI_max=%d\n", pDM_DigTable->AntDiv_RSSI_max));
-	}
 	/* If only one Entry connected */
 }
 
@@ -25,7 +22,6 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 		ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);  /*  1:CG, 0:CS */
 		return;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_RX_HWAntDivInit()\n"));
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
@@ -54,7 +50,6 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, 0); /* Default RX   (0/1) */
 		return;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_TRX_HWAntDivInit()\n"));
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
@@ -88,12 +83,8 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 	u32	AntCombination = 2;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_FastAntTrainingInit()\n"));
-
-	if (*(dm_odm->mp_mode) == 1) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("dm_odm->AntDivType: %d\n", dm_odm->AntDivType));
+	if (*(dm_odm->mp_mode) == 1)
 		return;
-	}
 
 	for (i = 0; i < 6; i++) {
 		dm_fat_tbl->Bssid[i] = 0;
@@ -167,9 +158,6 @@ void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
 	if (dm_odm->SupportICType != ODM_RTL8188E)
 		return;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("dm_odm->AntDivType=%d\n", dm_odm->AntDivType));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("dm_odm->bIsMPChip=%s\n", (dm_odm->bIsMPChip ? "true" : "false")));
-
 	if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)
 		odm_RX_HWAntDivInit(dm_odm);
 	else if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
@@ -184,7 +172,6 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 	u32	DefaultAnt, OptionalAnt;
 
 	if (dm_fat_tbl->RxIdleAnt != Ant) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Update Rx Idle Ant\n"));
 		if (Ant == MAIN_ANT) {
 			DefaultAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
 			OptionalAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
@@ -204,7 +191,6 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 		}
 	}
 	dm_fat_tbl->RxIdleAnt = Ant;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("RxIdleAnt=%s\n", (Ant == MAIN_ANT) ? "MAIN_ANT" : "AUX_ANT"));
 	if (Ant != MAIN_ANT)
 		pr_info("RxIdleAnt=AUX_ANT\n");
 }
@@ -221,13 +207,6 @@ static void odm_UpdateTxAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant, u32 MacId)
 	dm_fat_tbl->antsel_a[MacId] = TargetAnt&BIT0;
 	dm_fat_tbl->antsel_b[MacId] = (TargetAnt&BIT1)>>1;
 	dm_fat_tbl->antsel_c[MacId] = (TargetAnt&BIT2)>>2;
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-		     ("Tx from TxInfo, TargetAnt=%s\n",
-		     (Ant == MAIN_ANT) ? "MAIN_ANT" : "AUX_ANT"));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-		     ("antsel_tr_mux=3'b%d%d%d\n",
-		     dm_fat_tbl->antsel_c[MacId], dm_fat_tbl->antsel_b[MacId], dm_fat_tbl->antsel_a[MacId]));
 }
 
 void ODM_SetTxAntByTxInfo_88E(struct odm_dm_struct *dm_odm, u8 *pDesc, u8 macId)
@@ -279,16 +258,6 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i]/dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-				     ("MacID=%d, MainAnt_Sum=%d, MainAnt_Cnt=%d\n",
-				     i, dm_fat_tbl->MainAnt_Sum[i],
-				     dm_fat_tbl->MainAnt_Cnt[i]));
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-				     ("MacID=%d, AuxAnt_Sum=%d, AuxAnt_Cnt=%d\n",
-				     i, dm_fat_tbl->AuxAnt_Sum[i], dm_fat_tbl->AuxAnt_Cnt[i]));
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-				     ("MacID=%d, Main_RSSI= %d, Aux_RSSI= %d\n",
-				     i, Main_RSSI, Aux_RSSI));
 			/* 2 Select MaxRSSI for DIG */
 			LocalMaxRSSI = (Main_RSSI > Aux_RSSI) ? Main_RSSI : Aux_RSSI;
 			if ((LocalMaxRSSI > AntDivMaxRSSI) && (LocalMaxRSSI < 40))
@@ -330,9 +299,7 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 	if ((dm_odm->SupportICType != ODM_RTL8188E) || (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV)))
 		return;
 	if (!dm_odm->bLinked) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_AntennaDiversity_88E(): No Link.\n"));
 		if (dm_fat_tbl->bBecomeLinked) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Turn off HW AntDiv\n"));
 			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
 			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 0); /* Enable CCK AntDiv */
 			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
@@ -342,7 +309,6 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 		return;
 	} else {
 		if (!dm_fat_tbl->bBecomeLinked) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Turn on HW AntDiv\n"));
 			/* Because HW AntDiv is disabled before Link, we enable HW AntDiv after link */
 			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
 			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 1); /* Enable CCK AntDiv */
-- 
2.31.1

