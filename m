Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15934FD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhCaJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhCaJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F53C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u5so29092514ejn.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zzu/naQlTfeDdIymu6+OBXWmErHfYV2FAMDHHOpNGVc=;
        b=RTsclca2YVZU0xxtbekkgRed2clZcZxH4xFxd/omDyvz9GjAE2XHIF3RgRrAsHra45
         Epbh/i+1GjKfM+vLjQz6FOfb4YvE/h3vSf+bqwFmfK9Y1JYQq2mxxYJAJBX6pY73GD0q
         DERO0BV/bL96ux/tiffEMPXYSZ6ToCh9Fe+5UYRQvQFIk5CX+A4KRXufy6/q6hynTuEB
         IeCbJHNjAquk7N3taIRszOulln/Uq9LpNfjtg0+MXx1Shp4QsRDh2SIPRhFs9OPYh67R
         77ffRnlZ4gaEGEWEt06st8WXGJStUH3tqgw05N07umNm9S54WPl/fzmvk9OZF7Uzw2Yf
         hRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zzu/naQlTfeDdIymu6+OBXWmErHfYV2FAMDHHOpNGVc=;
        b=kcnNy/yClPu5NFUG1SgtxWFEFocjpDt43gVFZIAZ3MGh91Z/5Ear19LcR6MGxLjVX5
         zN5KNCONz8Ih9WVbNnzUDrri/kva4Iro0bf3YhpAyoFLZAcwjAqkqKnEezN+5PjcK3jC
         tvD37dQ2Pf5vge7uAPgTTFvvvSpLMu7YMmXE7pu6f/3xOo2pB3pYOi5PNakUfYPaCVZT
         V8WrAEzKZAGRt5wgpG33oae3rYubdO4fjFykODDEavD7brtwQkPxBphXINLQgJ+uOIec
         GTCz6pgj8Me5TEdn+BfJw+eO59KoRMcom7dygbfPbZ5kLqdRzrbpPGmrvljraS0+cA6T
         ENJQ==
X-Gm-Message-State: AOAM532ysuT/rSFWxLmXYNgYKH3tN86i7d1JYMiFFrMDuGUOYXWES661
        vQ+u4nxWAInd0Bt2ocMwnJE=
X-Google-Smtp-Source: ABdhPJx7b4kIt3W4HPrmUANUKuGSjw9K21dofNOvBBoDrLhHXnxeGaD1vmOsq2jNUddERIDx6uN+1g==
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr2539330ejc.283.1617183650619;
        Wed, 31 Mar 2021 02:40:50 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id v22sm811037ejj.103.2021.03.31.02.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 20/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/rtl8723b_hal_init.c
Date:   Wed, 31 Mar 2021 11:39:48 +0200
Message-Id: <9e9bc5f1fe6bdbdcddf4fc5dc2358cb4ba63423e.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 143 +++++++++---------
 1 file changed, 68 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index e9d107093942..fa904061a9c3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -65,17 +65,12 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	remainSize_p1 = buffSize % blockSize_p1;
 
 	if (blockCount_p1) {
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_notice_,
-			(
-				"_BlockWrite: [P1] buffSize(%d) blockSize_p1(%d) blockCount_p1(%d) remainSize_p1(%d)\n",
-				buffSize,
-				blockSize_p1,
-				blockCount_p1,
-				remainSize_p1
-			)
-		);
+		pr_notice("%s %s: [P1] buffSize(%d) blockSize_p1(%d) blockCount_p1(%d) remainSize_p1(%d)\n",
+			  DRIVER_PREFIX, __func__,
+			  buffSize,
+			  blockSize_p1,
+			  blockCount_p1,
+			  remainSize_p1);
 	}
 
 	for (i = 0; i < blockCount_p1; i++) {
@@ -94,17 +89,12 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 		remainSize_p2 = remainSize_p1%blockSize_p2;
 
 		if (blockCount_p2) {
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_notice_,
-					(
-						"_BlockWrite: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
-						(buffSize-offset),
-						blockSize_p2,
-						blockCount_p2,
-						remainSize_p2
-					)
-				);
+			pr_notice("%s %s: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
+				  DRIVER_PREFIX, __func__,
+				  (buffSize-offset),
+				  blockSize_p2,
+				  blockCount_p2,
+				  remainSize_p2);
 		}
 
 	}
@@ -115,9 +105,9 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 
 		blockCount_p3 = remainSize_p2 / blockSize_p3;
 
-		RT_TRACE(_module_hal_init_c_, _drv_notice_,
-				("_BlockWrite: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
-				(buffSize-offset), blockSize_p3, blockCount_p3));
+		pr_notice("%s %s: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
+			  DRIVER_PREFIX, __func__, (buffSize-offset), blockSize_p3,
+			  blockCount_p3);
 
 		for (i = 0; i < blockCount_p3; i++) {
 			ret = rtw_write8(padapter, (FW_8723B_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
@@ -181,7 +171,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 			goto exit;
 		}
 	}
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("_WriteFW Done- for Normal chip.\n"));
+	pr_info("%s %s Done- for Normal chip.\n", DRIVER_PREFIX, __func__);
 
 exit:
 	return ret;
@@ -334,10 +324,10 @@ void rtl8723b_FirmwareSelfReset(struct adapter *padapter)
 			udelay(50);
 			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
 		}
-		RT_TRACE(_module_hal_init_c_, _drv_notice_, ("-%s: 8051 reset success (%d)\n", __func__, Delay));
+		pr_notice("%s-%s: 8051 reset success (%d)\n", DRIVER_PREFIX, __func__, Delay);
 
 		if (Delay == 0) {
-			RT_TRACE(_module_hal_init_c_, _drv_notice_, ("%s: Force 8051 reset!!!\n", __func__));
+			pr_notice("%s %s: Force 8051 reset!!!\n", DRIVER_PREFIX, __func__);
 			/* force firmware reset */
 			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
 			rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT2));
@@ -368,7 +358,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 	u8 tmp_ps;
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("+%s\n", __func__));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 	pFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
 	if (!pFirmware)
 		return _FAIL;
@@ -410,11 +400,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 
 	if (fw->size > FW_8723B_SIZE) {
 		rtStatus = _FAIL;
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_err_,
-			("Firmware size exceed 0x%X. Check it.\n", FW_8723B_SIZE)
-		);
+		pr_err("%s Firmware size exceed 0x%X. Check it.\n", DRIVER_PREFIX, FW_8723B_SIZE);
 		goto exit;
 	}
 
@@ -1953,7 +1939,7 @@ static void ResumeTxBeacon(struct adapter *padapter)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+ResumeTxBeacon\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	pHalData->RegFwHwTxQCtrl |= BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
@@ -1970,7 +1956,7 @@ static void StopTxBeacon(struct adapter *padapter)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+StopTxBeacon\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	pHalData->RegFwHwTxQCtrl &= ~BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
@@ -2315,7 +2301,8 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
 		else if (12 <= Channel && Channel <= 14)
 			*pGroup = 4;
 		else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 2.4 G, but Channel %d in Group not found\n", Channel));
+			pr_notice("%s ==> %s in 2.4 G, but Channel %d in Group not found\n",
+				  DRIVER_PREFIX, __func__, Channel);
 		}
 	} else {
 		bIn24G = false;
@@ -2349,20 +2336,16 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
 		else if (173  <= Channel && Channel <= 177)
 			*pGroup = 13;
 		else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 5G, but Channel %d in Group not found\n", Channel));
+			pr_notice("%s ==> %s in 5G, but Channel %d in Group not found\n",
+				  DRIVER_PREFIX, __func__, Channel);
 		}
 
 	}
-	RT_TRACE(
-		_module_hci_hal_init_c_,
-		_drv_info_,
-		(
-			"<==Hal_GetChnlGroup8723B,  (%s) Channel = %d, Group =%d,\n",
-			bIn24G ? "2.4G" : "5G",
-			Channel,
-			*pGroup
-		)
-	);
+	pr_info("%s <== %s,  (%s) Channel = %d, Group =%d,\n",
+		DRIVER_PREFIX, __func__,
+		bIn24G ? "2.4G" : "5G",
+		Channel,
+		*pGroup);
 	return bIn24G;
 }
 
@@ -2377,7 +2360,7 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 			memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 		}
 	} else {/* autoload fail */
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
+		pr_notice("%s AutoLoad Fail reported from CR9346!!\n", DRIVER_PREFIX);
 		if (!pEEPROM->EepromOrEfuse)
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
@@ -2399,7 +2382,7 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
 	} else
 		pEEPROM->bautoload_fail_flag = false;
 
-	RT_TRACE(_module_hal_init_c_, _drv_notice_, ("EEPROM ID = 0x%04x\n", EEPROMId));
+	pr_notice("%s EEPROM ID = 0x%04x\n", DRIVER_PREFIX, EEPROMId);
 }
 
 static void Hal_ReadPowerValueFromPROM_8723B(
@@ -2541,9 +2524,12 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
 			}
 #ifdef DEBUG
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("======= Path %d, ChannelIndex %d, Group %d =======\n", rfPath, ch, group));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]));
+			pr_info("%s ======= Path %d, ChannelIndex %d, Group %d =======\n",
+				DRIVER_PREFIX, rfPath, ch, group);
+			pr_info("%s Index24G_CCK_Base[%d][%d] = 0x%x\n", DRIVER_PREFIX,
+				rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
+			pr_info("%s Index24G_BW40_Base[%d][%d] = 0x%x\n", DRIVER_PREFIX,
+				rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
 #endif
 		}
 
@@ -2554,11 +2540,16 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
 
 #ifdef DEBUG
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("--------------------------------------- 2.4G ---------------------------------------\n"));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("CCK_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("OFDM_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW20_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW40_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]));
+			pr_info("%s --------------------------------------- 2.4G ---------------------------------------\n",
+				DRIVER_PREFIX);
+			pr_info("%s CCK_24G_Diff[%d][%d]= %d\n", DRIVER_PREFIX, rfPath, TxCount,
+				pHalData->CCK_24G_Diff[rfPath][TxCount]);
+			pr_info("%s OFDM_24G_Diff[%d][%d]= %d\n", DRIVER_PREFIX, rfPath, TxCount,
+				pHalData->OFDM_24G_Diff[rfPath][TxCount]);
+			pr_info("%s BW20_24G_Diff[%d][%d]= %d\n", DRIVER_PREFIX, rfPath, TxCount,
+				pHalData->BW20_24G_Diff[rfPath][TxCount]);
+			pr_info("%s BW40_24G_Diff[%d][%d]= %d\n", DRIVER_PREFIX, rfPath, TxCount,
+				pHalData->BW40_24G_Diff[rfPath][TxCount]);
 #endif
 		}
 	}
@@ -2571,7 +2562,7 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 	} else
 		pHalData->EEPROMRegulatory = 0;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory));
+	pr_info("%s EEPROMRegulatory = 0x%x\n", DRIVER_PREFIX, pHalData->EEPROMRegulatory);
 }
 
 void Hal_EfuseParseBTCoexistInfo_8723B(
@@ -2660,8 +2651,7 @@ void Hal_EfuseParseEEPROMVer_8723B(
 		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
 	else
 		pHalData->EEPROMVersion = 1;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
-		pHalData->EEPROMVersion));
+	pr_notice("%s %s, EEVer = %d\n", DRIVER_PREFIX, __func__, pHalData->EEPROMVersion);
 }
 
 
@@ -2729,7 +2719,7 @@ void Hal_EfuseParseChnlPlan_8723B(
 
 	Hal_ChannelPlanToRegulation(padapter, padapter->mlmepriv.ChannelPlan);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan));
+	pr_notice("%s EEPROM ChannelPlan = 0x%02x\n", DRIVER_PREFIX, padapter->mlmepriv.ChannelPlan);
 }
 
 void Hal_EfuseParseCustomerID_8723B(
@@ -2743,7 +2733,7 @@ void Hal_EfuseParseCustomerID_8723B(
 	else
 		pHalData->EEPROMCustomerID = 0;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID));
+	pr_notice("%s EEPROM Customer ID: 0x%2x\n", DRIVER_PREFIX, pHalData->EEPROMCustomerID);
 }
 
 void Hal_EfuseParseAntennaDiversity_8723B(
@@ -2767,7 +2757,7 @@ void Hal_EfuseParseXtal_8723B(
 	} else
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM CrystalCap: 0x%2x\n", pHalData->CrystalCap));
+	pr_notice("%s EEPROM CrystalCap: 0x%2x\n", DRIVER_PREFIX, pHalData->CrystalCap);
 }
 
 
@@ -2790,7 +2780,7 @@ void Hal_EfuseParseThermalMeter_8723B(
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
 	}
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter));
+	pr_notice("%s EEPROM ThermalMeter = 0x%x\n", DRIVER_PREFIX, pHalData->EEPROMThermalMeter);
 }
 
 
@@ -3107,9 +3097,10 @@ static void rtl8723b_fill_default_txdesc(
 			ptxdesc->sw_define = (u8)(GET_PRIMARY_ADAPTER(padapter)->xmitpriv.seq_no);
 		}
 	} else if (pxmitframe->frame_tag == TXAGG_FRAMETAG) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: TXAGG_FRAMETAG\n", __func__));
+		pr_warn("%s %s: TXAGG_FRAMETAG\n", DRIVER_PREFIX, __func__);
 	} else {
-		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: frame_tag = 0x%x\n", __func__, pxmitframe->frame_tag));
+		pr_warn("%s %s: frame_tag = 0x%x\n", DRIVER_PREFIX, __func__,
+			pxmitframe->frame_tag);
 
 		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
 		ptxdesc->rate_id = pattrib->raid; /*  Rate ID */
@@ -3584,7 +3575,7 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("c2h_handler_8723b: %s\n", pC2hEvent->payload));
+			pr_info("%s %s: %s\n", DRIVER_PREFIX, __func__, pC2hEvent->payload);
 		}
 		break;
 
@@ -3597,9 +3588,10 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
+		pr_info("%s [BT], C2H_HW_INFO_EXCH\n", DRIVER_PREFIX);
 		for (index = 0; index < pC2hEvent->plen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, pC2hEvent->payload[index]));
+			pr_info("%s [BT], tmpBuf[%d]= 0x%x\n", DRIVER_PREFIX,
+				index, pC2hEvent->payload[index]);
 		}
 		break;
 
@@ -3633,7 +3625,7 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("C2HCommandHandler: %s\n", c2hBuf));
+			pr_info("%s C2HCommandHandler: %s\n", DRIVER_PREFIX, c2hBuf);
 		}
 		break;
 
@@ -3646,9 +3638,9 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
+		pr_info("%s [BT], C2H_HW_INFO_EXCH\n", DRIVER_PREFIX);
 		for (index = 0; index < pC2hEvent->CmdLen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, c2hBuf[index]));
+			pr_info("%s [BT], tmpBuf[%d]= 0x%x\n", DRIVER_PREFIX, index, c2hBuf[index]);
 		}
 		break;
 
@@ -4049,7 +4041,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			u32 usNavUpper = *((u32 *)val);
 
 			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF) {
-				RT_TRACE(_module_hal_init_c_, _drv_notice_, ("The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n", usNavUpper, HAL_NAV_UPPER_UNIT_8723B));
+				pr_notice("%s The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n",
+					  DRIVER_PREFIX, usNavUpper, HAL_NAV_UPPER_UNIT_8723B);
 				break;
 			}
 
@@ -4353,7 +4346,7 @@ void rtl8723b_start_thread(struct adapter *padapter)
 
 	xmitpriv->SdioXmitThread = kthread_run(rtl8723bs_xmit_thread, padapter, "RTWHALXT");
 	if (IS_ERR(xmitpriv->SdioXmitThread)) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("%s: start rtl8723bs_xmit_thread FAIL!!\n", __func__));
+		pr_err("%s %s: start rtl8723bs_xmit_thread FAIL!!\n", DRIVER_PREFIX, __func__);
 	}
 }
 
-- 
2.20.1

