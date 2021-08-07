Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DD3E346C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhHGJsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhHGJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D0C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z4so14322341wrv.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXFNxL+sth5fr7UdDwCy/rCrkTEGOeAYbRa2XXK9le4=;
        b=O2rQ1Chj/4z6F6WKJn0VU+6JalLAJKkl/LveYS7b/uf3B0XAF1qnp+RNYPOGcOyvDe
         3KHGziBkm3EbzQskHpJKM52TI8bLnvwr1ItUCBUYOdUZ8gc+LmbmnO8uvOv+UBe8/20x
         WAt9QFaHuz0mVmlbBVwmahRFw4K/9TiZOfkAuTnQEUGlkifB1iAaPbCL2cZdekHCz723
         F2HZPUuGxZL6z7jehKlxG7j7A2XbMCteiOWuE4f/3AWnpwJhCidz+ALXWyaIisleJNT2
         oH/G+zeuHGmV5sc1RrF+zQkKcRYSa9C/DweRI2dnHgx/lBxOGaavozUV+BGHaXnLsAUc
         7cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXFNxL+sth5fr7UdDwCy/rCrkTEGOeAYbRa2XXK9le4=;
        b=oFTfO686KeqIochZHn94av57xwkQ4VvbYyxtmaGkn2UCJb/YJ9N2Chb+yNGE9gglmQ
         PWBKOoOIObGOVlZclI5IO8B9Ac/1VA+x+jaiREbWCWQDfYJMle78tkMacjIXjeWTcJ+y
         5EOMGnEAbvX5fttl82EvaWCrQyYdiJtNsSB/vD/5OichQEELGJaXoVHXY7kEy++Woc/Q
         dtnraQM2rM3MDPevMcQHDNbFyxI5pPnd65L+DIpOVL/fKvi0U3Dz52BNHHcFtXul1yKi
         2Cvpv2hzPuILlzL99LKR6oF7FT8sQ+o4KFuI5WX9b/noaz1sFN3d4xQFlr8cznCVXI46
         4w2g==
X-Gm-Message-State: AOAM531bxSvJJVwOehIt7yBBGigJ+SuajmA3f9FNnf++fCOC9pmccYXL
        ocWs8fKzRtCA+j/wq/JfYM3UfMTZ/bk=
X-Google-Smtp-Source: ABdhPJxC8d6ichjCg95/t86ZdAgE1XUgmcZAY6VDLJWuGMugXJyyB5CUqgm/IH2Hqey388lwuCej2g==
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr7921363wrh.418.1628329696569;
        Sat, 07 Aug 2021 02:48:16 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id g12sm12268402wri.49.2021.08.07.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] staging: rtl8723bs: remove code related to unsupported MCS index values
Date:   Sat,  7 Aug 2021 11:47:53 +0200
Message-Id: <1d5c8ca570a9f1880864f37099d625f96ea4a1d1.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove code related to MCS index from 8 to 31 for
rtl8723bs works only with index from 0 to 7 and
index 32.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 144 ---------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 275 +-----------------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |   5 +-
 .../staging/rtl8723bs/hal/odm_RegDefine11N.h  |   2 -
 drivers/staging/rtl8723bs/hal/odm_reg.h       |   4 -
 drivers/staging/rtl8723bs/include/hal_com.h   |  35 +--
 .../rtl8723bs/include/hal_com_phycfg.h        |   3 -
 .../staging/rtl8723bs/include/hal_com_reg.h   |  19 --
 drivers/staging/rtl8723bs/include/ieee80211.h |  24 --
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |   8 -
 10 files changed, 8 insertions(+), 511 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index fbe6b64aa1fb..7dd49c8538e4 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -222,78 +222,6 @@ u8 MRateToHwRate(u8 rate)
 	case MGN_MCS7:
 		ret = DESC_RATEMCS7;
 		break;
-	case MGN_MCS8:
-		ret = DESC_RATEMCS8;
-		break;
-	case MGN_MCS9:
-		ret = DESC_RATEMCS9;
-		break;
-	case MGN_MCS10:
-		ret = DESC_RATEMCS10;
-		break;
-	case MGN_MCS11:
-		ret = DESC_RATEMCS11;
-		break;
-	case MGN_MCS12:
-		ret = DESC_RATEMCS12;
-		break;
-	case MGN_MCS13:
-		ret = DESC_RATEMCS13;
-		break;
-	case MGN_MCS14:
-		ret = DESC_RATEMCS14;
-		break;
-	case MGN_MCS15:
-		ret = DESC_RATEMCS15;
-		break;
-	case MGN_MCS16:
-		ret = DESC_RATEMCS16;
-		break;
-	case MGN_MCS17:
-		ret = DESC_RATEMCS17;
-		break;
-	case MGN_MCS18:
-		ret = DESC_RATEMCS18;
-		break;
-	case MGN_MCS19:
-		ret = DESC_RATEMCS19;
-		break;
-	case MGN_MCS20:
-		ret = DESC_RATEMCS20;
-		break;
-	case MGN_MCS21:
-		ret = DESC_RATEMCS21;
-		break;
-	case MGN_MCS22:
-		ret = DESC_RATEMCS22;
-		break;
-	case MGN_MCS23:
-		ret = DESC_RATEMCS23;
-		break;
-	case MGN_MCS24:
-		ret = DESC_RATEMCS24;
-		break;
-	case MGN_MCS25:
-		ret = DESC_RATEMCS25;
-		break;
-	case MGN_MCS26:
-		ret = DESC_RATEMCS26;
-		break;
-	case MGN_MCS27:
-		ret = DESC_RATEMCS27;
-		break;
-	case MGN_MCS28:
-		ret = DESC_RATEMCS28;
-		break;
-	case MGN_MCS29:
-		ret = DESC_RATEMCS29;
-		break;
-	case MGN_MCS30:
-		ret = DESC_RATEMCS30;
-		break;
-	case MGN_MCS31:
-		ret = DESC_RATEMCS31;
-		break;
 	default:
 		break;
 	}
@@ -366,78 +294,6 @@ u8 HwRateToMRate(u8 rate)
 	case DESC_RATEMCS7:
 		ret_rate = MGN_MCS7;
 		break;
-	case DESC_RATEMCS8:
-		ret_rate = MGN_MCS8;
-		break;
-	case DESC_RATEMCS9:
-		ret_rate = MGN_MCS9;
-		break;
-	case DESC_RATEMCS10:
-		ret_rate = MGN_MCS10;
-		break;
-	case DESC_RATEMCS11:
-		ret_rate = MGN_MCS11;
-		break;
-	case DESC_RATEMCS12:
-		ret_rate = MGN_MCS12;
-		break;
-	case DESC_RATEMCS13:
-		ret_rate = MGN_MCS13;
-		break;
-	case DESC_RATEMCS14:
-		ret_rate = MGN_MCS14;
-		break;
-	case DESC_RATEMCS15:
-		ret_rate = MGN_MCS15;
-		break;
-	case DESC_RATEMCS16:
-		ret_rate = MGN_MCS16;
-		break;
-	case DESC_RATEMCS17:
-		ret_rate = MGN_MCS17;
-		break;
-	case DESC_RATEMCS18:
-		ret_rate = MGN_MCS18;
-		break;
-	case DESC_RATEMCS19:
-		ret_rate = MGN_MCS19;
-		break;
-	case DESC_RATEMCS20:
-		ret_rate = MGN_MCS20;
-		break;
-	case DESC_RATEMCS21:
-		ret_rate = MGN_MCS21;
-		break;
-	case DESC_RATEMCS22:
-		ret_rate = MGN_MCS22;
-		break;
-	case DESC_RATEMCS23:
-		ret_rate = MGN_MCS23;
-		break;
-	case DESC_RATEMCS24:
-		ret_rate = MGN_MCS24;
-		break;
-	case DESC_RATEMCS25:
-		ret_rate = MGN_MCS25;
-		break;
-	case DESC_RATEMCS26:
-		ret_rate = MGN_MCS26;
-		break;
-	case DESC_RATEMCS27:
-		ret_rate = MGN_MCS27;
-		break;
-	case DESC_RATEMCS28:
-		ret_rate = MGN_MCS28;
-		break;
-	case DESC_RATEMCS29:
-		ret_rate = MGN_MCS29;
-		break;
-	case DESC_RATEMCS30:
-		ret_rate = MGN_MCS30;
-		break;
-	case DESC_RATEMCS31:
-		ret_rate = MGN_MCS31;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 4fb2884fce38..03c174aab08d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -29,15 +29,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 	case HT_MCS0_MCS7:
 		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2];
 		break;
-	case HT_MCS8_MCS15:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3];
-		break;
-	case HT_MCS16_MCS23:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4];
-		break;
-	case HT_MCS24_MCS31:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5];
-		break;
 	default:
 		break;
 	}
@@ -69,15 +60,6 @@ phy_SetTxPowerByRateBase(
 	case HT_MCS0_MCS7:
 		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2] = Value;
 		break;
-	case HT_MCS8_MCS15:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][3] = Value;
-		break;
-	case HT_MCS16_MCS23:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][4] = Value;
-		break;
-	case HT_MCS24_MCS31:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][5] = Value;
-		break;
 	default:
 		break;
 	}
@@ -99,13 +81,6 @@ struct adapter *padapter
 
 		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_MCS7);
 		phy_SetTxPowerByRateBase(padapter, path, HT_MCS0_MCS7, RF_1TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, path, RF_2TX, MGN_MCS15);
-		phy_SetTxPowerByRateBase(padapter, path, HT_MCS8_MCS15, RF_2TX, base);
-
-		base = PHY_GetTxPowerByRate(padapter, path, RF_3TX, MGN_MCS23);
-		phy_SetTxPowerByRateBase(padapter, path, HT_MCS16_MCS23, RF_3TX, base);
-
 	}
 }
 
@@ -266,33 +241,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 		*RateNum = 4;
 		break;
 
-	case rTxAGC_A_Mcs11_Mcs08:
-	case rTxAGC_B_Mcs11_Mcs08:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS8);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS9);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS10);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS11);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case rTxAGC_A_Mcs15_Mcs12:
-	case rTxAGC_B_Mcs15_Mcs12:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS12);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS13);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS14);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS15);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-
-		break;
-
 	case rTxAGC_B_CCK1_55_Mcs32:
 		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_1M);
 		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_2M);
@@ -379,66 +327,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 		*RateNum = 4;
 		break;
 
-	case 0xC34:
-	case 0xE34:
-	case 0x1834:
-	case 0x1a34:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS8);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS9);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS10);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS11);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xC38:
-	case 0xE38:
-	case 0x1838:
-	case 0x1a38:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS12);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS13);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS14);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS15);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xCD8:
-	case 0xED8:
-	case 0x18D8:
-	case 0x1aD8:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS16);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS17);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS18);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS19);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
-	case 0xCDC:
-	case 0xEDC:
-	case 0x18DC:
-	case 0x1aDC:
-		RateIndex[0] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS20);
-		RateIndex[1] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS21);
-		RateIndex[2] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS22);
-		RateIndex[3] = PHY_GetRateIndexOfTxPowerByRate(MGN_MCS23);
-		for (i = 0; i < 4; ++i) {
-			PwrByRateVal[i] = (s8) ((((Value >> (i * 8 + 4)) & 0xF)) * 10 +
-											((Value >> (i * 8)) & 0xF));
-		}
-		*RateNum = 4;
-		break;
-
 	default:
 		break;
 	}
@@ -530,13 +418,6 @@ struct adapter *padapter
 	u8 mcs0_7Rates[8] = {
 		MGN_MCS0, MGN_MCS1, MGN_MCS2, MGN_MCS3, MGN_MCS4, MGN_MCS5, MGN_MCS6, MGN_MCS7
 	};
-	u8 mcs8_15Rates[8] = {
-		MGN_MCS8, MGN_MCS9, MGN_MCS10, MGN_MCS11, MGN_MCS12, MGN_MCS13, MGN_MCS14, MGN_MCS15
-	};
-	u8 mcs16_23Rates[8] = {
-		MGN_MCS16, MGN_MCS17, MGN_MCS18, MGN_MCS19, MGN_MCS20, MGN_MCS21, MGN_MCS22, MGN_MCS23
-	};
-
 	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
 		for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
 			/*  CCK */
@@ -560,19 +441,6 @@ struct adapter *padapter
 				PHY_SetTxPowerByRate(padapter, path, txNum, mcs0_7Rates[i], value - base);
 			}
 
-			/*  HT MCS8~15 */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS15);
-			for (i = 0; i < sizeof(mcs8_15Rates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs8_15Rates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, mcs8_15Rates[i], value - base);
-			}
-
-			/*  HT MCS16~23 */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS23);
-			for (i = 0; i < sizeof(mcs16_23Rates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, mcs16_23Rates[i], value - base);
-			}
 		}
 	}
 }
@@ -614,27 +482,6 @@ void PHY_SetTxPowerIndexByRateSection(
 					       Channel, htRates1T,
 					       ARRAY_SIZE(htRates1T));
 
-	} else if (RateSection == HT_MCS8_MCS15) {
-		u8 htRates2T[]  = {MGN_MCS8, MGN_MCS9, MGN_MCS10, MGN_MCS11, MGN_MCS12, MGN_MCS13, MGN_MCS14, MGN_MCS15};
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, htRates2T,
-					       ARRAY_SIZE(htRates2T));
-
-	} else if (RateSection == HT_MCS16_MCS23) {
-		u8 htRates3T[]  = {MGN_MCS16, MGN_MCS17, MGN_MCS18, MGN_MCS19, MGN_MCS20, MGN_MCS21, MGN_MCS22, MGN_MCS23};
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, htRates3T,
-					       ARRAY_SIZE(htRates3T));
-
-	} else if (RateSection == HT_MCS24_MCS31) {
-		u8 htRates4T[]  = {MGN_MCS24, MGN_MCS25, MGN_MCS26, MGN_MCS27, MGN_MCS28, MGN_MCS29, MGN_MCS30, MGN_MCS31};
-		PHY_SetTxPowerIndexByRateArray(padapter, RFPath,
-					       pHalData->CurrentChannelBW,
-					       Channel, htRates4T,
-					       ARRAY_SIZE(htRates4T));
-
 	}
 }
 
@@ -663,25 +510,11 @@ u8 PHY_GetTxPowerIndexBase(
 		txPower += pHalData->OFDM_24G_Diff[RFPath][TX_1S];
 
 	if (BandWidth == CHANNEL_WIDTH_20) { /*  BW20-1S, BW20-2S */
-		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS31)
+		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS7)
 			txPower += pHalData->BW20_24G_Diff[RFPath][TX_1S];
-		if (MGN_MCS8 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW20_24G_Diff[RFPath][TX_2S];
-		if (MGN_MCS16 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW20_24G_Diff[RFPath][TX_3S];
-		if (MGN_MCS24 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW20_24G_Diff[RFPath][TX_4S];
-
 	} else if (BandWidth == CHANNEL_WIDTH_40) { /*  BW40-1S, BW40-2S */
-		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS31)
+		if (MGN_MCS0 <= Rate && Rate <= MGN_MCS7)
 			txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
-		if (MGN_MCS8 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
-		if (MGN_MCS16 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
-		if (MGN_MCS24 <= Rate && Rate <= MGN_MCS31)
-			txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
-
 	}
 
 	return txPower;
@@ -768,78 +601,6 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate)
 	case MGN_MCS7:
 		index = 19;
 		break;
-	case MGN_MCS8:
-		index = 20;
-		break;
-	case MGN_MCS9:
-		index = 21;
-		break;
-	case MGN_MCS10:
-		index = 22;
-		break;
-	case MGN_MCS11:
-		index = 23;
-		break;
-	case MGN_MCS12:
-		index = 24;
-		break;
-	case MGN_MCS13:
-		index = 25;
-		break;
-	case MGN_MCS14:
-		index = 26;
-		break;
-	case MGN_MCS15:
-		index = 27;
-		break;
-	case MGN_MCS16:
-		index = 28;
-		break;
-	case MGN_MCS17:
-		index = 29;
-		break;
-	case MGN_MCS18:
-		index = 30;
-		break;
-	case MGN_MCS19:
-		index = 31;
-		break;
-	case MGN_MCS20:
-		index = 32;
-		break;
-	case MGN_MCS21:
-		index = 33;
-		break;
-	case MGN_MCS22:
-		index = 34;
-		break;
-	case MGN_MCS23:
-		index = 35;
-		break;
-	case MGN_MCS24:
-		index = 36;
-		break;
-	case MGN_MCS25:
-		index = 37;
-		break;
-	case MGN_MCS26:
-		index = 38;
-		break;
-	case MGN_MCS27:
-		index = 39;
-		break;
-	case MGN_MCS28:
-		index = 40;
-		break;
-	case MGN_MCS29:
-		index = 41;
-		break;
-	case MGN_MCS30:
-		index = 42;
-		break;
-	case MGN_MCS31:
-		index = 43;
-		break;
 	default:
 		break;
 	}
@@ -896,19 +657,10 @@ void PHY_SetTxPowerByRate(
 
 void PHY_SetTxPowerLevelByPath(struct adapter *Adapter, u8 channel, u8 path)
 {
-	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-
-	/* if (pMgntInfo->RegNByteAccess == 0) */
-	{
-		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, CCK);
+	PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, CCK);
 
-		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, OFDM);
-		PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, HT_MCS0_MCS7);
-
-		if (pHalData->NumTotalRFPath >= 2)
-			PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, HT_MCS8_MCS15);
-
-	}
+	PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, OFDM);
+	PHY_SetTxPowerIndexByRateSection(Adapter, path, channel, HT_MCS0_MCS7);
 }
 
 void PHY_SetTxPowerIndexByRateArray(
@@ -970,15 +722,6 @@ static s16 get_rate_sctn_idx(const u8 rate)
 	case MGN_MCS0: case MGN_MCS1: case MGN_MCS2: case MGN_MCS3:
 	case MGN_MCS4: case MGN_MCS5: case MGN_MCS6: case MGN_MCS7:
 		return 2;
-	case MGN_MCS8: case MGN_MCS9: case MGN_MCS10: case MGN_MCS11:
-	case MGN_MCS12: case MGN_MCS13: case MGN_MCS14: case MGN_MCS15:
-		return 3;
-	case MGN_MCS16: case MGN_MCS17: case MGN_MCS18: case MGN_MCS19:
-	case MGN_MCS20: case MGN_MCS21: case MGN_MCS22: case MGN_MCS23:
-		return 4;
-	case MGN_MCS24: case MGN_MCS25: case MGN_MCS26: case MGN_MCS27:
-	case MGN_MCS28: case MGN_MCS29: case MGN_MCS30: case MGN_MCS31:
-		return 5;
 	default:
 		return -1;
 	}
@@ -1070,13 +813,7 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 
 					for (rfPath = ODM_RF_PATH_A; rfPath < MAX_RF_PATH_NUM; ++rfPath) {
 						if (pHalData->odmpriv.PhyRegPgValueType == PHY_REG_PG_EXACT_VALUE) {
-							if (rateSection == 5) /*  HT 4T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_4TX, HT_MCS24_MCS31);
-							else if (rateSection == 4) /*  HT 3T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_3TX, HT_MCS16_MCS23);
-							else if (rateSection == 3) /*  HT 2T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_2TX, HT_MCS8_MCS15);
-							else if (rateSection == 2) /*  HT 1T */
+							if (rateSection == 2) /*  HT 1T */
 								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, HT_MCS0_MCS7);
 							else if (rateSection == 1) /*  OFDM */
 								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, OFDM);
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 859451810c48..17a5850183ad 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -186,10 +186,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			/*  */
 			/*  (3)EVM of HT rate */
 			/*  */
-			if (pPktinfo->data_rate >= DESC_RATEMCS8 && pPktinfo->data_rate <= DESC_RATEMCS15)
-				Max_spatial_stream = 2; /* both spatial stream make sense */
-			else
-				Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
+			Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
 
 			for (i = 0; i < Max_spatial_stream; i++) {
 				/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h b/drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h
index 1c6c08000e27..3c71938899e0 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h
@@ -111,8 +111,6 @@
 #define	ODM_REG_TXAGC_A_1_MCS32_11N	0xE08
 #define	ODM_REG_TXAGC_A_MCS0_3_11N		0xE10
 #define	ODM_REG_TXAGC_A_MCS4_7_11N		0xE14
-#define	ODM_REG_TXAGC_A_MCS8_11_11N	0xE18
-#define	ODM_REG_TXAGC_A_MCS12_15_11N	0xE1C
 #define	ODM_REG_FPGA0_IQK_11N			0xE28
 #define	ODM_REG_TXIQK_TONE_A_11N		0xE30
 #define	ODM_REG_RXIQK_TONE_A_11N		0xE34
diff --git a/drivers/staging/rtl8723bs/hal/odm_reg.h b/drivers/staging/rtl8723bs/hal/odm_reg.h
index 1ec6ffd69dbe..a3b1f673774c 100644
--- a/drivers/staging/rtl8723bs/hal/odm_reg.h
+++ b/drivers/staging/rtl8723bs/hal/odm_reg.h
@@ -32,10 +32,8 @@
 #define	ODM_TXAGC_B_MCS32_5			0x838
 #define	ODM_TXAGC_B_MCS0_MCS3			0x83c
 #define	ODM_TXAGC_B_MCS4_MCS7			0x848
-#define	ODM_TXAGC_B_MCS8_MCS11			0x84c
 #define	ODM_ANALOG_REGISTER			0x85c
 #define	ODM_RF_INTERFACE_OUTPUT			0x860
-#define	ODM_TXAGC_B_MCS12_MCS15			0x868
 #define	ODM_TXAGC_B_11_A_2_11			0x86c
 #define	ODM_AD_DA_LSB_MASK			0x874
 #define	ODM_ENABLE_3_WIRE			0x88c
@@ -71,8 +69,6 @@
 #define	ODM_TXAGC_A_1_MCS32			0xe08
 #define	ODM_TXAGC_A_MCS0_MCS3			0xe10
 #define	ODM_TXAGC_A_MCS4_MCS7			0xe14
-#define	ODM_TXAGC_A_MCS8_MCS11			0xe18
-#define	ODM_TXAGC_A_MCS12_MCS15			0xe1c
 
 /* RF REG */
 #define	ODM_GAIN_SETTING			0x00
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 1bc332261b2a..7be0ea20bca4 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -45,30 +45,6 @@
 #define DESC_RATEMCS5				0x11
 #define DESC_RATEMCS6				0x12
 #define DESC_RATEMCS7				0x13
-#define DESC_RATEMCS8				0x14
-#define DESC_RATEMCS9				0x15
-#define DESC_RATEMCS10				0x16
-#define DESC_RATEMCS11				0x17
-#define DESC_RATEMCS12				0x18
-#define DESC_RATEMCS13				0x19
-#define DESC_RATEMCS14				0x1a
-#define DESC_RATEMCS15				0x1b
-#define DESC_RATEMCS16				0x1C
-#define DESC_RATEMCS17				0x1D
-#define DESC_RATEMCS18				0x1E
-#define DESC_RATEMCS19				0x1F
-#define DESC_RATEMCS20				0x20
-#define DESC_RATEMCS21				0x21
-#define DESC_RATEMCS22				0x22
-#define DESC_RATEMCS23				0x23
-#define DESC_RATEMCS24				0x24
-#define DESC_RATEMCS25				0x25
-#define DESC_RATEMCS26				0x26
-#define DESC_RATEMCS27				0x27
-#define DESC_RATEMCS28				0x28
-#define DESC_RATEMCS29				0x29
-#define DESC_RATEMCS30				0x2A
-#define DESC_RATEMCS31				0x2B
 
 #define HDATA_RATE(rate)\
 (rate == DESC_RATE1M) ? "CCK_1M" : \
@@ -90,16 +66,7 @@
 (rate == DESC_RATEMCS4) ? "MCS4" : \
 (rate == DESC_RATEMCS5) ? "MCS5" : \
 (rate == DESC_RATEMCS6) ? "MCS6" : \
-(rate == DESC_RATEMCS7) ? "MCS7" : \
-(rate == DESC_RATEMCS8) ? "MCS8" : \
-(rate == DESC_RATEMCS9) ? "MCS9" : \
-(rate == DESC_RATEMCS10) ? "MCS10" : \
-(rate == DESC_RATEMCS11) ? "MCS11" : \
-(rate == DESC_RATEMCS12) ? "MCS12" : \
-(rate == DESC_RATEMCS13) ? "MCS13" : \
-(rate == DESC_RATEMCS14) ? "MCS14" : \
-(rate == DESC_RATEMCS15) ? "MCS15" : "UNKNOWN"
-
+(rate == DESC_RATEMCS7) ? "MCS7" : "UNKNOWN"
 
 enum{
 	UP_LINK,
diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index c966d0e3e5ae..637089fed93d 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -16,9 +16,6 @@ enum rate_section {
 	CCK = 0,
 	OFDM,
 	HT_MCS0_MCS7,
-	HT_MCS8_MCS15,
-	HT_MCS16_MCS23,
-	HT_MCS24_MCS31,
 };
 
 enum {
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index b2f179b48019..8213dcf48b34 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -662,15 +662,6 @@ Default: 00b.
 #define	RATR_MCS5					0x00020000
 #define	RATR_MCS6					0x00040000
 #define	RATR_MCS7					0x00080000
-/* MCS 2 Spatial Stream */
-#define	RATR_MCS8					0x00100000
-#define	RATR_MCS9					0x00200000
-#define	RATR_MCS10					0x00400000
-#define	RATR_MCS11					0x00800000
-#define	RATR_MCS12					0x01000000
-#define	RATR_MCS13					0x02000000
-#define	RATR_MCS14					0x04000000
-#define	RATR_MCS15					0x08000000
 
 /* CCK */
 #define RATE_1M					BIT(0)
@@ -695,16 +686,6 @@ Default: 00b.
 #define RATE_MCS5				BIT(17)
 #define RATE_MCS6				BIT(18)
 #define RATE_MCS7				BIT(19)
-/* MCS 2 Spatial Stream */
-#define RATE_MCS8				BIT(20)
-#define RATE_MCS9				BIT(21)
-#define RATE_MCS10				BIT(22)
-#define RATE_MCS11				BIT(23)
-#define RATE_MCS12				BIT(24)
-#define RATE_MCS13				BIT(25)
-#define RATE_MCS14				BIT(26)
-#define RATE_MCS15				BIT(27)
-
 
 /*  ALL CCK Rate */
 #define RATE_BITMAP_ALL			0xFFFFF
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index b3a9bcce4c44..89851fa36830 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -389,30 +389,6 @@ enum {
 	MGN_MCS5,
 	MGN_MCS6,
 	MGN_MCS7,
-	MGN_MCS8,
-	MGN_MCS9,
-	MGN_MCS10,
-	MGN_MCS11,
-	MGN_MCS12,
-	MGN_MCS13,
-	MGN_MCS14,
-	MGN_MCS15,
-	MGN_MCS16,
-	MGN_MCS17,
-	MGN_MCS18,
-	MGN_MCS19,
-	MGN_MCS20,
-	MGN_MCS21,
-	MGN_MCS22,
-	MGN_MCS23,
-	MGN_MCS24,
-	MGN_MCS25,
-	MGN_MCS26,
-	MGN_MCS27,
-	MGN_MCS28,
-	MGN_MCS29,
-	MGN_MCS30,
-	MGN_MCS31,
 	MGN_UNKNOWN
 };
 
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
index 9dd329a5208a..ad2542d0cabe 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
@@ -394,14 +394,6 @@ struct txdesc_8723b {
 #define DESC8723B_RATEMCS5				0x11
 #define DESC8723B_RATEMCS6				0x12
 #define DESC8723B_RATEMCS7				0x13
-#define DESC8723B_RATEMCS8				0x14
-#define DESC8723B_RATEMCS9				0x15
-#define DESC8723B_RATEMCS10		0x16
-#define DESC8723B_RATEMCS11		0x17
-#define DESC8723B_RATEMCS12		0x18
-#define DESC8723B_RATEMCS13		0x19
-#define DESC8723B_RATEMCS14		0x1a
-#define DESC8723B_RATEMCS15		0x1b
 
 #define		RX_HAL_IS_CCK_RATE_8723B(pDesc)\
 			(GET_RX_STATUS_DESC_RX_RATE_8723B(pDesc) == DESC8723B_RATE1M ||\
-- 
2.20.1

