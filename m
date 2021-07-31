Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADB43DC212
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhGaAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhGaAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C460C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b13so2506618wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV06QZ64uyNn1gJZ+qOMKugrLK13q1+Hv54x8I1OrO0=;
        b=cz+Lg+4ZeX9+XojXdOmJXkfe9ZpuZ6VhBtu3duSHudHHofOHHTA6Uk0IBKGAe4f0t6
         IDWWAetr/8/fvJCYGelq8Km21O7/KoSThCMGHCeooGDFXPNEPrD4AsLIjnmK3yqgckpc
         3zNxPY+JUVyAqmPF8iME189kBwde3gHN5+16u4qC1pG2aKnQD6/9XPAk5WXIPMuGElH4
         SgXi5jpiTislDIecQqR0MN8elhltTNgVmC61+q0qjVwY4owz/PwCDlb0rHnYYYZI3FFL
         KFnoZeRD7BhECDK9bidSbj6n7Rqw9DEqe8oLAH5+ms+sHcQUVAvH4JtgWwCESqMU/67p
         kZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV06QZ64uyNn1gJZ+qOMKugrLK13q1+Hv54x8I1OrO0=;
        b=liRmqymI9hGVJI2H1TAYwZH0YuxaBJGnyd7scbF+YG7uyXZcRpH3svEYGRyl/RUnnF
         RQ2rQLfxV8YtnEBDhOoJA0aRnEHvzhfr2kohRc2J4ogCYYa07x7n6QD8SfIYuvavyjB5
         fP8nb5Do4EvSjLpSr7nVFIbxYNmi/cL17p6eaM6lj3uCsO5I8okaatKlVFBS1CVJIht6
         7LupQoLO8wp+qYmFBi0CSJ5/ZtYMHLjnD1j1ZLgowBYnkpCZzovdqw6bZBqLKtiKDUQg
         qmGQrlChqG5GQkioJVn8A7yxZ6ZvJAPgsYbI3IESMhJUwOZfJAK3dT+CnqeLvNdyPDJq
         gFVQ==
X-Gm-Message-State: AOAM533HfoZSx7nwrWBVXUbtdYAEB+AxbGG/kJGWv1gW6U4EVVopW+Ga
        LRcFBxEOPM9CFslp05pCZ5m2tA==
X-Google-Smtp-Source: ABdhPJwEPFaYoVq3juUdJs3a8ULrcLr2m74oxreWLTjRQ0ykas/CG86wANqir2T9e6phlh1BLUKVwA==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr6192589wrt.244.1627691989616;
        Fri, 30 Jul 2021 17:39:49 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:49 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14 resent] staging: r8188eu: remove include/odm_debug.h
Date:   Sat, 31 Jul 2021 01:39:37 +0100
Message-Id: <20210731003937.68615-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include/odm_debug.h in its entirety. To do this, first:

(1) Remove DebugLevel and DebugComponents members from the struct
    odm_dm_struct definition, and any uses of these elsewhere in
    the driver.

(2) Remove the function ODM_InitDebugSetting from hal/odm_debug.c
    whilst leaving the file in place for now as it contains a global
    which is still used and will be removed by further cleanup code.
    Also remove all of its callers. All the function does is set the
    members mentioned above.

(3) Remove the now redundant constants and their usages:
    ODM_CMNINFO_DBG_LEVEL
    ODM_CMNINFO_DBG_COMP
    HW_DEF_ODM_DBG_FLAG
    HW_DEF_FA_CNT_DUMP
    This includes usage within a few hexadecimal ioctl switch cases
    in os_dep/ioctl_linux.c (although only the call itself within
    0x11 as it contains additional code currently).

(4) Finally, remove the file itself and its inclusion within
    include/odm_precomp.h, as none of the remaining content is used
    from anywhere else in the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm.c             |  8 ---
 drivers/staging/r8188eu/hal/odm_debug.c       |  7 --
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  1 -
 drivers/staging/r8188eu/hal/usb_halinit.c     | 23 -------
 drivers/staging/r8188eu/include/hal_intf.h    |  2 -
 drivers/staging/r8188eu/include/odm.h         |  4 --
 drivers/staging/r8188eu/include/odm_debug.h   | 69 -------------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 27 --------
 9 files changed, 142 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_debug.h

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 927e1cce999e..b3ce95822b0f 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -416,12 +416,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_RSSI_MIN:
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
-	case	ODM_CMNINFO_DBG_COMP:
-		pDM_Odm->DebugComponents = Value;
-		break;
-	case	ODM_CMNINFO_DBG_LEVEL:
-		pDM_Odm->DebugLevel = (u32)Value;
-		break;
 	case	ODM_CMNINFO_RA_THRESHOLD_HIGH:
 		pDM_Odm->RateAdaptive.HighRSSIThresh = (u8)Value;
 		break;
@@ -439,8 +433,6 @@ void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->AntDivType = CG_TRX_HW_ANTDIV;
 	if (pDM_Odm->SupportICType & (ODM_RTL8723A))
 		pDM_Odm->AntDivType = CGCS_RX_SW_ANTDIV;
-
-	ODM_InitDebugSetting(pDM_Odm);
 }
 
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
index fad1c3cca25b..7029ec4f771e 100644
--- a/drivers/staging/r8188eu/hal/odm_debug.c
+++ b/drivers/staging/r8188eu/hal/odm_debug.c
@@ -3,11 +3,4 @@
 
 #include "../include/odm_precomp.h"
 
-void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm)
-{
-	pDM_Odm->DebugLevel = ODM_DBG_TRACE;
-
-	pDM_Odm->DebugComponents = 0;
-}
-
 u32 GlobalDebugLevel;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 294b082a6c09..0e264c39d636 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -193,7 +193,6 @@ void rtl8188e_init_dm_priv(struct adapter *Adapter)
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
 	Init_ODM_ComInfo_88E(Adapter);
-	ODM_InitDebugSetting(podmpriv);
 }
 
 void rtl8188e_deinit_dm_priv(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d50a887ad7ea..ca8f00c4659a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2035,12 +2035,6 @@ GetHalDefVar8188EUsb(
 			}
 		}
 		break;
-	case HW_DEF_ODM_DBG_FLAG:
-		{
-			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
-			pr_info("dm_ocm->DebugComponents = 0x%llx\n", dm_ocm->DebugComponents);
-		}
-		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
 		break;
@@ -2099,23 +2093,6 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 	case HAL_DEF_DBG_DUMP_TXPKT:
 		haldata->bDumpTxPkt = *((u8 *)pValue);
 		break;
-	case HW_DEF_FA_CNT_DUMP:
-		{
-			u8 bRSSIDump = *((u8 *)pValue);
-			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
-			if (bRSSIDump)
-				dm_ocm->DebugComponents	=	ODM_COMP_DIG|ODM_COMP_FA_CNT	;
-			else
-				dm_ocm->DebugComponents	= 0;
-		}
-		break;
-	case HW_DEF_ODM_DBG_FLAG:
-		{
-			u64	DebugComponents = *((u64 *)pValue);
-			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
-			dm_ocm->DebugComponents = DebugComponents;
-		}
-		break;
 	default:
 		bResult = _FAIL;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 81d959c6fd4e..8f62cbe9ba37 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -113,8 +113,6 @@ enum hal_def_variable {
 	HW_VAR_MAX_RX_AMPDU_FACTOR,
 	HW_DEF_RA_INFO_DUMP,
 	HAL_DEF_DBG_DUMP_TXPKT,
-	HW_DEF_FA_CNT_DUMP,
-	HW_DEF_ODM_DBG_FLAG,
 };
 
 enum hal_odm_variable {
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 15827b6a5729..2a6fd4072e00 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -388,8 +388,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_WIFI_DISPLAY,
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
-	ODM_CMNINFO_DBG_COMP,			/*  u64 */
-	ODM_CMNINFO_DBG_LEVEL,			/*  u32 */
 	ODM_CMNINFO_RA_THRESHOLD_HIGH,		/*  u8 */
 	ODM_CMNINFO_RA_THRESHOLD_LOW,		/*  u8 */
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
@@ -748,8 +746,6 @@ struct odm_dm_struct {
 	bool	odm_ready;
 
 	struct rtl8192cd_priv *fake_priv;
-	u64	DebugComponents;
-	u32	DebugLevel;
 
 /*  ODM HANDLE, DRIVER NEEDS NOT TO HOOK------ */
 	bool	bCckHighPower;
diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
deleted file mode 100644
index c71d890ac552..000000000000
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef	__ODM_DBG_H__
-#define __ODM_DBG_H__
-
-/*  */
-/*	Define the debug levels */
-/*  */
-/*	1. DBG_TRACE and DBG_LOUD are used for normal cases. */
-/*	They can help SW engineer to develop or trace states changed */
-/*	and also help HW enginner to trace every operation to and from HW, */
-/*	e.g IO, Tx, Rx. */
-/*  */
-/*	2. DBG_WARNNING and DBG_SERIOUS are used for unusual or error cases, */
-/*	which help us to debug SW or HW. */
-
-/*	Never used in a call to ODM_RT_TRACE()! */
-#define ODM_DBG_OFF				1
-
-/*	Fatal bug. */
-/*	For example, Tx/Rx/IO locked up, OS hangs, memory access violation, */
-/*	resource allocation failed, unexpected HW behavior, HW BUG and so on. */
-#define ODM_DBG_SERIOUS				2
-
-/*	Abnormal, rare, or unexpeted cases. */
-/*	For example, IRP/Packet/OID canceled, device suprisely unremoved and so on. */
-#define ODM_DBG_WARNING				3
-
-/*	Normal case with useful information about current SW or HW state. */
-/*	For example, Tx/Rx descriptor to fill, Tx/Rx descr. completed status, */
-/*	SW protocol state change, dynamic mechanism state change and so on. */
-/*  */
-#define ODM_DBG_LOUD					4
-
-/*	Normal case with detail execution flow or information. */
-#define ODM_DBG_TRACE					5
-
-/*  Define the tracing components */
-/* BB Functions */
-#define ODM_COMP_DIG					BIT0
-#define ODM_COMP_RA_MASK				BIT1
-#define ODM_COMP_DYNAMIC_TXPWR				BIT2
-#define ODM_COMP_FA_CNT					BIT3
-#define ODM_COMP_RSSI_MONITOR				BIT4
-#define ODM_COMP_CCK_PD					BIT5
-#define ODM_COMP_ANT_DIV				BIT6
-#define ODM_COMP_PWR_SAVE				BIT7
-#define ODM_COMP_PWR_TRA				BIT8
-#define ODM_COMP_RATE_ADAPTIVE				BIT9
-#define ODM_COMP_PATH_DIV				BIT10
-#define ODM_COMP_PSD					BIT11
-#define ODM_COMP_DYNAMIC_PRICCA				BIT12
-#define ODM_COMP_RXHP					BIT13
-/* MAC Functions */
-#define ODM_COMP_EDCA_TURBO				BIT16
-#define ODM_COMP_EARLY_MODE				BIT17
-/* RF Functions */
-#define ODM_COMP_TX_PWR_TRACK				BIT24
-#define ODM_COMP_RX_GAIN_TRACK				BIT25
-#define ODM_COMP_CALIBRATION				BIT26
-/* Common Functions */
-#define ODM_COMP_COMMON					BIT30
-#define ODM_COMP_INIT					BIT31
-
-/*------------------------Export Marco Definition---------------------------*/
-void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
-
-#endif	/*  __ODM_DBG_H__ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 9072acd26386..a1d6d674bda6 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -18,7 +18,6 @@
 
 #include "odm.h"
 #include "odm_HWConfig.h"
-#include "odm_debug.h"
 #include "odm_RegDefine11AC.h"
 #include "odm_RegDefine11N.h"
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ffce43f99dd6..c763714cda58 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4455,7 +4455,6 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x11:
 			DBG_88E("turn %s Rx RSSI display function\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bRxRSSIDisplay = extra_arg;
-			rtw_hal_set_def_var(padapter, HW_DEF_FA_CNT_DUMP, &extra_arg);
 			break;
 		case 0x12: /* set rx_stbc */
 		{
@@ -4492,32 +4491,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			DBG_88E("get wifi_spec =%d\n", pregpriv->wifi_spec);
 		}
 			break;
-		case 0x16:
-			if (arg == 0xff) {
-				pr_info("ODM_COMP_DIG\t\tBIT0\n");
-				pr_info("ODM_COMP_RA_MASK\t\tBIT1\n");
-				pr_info("ODM_COMP_DYNAMIC_TXPWR\tBIT2\n");
-				pr_info("ODM_COMP_FA_CNT\t\tBIT3\n");
-				pr_info("ODM_COMP_RSSI_MONITOR\tBIT4\n");
-				pr_info("ODM_COMP_CCK_PD\t\tBIT5\n");
-				pr_info("ODM_COMP_ANT_DIV\t\tBIT6\n");
-				pr_info("ODM_COMP_PWR_SAVE\t\tBIT7\n");
-				pr_info("ODM_COMP_PWR_TRAIN\tBIT8\n");
-				pr_info("ODM_COMP_RATE_ADAPTIVE\tBIT9\n");
-				pr_info("ODM_COMP_PATH_DIV\t\tBIT10\n");
-				pr_info("ODM_COMP_PSD	\tBIT11\n");
-				pr_info("ODM_COMP_DYNAMIC_PRICCA\tBIT12\n");
-				pr_info("ODM_COMP_RXHP\t\tBIT13\n");
-				pr_info("ODM_COMP_EDCA_TURBO\tBIT16\n");
-				pr_info("ODM_COMP_EARLY_MODE\tBIT17\n");
-				pr_info("ODM_COMP_TX_PWR_TRACK\tBIT24\n");
-				pr_info("ODM_COMP_RX_GAIN_TRACK\tBIT25\n");
-				pr_info("ODM_COMP_CALIBRATION\tBIT26\n");
-				rtw_hal_get_def_var(padapter, HW_DEF_ODM_DBG_FLAG, &extra_arg);
-			} else {
-				rtw_hal_set_def_var(padapter, HW_DEF_ODM_DBG_FLAG, &extra_arg);
-			}
-			break;
 		case 0x23:
 			DBG_88E("turn %s the bNotifyChannelChange Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bNotifyChannelChange = extra_arg;
-- 
2.31.1

