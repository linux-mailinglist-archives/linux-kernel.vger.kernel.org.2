Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AD3DC1EE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhGaAYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhGaAYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so13357325wrv.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhLBbamIIso3q24OfMYMwdZiHoUKSwGiscpw73oDofo=;
        b=yVbGjU+fYDd6O8o+HsXyXq9Sst7+20ZXf7fiWAKpkkPGuciSJejoecc7qOvp/ztSN7
         1a38IRCxAAhViL33/qyyJ118shYbVXx5/gGMPp2L5RBslgg0kEe0CPewAPelrgQAHAhV
         SgX67UBwMB8yMvgoXi7G5/NyUhhzNdu3+3L66WNqaHTFsJu77KKgNiO8hIgmO6BebsIZ
         qbovsVNsdaGZ+olRQoXuDPNOA/RlX0DR6DB47DjYT1/nezt3JdJf0C8KyYtmktX/kQRU
         xuSibiZ2ppPvHYPriTfhcQ+oIG72/F44QPmGzVZUbqV549byu6k4CjJsZSbk47/8MP9E
         X3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhLBbamIIso3q24OfMYMwdZiHoUKSwGiscpw73oDofo=;
        b=iEyTeO1r9imKJp+GBRrhVWj2sZgfB11l+//NzFIVwFGywwK0piGCm76zhPiq7+649B
         ITS4ma4IQKhRxuMKLQSpxktmqbohrbcLKGFbZe6azfwvzaH+Jl/hcXNAWiEkkMdeQV2P
         tQ1CEnt5hRrq6XIuvqO/pGmdAFoOPNMdMQkg/X88TVkkm/WGfu79AE5W+d3PanuGgOvh
         LhyUY+1mNsApj1Vvu2GutxFwwaihWFCq+zWwQa9s/wSfzukXwBsCq5Ap30JunY1uDXJx
         11+mPQkaPRhhFQRZmUhwqLeBBOSwkIrbqTL7KC/aEGQmykv9P31veD/oyGQxknWNULoM
         XjWw==
X-Gm-Message-State: AOAM533n4w7UmueQ6052Ki4p5MiFIEXJxXGUHK5cqJ6hJqLkysSjirSr
        ZwBg5OtTHGiCDmVHBS3wvLn8ug==
X-Google-Smtp-Source: ABdhPJwsCT9tlsrKN5/AKcyGG1tYnavl7X72B4syyN+T+neFQaIR57sqwZUCZbnQavxLOalLHwvB6w==
X-Received: by 2002:adf:ed50:: with SMTP id u16mr5768867wro.174.1627691042088;
        Fri, 30 Jul 2021 17:24:02 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:24:01 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RTL8188E.c
Date:   Sat, 31 Jul 2021 01:23:48 +0100
Message-Id: <20210731002353.68479-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
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

