Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED714282CB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJJRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhJJRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:54:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809BC061745
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:52:38 -0700 (PDT)
Received: from dslb-188-104-061-167.188.104.pools.vodafone-ip.de ([188.104.61.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mZczy-0001WC-NT; Sun, 10 Oct 2021 19:52:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/11] staging: r8188eu: remove odm cut version info
Date:   Sun, 10 Oct 2021 19:51:58 +0200
Message-Id: <20211010175204.24029-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010175204.24029-1-martin@kaiser.cx>
References: <20211010175204.24029-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cut version info is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c         |  3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c |  5 -----
 drivers/staging/r8188eu/include/odm.h     | 14 --------------
 3 files changed, 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 17427bec9832..cd09cdbdb863 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -228,9 +228,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_IC_TYPE:
 		pDM_Odm->SupportICType = Value;
 		break;
-	case	ODM_CMNINFO_CUT_VER:
-		pDM_Odm->CutVersion = (u8)Value;
-		break;
 	case	ODM_CMNINFO_RF_TYPE:
 		pDM_Odm->RFType = (u8)Value;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index c752c106980a..54cf0d6d726f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -31,7 +31,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
-	u8 cut_ver;
 
 	/*  Init Value */
 	memset(dm_odm, 0, sizeof(*dm_odm));
@@ -44,10 +43,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_IC_TYPE, ODM_RTL8188E);
 
-	cut_ver = ODM_CUT_A;
-
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_CUT_VER, cut_ver);
-
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 527898571a54..b3a9902761df 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -266,7 +266,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
 	ODM_CMNINFO_IC_TYPE,		/* ODM_IC_TYPE_E */
-	ODM_CMNINFO_CUT_VER,		/* ODM_CUT_VERSION_E */
 	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
 	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
 	ODM_CMNINFO_EXT_LNA,		/* true */
@@ -372,17 +371,6 @@ enum odm_ic_type {
 	ODM_RTL8821	=	BIT(6),
 };
 
-/* ODM_CMNINFO_CUT_VER */
-enum odm_cut_version {
-	ODM_CUT_A	=	1,
-	ODM_CUT_B	=	2,
-	ODM_CUT_C	=	3,
-	ODM_CUT_D	=	4,
-	ODM_CUT_E	=	5,
-	ODM_CUT_F	=	6,
-	ODM_CUT_TEST	=	7,
-};
-
 /*  ODM_CMNINFO_RF_TYPE */
 /*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
 enum odm_rf_path {
@@ -659,8 +647,6 @@ struct odm_dm_struct {
 	/*  ODM composite or independent. Bit oriented/ 92C+92D+ .... or any
 	 *  other type = 1/2/3/... */
 	u32	SupportICType;
-	/*  Cut Version TestChip/A-cut/B-cut... = 0/1/2/3/... */
-	u8	CutVersion;
 	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
 	u8	RFType;
 	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/. = 0/1/2/3/4/. */
-- 
2.20.1

