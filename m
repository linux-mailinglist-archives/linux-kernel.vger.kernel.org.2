Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3057A447354
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhKGOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhKGOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:34:27 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69041C061714
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:31:44 -0800 (PST)
Received: from dslb-178-004-202-058.178.004.pools.vodafone-ip.de ([178.4.202.58] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mjjCu-0001Pk-5M; Sun, 07 Nov 2021 15:31:40 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: clean up _PHY_PathADDAOn
Date:   Sun,  7 Nov 2021 15:31:00 +0100
Message-Id: <20211107143100.9047-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107143100.9047-1-martin@kaiser.cx>
References: <20211107143100.9047-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller sets isPathAOn = true and is2t = false. Remove the
parameters and resulting dead code.

Make the function static, it's used only inside HalPhyRf_8188e.c.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 20 +++++--------------
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |  3 ---
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 6b49acab0be8..5c82e5f6cebf 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -596,29 +596,19 @@ _PHY_ReloadMACRegisters(
 	rtw_write32(adapt, MACReg[i], MACBackup[i]);
 }
 
-void
+static void
 _PHY_PathADDAOn(
 		struct adapter *adapt,
-		u32 *ADDAReg,
-		bool isPathAOn,
-		bool is2t
-	)
+		u32 *ADDAReg)
 {
-	u32 pathOn;
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	pathOn = isPathAOn ? 0x04db25a4 : 0x0b1b25a4;
-	if (!is2t) {
-		pathOn = 0x0bdb25a0;
-		ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
-	} else {
-		ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, pathOn);
-	}
+	ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
 
 	for (i = 1; i < IQK_ADDA_REG_NUM; i++)
-		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, pathOn);
+		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, 0x0bdb25a0);
 }
 
 void
@@ -768,7 +758,7 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 		_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 	}
 
-	_PHY_PathADDAOn(adapt, ADDA_REG, true, false);
+	_PHY_PathADDAOn(adapt, ADDA_REG);
 	if (t == 0)
 		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)ODM_GetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, BIT(8));
 
diff --git a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
index 60909ea2874e..b75a5d869c56 100644
--- a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
+++ b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
@@ -30,9 +30,6 @@ void PHY_DigitalPredistortion_8188E(struct adapter *pAdapter);
 void _PHY_SaveADDARegisters(struct adapter *pAdapter, u32 *ADDAReg,
 			    u32 *ADDABackup, u32 RegisterNum);
 
-void _PHY_PathADDAOn(struct adapter *pAdapter, u32 *ADDAReg,
-		     bool isPathAOn, bool is2T);
-
 void _PHY_MACSettingCalibration(struct adapter *pAdapter, u32 *MACReg,
 				u32 *MACBackup);
 
-- 
2.20.1

