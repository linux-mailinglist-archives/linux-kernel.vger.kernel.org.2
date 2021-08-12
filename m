Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB773E9C11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhHLBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhHLBxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:53:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B6C061798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t35so7718454oiw.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+5BIPqIClTcV0YYgynov8F+Utk2HH5wrZ7nDJYvWAM=;
        b=f7ndj/bZIlxPa9w+Q8wLIdcG8aT77koZ/tio852aONRvJjVSV5bwCAdupmNvmnMhA7
         6MFEPHOZuoF8TvG/BA9NP/Q+laffI6fuKnHVuQTjYGZVexSJ1MIfwBUKK93ZdbvPzp4m
         SbQOsUgKd+raAVSCDliy0T3zPfKuSuh8Z+V/jkitN1j0NrGiV/6VRxsnmFSvzSzu0Y5J
         OtV/tlrxq7DAJJ+0hpTUc3oUfUpeKOD+tAdraYASzr2toO6x3Nc8BFCWcPQzKQmgFj0J
         FUSI6a03uxJcdii9jsrNgELW3An/VoqyAXK1hI54YZqdFe7GorWcEysbb+NIEBdzRPi/
         6P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u+5BIPqIClTcV0YYgynov8F+Utk2HH5wrZ7nDJYvWAM=;
        b=Pm2pcHtC5Ago9mbCpqz/DX8wvmJ4EEGw+xjgHn2ZlF15lKRNvH043BmaynKAcqNxTi
         fo0p6RdVyIZLAk+OLLMrBPcCQiGXbpUi6uJdvqsRPhh6QJB6UPn26cAIYC8BE892zshE
         /wAQXVZWltVxa9zmcIjsc/9wRWpZthbLLJBrCx69kKpLA/STR+yEdpQCDs6DnfyLB+1C
         X/zeXe/XlWzz055QUtwqfro1+lAGQuIWOZeSkJ3dN4RHzPlyvMv2oCPgPe7k3j/7nxDR
         vpAacVS2ol6vXgKf9BaYZ9q05cn1NKNxTzBes5kN7YP98KB7QhHbYfeHm4ASlTLvJJnw
         MioQ==
X-Gm-Message-State: AOAM531vnDbP6QjEihWunbK+JeVwIcds8DNWDQnSoYgxgy++Kbd6D/yp
        ePS7Lo7zsH6DxXPqXffdNz8=
X-Google-Smtp-Source: ABdhPJyPhgd73CGvQB6y+QKgzutkhY7s3SWR744KPlh4kysFhxjZ7jJKIjAwUP31g3zUp69d1Sj1yQ==
X-Received: by 2002:aca:eb0f:: with SMTP id j15mr9872864oih.63.1628733172379;
        Wed, 11 Aug 2021 18:52:52 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id q21sm305718otn.61.2021.08.11.18.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 18:52:51 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 2/3] staging: r8188eu: Fix smatch problems in hal/*.c
Date:   Wed, 11 Aug 2021 20:52:31 -0500
Message-Id: <20210812015232.23784-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
References: <20210812015232.23784-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch detects the folloring:

drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c:199 ODM_ReadAndConfig_RadioA_1T_8188E() warn: inconsistent indenting
drivers/staging/r8188eu/hal/HalPwrSeqCmd.c:65 HalPwrSeqCmdParsing() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm.c:225 ODM_DMWatchdog() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm.c:485 ODM_Write_DIG() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm.c:485 ODM_Write_DIG() warn: if statement not indented
drivers/staging/r8188eu/hal/odm.c:491 ODM_Write_DIG() warn: if statement not indented
drivers/staging/r8188eu/hal/odm.c:493 ODM_Write_DIG() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm.c:496 ODM_Write_DIG() warn: if statement not indented
drivers/staging/r8188eu/hal/odm.c:498 ODM_Write_DIG() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm.c:501 ODM_Write_DIG() warn: if statement not indented
drivers/staging/r8188eu/hal/odm.c:551 odm_DIGbyRSSI_LPS() warn: inconsistent indenting
drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c:360 odm_ARFBRefresh_8188E() warn: inconsistent indenting
drivers/staging/r8188eu/hal/odm_HWConfig.c:268 odm_RxPhyStatus92CSeries_Parsing() warn: inconsistent indenting
drivers/staging/r8188eu/hal/rtl8188e_hal_init.c:726 hal_EfusePowerSwitch_RTL8188E() warn: inconsistent indenting
drivers/staging/r8188eu/hal/rtl8188e_mp.c:60 Hal_mpt_SwitchRfSetting() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:547 wpa_set_encryption() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1478 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1479 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1481 rtw_wx_set_essid() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1555 rtw_wx_set_rate() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:2596 rtw_wps_start() warn: variable dereferenced before check 'pdata' (see line 2590)
drivers/staging/r8188eu/os_dep/ioctl_linux.c:2790 rtw_p2p_profilefound() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:4846 rtw_set_encryption() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:5628 rtw_mp_efuse_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7055 rtw_mp_thermal() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7251 rtw_mp_set() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7255 rtw_mp_set() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7310 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7345 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/os_dep/ioctl_linux.c:7349 rtw_mp_get() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:1887:17: warning: mixing declarations and code
drivers/staging/r8188eu/hal/usb_halinit.c:856 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:859 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:862 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:887 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:915 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:925 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_halinit.c:929 rtl8188eu_hal_init() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_ops_linux.c:519:25: error: typename in expression
drivers/staging/r8188eu/hal/usb_ops_linux.c:263 usb_writeN() warn: inconsistent indenting
drivers/staging/r8188eu/hal/usb_ops_linux.c:568 usb_read_port() warn: inconsistent indenting
`
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 16 ++--
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  2 +-
 drivers/staging/r8188eu/hal/odm.c             | 18 ++--
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 18 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 87 +++++++++----------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 30 +++----
 9 files changed, 90 insertions(+), 93 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 57839f8629ac..1f1ce5f36f83 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -357,14 +357,14 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 	} else {
 		pRaInfo->LowestRate = 0;
 	}
-		if (pRaInfo->HighestRate > 0x13)
-			pRaInfo->PTModeSS = 3;
-		else if (pRaInfo->HighestRate > 0x0b)
-			pRaInfo->PTModeSS = 2;
-		else if (pRaInfo->HighestRate > 0x03)
-			pRaInfo->PTModeSS = 1;
-		else
-			pRaInfo->PTModeSS = 0;
+	if (pRaInfo->HighestRate > 0x13)
+		pRaInfo->PTModeSS = 3;
+	else if (pRaInfo->HighestRate > 0x0b)
+		pRaInfo->PTModeSS = 2;
+	else if (pRaInfo->HighestRate > 0x03)
+		pRaInfo->PTModeSS = 1;
+	else
+		pRaInfo->PTModeSS = 0;
 
 	if (pRaInfo->DecisionRate > pRaInfo->HighestRate)
 		pRaInfo->DecisionRate = pRaInfo->HighestRate;
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 37bca779ee00..15386d42b0da 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -60,7 +60,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				poll_bit = false;
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 				do {
-						value = rtw_read8(padapter, offset);
+					value = rtw_read8(padapter, offset);
 
 					value &= GET_PWR_CFG_MASK(pwrcfgcmd);
 					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 53198bf92c0f..024b534ba555 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -222,7 +222,7 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 		;
 	} else if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
 		ODM_TXPowerTrackingCheck(pDM_Odm);
-	      odm_EdcaTurboCheck(pDM_Odm);
+		odm_EdcaTurboCheck(pDM_Odm);
 		odm_DynamicTxPower(pDM_Odm);
 	}
 	odm_dtc(pDM_Odm);
@@ -482,26 +482,26 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
 		if (pDM_Odm->SupportPlatform & (ODM_CE|ODM_MP)) {
 			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-				if (pDM_Odm->SupportICType != ODM_RTL8188E)
+			if (pDM_Odm->SupportICType != ODM_RTL8188E)
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 		} else if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
 			switch (*pDM_Odm->pOnePathCCA) {
 			case ODM_CCA_2R:
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+				if (pDM_Odm->SupportICType != ODM_RTL8188E)
 					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 				break;
 			case ODM_CCA_1R_A:
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+				if (pDM_Odm->SupportICType != ODM_RTL8188E)
 					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
 				break;
 			case ODM_CCA_1R_B:
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
-					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+				if (pDM_Odm->SupportICType != ODM_RTL8188E)
 					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-					break;
-				}
+				break;
+			}
 		}
 		/* pDM_DigTable->PreIGValue = pDM_DigTable->CurIGValue; */
 		pDM_DigTable->CurIGValue = CurrentIGI;
@@ -548,9 +548,9 @@ void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
 		RSSI_Lower = DM_DIG_MIN_NIC;
 
 	/* Upper and Lower Bound checking */
-	 if (CurrentIGI > DM_DIG_MAX_NIC)
+	if (CurrentIGI > DM_DIG_MAX_NIC)
 		CurrentIGI = DM_DIG_MAX_NIC;
-	 else if (CurrentIGI < RSSI_Lower)
+	else if (CurrentIGI < RSSI_Lower)
 		CurrentIGI = RSSI_Lower;
 
 	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 343c647a1eaf..530357b58d66 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -265,7 +265,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		/*  (1)Get RSSI for HT rate */
 
-		 for (i = RF_PATH_A; i < RF_PATH_MAX; i++) {
+		for (i = RF_PATH_A; i < RF_PATH_MAX; i++) {
 			/*  2008/01/30 MH we will judge RF RX path now. */
 			if (dm_odm->RFPathRxEnable & BIT(i))
 				rf_rx_num++;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 588520d28097..f0560c15387c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -723,7 +723,7 @@ hal_EfusePowerSwitch_RTL8188E(
 		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
 		if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
-			 rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
+			rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
 		}
 		/*  Reset: 0x0000h[28], default valid */
 		tmpV16 =  rtw_read16(pAdapter, REG_SYS_FUNC_EN);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index b5fb3aedc000..a26a5816a45f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -57,10 +57,10 @@ void Hal_mpt_SwitchRfSetting(struct adapter *pAdapter)
 	struct mp_priv	*pmp = &pAdapter->mppriv;
 
 	/*  <20120525, Kordan> Dynamic mechanism for APK, asked by Dennis. */
-		pmp->MptCtx.backup0x52_RF_A = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0);
-		pmp->MptCtx.backup0x52_RF_B = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0);
-		PHY_SetRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0, 0xD);
-		PHY_SetRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0, 0xD);
+	pmp->MptCtx.backup0x52_RF_A = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0);
+	pmp->MptCtx.backup0x52_RF_B = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0);
+	PHY_SetRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0, 0xD);
+	PHY_SetRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0, 0xD);
 }
 /*---------------------------hal\rtl8192c\MPT_Phy.c---------------------------*/
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9305d97fd54d..8948c429afd7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -853,13 +853,13 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	haldata->RfRegChnlVal[0] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
 	haldata->RfRegChnlVal[1] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
 	_BBTurnOnBlock(Adapter);
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_SECURITY);
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_SECURITY);
 	invalidate_cam_all(Adapter);
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
 	/*  2010/12/17 MH We need to set TX power according to EFUSE content at first. */
 	PHY_SetTxPowerLevel8188E(Adapter, haldata->CurrentChannel);
 
@@ -884,7 +884,7 @@ HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
 	/* Nav limit , suggest by scott */
 	rtw_write8(Adapter, 0x652, 0x0);
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
 	rtl8188e_InitHalDm(Adapter);
 
 	if (Adapter->registrypriv.mp_mode == 1) {
@@ -912,7 +912,7 @@ HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
 		/* enable tx DMA to drop the redundate data of packet */
 		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
+		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 		/*  2010/08/26 MH Merge from 8192CE. */
 		if (pwrctrlpriv->rf_pwrstate == rf_on) {
 			if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -922,11 +922,11 @@ HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 				haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = true;
 			}
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_PW_TRACK);
+			HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_PW_TRACK);
 
 			ODM_TXPowerTrackingCheck(&haldata->odmpriv);
 
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
+			HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
 			PHY_LCCalibrate_8188E(Adapter);
 		}
 	}
@@ -939,7 +939,7 @@ HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
 	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL)|BIT(12));
 
 exit:
-HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
 
 	DBG_88E("%s in %dms\n", __func__, rtw_get_passing_time_ms(init_start_time));
 
@@ -1884,7 +1884,7 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	switch (variable) {
 	case HW_VAR_BASIC_RATE:
 		*((u16 *)(val)) = haldata->BasicRateSet;
-		__attribute__((__fallthrough__));
+		fallthrough;
 	case HW_VAR_TXPAUSE:
 		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
 		break;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 012846ea8263..8fcfe73cf5b3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -260,12 +260,10 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 
 	wvalue = (u16)(addr&0x0000ffff);
 	len = length;
-	 memcpy(buf, pdata, len);
+	memcpy(buf, pdata, len);
 
 	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, buf, len, requesttype);
 
-
-
 	return ret;
 }
 
@@ -516,7 +514,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		case -EPIPE:
 		case -ENODEV:
 		case -ESHUTDOWN:
-			__attribute__((__fallthrough__));
 		case -ENOENT:
 			adapt->bDriverStopped = true;
 			break;
@@ -565,54 +562,54 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 			precvbuf->reuse = true;
 	}
 
-		rtl8188eu_init_recvbuf(adapter, precvbuf);
-
-		/* re-assign for linux based on skb */
-		if (!precvbuf->reuse || !precvbuf->pskb) {
-			precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-			if (!precvbuf->pskb) {
-				DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
-				return _FAIL;
-			}
-
-			tmpaddr = (size_t)precvbuf->pskb->data;
-			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
-			skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
-
-			precvbuf->phead = precvbuf->pskb->head;
-			precvbuf->pdata = precvbuf->pskb->data;
-			precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
-			precvbuf->pend = skb_end_pointer(precvbuf->pskb);
-			precvbuf->pbuf = precvbuf->pskb->data;
-		} else { /* reuse skb */
-			precvbuf->phead = precvbuf->pskb->head;
-			precvbuf->pdata = precvbuf->pskb->data;
-			precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
-			precvbuf->pend = skb_end_pointer(precvbuf->pskb);
-			precvbuf->pbuf = precvbuf->pskb->data;
+	rtl8188eu_init_recvbuf(adapter, precvbuf);
 
-			precvbuf->reuse = false;
+	/* re-assign for linux based on skb */
+	if (!precvbuf->reuse || !precvbuf->pskb) {
+		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
+		if (!precvbuf->pskb) {
+			DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
+			return _FAIL;
 		}
 
-		precvpriv->rx_pending_cnt++;
+		tmpaddr = (size_t)precvbuf->pskb->data;
+		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
+
+		precvbuf->phead = precvbuf->pskb->head;
+		precvbuf->pdata = precvbuf->pskb->data;
+		precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
+		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
+		precvbuf->pbuf = precvbuf->pskb->data;
+	} else { /* reuse skb */
+		precvbuf->phead = precvbuf->pskb->head;
+		precvbuf->pdata = precvbuf->pskb->data;
+		precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
+		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
+		precvbuf->pbuf = precvbuf->pskb->data;
+
+		precvbuf->reuse = false;
+	}
 
-		purb = precvbuf->purb;
+	precvpriv->rx_pending_cnt++;
 
-		/* translate DMA FIFO addr to pipehandle */
-		pipe = ffaddr2pipehdl(pdvobj, addr);
+	purb = precvbuf->purb;
 
-		usb_fill_bulk_urb(purb, pusbd, pipe,
-				  precvbuf->pbuf,
-				  MAX_RECVBUF_SZ,
-				  usb_read_port_complete,
-				  precvbuf);/* context is precvbuf */
+	/* translate DMA FIFO addr to pipehandle */
+	pipe = ffaddr2pipehdl(pdvobj, addr);
 
-		err = usb_submit_urb(purb, GFP_ATOMIC);
-		if ((err) && (err != (-EPERM))) {
-			DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
-				err, purb->status);
-			ret = _FAIL;
-		}
+	usb_fill_bulk_urb(purb, pusbd, pipe,
+			  precvbuf->pbuf,
+			  MAX_RECVBUF_SZ,
+			  usb_read_port_complete,
+			  precvbuf);/* context is precvbuf */
+
+	err = usb_submit_urb(purb, GFP_ATOMIC);
+	if ((err) && (err != (-EPERM))) {
+		DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
+			err, purb->status);
+		ret = _FAIL;
+	}
 
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index a3e6d761e748..84486ba6193d 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -544,7 +544,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				ret = -EOPNOTSUPP;
 				goto exit;
 			}
-		      memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
 			rtw_set_key(padapter, psecuritypriv, wep_key_idx, 0);
 		}
@@ -6084,22 +6084,22 @@ static int rtw_mp_thermal(struct net_device *dev,
 	if (copy_from_user(extra, wrqu->pointer, wrqu->length))
 		return -EFAULT;
 
-	 bwrite = strncmp(extra, "write", 6); /*  strncmp true is 0 */
+	bwrite = strncmp(extra, "write", 6); /*  strncmp true is 0 */
 
-	 Hal_GetThermalMeter(padapter, &val);
+	Hal_GetThermalMeter(padapter, &val);
 
-	 if (bwrite == 0) {
-			EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
-			if (2 > max_available_size) {
-				DBG_88E("no available efuse!\n");
-				return -EFAULT;
-			}
-			if (rtw_efuse_map_write(padapter, addr, cnt, &val) == _FAIL) {
-				DBG_88E("rtw_efuse_map_write error\n");
-				return -EFAULT;
-			} else {
-				 sprintf(extra, " efuse write ok :%d", val);
-			}
+	if (bwrite == 0) {
+		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		if (2 > max_available_size) {
+			DBG_88E("no available efuse!\n");
+			return -EFAULT;
+		}
+		if (rtw_efuse_map_write(padapter, addr, cnt, &val) == _FAIL) {
+			DBG_88E("rtw_efuse_map_write error\n");
+			return -EFAULT;
+		} else {
+			 sprintf(extra, " efuse write ok :%d", val);
+		}
 	 } else {
 			 sprintf(extra, "%d", val);
 	 }
-- 
2.32.0

