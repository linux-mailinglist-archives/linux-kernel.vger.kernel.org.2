Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8E41AFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbhI1NV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbhI1NVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:21:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778DEC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:19:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x20so13350881wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HUcm5UT8JTYv5A4ahE88o0H+HS/K/Ez1md4de9EFkw=;
        b=N9h7vGgYxhTfG/rPL/UUZwjgJlgxCX7aKe58zQiLohkWQ7lAPWCbGbeIRU2VYh+26w
         Oc5xucrs/nXS5SWJwLS89YfUfu7Ddpxb+Fmh4zvgPgFoozNwSXmjmvAdFaVjipmKjl0n
         mWsXiun9+UZyIIASw+LAsdc80S/WC5kALyji3BxY10lSnSSMTljSN9lf0u4wogjQRJUU
         TRVdtwvyIxjFikbFG1xVwixWb/P7dUi66zJSI9NUeZDcJ1GKTL52JeyENPE7cdL2ZswA
         BFJg8PR3oFtow79JQkUkxsRIxT7Z5t3FD0OpHmgav90zRI/rp5J9dzNP8y213mlOYnLE
         4VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HUcm5UT8JTYv5A4ahE88o0H+HS/K/Ez1md4de9EFkw=;
        b=tIeD2X68vQBhkKOIzX0xZSyGgO4dzQm6FWSyiXTJ/arxGml33tYXQB0AnNikJi3YsK
         kdRGVJNz1c6TnnxdpysCzv8NndTjNUCtqkIfPIQCnMQWgwSev+1qk/HXxNx1HEvgh3O/
         HsO40zD0rVo8VkGbSWahJ6WGNiHa+Kzq9xoNgAk9OvzAcGBy7L+q8nmTQbZHbFG+YAET
         5MPuAeej2bZbhj1f2ryFIJ0mfMi+RfjnS27OFRITdI918bJy93ieiLV5ddCa2QviL3IB
         K4f5R/DksU+E2U1C0Zu/PZObDPqOKuXM4QTqO9UyDjj64l7Zn+yeCZ7zZaKyX5u/xhdp
         aAFw==
X-Gm-Message-State: AOAM531DxOZnOxfIFG2EbQ5x5uWopLAMjsLze9bWcK0EcESrU3O9eA/g
        eaZTDTmmeB6Y2oOs5sJzC55FazIUNDM=
X-Google-Smtp-Source: ABdhPJyBXkFf+ZZb89amsGVO7SyPHmvxULxEmwLibAEHQGfF0bWIv7G+AY8FvLknUNigTxKEt0zk2g==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr6264111wri.419.1632835183694;
        Tue, 28 Sep 2021 06:19:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc89])
        by smtp.gmail.com with ESMTPSA id m5sm1727030wms.41.2021.09.28.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:19:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove odm_DynamicBBPowerSaving()
Date:   Tue, 28 Sep 2021 15:19:29 +0200
Message-Id: <20210928131930.8866-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportICType is ODM_RTL8188E in this driver. So function
odm_DynamicBBPowerSaving() does nothing, remove it. It is the only
user of odm_1R_CCA(), remove that function as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 54 -------------------
 drivers/staging/r8188eu/include/odm_precomp.h |  2 -
 2 files changed, 56 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index e0784e38e083..277357111452 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -205,7 +205,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 
 	odm_RefreshRateAdaptiveMask(pDM_Odm);
 
-	odm_DynamicBBPowerSaving(pDM_Odm);
 	if ((pDM_Odm->AntDivType ==  CG_TRX_HW_ANTDIV)	||
 	    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV)	||
 	    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
@@ -859,59 +858,6 @@ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
 	pDM_PSTable->initialize = 0;
 }
 
-void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm)
-{
-	if ((pDM_Odm->SupportICType != ODM_RTL8192C) && (pDM_Odm->SupportICType != ODM_RTL8723A))
-		return;
-	if (!(pDM_Odm->SupportAbility & ODM_BB_PWR_SAVE))
-		return;
-	if (!(pDM_Odm->SupportPlatform & (ODM_MP | ODM_CE)))
-		return;
-
-	/* 1 2.Power Saving for 92C */
-	if ((pDM_Odm->SupportICType == ODM_RTL8192C) && (pDM_Odm->RFType == ODM_2T2R)) {
-		odm_1R_CCA(pDM_Odm);
-	} else {
-	/*  20100628 Joseph: Turn off BB power save for 88CE because it makesthroughput unstable. */
-	/*  20100831 Joseph: Turn ON BB power save again after modifying AGC delay from 900ns ot 600ns. */
-	/* 1 3.Power Saving for 88C */
-		ODM_RF_Saving(pDM_Odm, false);
-	}
-}
-
-void odm_1R_CCA(struct odm_dm_struct *pDM_Odm)
-{
-	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
-
-	if (pDM_Odm->RSSI_Min != 0xFF) {
-		if (pDM_PSTable->pre_cca_state == CCA_2R) {
-			if (pDM_Odm->RSSI_Min >= 35)
-				pDM_PSTable->cur_cca_state = CCA_1R;
-			else
-				pDM_PSTable->cur_cca_state = CCA_2R;
-		} else {
-			if (pDM_Odm->RSSI_Min <= 30)
-				pDM_PSTable->cur_cca_state = CCA_2R;
-			else
-				pDM_PSTable->cur_cca_state = CCA_1R;
-		}
-	} else {
-		pDM_PSTable->cur_cca_state = CCA_MAX;
-	}
-
-	if (pDM_PSTable->pre_cca_state != pDM_PSTable->cur_cca_state) {
-		if (pDM_PSTable->cur_cca_state == CCA_1R) {
-			if (pDM_Odm->RFType == ODM_2T2R)
-				ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x13);
-			else
-				ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x23);
-		} else {
-			ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x33);
-		}
-		pDM_PSTable->pre_cca_state = pDM_PSTable->cur_cca_state;
-	}
-}
-
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 {
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 6b3800894bc6..210275a51994 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -45,14 +45,12 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm);
-void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivChkAntSwitch(struct odm_dm_struct *pDM_Odm, u8 Step);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
-void odm_1R_CCA(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0

