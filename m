Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E0442938
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhKBIVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhKBIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:21:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88483C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:19:04 -0700 (PDT)
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mhp0W-0007h9-9I; Tue, 02 Nov 2021 09:19:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: remove ODM_Read4Byte
Date:   Tue,  2 Nov 2021 09:18:30 +0100
Message-Id: <20211102081833.18054-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211102081833.18054-1-martin@kaiser.cx>
References: <20211102081833.18054-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ODM_Read4Byte wrapper and call rtw_read32 directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c | 8 ++++----
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       | 5 ++---
 drivers/staging/r8188eu/hal/odm_interface.c        | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h    | 2 --
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 2d351f831289..c9feb8f095fa 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -316,19 +316,19 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0000000d;
 		break;
 	case 12:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR0);
+		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR0);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 13:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR1);
+		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR1);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 14:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR2);
+		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR2);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 15:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR3);
+		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR3);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 6a7e2d60dfbf..0057c3626bb2 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -601,12 +601,11 @@ static void _PHY_SaveMACRegisters(
 	)
 {
 	u32 i;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
 	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
 		MACBackup[i] = rtw_read8(adapt, MACReg[i]);
 
-	MACBackup[i] = ODM_Read4Byte(dm_odm, MACReg[i]);
+	MACBackup[i] = rtw_read32(adapt, MACReg[i]);
 }
 
 static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index e44e24c2a86e..948fe0e42235 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read32(Adapter, RegAddr);
-}
-
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 6e9a7d5860d8..a4fa123d239a 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -19,8 +19,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
-
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
 
 void ODM_Write2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 Data);
-- 
2.20.1

