Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92C43E347A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhHGJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhHGJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDBFC061799
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4so7136995wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IhmZoQ2mW3hKZEztQHZLTUWIO1xETJCGbSh99O5Wb8=;
        b=uze2seODRYEgijKkfTIm1xU/942R8prNY2XIYw4IWPfVvxZioQdXOmS9rDj9kDaJjJ
         CWW9SxOFgxvUgY7DeQsUpVFiLNfUnNp0bWKg3Potwxv5ZFP1pDJZ1hOnFkn+n74droMh
         whJBCLzgB6nrmFDy0RQcIY3kkO2ytuP8W5qAEkKLucnNaMIP680kR7B8K5qw7dstcCh4
         dBPIhNy/CZqsW16vm7ihXGYgxD7S/80aDGYlVcOB0/jl8Q1s7hY45I87Q1a6q/S68XZ9
         STNfZWZXaQzCdBHKYk2EKBesh8I+0YNlNLyujvrNMycWO9S7SAQeGnRe3SmXrikvR8W/
         1NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IhmZoQ2mW3hKZEztQHZLTUWIO1xETJCGbSh99O5Wb8=;
        b=q9lil7g9x9UHtF0+XlZoigCmEsvsyNfuuZOy1cWPpgpUoPEg3RJYzFwFCWkryztyuP
         K+8mlcbjU7Vq0s0Ogg6eswCox9eGafghPPs7deSJFY7Cr6HaRE7/cFPYL9VV12oodZi2
         SddCSjeOzGplBlUFwG9ewIQ1A2kGTw+aKa3TFKgiqp1VJhxBOFTgRdqf7yngheTVsOfr
         wBQuhPQ3yUqXz44R0s6bLV3reZZNQWjrnFNC4O3avaiv9UYREwvVYcSOWEPA0keXDrpd
         WiNAywSeJ0Vs6XNHQ6EUOPYz3AfIdhDNFB2YmoWAkg/S2sazp9QqXyxMZcNvepqbo3R/
         F5ew==
X-Gm-Message-State: AOAM5327Nt93yUlxHdPDQ9pQtiRFoDKWyf7FQ2AQpLkqNMhNkkyDTWmr
        Kl7d/Ph3nWfq/nOPOMexTYfv34VhmBY=
X-Google-Smtp-Source: ABdhPJx+6ztnfsSgSAua2SYR7CrwdGMHCmLN/asfMxBZ/d/lDZpoO3EFMnDtjcPZR9tPaUKwmwQQog==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr637680wml.141.1628329713952;
        Sat, 07 Aug 2021 02:48:33 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id u11sm12261473wrt.89.2021.08.07.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] staging: rtl8723bs: remove rf type branching (third patch)
Date:   Sat,  7 Aug 2021 11:48:06 +0200
Message-Id: <e626790eb8bd7d96f939e1bbb47b899bf12dab0d.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove rf_type struct member, keep all 1T1R code
unconditionally, remove the other *T*R branches.
Removed dead code related to MCS indexes above 7.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c         |  3 ---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c  | 17 -----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c   |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c |  5 +----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c    |  2 --
 .../staging/rtl8723bs/include/Hal8192CPhyReg.h  |  4 ----
 drivers/staging/rtl8723bs/include/hal_data.h    |  1 -
 7 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 65987e3076a3..8964303a619f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -670,9 +670,6 @@ void GetHwReg(struct adapter *adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FLAG:
 		*((u32 *)val) = odm->SupportAbility;
 		break;
-	case HW_VAR_RF_TYPE:
-		*((u8 *)val) = hal_data->rf_type;
-		break;
 	default:
 		netdev_dbg(adapter->pnetdev,
 			   FUNC_ADPT_FMT " variable(%d) not defined!\n",
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 3e426c975828..4a249d20c661 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -116,12 +116,6 @@ u8 PHY_GetRateSectionIndexOfTxPowerByRate(
 		case rTxAGC_A_Mcs07_Mcs04:
 			index = 3;
 			break;
-		case rTxAGC_A_Mcs11_Mcs08:
-			index = 4;
-			break;
-		case rTxAGC_A_Mcs15_Mcs12:
-			index = 5;
-			break;
 		case rTxAGC_B_Rate18_06:
 			index = 8;
 			break;
@@ -137,12 +131,6 @@ u8 PHY_GetRateSectionIndexOfTxPowerByRate(
 		case rTxAGC_B_Mcs07_Mcs04:
 			index = 11;
 			break;
-		case rTxAGC_B_Mcs11_Mcs08:
-			index = 12;
-			break;
-		case rTxAGC_B_Mcs15_Mcs12:
-			index = 13;
-			break;
 		default:
 			break;
 		}
@@ -395,11 +383,6 @@ void PHY_StoreTxPowerByRate(
 		PHY_StoreTxPowerByRateNew(padapter, RfPath, TxNum, RegAddr, BitMask, Data);
 	else if (pDM_Odm->PhyRegPgVersion == 0) {
 		PHY_StoreTxPowerByRateOld(padapter, RegAddr, BitMask, Data);
-
-		if (RegAddr == rTxAGC_A_Mcs15_Mcs12 && pHalData->rf_type == RF_1T1R)
-			pHalData->pwrGroupCnt++;
-		else if (RegAddr == rTxAGC_B_Mcs15_Mcs12 && pHalData->rf_type != RF_1T1R)
-			pHalData->pwrGroupCnt++;
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 5da8e21bb02f..cce3e7e80953 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1660,7 +1660,6 @@ static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 	dump_chip_info(ChipVersion);
 #endif
 	pHalData->VersionID = ChipVersion;
-	pHalData->rf_type = RF_1T1R;
 
 	return ChipVersion;
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index 51865f81b1fe..ffb35e1ace62 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -156,10 +156,7 @@ int PHY_RF6052_Config8723B(struct adapter *Adapter)
 	/*  */
 	/*  Initialize general global value */
 	/*  */
-	if (pHalData->rf_type == RF_1T1R)
-		pHalData->NumTotalRFPath = 1;
-	else
-		pHalData->NumTotalRFPath = 2;
+	pHalData->NumTotalRFPath = 1;
 
 	/*  */
 	/*  Config BB and RF */
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a07a6dacec42..c9cd6578f7f8 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -556,8 +556,6 @@ static void _InitRFType(struct adapter *padapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
 	pHalData->rf_chip	= RF_6052;
-
-	pHalData->rf_type = RF_1T1R;
 }
 
 static void _RfPowerSave(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
index aad962548278..586a3dabc5ca 100644
--- a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
+++ b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
@@ -109,7 +109,6 @@
 #define		rTxAGC_B_Mcs03_Mcs00			0x83c
 
 #define		rTxAGC_B_Mcs07_Mcs04			0x848
-#define		rTxAGC_B_Mcs11_Mcs08			0x84c
 
 #define		rFPGA0_XA_LSSIParameter		0x840
 #define		rFPGA0_XB_LSSIParameter		0x844
@@ -123,7 +122,6 @@
 #define		rFPGA0_XA_RFInterfaceOE		0x860	/*  RF Channel switch */
 #define		rFPGA0_XB_RFInterfaceOE		0x864
 
-#define		rTxAGC_B_Mcs15_Mcs12			0x868
 #define		rTxAGC_B_CCK11_A_CCK2_11		0x86c
 
 #define		rFPGA0_XAB_RFInterfaceSW		0x870	/*  RF Interface Software Control */
@@ -303,8 +301,6 @@
 #define		rTxAGC_A_CCK1_Mcs32			0xe08
 #define		rTxAGC_A_Mcs03_Mcs00			0xe10
 #define		rTxAGC_A_Mcs07_Mcs04			0xe14
-#define		rTxAGC_A_Mcs11_Mcs08			0xe18
-#define		rTxAGC_A_Mcs15_Mcs12			0xe1c
 
 #define		rFPGA0_IQK					0xe28
 #define		rTx_IQK_Tone_A				0xe30
diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index 3298fa8eb682..f0b26e44f9b9 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -189,7 +189,6 @@ struct hal_com_data {
 
 	/* rf_ctrl */
 	u8 rf_chip;
-	u8 rf_type;
 	u8 PackageType;
 	u8 NumTotalRFPath;
 
-- 
2.20.1

