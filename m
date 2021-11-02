Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C967E442939
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhKBIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:21:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56971C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:19:05 -0700 (PDT)
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mhp0X-0007h9-7D; Tue, 02 Nov 2021 09:19:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: remove ODM_Write1Byte
Date:   Tue,  2 Nov 2021 09:18:31 +0100
Message-Id: <20211102081833.18054-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211102081833.18054-1-martin@kaiser.cx>
References: <20211102081833.18054-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ODM_Write1Byte wrapper and call rtw_write8 directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 26 +++++++++----------
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  6 -----
 .../staging/r8188eu/include/odm_interface.h   |  2 --
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 0057c3626bb2..cbac5d908d67 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -629,9 +629,9 @@ _PHY_ReloadMACRegisters(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
-		ODM_Write1Byte(dm_odm, MACReg[i], (u8)MACBackup[i]);
-	}
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
+		rtw_write8(adapt, MACReg[i], (u8)MACBackup[i]);
+
 	ODM_Write4Byte(dm_odm, MACReg[i], MACBackup[i]);
 }
 
@@ -668,15 +668,13 @@ _PHY_MACSettingCalibration(
 	)
 {
 	u32 i = 0;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_Write1Byte(dm_odm, MACReg[i], 0x3F);
+	rtw_write8(adapt, MACReg[i], 0x3F);
 
-	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++) {
-		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i] & (~BIT(3))));
-	}
-	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i] & (~BIT(5))));
+	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++)
+		rtw_write8(adapt, MACReg[i], (u8)(MACBackup[i] & (~BIT(3))));
+
+	rtw_write8(adapt, MACReg[i], (u8)(MACBackup[i] & (~BIT(5))));
 }
 
 void
@@ -940,9 +938,9 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	tmpreg = rtw_read8(adapt, 0xd03);
 
 	if ((tmpreg & 0x70) != 0)			/* Deal with contisuous TX case */
-		ODM_Write1Byte(dm_odm, 0xd03, tmpreg & 0x8F);	/* disable all continuous TX */
+		rtw_write8(adapt, 0xd03, tmpreg & 0x8F);	/* disable all continuous TX */
 	else							/*  Deal with Packet TX case */
-		ODM_Write1Byte(dm_odm, REG_TXPAUSE, 0xFF);			/*  block all queues */
+		rtw_write8(adapt, REG_TXPAUSE, 0xFF);		/*  block all queues */
 
 	if ((tmpreg & 0x70) != 0) {
 		/* 1. Read original RF mode */
@@ -974,7 +972,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	if ((tmpreg & 0x70) != 0) {
 		/* Deal with continuous TX case */
 		/* Path-A */
-		ODM_Write1Byte(dm_odm, 0xd03, tmpreg);
+		rtw_write8(adapt, 0xd03, tmpreg);
 		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
 
 		/* Path-B */
@@ -982,7 +980,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
 	} else {
 		/*  Deal with Packet TX case */
-		ODM_Write1Byte(dm_odm, REG_TXPAUSE, 0x00);
+		rtw_write8(adapt, REG_TXPAUSE, 0x00);
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 21f115194df8..2b82b0912013 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -584,7 +584,7 @@ void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurCCK_CCAThres != CurCCK_CCAThres)		/* modify by Guo.Mingzhi 2012-01-03 */
-		ODM_Write1Byte(pDM_Odm, ODM_REG_CCK_CCA_11N, CurCCK_CCAThres);
+		rtw_write8(pDM_Odm->Adapter, ODM_REG_CCK_CCA_11N, CurCCK_CCAThres);
 	pDM_DigTable->PreCCK_CCAThres = pDM_DigTable->CurCCK_CCAThres;
 	pDM_DigTable->CurCCK_CCAThres = CurCCK_CCAThres;
 }
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 5f6f0ae5196e..f75086d7c569 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -36,7 +36,7 @@ void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data
 
 void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
 {
-	ODM_Write1Byte(pDM_Odm, Addr, Data);
+	rtw_write8(pDM_Odm->Adapter, Addr, Data);
 }
 
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 948fe0e42235..6cd239210b68 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	rtw_write8(Adapter, RegAddr, Data);
-}
-
 void ODM_Write2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index a4fa123d239a..f8a76ebbdfa6 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -19,8 +19,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
-
 void ODM_Write2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 Data);
 
 void ODM_Write4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 Data);
-- 
2.20.1

