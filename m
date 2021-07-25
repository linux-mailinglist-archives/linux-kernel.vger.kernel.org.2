Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAE3D4E83
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhGYPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhGYPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:19:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF9C061757;
        Sun, 25 Jul 2021 08:59:45 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXT-0000SM-1A; Sun, 25 Jul 2021 17:59:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 18/18] staging: rtl8188eu: remove unused IQKMatrixRegSetting array
Date:   Sun, 25 Jul 2021 17:59:02 +0200
Message-Id: <20210725155902.32433-18-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IQKMatrixRegSetting array in struct odm_rf_cal is initialised
but never used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/phy.c     | 6 ------
 drivers/staging/rtl8188eu/include/odm.h | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 6c6404eb2f1e..4a4d4a23eda6 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -1091,12 +1091,6 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 		patha_fill_iqk(adapt, pathaok, result, final,
 			       (reg_ea4 == 0));
 
-	if (final < 4) {
-		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final][i];
-		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
-	}
-
 	save_adda_registers(adapt, iqk_bb_reg_92c,
 			    dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 }
diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index 98402cfb1168..9cd612414ab9 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -241,7 +241,6 @@ struct odm_rate_adapt {
 #define HP_THERMAL_NUM		8
 
 #define AVG_THERMAL_NUM		8
-#define IQK_Matrix_REG_NUM	8
 #define IQK_Matrix_Settings_NUM	(1 + 24 + 21)
 
 #define	DM_Type_ByFWi		0
@@ -565,11 +564,6 @@ struct odm_ra_info {
 	u8 PTSmoothFactor;
 };
 
-struct ijk_matrix_regs_set {
-	bool	bIQKDone;
-	s32	Value[1][IQK_Matrix_REG_NUM];
-};
-
 struct odm_rf_cal {
 	/* for tx power tracking */
 	u32	RegA24; /*  for TempCCK */
@@ -613,7 +607,6 @@ struct odm_rf_cal {
 
 	u8	ThermalValue_HP[HP_THERMAL_NUM];
 	u8	ThermalValue_HP_index;
-	struct ijk_matrix_regs_set IQKMatrixRegSetting[IQK_Matrix_Settings_NUM];
 
 	u8	Delta_IQK;
 	u8	Delta_LCK;
-- 
2.20.1

