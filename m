Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8591243026B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbhJPLcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244337AbhJPLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:32:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A075C061764
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:30:40 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbhtb-00046d-Aq; Sat, 16 Oct 2021 13:30:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/8] staging: r8188eu: interface type is always usb
Date:   Sat, 16 Oct 2021 13:30:02 +0200
Message-Id: <20211016113008.27549-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportInterface in struct odm_dm_struct is always ODM_ITRF_USB.
Remove the variable and the code to configure the interface.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c  |  9 +++------
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c |  3 +--
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c  |  3 +--
 drivers/staging/r8188eu/hal/odm.c               |  3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c       |  2 --
 drivers/staging/r8188eu/include/odm.h           | 11 +----------
 6 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 17b55c31f6eb..a623e0aaa0d0 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -176,7 +176,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     interfaceValue   = dm_odm->SupportInterface;
 	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
 	u32    *array       = array_agc_tab_1t_8188e;
 	bool		biol = false;
@@ -185,7 +184,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
-	hex += interfaceValue << 8;
+	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(adapter);
@@ -453,7 +452,6 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     interfaceValue   = dm_odm->SupportInterface;
 	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
 	u32    *array       = array_phy_reg_1t_8188e;
 	bool	biol = false;
@@ -461,7 +459,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	struct xmit_frame *pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
-	hex += interfaceValue << 8;
+	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(adapter);
@@ -659,11 +657,10 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32  hex;
 	u32  i           = 0;
-	u8  interfaceValue   = dm_odm->SupportInterface;
 	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
 	u32 *array       = array_phy_reg_pg_8188e;
 
-	hex = interfaceValue << 8;
+	hex = ODM_ITRF_USB << 8;
 	hex += (ODM_CE << 16) + 0xFF000000;
 
 	for (i = 0; i < arraylen; i += 3) {
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index bb57e93eb959..b4c55863d3fb 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -133,7 +133,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	u32     hex         = 0;
 	u32     i;
-	u8     interface_val   = dm_odm->SupportInterface;
 	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
 	u32    *array       = array_MAC_REG_8188E;
 	bool	biol = false;
@@ -142,7 +141,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	struct xmit_frame	*pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
-	hex += interface_val << 8;
+	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 7a8faa7885a1..3e2a09fc2619 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -144,7 +144,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     interfaceValue   = pDM_Odm->SupportInterface;
 	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
 	u32    *Array       = Array_RadioA_1T_8188E;
 	bool		biol = false;
@@ -153,7 +152,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
-	hex += interfaceValue << 8;
+	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(Adapter);
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 2178ffe41bb3..a90597b82e12 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -214,9 +214,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_INTERFACE:
-		pDM_Odm->SupportInterface = (u8)Value;
-		break;
 	case	ODM_CMNINFO_MP_TEST_CHIP:
 		pDM_Odm->bIsMPChip = (u8)Value;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 1ca24a507d6d..869d95f3cf33 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -33,8 +33,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	dm_odm->Adapter = Adapter;
 
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_USB);
-
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
 	if (hal_data->rf_type == RF_1T1R)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 187f872d09b5..ba936d30a0db 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -262,7 +262,6 @@ enum odm_common_info_def {
 
 	/* HOOK BEFORE REG INIT----------- */
 	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
-	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
 	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
 	/* HOOK BEFORE REG INIT-----------  */
@@ -343,13 +342,7 @@ enum odm_ability_def {
 	ODM_RF_CALIBRATION		= BIT(26),
 };
 
-/* 	ODM_CMNINFO_INTERFACE */
-enum odm_interface_def {
-	ODM_ITRF_PCIE	=	0x1,
-	ODM_ITRF_USB	=	0x2,
-	ODM_ITRF_SDIO	=	0x4,
-	ODM_ITRF_ALL	=	0x7,
-};
+# define ODM_ITRF_USB 0x2
 
 /*  ODM_CMNINFO_RF_TYPE */
 /*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
@@ -611,8 +604,6 @@ struct odm_dm_struct {
 /* HOOK BEFORE REG INIT----------- */
 	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ �K�K = 1/2/3/�K */
 	u32	SupportAbility;
-	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
-	u8	SupportInterface;
 	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
 	u8	RFType;
 
-- 
2.20.1

