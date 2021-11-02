Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51D442935
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKBIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:21:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:19:03 -0700 (PDT)
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mhp0V-0007h9-4B; Tue, 02 Nov 2021 09:18:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: remove ODM_Read1Byte
Date:   Tue,  2 Nov 2021 09:18:29 +0100
Message-Id: <20211102081833.18054-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211102081833.18054-1-martin@kaiser.cx>
References: <20211102081833.18054-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a wrapper that calls rtw_read8. Remove the wrapper and
call rtw_read8 directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c    | 8 ++++----
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 60d4ba275196..6a7e2d60dfbf 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -603,9 +603,9 @@ static void _PHY_SaveMACRegisters(
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
-		MACBackup[i] = ODM_Read1Byte(dm_odm, MACReg[i]);
-	}
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
+		MACBackup[i] = rtw_read8(adapt, MACReg[i]);
+
 	MACBackup[i] = ODM_Read4Byte(dm_odm, MACReg[i]);
 }
 
@@ -938,7 +938,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* Check continuous TX and Packet TX */
-	tmpreg = ODM_Read1Byte(dm_odm, 0xd03);
+	tmpreg = rtw_read8(adapt, 0xd03);
 
 	if ((tmpreg & 0x70) != 0)			/* Deal with contisuous TX case */
 		ODM_Write1Byte(dm_odm, 0xd03, tmpreg & 0x8F);	/* disable all continuous TX */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 7ddba39a0f4b..e44e24c2a86e 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read8(Adapter, RegAddr);
-}
-
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 17a315d19a50..6e9a7d5860d8 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -19,8 +19,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
-
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
 
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
-- 
2.20.1

