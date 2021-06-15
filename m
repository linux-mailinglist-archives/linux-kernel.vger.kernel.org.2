Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714013A72ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhFOATw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:52 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:41629 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhFOATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:37 -0400
Received: by mail-qv1-f54.google.com with SMTP id x2so20771931qvo.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jfSBGhQhkwM3j8q+DmYAZ1AjB+UsXlR814MASaKnac=;
        b=pThKwqJJAVcGOrUTjzvteSiROvr7ulEP3d+pRcjA6DSWMmJ9c4VN37dgVgpBNLV48Q
         s3brY6oEebPi4RziItpduVeHP3qxM9P7VKChj7rXgcg3tEt8GLGnYT6fiNzuFSpsYBu2
         ddjP/tKMDTSq40QmCSYHlrVZn0iL1B3BWmQi6E5R06pjrbhYs0m0J9s+ZIevAOQgZ1gp
         tYoBXWngJ8HZ2XpML8p591ZN2FvXuU2jIw7e6JmYDvhO4LZPqEGji2yRJ8ClI98Cwuic
         Vx4+rdn7RpIstcdHzLu1tzk3PsRoAv+PbXNekEBTlkEQzucx0rMSUJtahhWbbLeelgEj
         5zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jfSBGhQhkwM3j8q+DmYAZ1AjB+UsXlR814MASaKnac=;
        b=VcTk0Z8uYwS0UP8dKs6h/Rbmq6pf2sxBE6rk49ayhwtUFyPW8iCDMhwguzxi0/mGRc
         8kr+5uIMs/+Y9/qLe2udEEDo8Kgr6Xa7ee0824tsnsfFy0a4kCR3n+LVZRO5trgeMw85
         Eo1PYeJSefheksMFBVgmwRse2qkVM/CCOVj6wrVEhJf9SS1ftOfFm2nyZD2S+zgesRri
         DxpCRVVkc3MCpfkIfYIKa0pDuTrRST1ac3WQzaGbjV5gGXBm//SuM3N+8paxG0X0oNNE
         nvp5o5l3d7fPRMx9cbPVcuPS5wPQ0sLJL9NzEfdZvIjNf8p6IIuXA0e7PkU7M6QVSG7s
         3Cww==
X-Gm-Message-State: AOAM530knHgmnm4cZ1sQ//7R5cC2pSZc93vbY4W5rtnbkRG3VuAAJ6Zp
        nP5VdxcbmBNVoQ8UqaW4urzocw==
X-Google-Smtp-Source: ABdhPJzV1699klf8z4N9OkvGVANtB5Ap7H/HRLa94oa3LglN1E0gUidF9WyTU2dz4gUpSGUGnDeXWQ==
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr1981056qve.15.1623716179557;
        Mon, 14 Jun 2021 17:16:19 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 20/28] staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_hal_init.c
Date:   Tue, 15 Jun 2021 01:14:59 +0100
Message-Id: <20210615001507.1171-21-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/rtl8188e_hal_init.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c | 45 +++----------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 0b46af1755ed..b06bdcf885fa 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -24,11 +24,8 @@ void iol_mode_enable(struct adapter *padapter, u8 enable)
 		reg_0xf0 = usb_read8(padapter, REG_SYS_CFG);
 		usb_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
-		if (!padapter->bFWReady) {
-			DBG_88E("bFWReady == false call reset 8051...\n");
+		if (!padapter->bFWReady)
 			_8051Reset88E(padapter);
-		}
-
 	} else {
 		/* disable initial offload */
 		reg_0xf0 = usb_read8(padapter, REG_SYS_CFG);
@@ -74,7 +71,6 @@ s32 rtl8188e_iol_efuse_patch(struct adapter *padapter)
 {
 	s32	result = _SUCCESS;
 
-	DBG_88E("==> %s\n", __func__);
 	if (rtw_iol_applied(padapter)) {
 		iol_mode_enable(padapter, 1);
 		result = iol_execute(padapter, CMD_READ_EFUSE_MAP);
@@ -95,7 +91,6 @@ void _8051Reset88E(struct adapter *padapter)
 	u1bTmp = usb_read8(padapter, REG_SYS_FUNC_EN + 1);
 	usb_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
 	usb_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
-	DBG_88E("=====> %s(): 8051 reset success .\n", __func__);
 }
 
 void rtl8188e_InitializeFirmwareVars(struct adapter *padapter)
@@ -139,11 +134,9 @@ void rtw_hal_set_odm_var(struct adapter *Adapter, enum hal_odm_variable eVariabl
 			struct sta_info *psta = pValue1;
 
 			if (bSet) {
-				DBG_88E("### Set STA_(%d) info\n", psta->mac_id);
 				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, psta);
 				ODM_RAInfo_Init(podmpriv, psta->mac_id);
 			} else {
-				DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
 				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
 			}
 		}
@@ -161,13 +154,10 @@ void rtw_hal_set_odm_var(struct adapter *Adapter, enum hal_odm_variable eVariabl
 
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
 {
-	if (enable) {
-		DBG_88E("Enable notch filter\n");
+	if (enable)
 		usb_write8(adapter, rOFDM0_RxDSP + 1, usb_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
-	} else {
-		DBG_88E("Disable notch filter\n");
+	else
 		usb_write8(adapter, rOFDM0_RxDSP + 1, usb_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
-	}
 }
 
 /*  */
@@ -263,14 +253,10 @@ void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo)
 
 	/*  Checl 0x8129 again for making sure autoload status!! */
 	EEPROMId = le16_to_cpu(*((__le16 *)hwinfo));
-	if (EEPROMId != RTL_EEPROM_ID) {
-		DBG_88E("EEPROM ID(%#x) is invalid!!\n", EEPROMId);
+	if (EEPROMId != RTL_EEPROM_ID)
 		pEEPROM->bautoload_fail_flag = true;
-	} else {
+	else
 		pEEPROM->bautoload_fail_flag = false;
-	}
-
-	DBG_88E("EEPROM ID = 0x%04x\n", EEPROMId);
 }
 
 static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G, u8 *PROMContent, bool AutoLoadFail)
@@ -404,11 +390,6 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
-
-		DBG_88E("%s...bHWPwrPindetect(%x)-bHWPowerdown(%x) , bSupportRemoteWakeup(%x)\n", __func__,
-			padapter->pwrctrlpriv.bHWPwrPindetect, padapter->pwrctrlpriv.bHWPowerdown, padapter->pwrctrlpriv.bSupportRemoteWakeup);
-
-		DBG_88E("### PS params =>  power_mgnt(%x), usbss_enable(%x) ###\n", padapter->registrypriv.power_mgnt, padapter->registrypriv.usbss_enable);
 	}
 }
 
@@ -431,21 +412,12 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][4];
 		else
 			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][group];
-
-		DBG_88E("======= Path %d, Channel %d =======\n", 0, ch);
-		DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_CCK_Base[0][ch]);
-		DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_BW40_Base[0][ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 		pHalData->CCK_24G_Diff[0][TxCount] = pwrInfo24G.CCK_Diff[0][TxCount];
 		pHalData->OFDM_24G_Diff[0][TxCount] = pwrInfo24G.OFDM_Diff[0][TxCount];
 		pHalData->BW20_24G_Diff[0][TxCount] = pwrInfo24G.BW20_Diff[0][TxCount];
 		pHalData->BW40_24G_Diff[0][TxCount] = pwrInfo24G.BW40_Diff[0][TxCount];
-		DBG_88E("======= TxCount %d =======\n", TxCount);
-		DBG_88E("CCK_24G_Diff[%d][%d] = %d\n", 0, TxCount, pHalData->CCK_24G_Diff[0][TxCount]);
-		DBG_88E("OFDM_24G_Diff[%d][%d] = %d\n", 0, TxCount, pHalData->OFDM_24G_Diff[0][TxCount]);
-		DBG_88E("BW20_24G_Diff[%d][%d] = %d\n", 0, TxCount, pHalData->BW20_24G_Diff[0][TxCount]);
-		DBG_88E("BW40_24G_Diff[%d][%d] = %d\n", 0, TxCount, pHalData->BW40_24G_Diff[0][TxCount]);
 	}
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
@@ -456,7 +428,6 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	} else {
 		pHalData->EEPROMRegulatory = 0;
 	}
-	DBG_88E("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory);
 }
 
 void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
@@ -470,7 +441,6 @@ void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoa
 	} else {
 		pHalData->CrystalCap = EEPROM_Default_CrystalCap_88E;
 	}
-	DBG_88E("CrystalCap: 0x%2x\n", pHalData->CrystalCap);
 }
 
 void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
@@ -482,7 +452,6 @@ void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo, bool AutoL
 					& 0xE0) >> 5;
 	else
 		pHalData->BoardType = 0;
-	DBG_88E("Board Type: 0x%2x\n", pHalData->BoardType);
 }
 
 void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -508,7 +477,6 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 					  padapter->registrypriv.channel_plan,
 					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
 
-	DBG_88E("mlmepriv.ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan);
 }
 
 void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -521,7 +489,6 @@ void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool Auto
 		pHalData->EEPROMCustomerID = 0;
 		pHalData->EEPROMSubCustomerID = 0;
 	}
-	DBG_88E("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID);
 }
 
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
@@ -553,7 +520,6 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 	} else {
 		pHalData->AntDivCfg = 0;
 	}
-	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
 }
 
 void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
@@ -569,5 +535,4 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 	}
-	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
-- 
2.30.2

