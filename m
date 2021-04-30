Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23CE36F687
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhD3HpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhD3HpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CADC061342
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y7so4960362ejj.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+yrfynC+yLmvEikp4y3xNtT3nwDVrsgYVC2eYbSqLM=;
        b=pcKCovuRG8yKYg+og2ATNK3QQoeAKKaoqHKyqWjVZO6XvXQwW+/32kLTxS2qBzdSZh
         Y0i8iGh9xATwKIGNhoBl38qMfV7cqXATOeXrhQUNb8GUd0kjYDABtRhrnJAnbEdOs44g
         3dKIMn9yd8wKLoM+1/khRaPdnnICg9Mqm3feOv5mEIZHq3wf/Dc5cCBZivfcwVvcMXxx
         Fhn6R6BSxFmJ8j1DZ9cFlYwNG/LjJl/kZ9yJUTFyWs8nJokdbsYDhkSb1sr32uh0ejIa
         X1aNYgv8TsMPIutsZc8ktWCV/QZ+uRpaha6dG8cCJKXZXOaYIRpXGWrvNlSJk2n2uuEA
         cF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+yrfynC+yLmvEikp4y3xNtT3nwDVrsgYVC2eYbSqLM=;
        b=N2gVBrA3BmH3mqsnfAKZC539qcf+0ujimPCKvD+xiitwINicZ72K6sUeqss+racrpv
         5ZmlDeHKzyRoKCyF17iBWpC6nIeD3QbhhiHyNksYYFP0dQrhqNkan4LZzhvm67Rv77Um
         ia1gnj7XIj08FgZb8a5J8acZI9AKvbQcbiD7dYxNpAcClpmis/XOGbhh4DK03xssfAyf
         egjMzm7e68JRno4rZ9RqTZvjMFKc9BuWkbQOo88jvC+DFUjO8YuProK/+eCcViKoC2r6
         2sGMEVRjHY/YoptjJ/peydBDmjVBzpuoOpsTRwG15SXqDgCY+7SnSov3FP9FcEYOdKBF
         AlaA==
X-Gm-Message-State: AOAM530Q3w+7yTvcfOy77UsWM7EG+bHdHULC5mwaISdcyc9RwXeg8xZi
        ES/dugbG1P1DqeOjZ9Zhc3TKJqRATp60Sw==
X-Google-Smtp-Source: ABdhPJxxUGrCjIbp9Kb3vbNcbh/SdHOB/pQRwh1pCejPrHgJpU6rQPfdxVcYes0aPfTjzgmIISo9yw==
X-Received: by 2002:a17:906:b853:: with SMTP id ga19mr2789155ejb.386.1619768658136;
        Fri, 30 Apr 2021 00:44:18 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id bu8sm672152edb.77.2021.04.30.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/43] staging: rtl8723bs: remove all commented out ODM_RT_TRACE logs
Date:   Fri, 30 Apr 2021 09:43:26 +0200
Message-Id: <c615f15a01bd3e3407d62443e40dd70e905189de.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all commented out ODM_RT_TRACE logs.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 32 -------------------
 drivers/staging/rtl8723bs/hal/odm.c           |  3 --
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |  1 -
 3 files changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 858aafc24931..c42fd36c88ef 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -421,7 +421,6 @@ static u8 phy_PathA_IQK_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord, 0x01007c00);
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK, bMaskDWord, 0x01004800);
 	/* path-A IQK setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A IQK setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK_Tone_A, bMaskDWord, 0x18008c1c);
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_Tone_A, bMaskDWord, 0x38008c1c);
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK_Tone_B, bMaskDWord, 0x38008c1c);
@@ -433,7 +432,6 @@ static u8 phy_PathA_IQK_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
 
 	/* enter IQK mode */
@@ -451,12 +449,10 @@ static u8 phy_PathA_IQK_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path A LOK & IQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_8723B)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_8723B*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
@@ -505,8 +501,6 @@ static u8 phy_PathA_RxIQK8723B(
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK!\n")); */
-
 	/*  Save RF Path */
 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord);
 
@@ -514,7 +508,6 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n")); */
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
@@ -540,7 +533,6 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
 	/* enter IQK mode */
@@ -558,12 +550,10 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path A LOK & IQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_8723B)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_8723B*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
@@ -601,7 +591,6 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord, u4tmp);
 
 	/* modify RXIQK mode table */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table 2!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
@@ -631,7 +620,6 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x0046a8d1);
 
 	/* enter IQK mode */
@@ -649,12 +637,10 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path A LOK & IQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_8723B*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
@@ -723,7 +709,6 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord, 0x01007c00);
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK, bMaskDWord, 0x01004800);
 	/* path-A IQK setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-B IQK setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK_Tone_A, bMaskDWord, 0x18008c1c);
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_Tone_A, bMaskDWord, 0x38008c1c);
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK_Tone_B, bMaskDWord, 0x38008c1c);
@@ -736,7 +721,6 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
 
 	/* enter IQK mode */
@@ -750,12 +734,10 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path B LOK & IQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path B LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path B LOK & IQK.\n", IQK_DELAY_TIME_88E)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
@@ -767,9 +749,6 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
     /* leave IQK mode */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0x948 = 0x%x\n", PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord))); */
-
-
 	/*  Check failed */
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regE94 = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord);
@@ -801,8 +780,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B Rx IQK!\n")); */
-
 	/*  Save RF Path */
 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord);
     /* leave IQK mode */
@@ -811,7 +788,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
 	/* modify RXIQK mode table */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n")); */
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
@@ -839,7 +815,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
     /* enter IQK mode */
@@ -853,13 +828,11 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path B TXIQK @ RXIQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path B LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
@@ -878,10 +851,8 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 
 	/* Allen 20131125 */
 	tmp = (regE9C & 0x03FF0000)>>16;
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("tmp1 = 0x%x\n", tmp)); */
 	if ((tmp & 0x200) > 0)
 		tmp = 0x400 - tmp;
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("tmp2 = 0x%x\n", tmp)); */
 
 	if (
 		!(regEAC & BIT28) &&
@@ -931,7 +902,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_PI_B, bMaskDWord, 0x28110000);
 
 	/* LO calibration setting */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Rsp, bMaskDWord, 0x0046a8d1);
 
     /* enter IQK mode */
@@ -945,12 +915,10 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
 
 	/* One shot, path B LOK & IQK */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path B LOK & IQK!\n")); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	PHY_SetBBReg(pDM_Odm->Adapter, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-/* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E)); */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
 	mdelay(IQK_DELAY_TIME_8723B);
 
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 73068a1681a9..0027ce211619 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -600,11 +600,8 @@ static void FindMinimumRSSI(struct adapter *padapter)
 		(pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0)
 	) {
 		pdmpriv->MinUndecoratedPWDBForDM = 0;
-		/* ODM_RT_TRACE(pDM_Odm, COMP_BB_POWERSAVING, DBG_LOUD, ("Not connected to any\n")); */
 	} else
 		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
-
-	/* ODM_RT_TRACE(pDM_Odm, COMP_DIG, DBG_LOUD, ("MinUndecoratedPWDBForDM =%d\n", pHalData->MinUndecoratedPWDBForDM)); */
 }
 
 static void odm_RSSIMonitorCheckCE(struct dm_odm_t *pDM_Odm)
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index c7010015b334..db703a3b1b25 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -186,7 +186,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		/* RT_DISP(FRX, RX_PHY_SS, ("PWDB_ALL =%d\n", PWDB_ALL)); */
 
 		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
-		/* ODM_RT_TRACE(pDM_Odm, ODM_COMP_RSSI_MONITOR, ODM_DBG_LOUD, ("ODM OFDM RSSI =%d\n", pPhyInfo->rx_pwd_ba11)); */
 		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL_BT;
 		pPhyInfo->rx_power = rx_pwr_all;
 		pPhyInfo->recv_signal_power = rx_pwr_all;
-- 
2.20.1

