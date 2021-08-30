Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4D3FB311
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhH3JW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhH3JW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:22:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D23BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b6so21391499wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDSyMU18eK06kQB1zIMw5DxjSTM6wD98jjjnY9/TjuU=;
        b=hUrDBLSSYfb9cUCi50cv9oIl+RpSX/fyS1CT9atILBOhrn5Q+sg8MI20264LC4C9Gs
         xXfSER9CP3OKEvYzrUuFZltnFTo2MLIQDhoXsLI/W1LNr2Q+yQsVAz8riNbXQNJIsSx7
         L0XpyK7VRFs8fW/gIXzdfbdjLIRFSVGPkXFxZJMko4aO2W2cSvxiZZOcrm3pnIdmtE1q
         tXH7z59E4xJ8H4F+gHvMUOGgnYG9GaYFLGrWnRVJE5YoC8cYMKG5bTKpMHKA1YV9qqJb
         /Bj3EMMm2LTIxaToFzE8m18UszmbRjjlUNfldBSw4ynkTir7NoPSbRs9kyrN5EmxRyDP
         L92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDSyMU18eK06kQB1zIMw5DxjSTM6wD98jjjnY9/TjuU=;
        b=k2ZJdBWI0nZn2c6BPAan3yiTFWMM/NBdTpYzoZix7Hzd1nPCkpC3mydlVp/fpIQIUZ
         h0NIwkyawZOxKzVMniHQ1Nl2d2lF/eZYZmpwa+aMFmQmk/dOmwHMdBQECUL9517m3N21
         b5Z2QvTKneHPflNcY80wBTMWOm521CiAyPlTz3Qrn2LE9b6ETma9L9+2pZHjzYUdCl2V
         oXPsWZmipt3x3GKAXdPJ9+Fz41P+LdV+/ofPTFua01+OaJtwfGVOhbbYCX+7kRBBBf+L
         Tt/MQno0t+X5HaAzzmzo+3JTa+30RglidFT9+kBxsSl3vJTaHrwT4TXWI4RVeFQzTZmT
         su1A==
X-Gm-Message-State: AOAM532IrwW7WZ2PJbjU+lvbbsUywHtvNkxYtjByCCV1G9nelFjTEvkR
        AJwCPMDl4gTUoYhW6UpapSE=
X-Google-Smtp-Source: ABdhPJxxIPEf9ioMekTO4WgpmGRMHAbRbjx0v2Yn6SBWd9wXwdqyozuq3Cf0topiX1KiRVZuZ3dkzQ==
X-Received: by 2002:adf:f743:: with SMTP id z3mr24596638wrp.211.1630315321958;
        Mon, 30 Aug 2021 02:22:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id j1sm18378248wrd.50.2021.08.30.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:22:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove Hal_MPT_CCKTxPowerAdjustbyIndex()
Date:   Mon, 30 Aug 2021 11:21:50 +0200
Message-Id: <20210830092153.9283-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830092153.9283-1-straube.linux@gmail.com>
References: <20210830092153.9283-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IC Type is always 8188E. Therefore, the test
"if (!IS_92C_SERIAL(pHalData->VersionID))" in
Hal_MPT_CCKTxPowerAdjustbyIndex() is always true and the function
does nothing, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_mp.c | 71 -----------------------
 drivers/staging/r8188eu/include/rtw_mp.h  |  1 -
 2 files changed, 72 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index fc13db705511..49c672383e43 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -130,73 +130,6 @@ void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14)
 	write_bbreg(Adapter, rCCK0_TxFilter2, bMaskDWord, TempVal2);
 	write_bbreg(Adapter, rCCK0_DebugPort, bMaskLWord, TempVal3);
 }
-
-void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *pAdapter, bool beven)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
-	struct mpt_context *pMptCtx = &pAdapter->mppriv.MptCtx;
-	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
-	s32		TempCCk;
-	u8		CCK_index, CCK_index_old = 0;
-	u8		Action = 0;	/* 0: no action, 1: even->odd, 2:odd->even */
-	s32		i = 0;
-
-	if (!IS_92C_SERIAL(pHalData->VersionID))
-		return;
-	if (beven && !pMptCtx->bMptIndexEven) {
-		/* odd->even */
-		Action = 2;
-		pMptCtx->bMptIndexEven = true;
-	} else if (!beven && pMptCtx->bMptIndexEven) {
-		/* even->odd */
-		Action = 1;
-		pMptCtx->bMptIndexEven = false;
-	}
-
-	if (Action != 0) {
-		/* Query CCK default setting From 0xa24 */
-		TempCCk = read_bbreg(pAdapter, rCCK0_TxFilter2, bMaskDWord) & bMaskCCK;
-		for (i = 0; i < CCK_TABLE_SIZE; i++) {
-			if (pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
-				if (!memcmp((void *)&TempCCk, (void *)&CCKSwingTable_Ch14[i][2], 4)) {
-					CCK_index_old = (u8)i;
-					break;
-				}
-			} else {
-				if (!memcmp((void *)&TempCCk, (void *)&CCKSwingTable_Ch1_Ch13[i][2], 4)) {
-					CCK_index_old = (u8)i;
-					break;
-				}
-			}
-		}
-
-		if (Action == 1)
-			CCK_index = CCK_index_old - 1;
-		else
-			CCK_index = CCK_index_old + 1;
-
-		/* Adjust CCK according to gain index */
-		if (!pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
-			rtw_write8(pAdapter, 0xa22, CCKSwingTable_Ch1_Ch13[CCK_index][0]);
-			rtw_write8(pAdapter, 0xa23, CCKSwingTable_Ch1_Ch13[CCK_index][1]);
-			rtw_write8(pAdapter, 0xa24, CCKSwingTable_Ch1_Ch13[CCK_index][2]);
-			rtw_write8(pAdapter, 0xa25, CCKSwingTable_Ch1_Ch13[CCK_index][3]);
-			rtw_write8(pAdapter, 0xa26, CCKSwingTable_Ch1_Ch13[CCK_index][4]);
-			rtw_write8(pAdapter, 0xa27, CCKSwingTable_Ch1_Ch13[CCK_index][5]);
-			rtw_write8(pAdapter, 0xa28, CCKSwingTable_Ch1_Ch13[CCK_index][6]);
-			rtw_write8(pAdapter, 0xa29, CCKSwingTable_Ch1_Ch13[CCK_index][7]);
-		} else {
-			rtw_write8(pAdapter, 0xa22, CCKSwingTable_Ch14[CCK_index][0]);
-			rtw_write8(pAdapter, 0xa23, CCKSwingTable_Ch14[CCK_index][1]);
-			rtw_write8(pAdapter, 0xa24, CCKSwingTable_Ch14[CCK_index][2]);
-			rtw_write8(pAdapter, 0xa25, CCKSwingTable_Ch14[CCK_index][3]);
-			rtw_write8(pAdapter, 0xa26, CCKSwingTable_Ch14[CCK_index][4]);
-			rtw_write8(pAdapter, 0xa27, CCKSwingTable_Ch14[CCK_index][5]);
-			rtw_write8(pAdapter, 0xa28, CCKSwingTable_Ch14[CCK_index][6]);
-			rtw_write8(pAdapter, 0xa29, CCKSwingTable_Ch14[CCK_index][7]);
-		}
-	}
-}
 /*---------------------------hal\rtl8192c\MPT_HelperFunc.c---------------------------*/
 
 /*
@@ -311,8 +244,6 @@ void Hal_SetAntennaPathPower(struct adapter *pAdapter)
 	case RF_8256:
 	case RF_6052:
 		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
-		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
-			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath] % 2 == 0);
 		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
 		break;
 	default:
@@ -350,8 +281,6 @@ void Hal_SetTxPower(struct adapter *pAdapter)
 	case RF_8256:
 	case RF_6052:
 		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
-		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
-			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath] % 2 == 0);
 		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index 3a259d991348..b2befe09d944 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -460,7 +460,6 @@ void Hal_GetPowerTracking(struct adapter *padapter, u8 * enable);
 void Hal_GetThermalMeter(struct adapter *pAdapter, u8 *value);
 void Hal_mpt_SwitchRfSetting(struct adapter *pAdapter);
 void Hal_MPT_CCKTxPowerAdjust(struct adapter * Adapter, bool bInCH14);
-void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *pAdapter, bool beven);
 void Hal_SetCCKTxPower(struct adapter *pAdapter, u8 * TxPower);
 void Hal_SetOFDMTxPower(struct adapter *pAdapter, u8 * TxPower);
 void Hal_TriggerRFThermalMeter(struct adapter *pAdapter);
-- 
2.33.0

