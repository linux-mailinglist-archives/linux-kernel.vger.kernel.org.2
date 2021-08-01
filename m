Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619FB3DCBE8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhHANql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHANqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 09:46:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5564C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 06:46:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qk33so26352490ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcxxRXgUyyUKlkwG1xLBcqjorNkHPqWK5UAC6KxYUeQ=;
        b=MrsXW8sKkatJiqxRtoCq7O8L+Vis0bxCfQCO1gemGcSGVFx0ThuKx/zyir5apBj6XZ
         q33fR9FNW3cX8WjH1B7yJZfxabx55UfHKHCgZipoGUBNmUDp/PVHxevO6S/TtrrgLMc2
         xmlG7ogSgMe0Kc6p4KlSo5FYTNjWfzYifu7xvl/DuAMdJyIvBqwKmC0HFgdnV1OU+Nip
         CoKRAVt4DnpLhub6mWVODFPAORkK2zxftKFjI0FEU0XjzJMiqUtfdaaTAOa/HB1FJKeq
         wCbFaEFJA9XgW8XN6smHoMvJ3z52IQI6qn6kN1C9kMl9Wz5ktXfe9ePWsia54+Idq5mt
         MDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcxxRXgUyyUKlkwG1xLBcqjorNkHPqWK5UAC6KxYUeQ=;
        b=X449ZOQARkxo0zokUzb6DxjBCvyJMrCQjKNaVanr2zgxkq84oxCAZUH7K22vGk9NqM
         CJfR0bxgfGB1RVi+M7EdmQhsPew+LLT6ag9GN23LioZCsVXBYXknlK3qE1UwBZoq2UwG
         Lbuzcd3L0XzRiglvHvjQ96uHrGgC7W7bKxLmhsajxSQZR6cVe+tAWdE9Lp8NfSlcvkeJ
         z2Hp3dwS/kP+YiDr6Ih+SrautqRvpq0xUUjuxSJjMxBu5QfBe9MRQAdHYpx6EbdRhI5K
         SHBvkpVRyv5FDhXFNj4MWh3xS8YCzb3CxL+g73mnf7aDoHBtxbz/lwQm5hfINuuEDxjU
         ntkg==
X-Gm-Message-State: AOAM531O40AMkIst4Ulukahao/lYdaW2RnLKbLnD+WmJlDzLsHToTZgf
        tWoT83IikmbKDUVgACSOeZTIcy5ec+g=
X-Google-Smtp-Source: ABdhPJxOcIVEYuclafDpfyBiHLjn92zjZschM+dIab2n1M0UI01sGh7u/1IsclLTNXFlZXUe7ku9JQ==
X-Received: by 2002:a17:907:101a:: with SMTP id ox26mr11300832ejb.236.1627825590943;
        Sun, 01 Aug 2021 06:46:30 -0700 (PDT)
Received: from agape ([5.171.81.90])
        by smtp.gmail.com with ESMTPSA id t25sm4118799edq.29.2021.08.01.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 06:46:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unused macros
Date:   Sun,  1 Aug 2021 15:46:29 +0200
Message-Id: <20210801134629.23433-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros detected by -Wunused-macros
gcc option.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  1 -
 drivers/staging/rtl8723bs/core/rtw_debug.c    |  1 -
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  1 -
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_rf.c       |  1 -
 drivers/staging/rtl8723bs/core/rtw_security.c |  5 ----
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  3 ---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      | 15 -----------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 27 -------------------
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |  3 ---
 drivers/staging/rtl8723bs/hal/hal_com.c       |  1 -
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  1 -
 drivers/staging/rtl8723bs/hal/hal_sdio.c      |  1 -
 drivers/staging/rtl8723bs/hal/odm.c           |  4 ---
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  2 --
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |  2 --
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  2 --
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 ---
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 10 -------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  1 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  1 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  1 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 ---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  1 -
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c |  1 -
 26 files changed, 93 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index b7e1d7817595..69a55482e8a0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_AP_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 576b039f741c..76ad1122f89f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_DEBUG_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b7ad4a11a7b7..795eafb7d6ff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _IEEE80211_C
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8914ef3d33c8..0152491455a2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_IOCTL_SET_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/core/rtw_rf.c b/drivers/staging/rtl8723bs/core/rtw_rf.c
index a5095a4ef690..96eb8ca38003 100644
--- a/drivers/staging/rtl8723bs/core/rtw_rf.c
+++ b/drivers/staging/rtl8723bs/core/rtw_rf.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_RF_C_
 
 #include <drv_types.h>
 #include <linux/kernel.h>
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8b507f6a447e..b050bf62e3b9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -268,11 +268,6 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 
 /* fixed algorithm "parameters" */
 #define PHASE1_LOOP_CNT   8    /* this needs to be "big enough"     */
-#define TA_SIZE           6    /*  48-bit transmitter address       */
-#define TK_SIZE          16    /* 128-bit temporal key              */
-#define P1K_SIZE         10    /*  80-bit Phase1 key                */
-#define RC4_KEY_SIZE     16    /* 128-bit RC4KEY (104 bits unknown) */
-
 
 /* 2-unsigned char by 2-unsigned char subset of the full AES S-box table */
 static const unsigned short Sbox1[2][256] = {      /* Sbox for hash (can be in ROM)     */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 865a82d5cedb..170536986476 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_WLAN_UTIL_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
@@ -25,8 +24,6 @@ static unsigned char AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
 static unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 static unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 
-#define R2T_PHY_DELAY	(0)
-
 /* define WAIT_FOR_BCN_TO_MIN	(3000) */
 #define WAIT_FOR_BCN_TO_MIN	(6000)
 #define WAIT_FOR_BCN_TO_MAX	(20000)
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index 365e1195b5e5..9c6d3bf2f2ea 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -8,21 +8,6 @@
 /* include "Mp_Precomp.h" */
 #include "odm_precomp.h"
 
-
-#define CALCULATE_SWINGTALBE_OFFSET(_offset, _direction, _size, _deltaThermal) \
-	do {\
-		for (_offset = 0; _offset < _size; _offset++) {\
-			if (_deltaThermal < thermalThreshold[_direction][_offset]) {\
-				if (_offset != 0)\
-					_offset--;\
-				break;\
-			} \
-		} \
-		if (_offset >= _size)\
-			_offset = _size-1;\
-	} while (0)
-
-
 void ConfigureTxpowerTrack(struct dm_odm_t *pDM_Odm, struct txpwrtrack_cfg *pConfig)
 {
 	ConfigureTxpowerTrack_8723B(pConfig);
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 8121b8eb45b6..c696569ae5cf 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -9,17 +9,10 @@
 #include <rtw_debug.h>
 #include "odm_precomp.h"
 
-
-
-/*---------------------------Define Local Constant---------------------------*/
-/*  2010/04/25 MH Define the max tx power tracking tx agc power. */
-#define		ODM_TXPWRTRACK_MAX_IDX8723B	6
-
 /*  MACRO definition for pRFCalibrateInfo->TxIQC_8723B[0] */
 #define		PATH_S0							1 /*  RF_PATH_B */
 #define		IDX_0xC94						0
 #define		IDX_0xC80						1
-#define		IDX_0xC4C						2
 #define		IDX_0xC14						0
 #define		IDX_0xCA0						1
 #define		KEY							0
@@ -27,12 +20,7 @@
 
 /*  MACRO definition for pRFCalibrateInfo->TxIQC_8723B[1] */
 #define		PATH_S1							0 /*  RF_PATH_A */
-#define		IDX_0xC9C						0
-#define		IDX_0xC88						1
 #define		IDX_0xC4C						2
-#define		IDX_0xC1C						0
-#define		IDX_0xC78						1
-
 
 /*---------------------------Define Local Constant---------------------------*/
 
@@ -373,7 +361,6 @@ void ConfigureTxpowerTrack_8723B(struct txpwrtrack_cfg *pConfig)
 
 /* 1 7. IQK */
 #define MAX_TOLERANCE		5
-#define IQK_DELAY_TIME		1		/* ms */
 
 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
 static u8 phy_PathA_IQK_8723B(
@@ -1583,20 +1570,6 @@ static void phy_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm, bool is2T)
 		rtw_write8(pDM_Odm->Adapter, REG_TXPAUSE, 0x00);
 }
 
-/* Analog Pre-distortion calibration */
-#define		APK_BB_REG_NUM	8
-#define		APK_CURVE_REG_NUM 4
-#define		PATH_NUM		2
-
-#define		DP_BB_REG_NUM		7
-#define		DP_RF_REG_NUM		1
-#define		DP_RETRY_LIMIT		10
-#define		DP_PATH_NUM	2
-#define		DP_DPK_NUM			3
-#define		DP_DPK_VALUE_NUM	2
-
-
-
 /* IQK version:V2.5    20140123 */
 /* IQK is controlled by Is2ant, RF path */
 void PHY_IQCalibrate_8723B(
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 6e165d808bbd..f4b3e8b28712 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2013 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define __HAL_BTCOEX_C__
 
 #include <hal_data.h>
 #include <rtw_debug.h>
@@ -17,8 +16,6 @@ struct btc_coexist GLBtCoexist;
 static u8 GLBtcWiFiInScanState;
 static u8 GLBtcWiFiInIQKState;
 
-#define	BT_Operation(Adapter)						false
-
 /*  */
 /* 		Debug related function */
 /*  */
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 0df2b9b61cf8..fbe6b64aa1fb 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _HAL_COM_C_
 
 #include <linux/kernel.h>
 #include <drv_types.h>
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index bb7941aee0c4..4fb2884fce38 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _HAL_COM_PHYCFG_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/hal/hal_sdio.c b/drivers/staging/rtl8723bs/hal/hal_sdio.c
index 2d61b09ebce6..9de62a0f5d35 100644
--- a/drivers/staging/rtl8723bs/hal/hal_sdio.c
+++ b/drivers/staging/rtl8723bs/hal/hal_sdio.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _HAL_SDIO_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 68dfb77772b2..45fdd51b784e 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -281,10 +281,6 @@ u32 TxScalingTable_Jaguar[TXSCALE_TABLE_SIZE] = {
 
 /* Remove Edca by Yu Chen */
 
-
-#define RxDefaultAnt1		0x65a9
-#define RxDefaultAnt2		0x569a
-
 static void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm)
 {
 	pDM_Odm->bCckHighPower = (bool) PHY_QueryBBReg(pDM_Odm->Adapter, ODM_REG(CCK_RPT_FORMAT, pDM_Odm), ODM_BIT(CCK_RPT_FORMAT, pDM_Odm));
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index ef5b48bb01b2..fb932e0618e2 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -7,8 +7,6 @@
 
 #include "odm_precomp.h"
 
-#define ADAPTIVITY_VERSION "5.0"
-
 void odm_NHMCounterStatisticsInit(void *pDM_VOID)
 {
 	struct dm_odm_t	*pDM_Odm = (struct dm_odm_t *)pDM_VOID;
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 32f7eb952ca8..859451810c48 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -9,8 +9,6 @@
 
 #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig_MP_##ic##txt(pDM_Odm))
 #define READ_AND_CONFIG     READ_AND_CONFIG_MP
-#define GET_VERSION_MP(ic, txt) (ODM_GetVersion_MP_##ic##txt())
-#define GET_VERSION(ic, txt) (pDM_Odm->bIsMPChip?GET_VERSION_MP(ic, txt):GET_VERSION_TC(ic, txt))
 
 static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 853fe758c4a9..a59ae622f05e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTL8723B_CMD_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 5840a5241fde..54e2a68a0824 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -7,8 +7,6 @@
 /*  Description: */
 /*  This file is for 92CE/92CU dynamic mechanism only */
 
-#define _RTL8723B_DM_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index d9a2d3e6a56f..713ee0179dda 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2013 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _HAL_INIT_C_
 
 #include <linux/firmware.h>
 #include <linux/slab.h>
@@ -598,14 +597,12 @@ static void Hal_GetEfuseDefinition(
 }
 
 #define VOLTAGE_V25		0x03
-#define LDOE25_SHIFT	28
 
 /*  */
 /* 	The following is for compile ok */
 /* 	That should be merged with the original in the future */
 /*  */
 #define EFUSE_ACCESS_ON_8723			0x69	/*  For RTL8723 only. */
-#define EFUSE_ACCESS_OFF_8723			0x00	/*  For RTL8723 only. */
 #define REG_EFUSE_ACCESS_8723			0x00CF	/*  Efuse access protection for RTL8723 */
 
 /*  */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 6e524034f388..ca6b548171b4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -4,21 +4,11 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTL8723B_PHYCFG_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
 
-
-/*---------------------------Define Local Constant---------------------------*/
-/* Channel switch:The size of command tables for switch channel*/
-#define MAX_PRECMD_CNT 16
-#define MAX_RFDEPENDCMD_CNT 16
-#define MAX_POSTCMD_CNT 16
-
-#define MAX_DOZE_WAITING_TIMES_9x 64
-
 /**
  * phy_CalculateBitShift - Get shifted position of the BitMask.
  * @BitMask: Bitmask.
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
index f2f02a69f0af..717faebf8aca 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTL8723B_REDESC_C_
 
 #include <rtl8723b_hal.h>
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index ad803ffc0696..6dc5cd959b75 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTL8723BS_RECV_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index a05d43b716ee..156d6aba18ca 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTL8723BS_XMIT_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 12b8e1773a84..62eb64e447a4 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define  _IOCTL_CFG80211_C_
 
 #include <linux/etherdevice.h>
 #include <drv_types.h>
@@ -71,8 +70,6 @@ static struct ieee80211_rate rtw_rates[] = {
 	RATETAB_ENT(540, 0x800, 0),
 };
 
-#define rtw_a_rates		(rtw_rates + 4)
-#define RTW_A_RATES_NUM	8
 #define rtw_g_rates		(rtw_rates + 0)
 #define RTW_G_RATES_NUM	12
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 19c5c7e8f403..e2ab34463182 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _IOCTL_LINUX_C_
 
 #include <linux/etherdevice.h>
 #include <drv_types.h>
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index bed930760656..0a0b04088e66 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  *******************************************************************************/
-#define _SDIO_OPS_LINUX_C_
 
 #include <drv_types.h>
 #include <rtw_debug.h>
-- 
2.20.1

