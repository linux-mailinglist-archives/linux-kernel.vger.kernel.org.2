Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835DC351212
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhDAJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhDAJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06201C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so1843684ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjYgXvdObXfWEVE678CYI2Su97AYacWD68NqQqzOyU0=;
        b=ddkqfdJxT4mt63yXl7U9WGZNQx5Eu+PqN8dcuQsbnyQVn317PI+rjgtxgRHza+tQCL
         2XLDuHuRV4BPg142bIp15AwsSGMPgxYKqmHDhtv7hkcZ4SCIh1lVTW9+USNtBTO+5Zhu
         AtjbBmn91KzYguQ/qahQyEPkWpmTDyS+bQk83YeYf5+e03g6UiQPlxPasPqAL3ikWMlc
         tppUhDAUxzrLs1v44PEsKkFJsqGqNh8887+DqRN0ZZMuI3qkOx1GjWAiHx/rtTSJnJWB
         cGdBdQMHzL1GNxV/bxMP28h2vT9U8hHi2HL4QQE5+vvb6ngfJ3YjUPzjRTFM8tlSyij3
         IcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjYgXvdObXfWEVE678CYI2Su97AYacWD68NqQqzOyU0=;
        b=HV/Qz/xnzmpvpLxcYE6konrwRPAVQeiFmKIVocDBfJkjOvweNzCXfmSVu8dSCLOsuS
         NCl0vIZdqGJQWFvOFPWuPb3ibBRfI6RTGvV8s2B6AKH9NOEjs62l3xF321keNoiuCVsY
         RLqDt/Qgm/FQ29+viNDR6nh5V27oeI5u+pAGZo73bjQdNKDuoSYEp2ZY8DnxWYZajMo5
         Q2uKEpr5FXNwMMoxDJDx/b3iIK/kmtm5e4cArHE8xhwgXF4y+/BFzRJljLOOIuZwBIGU
         AyVY2Kg7e4LfGPQZDdehinMiujdFb9RVzAKgssMBrVSfV6K44j9gPtQyWM2Gcrm+x+OY
         wFbg==
X-Gm-Message-State: AOAM532VyYzDFovkT/lPHI7ewTorPcj/pWoUGkLz/nv7eb3C9htY1hFJ
        Nmc1KT/I2o7uzzVyfjTKSlNDKlLloCUC2w==
X-Google-Smtp-Source: ABdhPJyArpzC3gXEDEUj2yVwPuE2KelodJxsZ174y9hADdDR9Vd52za+VZtgKkibp7cotV+jee0OXQ==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr8195692ejc.214.1617268926758;
        Thu, 01 Apr 2021 02:22:06 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id s20sm3209074edu.93.2021.04.01.02.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 26/49] staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723b_hal_init.c
Date:   Thu,  1 Apr 2021 11:20:56 +0200
Message-Id: <04c821cfa66ca25992c3da54070728b0838c3c80.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 86 -------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0273118e70af..20b66bf942e4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -65,17 +65,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
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
 	}
 
 	for (i = 0; i < blockCount_p1; i++) {
@@ -94,17 +83,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
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
 		}
 
 	}
@@ -115,10 +93,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 
 		blockCount_p3 = remainSize_p2 / blockSize_p3;
 
-		RT_TRACE(_module_hal_init_c_, _drv_notice_,
-				("_BlockWrite: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
-				(buffSize-offset), blockSize_p3, blockCount_p3));
-
 		for (i = 0; i < blockCount_p3; i++) {
 			ret = rtw_write8(padapter, (FW_8723B_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
 
@@ -181,7 +155,6 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 			goto exit;
 		}
 	}
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("_WriteFW Done- for Normal chip.\n"));
 
 exit:
 	return ret;
@@ -334,10 +307,8 @@ void rtl8723b_FirmwareSelfReset(struct adapter *padapter)
 			udelay(50);
 			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
 		}
-		RT_TRACE(_module_hal_init_c_, _drv_notice_, ("-%s: 8051 reset success (%d)\n", __func__, Delay));
 
 		if (Delay == 0) {
-			RT_TRACE(_module_hal_init_c_, _drv_notice_, ("%s: Force 8051 reset!!!\n", __func__));
 			/* force firmware reset */
 			u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
 			rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT2));
@@ -368,7 +339,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 	u8 tmp_ps;
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("+%s\n", __func__));
 	pFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
 	if (!pFirmware)
 		return _FAIL;
@@ -409,11 +379,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 
 	if (fw->size > FW_8723B_SIZE) {
 		rtStatus = _FAIL;
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_err_,
-			("Firmware size exceed 0x%X. Check it.\n", FW_8188E_SIZE)
-		);
 		goto exit;
 	}
 
@@ -1952,8 +1917,6 @@ static void ResumeTxBeacon(struct adapter *padapter)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+ResumeTxBeacon\n"));
-
 	pHalData->RegFwHwTxQCtrl |= BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0xff);
@@ -1969,8 +1932,6 @@ static void StopTxBeacon(struct adapter *padapter)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+StopTxBeacon\n"));
-
 	pHalData->RegFwHwTxQCtrl &= ~BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0x64);
@@ -2314,7 +2275,6 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
 		else if (12 <= Channel && Channel <= 14)
 			*pGroup = 4;
 		else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 2.4 G, but Channel %d in Group not found\n", Channel));
 		}
 	} else {
 		bIn24G = false;
@@ -2348,20 +2308,9 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
 		else if (173  <= Channel && Channel <= 177)
 			*pGroup = 13;
 		else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 5G, but Channel %d in Group not found\n", Channel));
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
 	return bIn24G;
 }
 
@@ -2376,7 +2325,6 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 			memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 		}
 	} else {/* autoload fail */
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
 		if (!pEEPROM->EepromOrEfuse)
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
@@ -2398,7 +2346,6 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
 	} else
 		pEEPROM->bautoload_fail_flag = false;
 
-	RT_TRACE(_module_hal_init_c_, _drv_notice_, ("EEPROM ID = 0x%04x\n", EEPROMId));
 }
 
 static void Hal_ReadPowerValueFromPROM_8723B(
@@ -2540,9 +2487,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
 			}
 #ifdef DEBUG
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("======= Path %d, ChannelIndex %d, Group %d =======\n", rfPath, ch, group));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]));
 #endif
 		}
 
@@ -2553,11 +2497,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
 
 #ifdef DEBUG
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("--------------------------------------- 2.4G ---------------------------------------\n"));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("CCK_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("OFDM_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW20_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("BW40_24G_Diff[%d][%d]= %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]));
 #endif
 		}
 	}
@@ -2570,7 +2509,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 	} else
 		pHalData->EEPROMRegulatory = 0;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory));
 }
 
 void Hal_EfuseParseBTCoexistInfo_8723B(
@@ -2655,13 +2593,10 @@ void Hal_EfuseParseEEPROMVer_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
 	else
 		pHalData->EEPROMVersion = 1;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
-		pHalData->EEPROMVersion));
 }
 
 
@@ -2729,7 +2664,6 @@ void Hal_EfuseParseChnlPlan_8723B(
 
 	Hal_ChannelPlanToRegulation(padapter, padapter->mlmepriv.ChannelPlan);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan));
 }
 
 void Hal_EfuseParseCustomerID_8723B(
@@ -2738,13 +2672,11 @@ void Hal_EfuseParseCustomerID_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CustomID_8723B];
 	else
 		pHalData->EEPROMCustomerID = 0;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID));
 }
 
 void Hal_EfuseParseAntennaDiversity_8723B(
@@ -2761,7 +2693,6 @@ void Hal_EfuseParseXtal_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail) {
 		pHalData->CrystalCap = hwinfo[EEPROM_XTAL_8723B];
 		if (pHalData->CrystalCap == 0xFF)
@@ -2769,7 +2700,6 @@ void Hal_EfuseParseXtal_8723B(
 	} else
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM CrystalCap: 0x%2x\n", pHalData->CrystalCap));
 }
 
 
@@ -2779,7 +2709,6 @@ void Hal_EfuseParseThermalMeter_8723B(
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	/*  */
 	/*  ThermalMeter from EEPROM */
 	/*  */
@@ -2793,7 +2722,6 @@ void Hal_EfuseParseThermalMeter_8723B(
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
 	}
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter));
 }
 
 
@@ -3083,7 +3011,6 @@ static void rtl8723b_fill_default_txdesc(
 
 		ptxdesc->usb_txagg_num = pxmitframe->agg_num;
 	} else if (pxmitframe->frame_tag == MGNT_FRAMETAG) {
-/* 		RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("%s: MGNT_FRAMETAG\n", __func__)); */
 
 		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
 		ptxdesc->qsel = pattrib->qsel;
@@ -3111,10 +3038,7 @@ static void rtl8723b_fill_default_txdesc(
 			ptxdesc->sw_define = (u8)(GET_PRIMARY_ADAPTER(padapter)->xmitpriv.seq_no);
 		}
 	} else if (pxmitframe->frame_tag == TXAGG_FRAMETAG) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: TXAGG_FRAMETAG\n", __func__));
 	} else {
-		RT_TRACE(_module_hal_xmit_c_, _drv_warning_, ("%s: frame_tag = 0x%x\n", __func__, pxmitframe->frame_tag));
-
 		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
 		ptxdesc->rate_id = pattrib->raid; /*  Rate ID */
 		ptxdesc->qsel = pattrib->qsel;
@@ -3588,7 +3512,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("c2h_handler_8723b: %s\n", pC2hEvent->payload));
 		}
 		break;
 
@@ -3601,9 +3524,7 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
 		for (index = 0; index < pC2hEvent->plen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, pC2hEvent->payload[index]));
 		}
 		break;
 
@@ -3637,7 +3558,6 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("C2HCommandHandler: %s\n", c2hBuf));
 		}
 		break;
 
@@ -3650,9 +3570,7 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
 		for (index = 0; index < pC2hEvent->CmdLen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, c2hBuf[index]));
 		}
 		break;
 
@@ -3867,9 +3785,7 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				rtw_write32(padapter, WCAMI, ulContent);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A4: %lx\n", ulContent)); */
 				rtw_write32(padapter, RWCAM, ulCommand);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A0: %lx\n", ulCommand)); */
 			}
 		}
 		break;
@@ -4055,7 +3971,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			u32 usNavUpper = *((u32 *)val);
 
 			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF) {
-				RT_TRACE(_module_hal_init_c_, _drv_notice_, ("The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n", usNavUpper, HAL_NAV_UPPER_UNIT_8723B));
 				break;
 			}
 
@@ -4359,7 +4274,6 @@ void rtl8723b_start_thread(struct adapter *padapter)
 
 	xmitpriv->SdioXmitThread = kthread_run(rtl8723bs_xmit_thread, padapter, "RTWHALXT");
 	if (IS_ERR(xmitpriv->SdioXmitThread)) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("%s: start rtl8723bs_xmit_thread FAIL!!\n", __func__));
 	}
 }
 
-- 
2.20.1

