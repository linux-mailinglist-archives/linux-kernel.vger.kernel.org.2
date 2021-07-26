Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C23D67BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhGZTNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:13:40 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CFC061757;
        Mon, 26 Jul 2021 12:54:08 -0700 (PDT)
Received: from dslb-188-096-151-017.188.096.pools.vodafone-ip.de ([188.96.151.17] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m86fs-00078e-1U; Mon, 26 Jul 2021 21:54:04 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 14/18] staging: rtl8188eu: simplify rtl88eu_phy_iq_calibrate
Date:   Mon, 26 Jul 2021 21:53:54 +0200
Message-Id: <20210726195354.28548-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-14-martin@kaiser.cx>
References: <20210725155902.32433-14-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boolean is2t variable in rtl88eu_phy_iq_calibrate is always false.
Remove some code that's unused in this case.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - fixed two -Wunused-but-set-variable warnings
   reported by kernel test robot <lkp@intel.com>

 drivers/staging/rtl8188eu/hal/phy.c | 65 ++---------------------------
 1 file changed, 3 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 256f87b9d630..fcac885b6581 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -703,53 +703,6 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8],
 	}
 }
 
-static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8],
-			   u8 final_candidate, bool txonly)
-{
-	u32 oldval_1, x, tx1_a, reg;
-	s32 y, tx1_c;
-
-	if (final_candidate == 0xFF) {
-		return;
-	} else if (iqkok) {
-		oldval_1 = (phy_query_bb_reg(adapt, rOFDM0_XBTxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
-
-		x = result[final_candidate][4];
-		if ((x & 0x00000200) != 0)
-			x = x | 0xFFFFFC00;
-		tx1_a = (x * oldval_1) >> 8;
-		phy_set_bb_reg(adapt, rOFDM0_XBTxIQImbalance, 0x3FF, tx1_a);
-
-		phy_set_bb_reg(adapt, rOFDM0_ECCAThreshold, BIT(27),
-			       ((x * oldval_1 >> 7) & 0x1));
-
-		y = result[final_candidate][5];
-		if ((y & 0x00000200) != 0)
-			y = y | 0xFFFFFC00;
-
-		tx1_c = (y * oldval_1) >> 8;
-
-		phy_set_bb_reg(adapt, rOFDM0_XDTxAFE, 0xF0000000,
-			       ((tx1_c & 0x3C0) >> 6));
-		phy_set_bb_reg(adapt, rOFDM0_XBTxIQImbalance, 0x003F0000,
-			       (tx1_c & 0x3F));
-		phy_set_bb_reg(adapt, rOFDM0_ECCAThreshold, BIT(25),
-			       ((y * oldval_1 >> 7) & 0x1));
-
-		if (txonly)
-			return;
-
-		reg = result[final_candidate][6];
-		phy_set_bb_reg(adapt, rOFDM0_XBRxIQImbalance, 0x3FF, reg);
-
-		reg = result[final_candidate][7] & 0x3F;
-		phy_set_bb_reg(adapt, rOFDM0_XBRxIQImbalance, 0xFC00, reg);
-
-		reg = (result[final_candidate][7] >> 6) & 0xF;
-		phy_set_bb_reg(adapt, rOFDM0_AGCRSSITable, 0x0000F000, reg);
-	}
-}
-
 static void save_adda_registers(struct adapter *adapt, const u32 *addareg,
 				u32 *backup, u32 register_num)
 {
@@ -1150,8 +1103,8 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 	s32 result[4][8];
 	u8 i, final;
-	bool pathaok, pathbok;
-	s32 reg_e94, reg_e9c, reg_ea4, reg_eb4, reg_ebc, reg_ec4;
+	bool pathaok;
+	s32 reg_e94, reg_e9c, reg_ea4, reg_eb4, reg_ebc;
 	bool is12simular, is13simular, is23simular;
 	u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
 		rOFDM0_XARxIQImbalance, rOFDM0_XBRxIQImbalance,
@@ -1159,9 +1112,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 		rOFDM0_XATxIQImbalance, rOFDM0_XBTxIQImbalance,
 		rOFDM0_XCTxAFE, rOFDM0_XDTxAFE,
 		rOFDM0_RxIQExtAnta};
-	bool is2t;
-
-	is2t = false;
 
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
@@ -1178,13 +1128,12 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 
 	final = 0xff;
 	pathaok = false;
-	pathbok = false;
 	is12simular = false;
 	is23simular = false;
 	is13simular = false;
 
 	for (i = 0; i < 3; i++) {
-		phy_iq_calibrate(adapt, result, i, is2t);
+		phy_iq_calibrate(adapt, result, i, false);
 
 		if (i == 1) {
 			is12simular = simularity_compare(adapt, result, 0, 1);
@@ -1214,7 +1163,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 		reg_ea4 = result[i][2];
 		reg_eb4 = result[i][4];
 		reg_ebc = result[i][5];
-		reg_ec4 = result[i][6];
 	}
 
 	if (final != 0xff) {
@@ -1227,9 +1175,7 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 		dm_odm->RFCalibrateInfo.RegE9C = reg_e9c;
 		dm_odm->RFCalibrateInfo.RegEB4 = reg_eb4;
 		dm_odm->RFCalibrateInfo.RegEBC = reg_ebc;
-		reg_ec4 = result[final][6];
 		pathaok = true;
-		pathbok = true;
 	} else {
 		dm_odm->RFCalibrateInfo.RegE94 = 0x100;
 		dm_odm->RFCalibrateInfo.RegEB4 = 0x100;
@@ -1239,11 +1185,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 	if (reg_e94 != 0)
 		patha_fill_iqk(adapt, pathaok, result, final,
 			       (reg_ea4 == 0));
-	if (is2t) {
-		if (reg_eb4 != 0)
-			pathb_fill_iqk(adapt, pathbok, result, final,
-				       (reg_ec4 == 0));
-	}
 
 	if (final < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-- 
2.20.1

