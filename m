Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0E43026E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbhJPLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244348AbhJPLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64080C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:42 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhte-00046d-54; Sat, 16 Oct 2021 13:30:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/8] staging: r8188eu: PHY_SetRFPathSwitch_8188E is not used
Date:   Sat, 16 Oct 2021 13:30:05 +0200
Message-Id: <20211016113008.27549-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the PHY_SetRFPathSwitch_8188E function which is not used.

It was the only caller of phy_setrfpathswitch_8188e, that function
can be removed as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 38 -------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  3 --
 2 files changed, 41 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index f01ee3cd8795..79f407c280be 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -1189,41 +1189,3 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 		phy_LCCalibrate_8188E(adapt, false);
 	}
 }
-
-static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2t)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-
-	if (!adapt->hw_init_completed) {
-		u8 u1btmp;
-		u1btmp = ODM_Read1Byte(dm_odm, REG_LEDCFG2) | BIT(7);
-		ODM_Write1Byte(dm_odm, REG_LEDCFG2, u1btmp);
-		ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
-	}
-
-	if (is2t) {	/* 92C */
-		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5) | BIT(6), 0x1);	/* 92C_Path_A */
-		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5) | BIT(6), 0x2);	/* BT */
-	} else {			/* 88C */
-		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8) | BIT(9), 0x2);	/* Main */
-		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8) | BIT(9), 0x1);	/* Aux */
-	}
-}
-
-void PHY_SetRFPathSwitch_8188E(struct adapter *adapt, bool main)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-
-	if (dm_odm->RFType == ODM_2T2R) {
-		phy_setrfpathswitch_8188e(adapt, main, true);
-	} else {
-		/*  For 88C 1T1R */
-		phy_setrfpathswitch_8188e(adapt, main, false);
-	}
-}
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 084bccc5dcb9..feae0b32cac6 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -195,9 +195,6 @@ void PHY_SetBWMode8188E(struct adapter *adapter,
 /*  channel switch related funciton */
 void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
 
-/*  BB/MAC/RF other monitor API */
-void PHY_SetRFPathSwitch_8188E(struct adapter *adapter,	bool main);
-
 void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
 				 u32 mask, u32 data);
 /*--------------------------Exported Function prototype---------------------*/
-- 
2.20.1

