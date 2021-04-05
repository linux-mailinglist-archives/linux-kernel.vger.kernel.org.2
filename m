Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03C3545A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhDEQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhDEQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso5921851wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcswCNmcb0cgmZEQTc45N/mSZlD4UGly7Xqd2gDwvkE=;
        b=PykgBNoIap6HSbwtGRwRc+4Od16RPzpKq5IbqECx3mutqxXGQLQLvN2rieu7BUP2Np
         SJPLB/jVGTf2ZQAfypeihquchJwHb5O68kUCBP6t/ovLjz9aFe7Zxu4WUfa6xCI34KyA
         fDqNc0QoqokKsavlq5yZDxUbYoJ1xxUPDKYaQLfPhH8ZgWbY3uzNxbUahDvkCxeLYdba
         VIcwr12zhQve1jfbwW72H+Wb3tOI34+LapXUx2IFSDXjiLg3M4nllnDgdDfe5eTsQXZA
         Yh1RvyMMFdWtCRmUlKj5lyVkLSZB+8Q3GqkFYYAcDuP8SE1TdMylR+gsKZbxLEwlf5TR
         SIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcswCNmcb0cgmZEQTc45N/mSZlD4UGly7Xqd2gDwvkE=;
        b=Ms6qACMR/eyP1vbzQNUSrUTtuHBrqQHu36bClno14e/aud8yXPpkgvkp/WR0swsXsi
         fFdOi40onuXk+UOI+dyMF+WzWA42qVkGKEPOqX+7V5+l314jkdOGISwAyzrmN7M4Zw4x
         +V9gTMkHbtywo5sqFTe6Xri6EohCCvTkmpCcngxOcorA9eT4uFH8h2IGnxVKASLqdjEr
         YAyPCO5idYuvTYknaP5rdoFX9G490uSy8Od0gk35+X9hCRP8MNzebn5uSnTg0g+tFaJj
         rO2SxmAAz5wscSfXQNzIaMUoGM0ZhSBjtOw+IyMcVta6cZtlEiu2/8lkDzp4wWv1MCyr
         dQ0g==
X-Gm-Message-State: AOAM5339VLtcmez+BvfeWMPgYRkcgdRD9wgnVZxhZ60YKv7momCdXwm6
        ty4Jl19/sFsSxul0y/SHQzw=
X-Google-Smtp-Source: ABdhPJxIIo4UR3rHRdaSUJFzsKZC7JthZsbPupv6UEEvzjpE7/Dvehl9ky3TjUvN0HCssy6P4RSQVw==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr54204wmi.136.1617641413248;
        Mon, 05 Apr 2021 09:50:13 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id q10sm12966689wrx.35.2021.04.05.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/10] staging: rtl8723bs: remove all RT_TRACE logs in hal/ and os_dep/
Date:   Mon,  5 Apr 2021 18:49:48 +0200
Message-Id: <f5c6f61461ad957ecd5998019ac1ee1215dde097.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in hal/ and os_dep/ files as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

This bulk remove has been done with the following semantic
patch:

@@
expression a, b, c;
@@

-	RT_TRACE(a, b, (c));

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  | 46 ---------
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  2 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 93 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 32 +------
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  2 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 32 -------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 34 -------
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 31 -------
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 --
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 53 -----------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |  4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 46 ---------
 .../staging/rtl8723bs/os_dep/osdep_service.c  |  1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  9 --
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 15 ---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  5 -
 16 files changed, 3 insertions(+), 408 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index 932b31fda6ad..b1f271c65c3e 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -53,22 +53,6 @@ u8 HalPwrSeqCmdParsing(
 	do {
 		PwrCfgCmd = PwrSeqCmd[AryIdx];
 
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_info_,
-			(
-				"HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
-				GET_PWR_CFG_OFFSET(PwrCfgCmd),
-				GET_PWR_CFG_CUT_MASK(PwrCfgCmd),
-				GET_PWR_CFG_FAB_MASK(PwrCfgCmd),
-				GET_PWR_CFG_INTF_MASK(PwrCfgCmd),
-				GET_PWR_CFG_BASE(PwrCfgCmd),
-				GET_PWR_CFG_CMD(PwrCfgCmd),
-				GET_PWR_CFG_MASK(PwrCfgCmd),
-				GET_PWR_CFG_VALUE(PwrCfgCmd)
-			)
-		);
-
 		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
 		if (
 			(GET_PWR_CFG_FAB_MASK(PwrCfgCmd) & FabVersion) &&
@@ -77,19 +61,9 @@ u8 HalPwrSeqCmdParsing(
 		) {
 			switch (GET_PWR_CFG_CMD(PwrCfgCmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_READ\n")
-				);
 				break;
 
 			case PWR_CMD_WRITE:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n")
-				);
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
 
 				/*  */
@@ -124,11 +98,6 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_POLLING:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n")
-				);
 
 				bPollingBit = false;
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
@@ -160,11 +129,6 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_DELAY:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n")
-				);
 				if (GET_PWR_CFG_VALUE(PwrCfgCmd) == PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(PwrCfgCmd));
 				else
@@ -173,19 +137,9 @@ u8 HalPwrSeqCmdParsing(
 
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_END\n")
-				);
 				return true;
 
 			default:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_err_,
-					("HalPwrSeqCmdParsing: Unknown CMD!!\n")
-				);
 				break;
 			}
 		}
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index aa4356327636..7fbac4c8f2f8 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -108,8 +108,6 @@ uint rtw_hal_init(struct adapter *padapter)
 		DBG_871X("rtw_hal_init: hal__init fail\n");
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_err_, ("-rtl871x_hal_init:status = 0x%x\n", status));
-
 	return status;
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0273118e70af..b90b225d9589 100644
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
 
@@ -1948,12 +1913,6 @@ static void ResumeTxBeacon(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
-	/*  which should be read from register to a global variable. */
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+ResumeTxBeacon\n"));
-
 	pHalData->RegFwHwTxQCtrl |= BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0xff);
@@ -1965,12 +1924,6 @@ static void StopTxBeacon(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
-	/*  which should be read from register to a global variable. */
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+StopTxBeacon\n"));
-
 	pHalData->RegFwHwTxQCtrl &= ~BIT(6);
 	rtw_write8(padapter, REG_FWHW_TXQ_CTRL+2, pHalData->RegFwHwTxQCtrl);
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0x64);
@@ -2314,7 +2267,6 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
 		else if (12 <= Channel && Channel <= 14)
 			*pGroup = 4;
 		else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("==>Hal_GetChnlGroup8723B in 2.4 G, but Channel %d in Group not found\n", Channel));
 		}
 	} else {
 		bIn24G = false;
@@ -2348,20 +2300,9 @@ static bool Hal_GetChnlGroup8723B(u8 Channel, u8 *pGroup)
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
 
@@ -2376,7 +2317,6 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 			memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 		}
 	} else {/* autoload fail */
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
 		if (!pEEPROM->EepromOrEfuse)
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
@@ -2397,8 +2337,6 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
 		pEEPROM->bautoload_fail_flag = true;
 	} else
 		pEEPROM->bautoload_fail_flag = false;
-
-	RT_TRACE(_module_hal_init_c_, _drv_notice_, ("EEPROM ID = 0x%04x\n", EEPROMId));
 }
 
 static void Hal_ReadPowerValueFromPROM_8723B(
@@ -2540,9 +2478,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
 			}
 #ifdef DEBUG
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("======= Path %d, ChannelIndex %d, Group %d =======\n", rfPath, ch, group));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]));
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]));
 #endif
 		}
 
@@ -2553,11 +2488,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
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
@@ -2569,8 +2499,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION&0x7);	/* bit0~2 */
 	} else
 		pHalData->EEPROMRegulatory = 0;
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory));
 }
 
 void Hal_EfuseParseBTCoexistInfo_8723B(
@@ -2660,8 +2588,6 @@ void Hal_EfuseParseEEPROMVer_8723B(
 		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
 	else
 		pHalData->EEPROMVersion = 1;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
-		pHalData->EEPROMVersion));
 }
 
 
@@ -2728,8 +2654,6 @@ void Hal_EfuseParseChnlPlan_8723B(
 	);
 
 	Hal_ChannelPlanToRegulation(padapter, padapter->mlmepriv.ChannelPlan);
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan));
 }
 
 void Hal_EfuseParseCustomerID_8723B(
@@ -2743,8 +2667,6 @@ void Hal_EfuseParseCustomerID_8723B(
 		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CustomID_8723B];
 	else
 		pHalData->EEPROMCustomerID = 0;
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID));
 }
 
 void Hal_EfuseParseAntennaDiversity_8723B(
@@ -2768,8 +2690,6 @@ void Hal_EfuseParseXtal_8723B(
 			pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;	   /* what value should 8812 set? */
 	} else
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_8723B;
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM CrystalCap: 0x%2x\n", pHalData->CrystalCap));
 }
 
 
@@ -2792,8 +2712,6 @@ void Hal_EfuseParseThermalMeter_8723B(
 		pHalData->bAPKThermalMeterIgnore = true;
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
 	}
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("EEPROM ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter));
 }
 
 
@@ -3111,10 +3029,7 @@ static void rtl8723b_fill_default_txdesc(
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
@@ -3588,7 +3503,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("c2h_handler_8723b: %s\n", pC2hEvent->payload));
 		}
 		break;
 
@@ -3601,9 +3515,7 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
 		for (index = 0; index < pC2hEvent->plen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, pC2hEvent->payload[index]));
 		}
 		break;
 
@@ -3637,7 +3549,6 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 	case C2H_DBG:
 		{
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("C2HCommandHandler: %s\n", c2hBuf));
 		}
 		break;
 
@@ -3650,9 +3561,7 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], C2H_HW_INFO_EXCH\n"));
 		for (index = 0; index < pC2hEvent->CmdLen; index++) {
-			RT_TRACE(_module_hal_init_c_, _drv_info_, ("[BT], tmpBuf[%d]= 0x%x\n", index, c2hBuf[index]));
 		}
 		break;
 
@@ -4055,7 +3964,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			u32 usNavUpper = *((u32 *)val);
 
 			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF) {
-				RT_TRACE(_module_hal_init_c_, _drv_notice_, ("The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n", usNavUpper, HAL_NAV_UPPER_UNIT_8723B));
 				break;
 			}
 
@@ -4359,7 +4267,6 @@ void rtl8723b_start_thread(struct adapter *padapter)
 
 	xmitpriv->SdioXmitThread = kthread_run(rtl8723bs_xmit_thread, padapter, "RTWHALXT");
 	if (IS_ERR(xmitpriv->SdioXmitThread)) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("%s: start rtl8723bs_xmit_thread FAIL!!\n", __func__));
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 2abff4673be2..e5f0e48db557 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -551,7 +551,6 @@ void PHY_SetTxPowerIndex(
 			break;
 		}
 	} else {
-		RT_TRACE(_module_hal_init_c_, _drv_err_, ("Invalid RFPath!!\n"));
 	}
 }
 
@@ -604,11 +603,7 @@ void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 Channel)
 		RFPath = pHalData->ant_path;
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("==>PHY_SetTxPowerLevel8723B()\n"));
-
 	PHY_SetTxPowerLevelByPath(Adapter, Channel, RFPath);
-
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("<==PHY_SetTxPowerLevel8723B()\n"));
 }
 
 void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel)
@@ -648,23 +643,13 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 	u8 SCSettingOf40 = 0, SCSettingOf20 = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	RT_TRACE(
-		_module_hal_init_c_,
-		_drv_info_,
-		(
-			"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur80MhzPrimeSC %d, pHalData->nCur40MhzPrimeSC %d\n",
-			pHalData->CurrentChannelBW,
-			pHalData->nCur80MhzPrimeSC,
-			pHalData->nCur40MhzPrimeSC
-		)
-	);
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
 		if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
 			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
 		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			{}
 
 		if (
 			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
@@ -687,27 +672,16 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 		)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			{}
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_info_,
-			(
-				"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur40MhzPrimeSC %d\n",
-				pHalData->CurrentChannelBW,
-				pHalData->nCur40MhzPrimeSC
-			)
-		);
-
 		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
 			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			{}
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("SCMapping: SC Value %x\n", ((SCSettingOf40 << 4) | SCSettingOf20)));
 	return  (SCSettingOf40 << 4) | SCSettingOf20;
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 17a3e7bf66ef..d27d56920a11 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -346,7 +346,6 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 						update_recvframe_phyinfo(precvframe, (struct phy_stat *)ptr);
 
 					if (rtw_recv_entry(precvframe) != _SUCCESS) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_dump_, ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n", __func__));
 					}
 				} else if (pattrib->pkt_rpt_type == C2H_PACKET) {
 					struct c2h_evt_hdr_t	C2hEvent;
@@ -404,7 +403,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(n);
 	if (!precvpriv->pallocated_recv_buf) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
 		goto exit;
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 597cf3a88c51..c18587cc78a5 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -102,11 +102,6 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 		(padapter->bSurpriseRemoved) ||
 		(padapter->bDriverStopped)
 	) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_notice_,
-			("%s: bSurpriseRemoved(write port)\n", __func__)
-		);
 		goto free_xmitbuf;
 	}
 
@@ -151,16 +146,6 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 
 	ret = (padapter->bDriverStopped) || (padapter->bSurpriseRemoved);
 	if (ret) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_err_,
-			(
-				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)!\n",
-				__func__,
-				padapter->bDriverStopped,
-				padapter->bSurpriseRemoved
-			)
-		);
 		return _FAIL;
 	}
 
@@ -374,8 +359,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 
 		/*  dump xmit_buf to hw tx fifo */
 		if (pxmitbuf) {
-			RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("pxmitbuf->len =%d enqueue\n", pxmitbuf->len));
-
 			if (pxmitbuf->len > 0) {
 				struct xmit_frame *pframe;
 				pframe = (struct xmit_frame *)pxmitbuf->priv_data;
@@ -424,16 +407,6 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 		(padapter->bDriverStopped) ||
 		(padapter->bSurpriseRemoved)
 	) {
-		RT_TRACE(
-			_module_hal_xmit_c_,
-			_drv_notice_,
-			(
-				"%s: bDriverStopped(%d) bSurpriseRemoved(%d)\n",
-				__func__,
-				padapter->bDriverStopped,
-				padapter->bSurpriseRemoved
-			)
-		);
 		return _FAIL;
 	}
 
@@ -492,8 +465,6 @@ int rtl8723bs_xmit_thread(void *context)
 
 	complete(&pxmitpriv->SdioXmitTerminate);
 
-	RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("-%s\n", __func__));
-
 	thread_exit();
 }
 
@@ -509,8 +480,6 @@ s32 rtl8723bs_mgnt_xmit(
 	u8 *pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
 	u8 txdesc_size = TXDESC_SIZE;
 
-	RT_TRACE(_module_hal_xmit_c_, _drv_info_, ("+%s\n", __func__));
-
 	pattrib = &pmgntframe->attrib;
 	pxmitbuf = pmgntframe->pxmitbuf;
 
@@ -572,7 +541,6 @@ s32 rtl8723bs_hal_xmit(
 	err = rtw_xmitframe_enqueue(padapter, pxmitframe);
 	spin_unlock_bh(&pxmitpriv->lock);
 	if (err != _SUCCESS) {
-		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("rtl8723bs_hal_xmit: enqueue xmitframe fail\n"));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 		pxmitpriv->tx_drop++;
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index b1c4bbf29790..faedeeffcead 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -57,11 +57,6 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 	/*  only cmd52 can be used before power on(card enable) */
 	ret = CardEnable(padapter);
 	if (!ret) {
-		RT_TRACE(
-			_module_hci_hal_init_c_,
-			_drv_emerg_,
-			("%s: run power on flow fail\n", __func__)
-		);
 		return _FAIL;
 	}
 
@@ -680,7 +675,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = _InitPowerOn_8723BS(padapter);
 	if (_FAIL == ret) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init Power On!\n"));
 		return _FAIL;
 	}
 
@@ -688,12 +682,10 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = rtl8723b_FirmwareDownload(padapter, false);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("%s: Download Firmware failed!!\n", __func__));
 		padapter->bFWReady = false;
 		pHalData->fw_ractrl = false;
 		return ret;
 	} else {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("rtl8723bs_hal_init(): Download Firmware Success!!\n"));
 		padapter->bFWReady = true;
 		pHalData->fw_ractrl = true;
 	}
@@ -719,7 +711,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_MAC_ENABLE == 1)
 	ret = PHY_MACConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure MAC!!\n"));
 		return ret;
 	}
 #endif
@@ -729,7 +720,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_BB_ENABLE == 1)
 	ret = PHY_BBConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure BB!!\n"));
 		return ret;
 	}
 #endif
@@ -741,7 +731,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_RF_ENABLE == 1)
 		ret = PHY_RFConfig8723B(padapter);
 		if (ret != _SUCCESS) {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure RF!!\n"));
 			return ret;
 		}
 #endif
@@ -893,8 +882,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	/*  Init BT hw config. */
 	hal_btcoex_InitHwConfig(padapter, false);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-%s\n", __func__));
-
 	return _SUCCESS;
 }
 
@@ -1030,10 +1017,6 @@ static u32 rtl8723bs_inirp_init(struct adapter *padapter)
 
 static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+rtl8723bs_inirp_deinit\n"));
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-rtl8723bs_inirp_deinit\n"));
-
 	return _SUCCESS;
 }
 
@@ -1130,10 +1113,6 @@ static void Hal_EfuseParseMACAddr_8723BS(
 		/* Read Permanent MAC address */
 		memcpy(pEEPROM->mac_addr, &hwinfo[EEPROM_MAC_ADDR_8723BS], ETH_ALEN);
 	}
-/* 	NicIFSetMacAddress(padapter, padapter->PermanentAddress); */
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
-		 ("Hal_EfuseParseMACAddr_8723BS: Permanent Address = %pM\n", pEEPROM->mac_addr));
 }
 
 static void Hal_EfuseParseBoardType_8723BS(
@@ -1148,7 +1127,6 @@ static void Hal_EfuseParseBoardType_8723BS(
 			pHalData->BoardType = (EEPROM_DEFAULT_BOARD_OPTION & 0xE0) >> 5;
 	} else
 		pHalData->BoardType = 0;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Board Type: 0x%2x\n", pHalData->BoardType));
 }
 
 static void _ReadEfuseInfo8723BS(struct adapter *padapter)
@@ -1156,8 +1134,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u8 *hwinfo = NULL;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("====>_ReadEfuseInfo8723BS()\n"));
-
 	/*  */
 	/*  This part read and parse the eeprom/efuse content */
 	/*  */
@@ -1191,8 +1167,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	Hal_EfuseParseVoltage_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 
 	Hal_ReadRFGainOffset(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<==== _ReadEfuseInfo8723BS()\n"));
 }
 
 static void _ReadPROMContent(struct adapter *padapter)
@@ -1205,12 +1179,6 @@ static void _ReadPROMContent(struct adapter *padapter)
 	pEEPROM->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	pEEPROM->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("%s: 9346CR = 0x%02X, Boot from %s, Autoload %s\n",
-		  __func__, eeValue,
-		  (pEEPROM->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		  (pEEPROM->bautoload_fail_flag ? "Fail" : "OK")));
-
 /* 	pHalData->EEType = IS_BOOT_FROM_EEPROM(Adapter) ? EEPROM_93C46 : EEPROM_BOOT_EFUSE; */
 
 	_ReadEfuseInfo8723BS(padapter);
@@ -1233,8 +1201,6 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	u8 val8;
 	unsigned long start;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+_ReadAdapterInfo8723BS\n"));
-
 	/*  before access eFuse, make sure card enable has been called */
 	if (!padapter->hw_init_completed)
 		_InitPowerOn_8723BS(padapter);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a24a39e70454..4777793e752d 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -777,30 +777,10 @@ void EnableInterrupt8723BSdio(struct adapter *adapter)
 	himr = cpu_to_le32(haldata->sdio_himr);
 	sdio_local_write(adapter, SDIO_REG_HIMR, 4, (u8 *)&himr);
 
-	RT_TRACE(
-		_module_hci_ops_c_,
-		_drv_notice_,
-		(
-			"%s: enable SDIO HIMR = 0x%08X\n",
-			__func__,
-			haldata->sdio_himr
-		)
-	);
-
 	/*  Update current system IMR settings */
 	tmp = rtw_read32(adapter, REG_HSIMR);
 	rtw_write32(adapter, REG_HSIMR, tmp | haldata->SysIntrMask);
 
-	RT_TRACE(
-		_module_hci_ops_c_,
-		_drv_notice_,
-		(
-			"%s: enable HSIMR = 0x%08X\n",
-			__func__,
-			haldata->SysIntrMask
-		)
-	);
-
 	/*  */
 	/*  <Roger_Notes> There are some C2H CMDs have been sent before system interrupt is enabled, e.g., C2H, CPWM. */
 	/*  So we need to clear all C2H events that FW has notified, otherwise FW won't schedule any commands anymore. */
@@ -894,7 +874,6 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 	readbuf = recvbuf->pskb->data;
 	ret = sdio_read_port(&adapter->iopriv.intf, WLAN_RX0FF_DEVICE_ID, readsize, readbuf);
 	if (ret == _FAIL) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s: read port FAIL!\n", __func__));
 		return NULL;
 	}
 
@@ -1062,9 +1041,6 @@ void sd_int_hdl(struct adapter *adapter)
 
 		sd_int_dpc(adapter);
 	} else {
-		RT_TRACE(_module_hci_ops_c_, _drv_err_,
-				("%s: HISR(0x%08x) and HIMR(0x%08x) not match!\n",
-				__func__, hal->sdio_hisr, hal->sdio_himr));
 	}
 }
 
@@ -1088,13 +1064,6 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
 	numof_free_page = SdioLocalCmd53Read4Byte(adapter, SDIO_REG_FREE_TXPG);
 
 	memcpy(hal->SdioTxFIFOFreePage, &numof_free_page, 4);
-	RT_TRACE(_module_hci_ops_c_, _drv_notice_,
-			("%s: Free page for HIQ(%#x), MIDQ(%#x), LOWQ(%#x), PUBQ(%#x)\n",
-			__func__,
-			hal->SdioTxFIFOFreePage[HI_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[MID_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[LOW_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[PUBLIC_QUEUE_IDX]));
 
 	return true;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4f6398f86b75..42c0685e976e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -875,7 +875,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0)
 	{
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
 		DBG_8192C("wpa_set_encryption, crypt.alg = WEP\n");
 
 		wep_key_idx = param->u.crypt.idx;
@@ -1797,7 +1796,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	if (ielen < RSN_HEADER_LEN) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 		ret  = -1;
 		goto exit;
 	}
@@ -1901,10 +1899,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
 		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
-
 exit:
 	kfree(buf);
 	if (ret)
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 354441e6a667..cf8e783dc35c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -232,8 +232,6 @@ static char *translate_scan(struct adapter *padapter,
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
 		if (!buf)
@@ -423,7 +421,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
 		DBG_871X("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
@@ -433,20 +430,16 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
 		DBG_871X("(1)wep_key_idx =%d\n", wep_key_idx);
 
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
 
@@ -612,7 +605,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
 			goto exit;
 		}
@@ -715,10 +707,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
                 /*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
                 rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		  pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
-
 exit:
 
 	kfree(buf);
@@ -738,8 +726,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->IELength-12);
@@ -785,8 +771,6 @@ static int rtw_wx_set_freq(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_wx_set_freq\n"));
-
 	return 0;
 }
 
@@ -850,7 +834,6 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		break;
 	default:
 		ret = -EINVAL;
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
 
@@ -884,8 +867,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		wrqu->mode = IW_MODE_INFRA;
 	} else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
@@ -999,8 +980,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 	u16 val;
 	int i;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
-
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
 
@@ -1178,8 +1157,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	eth_zero_addr(wrqu->ap_addr.sa_data);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
-
 	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
@@ -1232,7 +1209,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
@@ -1393,9 +1369,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 ret = 0;
 	signed int wait_status;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
-
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
@@ -1477,9 +1450,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
-
 	rtw_ps_deny(padapter, PS_DENY_JOIN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
@@ -1513,16 +1483,12 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		memcpy(ndis_ssid.Ssid, extra, len);
 		src_ssid = ndis_ssid.Ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
 		pmlmepriv->pscanned = get_next(phead);
 
 		while (1) {
 			if (phead == pmlmepriv->pscanned) {
-			        RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_warning_,
-					 ("rtw_wx_set_essid: scan_q is empty, set ssid to check if scanning again!\n"));
-
 				break;
 			}
 
@@ -1532,15 +1498,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			dst_ssid = pnetwork->network.Ssid.Ssid;
 
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-				 ("rtw_wx_set_essid: dst_ssid =%s\n",
-				  pnetwork->network.Ssid.Ssid));
-
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
 				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-					 ("rtw_wx_set_essid: find match, set infra mode\n"));
-
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
 						continue;
@@ -1556,8 +1515,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
 		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
@@ -1588,8 +1545,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
-
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
 		len = pcur_bss->Ssid.SsidLength;
@@ -1620,9 +1575,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32 ratevalue = 0;
 	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
-
 	if (target_rate == -1) {
 		ratevalue = 11;
 		goto set_rate;
@@ -1681,12 +1633,9 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		} else {
 			datarates[i] = 0xff;
 		}
-
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
 	}
 
 	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("rtw_wx_set_rate Fail!!!\n"));
 		ret = -1;
 	}
 	return ret;
@@ -3180,8 +3129,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			break;
 		}
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
-
 		break;
 
 	case IEEE_PARAM_TKIP_COUNTERMEASURES:
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index ba4d3789a41e..b46c086233bb 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -145,12 +145,8 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	u8 *buff, *p, i;
 	union iwreq_data wrqu;
 
-	RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("+rtw_report_sec_ie, authmode =%d\n", authmode));
-
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
-		RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("rtw_report_sec_ie, authmode =%d\n", authmode));
-
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (NULL == buff) {
 			DBG_871X(FUNC_ADPT_FMT ": alloc memory FAIL!!\n",
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 405aa95af579..26b77e42c020 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -479,8 +479,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+init_net_dev\n"));
-
 	if (old_padapter)
 		pnetdev = rtw_alloc_etherdev_with_old_priv(sizeof(struct adapter), (void *)old_padapter);
 	else
@@ -529,7 +527,6 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 {
 	u32 _status = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_start_drv_threads\n"));
 	padapter->xmitThread = kthread_run(rtw_xmit_thread, padapter, "RTW_XMIT_THREAD");
 	if (IS_ERR(padapter->xmitThread))
 		_status = _FAIL;
@@ -546,14 +543,11 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
-
 	rtw_stop_cmd_thread(padapter);
 
 	/*  Below is to termindate tx_thread... */
 	complete(&padapter->xmitpriv.xmit_comp);
 	wait_for_completion(&padapter->xmitpriv.terminate_xmitthread_comp);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("\n drv_halt: rtw_xmit_thread can be terminated !\n"));
 
 	rtw_hal_stop_thread(padapter);
 }
@@ -697,14 +691,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8 ret8 = _SUCCESS;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
-
 	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
 	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -712,14 +703,12 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 
 	if (rtw_init_evt_priv(&padapter->evtpriv)) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init evt_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -760,29 +749,21 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 exit:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_init_drv_sw\n"));
-
 	return ret8;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_cancel_all_timer\n"));
-
 	del_timer_sync(&padapter->mlmepriv.assoc_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel association timer complete!\n"));
 
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel scan_to_timer!\n"));
 
 	del_timer_sync(&padapter->mlmepriv.dynamic_chk_timer);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel dynamic_chk_timer!\n"));
 
 	del_timer_sync(&(adapter_to_pwrctl(padapter)->pwr_state_check_timer));
 
 	del_timer_sync(&padapter->mlmepriv.set_scan_deny_timer);
 	rtw_clear_scan_deny(padapter);
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("rtw_cancel_all_timer:cancel set_scan_deny_timer!\n"));
 
 	del_timer_sync(&padapter->recvpriv.signal_stat_timer);
 
@@ -792,8 +773,6 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 
 u8 rtw_free_drv_sw(struct adapter *padapter)
 {
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("==>rtw_free_drv_sw"));
-
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
 	rtw_free_cmd_priv(&padapter->cmdpriv);
@@ -816,8 +795,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_hal_free_data(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("<==rtw_free_drv_sw\n"));
-
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
 		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
@@ -828,8 +805,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-rtw_free_drv_sw\n"));
-
 	return _SUCCESS;
 }
 
@@ -879,7 +854,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - dev_open\n"));
 	DBG_871X("+871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	padapter->netif_up = true;
@@ -896,7 +870,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 		status = rtw_hal_init(padapter);
 		if (status == _FAIL) {
-			RT_TRACE(_module_os_intfs_c_, _drv_err_, ("rtl871x_hal_init(): Can't init h/w!\n"));
 			goto netdev_open_error;
 		}
 
@@ -927,7 +900,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 netdev_open_normal_process:
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - dev_open\n"));
 	DBG_871X("-871x_drv - drv_open, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -939,7 +911,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_err_, ("-871x_drv - dev_open, fail!\n"));
 	DBG_871X("-871x_drv - drv_open fail, bup =%d\n", padapter->bup);
 
 	return (-1);
@@ -978,7 +949,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 	status = rtw_hal_init(padapter);
 	if (status == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("ips_netdrv_open(): Can't init h/w!\n"));
 		goto netdev_open_error;
 	}
 
@@ -1050,8 +1020,6 @@ static int netdev_close(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - drv_close\n"));
-
 	if (pwrctl->bInternalAutoSuspend) {
 		/* rtw_pwr_wakeup(padapter); */
 		if (pwrctl->rf_pwrstate == rf_off)
@@ -1092,7 +1060,6 @@ static int netdev_close(struct net_device *pnetdev)
 	rtw_scan_abort(padapter);
 	adapter_wdev_data(padapter)->bandroid_scan = false;
 
-	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("-871x_drv - drv_close\n"));
 	DBG_871X("-871x_drv - drv_close, bup =%d\n", padapter->bup);
 
 	return 0;
@@ -1113,8 +1080,6 @@ void rtw_dev_unload(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	u8 cnt = 0;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));
-
 	if (padapter->bup) {
 
 		padapter->bDriverStopped = true;
@@ -1124,8 +1089,6 @@ void rtw_dev_unload(struct adapter *padapter)
 		if (padapter->intf_stop)
 			padapter->intf_stop(padapter);
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ rtw_dev_unload: stop intf complete!\n"));
-
 		if (!pwrctl->bInternalAutoSuspend)
 			rtw_stop_drv_threads(padapter);
 
@@ -1140,8 +1103,6 @@ void rtw_dev_unload(struct adapter *padapter)
 			}
 		}
 
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop thread complete!\n", __func__));
-
 		/* check the status of IPS */
 		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
 			/* check HW status and SW state */
@@ -1160,17 +1121,12 @@ void rtw_dev_unload(struct adapter *padapter)
 
 			padapter->bSurpriseRemoved = true;
 		}
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_,
-			 ("@ %s: deinit hal complete!\n", __func__));
 
 		padapter->bup = false;
 
 	} else {
-		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("%s: bup ==false\n", __func__));
 		DBG_871X("%s: bup ==false\n", __func__);
 	}
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-%s\n", __func__));
 }
 
 static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
@@ -1329,14 +1285,12 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	/* if (sdio_init(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_init) && (padapter->intf_init(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!!\n", __func__));
 		goto exit;
 	}
 	rtw_hal_disable_interrupt(padapter);
 	/* if (sdio_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_alloc_irq) && (padapter->intf_alloc_irq(adapter_to_dvobj(padapter)) != _SUCCESS)) {
 		ret = -1;
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: sdio_alloc_irq Failed!!\n", __func__));
 		goto exit;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 843003b91ea2..7b2aad346d20 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -161,7 +161,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 		ret = register_netdevice(pnetdev);
 
 	if (ret != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
 		goto error;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index fbdbcd04d44a..a2a28803c8d9 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -202,22 +202,15 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	skb = precv_frame->u.hdr.pkt;
 	if (skb == NULL) {
-		RT_TRACE(_module_recv_osdep_c_, _drv_err_, ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
 		goto _recv_indicatepkt_drop;
 	}
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():skb != NULL !!!\n"));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():precv_frame->u.hdr.rx_head =%p  precv_frame->hdr.rx_data =%p\n", precv_frame->u.hdr.rx_head, precv_frame->u.hdr.rx_data));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("precv_frame->hdr.rx_tail =%p precv_frame->u.hdr.rx_end =%p precv_frame->hdr.len =%d\n", precv_frame->u.hdr.rx_tail, precv_frame->u.hdr.rx_end, precv_frame->u.hdr.len));
-
 	skb->data = precv_frame->u.hdr.rx_data;
 
 	skb_set_tail_pointer(skb, precv_frame->u.hdr.len);
 
 	skb->len = precv_frame->u.hdr.len;
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n skb->head =%p skb->data =%p skb->tail =%p skb->end =%p skb->len =%d\n", skb->head, skb->data, skb_tail_pointer(skb), skb_end_pointer(skb), skb->len));
-
 	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
 
 	/* pointers to NULL before rtw_free_recvframe() */
@@ -225,8 +218,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n rtw_recv_indicatepkt :after rtw_os_recv_indicate_pkt!!!!\n"));
-
 	return _SUCCESS;
 
 _recv_indicatepkt_drop:
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index b6be1423ef75..5da4d271b5ee 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -159,9 +159,6 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 	struct sdio_func *func;
 	int err;
 
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+sdio_deinit\n"));
-
 	func = dvobj->intf_data.func;
 
 	if (func) {
@@ -201,7 +198,6 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	psdio->func = func;
 
 	if (sdio_init(dvobj) != _SUCCESS) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!\n", __func__));
 		goto free_dvobj;
 	}
 	rtw_reset_continual_io_error(dvobj);
@@ -306,8 +302,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	padapter->intf_free_irq = &sdio_free_irq;
 
 	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			("rtw_drv_init: Can't init io_priv\n"));
 		goto free_hal_data;
 	}
 
@@ -322,8 +316,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	/* 3 7. init driver common data */
 	if (rtw_init_drv_sw(padapter) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("rtw_drv_init: Initialize driver software resource Failed!\n"));
 		goto free_hal_data;
 	}
 
@@ -406,7 +398,6 @@ static int rtw_drv_init(
 
 	dvobj = sdio_dvobj_init(func);
 	if (dvobj == NULL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("initialize device object priv Failed!\n"));
 		goto exit;
 	}
 
@@ -424,8 +415,6 @@ static int rtw_drv_init(
 	if (sdio_alloc_irq(dvobj) != _SUCCESS)
 		goto free_if2;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-871x_drv - drv_init, success!\n"));
-
 	rtw_ndev_notifier_register();
 	status = _SUCCESS;
 
@@ -447,8 +436,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 	struct dvobj_priv *dvobj = sdio_get_drvdata(func);
 	struct adapter *padapter = dvobj->if1;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+rtw_dev_remove\n"));
-
 	dvobj->processing_dev_remove = true;
 
 	rtw_unregister_netdevs(dvobj);
@@ -478,8 +465,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 	rtw_sdio_if1_deinit(padapter);
 
 	sdio_dvobj_deinit(func);
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-rtw_dev_remove\n"));
 }
 
 static int rtw_sdio_suspend(struct device *dev)
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 216b2f62eefd..1dc0787a80da 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -196,10 +196,7 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	s32 res = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
-
 	if (rtw_if_up(padapter) == false) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit_entry: rtw_if_up fail\n"));
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s if_up fail\n", __func__);
 		#endif
@@ -232,13 +229,11 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 		goto drop_packet;
 	}
 
-	RT_TRACE(_module_xmit_osdep_c_, _drv_info_, ("rtw_xmit_entry: tx_pkts =%d\n", (u32)pxmitpriv->tx_pkts));
 	goto exit;
 
 drop_packet:
 	pxmitpriv->tx_drop++;
 	dev_kfree_skb_any(pkt);
-	RT_TRACE(_module_xmit_osdep_c_, _drv_notice_, ("rtw_xmit_entry: drop, tx_drop =%d\n", (u32)pxmitpriv->tx_drop));
 
 exit:
 	return 0;
-- 
2.20.1

