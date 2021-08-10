Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264E63E82E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhHJSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhHJSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:21:48 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F354C07AF46
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:05:22 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so5579678oop.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FACFMxcGI9zl/h0ERNUpi85WNtldhj3CHSZJMVkVIis=;
        b=B3HYl+V3uuNyHVikcS7BSyQwQVeVh8Ha57kbTlJHTeFdROeLhqEdVNZWbJZ8ERvCCs
         t0/rxFK4/CrUG4K3/yfh5XM0XwKVFrO/+peFYluJQZ0a866QYJB3lLgdGq+qkeJzXQqV
         +oO6Ax45TU4ZOj+WNzclB7w+0Bx3P08Ah5I0rd0Oq1WXGpQ7JyrM7eqqyoarAqlk9i0q
         USQD4d+sqnMsdZLqvUWFip1MGcPtHyjGey20U5pOIIik4UghNbVjN8gzrNWcU6kRfy5i
         zk+tKrVAzJeo38OdwpnWVkevJkzAZkT4xNN7gVWtyAJ2LLyK14JlODqFyZTrK5rYKtR6
         QKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FACFMxcGI9zl/h0ERNUpi85WNtldhj3CHSZJMVkVIis=;
        b=puUdhsfZxSu+KeCdJIsSc7pQbj1g0f0oUbQfxqgZsdOxDnSYCdSCURdrGH1k0arLs6
         xILshKc/4J3Pl+WT1jCNxchKpEvNJ6p2N7/JqvRDcGYGPzwRYIR1i2Y0yuf62Y4WRjn5
         EbZIAbEFNSHUXCShrpvksXU7WpOLWKx13Twdlla6ZbupFoGL+5LRPGwxUCqH9mgCqyUf
         5c4ExaIjAzQFgMFk7yoaYUqIHQDIPCE7XOtBxuwOi0OS9MQlJdCyJapqUsI1vE6nRkXL
         6aZXh0KcvFOHlhhXIBWaboerv5FIg2IzOX1nN8bnXE57ZFLk0nYYazwlJRNIXwdStF1V
         MtRA==
X-Gm-Message-State: AOAM531NgXFYmxyWkK+L7M1Ca2Jtq/5qLhUBa7QT3sQQtX7ESNaBme6J
        pkXBXvrjOcmT4mNzW3aWh/o=
X-Google-Smtp-Source: ABdhPJzqREBfT9eNgTnVhpuVsH+TeyM1PQZG3aPlFixe/VA971bvH8vbg7KTgns2gs4n5ycybLokfw==
X-Received: by 2002:a4a:b601:: with SMTP id z1mr13941019oon.7.1628618720951;
        Tue, 10 Aug 2021 11:05:20 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id e13sm2614670oiw.38.2021.08.10.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:05:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] staging: r8188eu: Replace BITn with BIT(n)
Date:   Tue, 10 Aug 2021 13:05:11 -0500
Message-Id: <20210810180511.8986-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses BITn instead of BIT(n). All such usage is converted.

Note that this patch does not address any warnings that checkpatch
will find. These include missing space around operators and lines
that are too long. These problems will be addressed in a separate
patch.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

---
v2 - Removed dependency on incorrect patch
     Fixed typo n comment noted by Dan Carpenter
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   2 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  40 +-
 drivers/staging/r8188eu/hal/odm.c             |  68 +--
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |   4 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 116 ++---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  14 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  66 +--
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  34 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   8 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  10 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  48 +-
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  14 +-
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  84 ++--
 drivers/staging/r8188eu/include/hal_intf.h    |  16 +-
 drivers/staging/r8188eu/include/odm.h         | 106 ++---
 drivers/staging/r8188eu/include/odm_reg.h     |   2 +-
 drivers/staging/r8188eu/include/odm_types.h   |   8 +-
 .../staging/r8188eu/include/osdep_service.h   |  42 --
 .../staging/r8188eu/include/rtl8188e_spec.h   | 415 ++++++++----------
 drivers/staging/r8188eu/include/rtw_sreset.h  |  14 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |   4 +-
 21 files changed, 518 insertions(+), 597 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 35a4a9e222e6..37e8b076be93 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -564,7 +564,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 
 		bgroup = false;
 	} else {
-		/*  Group key - KeyIndex(BIT30 == 0) */
+		/*  Group key - KeyIndex(BIT(30) == 0) */
 		/*  when add wep key through add key and didn't assigned encryption type before */
 		if ((padapter->securitypriv.ndisauthtype <= 3) &&
 		    (padapter->securitypriv.dot118021XGrpPrivacy == 0)) {
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 68e7c31cc720..643a4d348b2e 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -336,11 +336,11 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
 
 						value32 = ((X * ele_D)>>7)&0x01;
-						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT28, value32);
+						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(28), value32);
 					} else {
 						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
 						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
-						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT28, 0x00);
+						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(28), 0x00);
 					}
 				}
 			}
@@ -392,7 +392,7 @@ phy_PathA_IQK_8188E(struct adapter *adapt, bool configPathB)
 	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
 
-	if (!(regeac & BIT28) &&
+	if (!(regeac & BIT(28)) &&
 	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
 	    (((regE9C & 0x03FF0000)>>16) != 0x42))
 		result |= 0x01;
@@ -446,7 +446,7 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
 
-	if (!(regeac & BIT28) &&
+	if (!(regeac & BIT(28)) &&
 	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
 	    (((regE9C & 0x03FF0000)>>16) != 0x42))
 		result |= 0x01;
@@ -495,7 +495,7 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
 
-	if (!(regeac & BIT27) &&		/* if Tx is OK, check whether Rx is OK */
+	if (!(regeac & BIT(27)) &&		/* if Tx is OK, check whether Rx is OK */
 	    (((regEA4 & 0x03FF0000)>>16) != 0x132) &&
 	    (((regeac & 0x03FF0000)>>16) != 0x36))
 		result |= 0x02;
@@ -525,14 +525,14 @@ phy_PathB_IQK_8188E(struct adapter *adapt)
 	regec4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord);
 	regecc = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord);
 
-	if (!(regeac & BIT31) &&
+	if (!(regeac & BIT(31)) &&
 	    (((regeb4 & 0x03FF0000)>>16) != 0x142) &&
 	    (((regebc & 0x03FF0000)>>16) != 0x42))
 		result |= 0x01;
 	else
 		return result;
 
-	if (!(regeac & BIT30) &&
+	if (!(regeac & BIT(30)) &&
 	    (((regec4 & 0x03FF0000)>>16) != 0x132) &&
 	    (((regecc & 0x03FF0000)>>16) != 0x36))
 		result |= 0x02;
@@ -732,9 +732,9 @@ _PHY_MACSettingCalibration(
 	ODM_Write1Byte(dm_odm, MACReg[i], 0x3F);
 
 	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++) {
-		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT3)));
+		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT(3))));
 	}
-	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT5)));
+	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT(5))));
 }
 
 void
@@ -907,15 +907,15 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	}
 
 	/* BB setting */
-	ODM_SetBBReg(dm_odm, rFPGA0_RFMOD, BIT24, 0x00);
+	ODM_SetBBReg(dm_odm, rFPGA0_RFMOD, BIT(24), 0x00);
 	ODM_SetBBReg(dm_odm, rOFDM0_TRxPathEnable, bMaskDWord, 0x03a05600);
 	ODM_SetBBReg(dm_odm, rOFDM0_TRMuxPar, bMaskDWord, 0x000800e4);
 	ODM_SetBBReg(dm_odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22204000);
 
-	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT10, 0x01);
-	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT26, 0x01);
-	ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT10, 0x00);
-	ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT10, 0x00);
+	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT(10), 0x01);
+	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT(26), 0x01);
+	ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(10), 0x00);
+	ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(10), 0x00);
 
 	if (is2t) {
 		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00010000);
@@ -1255,21 +1255,21 @@ static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2
 
 	if (!adapt->hw_init_completed) {
 		u8 u1btmp;
-		u1btmp = ODM_Read1Byte(dm_odm, REG_LEDCFG2) | BIT7;
+		u1btmp = ODM_Read1Byte(dm_odm, REG_LEDCFG2) | BIT(7);
 		ODM_Write1Byte(dm_odm, REG_LEDCFG2, u1btmp);
-		ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFParameter, BIT13, 0x01);
+		ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 	}
 
 	if (is2t) {	/* 92C */
 		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT5|BIT6, 0x1);	/* 92C_Path_A */
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5)|BIT(6), 0x1);	/* 92C_Path_A */
 		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT5|BIT6, 0x2);	/* BT */
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5)|BIT(6), 0x2);	/* BT */
 	} else {			/* 88C */
 		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT8|BIT9, 0x2);	/* Main */
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8)|BIT(9), 0x2);	/* Main */
 		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT8|BIT9, 0x1);	/* Aux */
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8)|BIT(9), 0x1);	/* Aux */
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 99b61a6c3a7a..53198bf92c0f 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -426,7 +426,7 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 {
-	pDM_Odm->bCckHighPower = (bool) ODM_GetBBReg(pDM_Odm, 0x824, BIT9);
+	pDM_Odm->bCckHighPower = (bool) ODM_GetBBReg(pDM_Odm, 0x824, BIT(9));
 	pDM_Odm->RFPathRxEnable = (u8) ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
 	if (pDM_Odm->SupportICType & (ODM_RTL8192C|ODM_RTL8192D))
 		pDM_Odm->AntDivType = CG_TRX_HW_ANTDIV;
@@ -798,8 +798,8 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 
 	if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
 		/* hold ofdm counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT31, 1); /* hold page C counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT31, 1); /* hold page D counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
 
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
 		FalseAlmCnt->Cnt_Fast_Fsync = (ret_value&0xffff);
@@ -824,8 +824,8 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		}
 
 		/* hold cck counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT12, 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT14, 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
 
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
 		FalseAlmCnt->Cnt_Cck_fail = ret_value;
@@ -847,20 +847,20 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 
 		if (pDM_Odm->SupportICType >= ODM_RTL8723A) {
 			/* reset false alarm counter registers */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT31, 1);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT31, 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT27, 1);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT27, 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 1);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 1);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 0);
 			/* update ofdm counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT31, 0); /* update page C counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT31, 0); /* update page D counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 0); /* update page C counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 0); /* update page D counter */
 
 			/* reset CCK CCA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT13|BIT12, 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT13|BIT12, 2);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13)|BIT(12), 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13)|BIT(12), 2);
 			/* reset CCK FA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 2);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15)|BIT(14), 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15)|BIT(14), 2);
 		}
 	} else { /* FOR ODM_IC_11AC_SERIES */
 		/* read OFDM FA counter */
@@ -869,11 +869,11 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		FalseAlmCnt->Cnt_all = FalseAlmCnt->Cnt_Ofdm_fail + FalseAlmCnt->Cnt_Cck_fail;
 
 		/*  reset OFDM FA coutner */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT(17), 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT(17), 0);
 		/*  reset CCK FA counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 0);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT(15), 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT(15), 1);
 	}
 }
 
@@ -1000,7 +1000,7 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 	}
 	if (pDM_PSTable->initialize == 0) {
 		pDM_PSTable->Reg874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord)&0x1CC000)>>14;
-		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord)&BIT3)>>3;
+		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord)&BIT(3))>>3;
 		pDM_PSTable->Reg85C = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord)&0xFF000000)>>24;
 		pDM_PSTable->RegA74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord)&0xF000)>>12;
 		pDM_PSTable->initialize = 1;
@@ -1031,23 +1031,23 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 			/*  <tynli_note> 8723 RSSI report will be wrong. Set 0x874[5]=1 when enter BB power saving mode. */
 			/*  Suggested by SD3 Yu-Nan. 2011.01.20. */
 			if (pDM_Odm->SupportICType == ODM_RTL8723A)
-				ODM_SetBBReg(pDM_Odm, 0x874, BIT5, 0x1); /* Reg874[5]=1b'1 */
+				ODM_SetBBReg(pDM_Odm, 0x874, BIT(5), 0x1); /* Reg874[5]=1b'1 */
 			ODM_SetBBReg(pDM_Odm, 0x874, 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
-			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, 0); /* RegC70[3]=1'b0 */
+			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), 0); /* RegC70[3]=1'b0 */
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
 			ODM_SetBBReg(pDM_Odm, 0x874, 0xC000, 0x2); /* Reg874[15:14]=2'b10 */
 			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, 0x3); /* RegA75[7:4]=0x3 */
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x0); /* Reg818[28]=1'b0 */
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x1); /* Reg818[28]=1'b1 */
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0); /* Reg818[28]=1'b0 */
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x1); /* Reg818[28]=1'b1 */
 		} else {
 			ODM_SetBBReg(pDM_Odm, 0x874, 0x1CC000, pDM_PSTable->Reg874);
-			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, pDM_PSTable->RegC70);
+			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), pDM_PSTable->RegC70);
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->Reg85C);
 			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->RegA74);
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x0);
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0);
 
 			if (pDM_Odm->SupportICType == ODM_RTL8723A)
-				ODM_SetBBReg(pDM_Odm, 0x874, BIT5, 0x0); /* Reg874[5]=1b'0 */
+				ODM_SetBBReg(pDM_Odm, 0x874, BIT(5), 0x0); /* Reg874[5]=1b'0 */
 		}
 		pDM_PSTable->PreRFState = pDM_PSTable->CurRFState;
 	}
@@ -1491,7 +1491,7 @@ void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm)
 		return;
 
 	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) {		/* at least delay 1 sec */
-		PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT17 | BIT16, 0x03);
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
 
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
 		return;
@@ -1700,10 +1700,10 @@ u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point, u8 initial_gai
 	ODM_SetBBReg(pDM_Odm, 0x808, 0x3FF, point);
 
 	/* Start PSD calculation, Reg808[22]=0->1 */
-	ODM_SetBBReg(pDM_Odm, 0x808, BIT22, 1);
+	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 1);
 	/* Need to wait for HW PSD report */
 	ODM_StallExecution(30);
-	ODM_SetBBReg(pDM_Odm, 0x808, BIT22, 0);
+	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 0);
 	/* Read PSD report, Reg8B4[15:0] */
 	psd_report = ODM_GetBBReg(pDM_Odm, 0x8B4, bMaskDWord) & 0x0000FFFF;
 
@@ -1805,11 +1805,11 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 
 	if (pDM_Odm->SupportICType == ODM_RTL8192C) {
 		/* Which path in ADC/DAC is turnned on for PSD: both I/Q */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT10|BIT11, 0x3);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(10)|BIT(11), 0x3);
 		/* Ageraged number: 8 */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT12|BIT13, 0x1);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(12)|BIT(13), 0x1);
 		/* pts = 128; */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT14|BIT15, 0x0);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(14)|BIT(15), 0x0);
 	}
 
 	/* 1 Backup Current RF/BB Settings */
@@ -1831,7 +1831,7 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 	odm_PHY_SaveAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
 
 	/* Set PSD 128 pts */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT14|BIT15, 0x0);  /* 128 pts */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT(14)|BIT(15), 0x0);  /* 128 pts */
 
 	/*  To SET CH1 to do */
 	ODM_SetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask, 0x01);     /* Channel 1 */
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 5f29535590cd..343c647a1eaf 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -449,7 +449,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 				}
 			}
 
-			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT0;
+			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT(0);
 
 		} else {
 			RSSI_Ave = pPhyInfo->RxPWDBAll;
@@ -478,7 +478,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			pEntry->rssi_stat.ValidBit++;
 
 		for (i = 0; i < pEntry->rssi_stat.ValidBit; i++)
-			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap>>i)&BIT0;
+			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap>>i)&BIT(0);
 
 		if (pEntry->rssi_stat.ValidBit == 64) {
 			Weighting = ((OFDM_pkt<<4) > 64) ? 64 : (OFDM_pkt<<4);
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 02e44403fd31..b6b95649f3af 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -18,24 +18,24 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
-		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
-		ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);  /*  1:CG, 0:CS */
+		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 0); /*  disable HW AntDiv */
+		ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);  /*  1:CG, 0:CS */
 		return;
 	}
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT22, 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	/* OFDM Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
 	/* CCK Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT7, 1); /* Fix CCK PHY status report issue */
-	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT4, 1); /* CCK complete HW AntDiv within 64 samples */
+	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
+	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
 	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
 	ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, 0xFFFF, 0x0201);	/* antenna mapping table */
 }
@@ -46,32 +46,32 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
-		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, 0); /* Default RX   (0/1) */
+		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 0); /*  disable HW AntDiv */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), 0); /* Default RX   (0/1) */
 		return;
 	}
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT22, 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	/* OFDM Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
 	/* CCK Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT7, 1); /* Fix CCK PHY status report issue */
-	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT4, 1); /* CCK complete HW AntDiv within 64 samples */
+	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
+	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
 	/* Tx Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 0); /* Reg80c[21]=1'b0		from TX Reg */
+	ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
 	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
 
 	/* antenna mapping table */
 	if (!dm_odm->bIsMPChip) { /* testchip */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT10|BIT9|BIT8, 1);	/* Reg858[10:8]=3'b001 */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT13|BIT12|BIT11, 2);	/* Reg858[13:11]=3'b010 */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(10)|BIT(9)|BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(13)|BIT(12)|BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 	} else { /* MPchip */
 		ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, bMaskDWord, 0x0201);	/* Reg914=3'b010, Reg915=3'b001 */
 	}
@@ -97,40 +97,40 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	value32 = ODM_GetMACReg(dm_odm,  0x7B4, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32|(BIT16|BIT17)); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
+	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32|(BIT(16)|BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
 
 	/* Match MAC ADDR */
 	ODM_SetMACReg(dm_odm, 0x7b4, 0xFFFF, 0);
 	ODM_SetMACReg(dm_odm, 0x7b0, bMaskDWord, 0);
 
-	ODM_SetBBReg(dm_odm, 0x870, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, 0x864, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, 0xb2c, BIT22, 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, 0xb2c, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	ODM_SetBBReg(dm_odm, 0x870, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, 0xb2c, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, 0xb2c, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	ODM_SetBBReg(dm_odm, 0xca4, bMaskDWord, 0x000000a0);
 
 	/* antenna mapping table */
 	if (AntCombination == 2) {
 		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT10|BIT9|BIT8, 1);	/* Reg858[10:8]=3'b001 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT13|BIT12|BIT11, 2);	/* Reg858[13:11]=3'b010 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(10)|BIT(9)|BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(13)|BIT(12)|BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 		} else { /* MPchip */
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
 		}
 	} else if (AntCombination == 7) {
 		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT10|BIT9|BIT8, 0);	/* Reg858[10:8]=3'b000 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT13|BIT12|BIT11, 1);	/* Reg858[13:11]=3'b001 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT16, 0);
-			ODM_SetBBReg(dm_odm, 0x858, BIT15|BIT14, 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT19|BIT18|BIT17, 3);/* Reg878[3:1]=3b'011 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT22|BIT21|BIT20, 4);/* Reg878[6:4]=3b'100 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT25|BIT24|BIT23, 5);/* Reg878[9:7]=3b'101 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT28|BIT27|BIT26, 6);/* Reg878[12:10]=3b'110 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT31|BIT30|BIT29, 7);/* Reg878[15:13]=3b'111 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(10)|BIT(9)|BIT(8), 0);	/* Reg858[10:8]=3'b000 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(13)|BIT(12)|BIT(11), 1);	/* Reg858[13:11]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(16), 0);
+			ODM_SetBBReg(dm_odm, 0x858, BIT(15)|BIT(14), 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(19)|BIT(18)|BIT(17), 3);/* Reg878[3:1]=3b'011 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(22)|BIT(21)|BIT(20), 4);/* Reg878[6:4]=3b'100 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(25)|BIT(24)|BIT(23), 5);/* Reg878[9:7]=3b'101 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(28)|BIT(27)|BIT(26), 6);/* Reg878[12:10]=3b'110 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(31)|BIT(30)|BIT(29), 7);/* Reg878[15:13]=3b'111 */
 		} else { /* MPchip */
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 0);
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 1);
@@ -144,13 +144,13 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	}
 
 	/* Default Ant Setting when no fast training */
-	ODM_SetBBReg(dm_odm, 0x80c, BIT21, 1); /* Reg80c[21]=1'b1		from TX Info */
-	ODM_SetBBReg(dm_odm, 0x864, BIT5|BIT4|BIT3, 0);	/* Default RX */
-	ODM_SetBBReg(dm_odm, 0x864, BIT8|BIT7|BIT6, 1);	/* Optional RX */
+	ODM_SetBBReg(dm_odm, 0x80c, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(5)|BIT(4)|BIT(3), 0);	/* Default RX */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(8)|BIT(7)|BIT(6), 1);	/* Optional RX */
 
 	/* Enter Traing state */
-	ODM_SetBBReg(dm_odm, 0x864, BIT2|BIT1|BIT0, (AntCombination-1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
-	ODM_SetBBReg(dm_odm, 0xc50, BIT7, 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(2)|BIT(1)|BIT(0), (AntCombination-1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
+	ODM_SetBBReg(dm_odm, 0xc50, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
 }
 
 void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
@@ -181,13 +181,13 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 		}
 
 		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT8|BIT7|BIT6, OptionalAnt);		/* Optional RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT14|BIT13|BIT12, DefaultAnt);	/* Default TX */
-			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT6|BIT7, DefaultAnt);	/* Resp Tx */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8)|BIT(7)|BIT(6), OptionalAnt);		/* Optional RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT(14)|BIT(13)|BIT(12), DefaultAnt);	/* Default TX */
+			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT(6)|BIT(7), DefaultAnt);	/* Resp Tx */
 		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT8|BIT7|BIT6, OptionalAnt);		/* Optional RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8)|BIT(7)|BIT(6), OptionalAnt);		/* Optional RX */
 		}
 	}
 	dm_fat_tbl->RxIdleAnt = Ant;
@@ -204,9 +204,9 @@ static void odm_UpdateTxAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant, u32 MacId)
 		TargetAnt = MAIN_ANT_CG_TRX;
 	else
 		TargetAnt = AUX_ANT_CG_TRX;
-	dm_fat_tbl->antsel_a[MacId] = TargetAnt&BIT0;
-	dm_fat_tbl->antsel_b[MacId] = (TargetAnt&BIT1)>>1;
-	dm_fat_tbl->antsel_c[MacId] = (TargetAnt&BIT2)>>2;
+	dm_fat_tbl->antsel_a[MacId] = TargetAnt&BIT(0);
+	dm_fat_tbl->antsel_b[MacId] = (TargetAnt&BIT(1))>>1;
+	dm_fat_tbl->antsel_c[MacId] = (TargetAnt&BIT(2))>>2;
 }
 
 void ODM_SetTxAntByTxInfo_88E(struct odm_dm_struct *dm_odm, u8 *pDesc, u8 macId)
@@ -300,20 +300,20 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 		return;
 	if (!dm_odm->bLinked) {
 		if (dm_fat_tbl->bBecomeLinked) {
-			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
-			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 0); /* Enable CCK AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 0); /* Enable CCK AntDiv */
 			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 0); /* Reg80c[21]=1'b0		from TX Reg */
+				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
 			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
 		}
 		return;
 	} else {
 		if (!dm_fat_tbl->bBecomeLinked) {
 			/* Because HW AntDiv is disabled before Link, we enable HW AntDiv after link */
-			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
-			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 1); /* Enable CCK AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 1); /* Enable CCK AntDiv */
 			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 1); /* Reg80c[21]=1'b1		from TX Info */
+				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
 			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 02eda8fae25c..6cbda9ab6e3f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -598,7 +598,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Do not set TSF again here or vWiFi beacon DMA INT will not work. */
 
 		/* Set REG_CR bit 8. DMA beacon by SW. */
-		haldata->RegCR_1 |= BIT0;
+		haldata->RegCR_1 |= BIT(0);
 		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
 
 		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
@@ -607,14 +607,14 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(3)));
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)|BIT(4));
 
-		if (haldata->RegFwHwTxQCtrl&BIT6) {
+		if (haldata->RegFwHwTxQCtrl&BIT(6)) {
 			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
 			bSendBeacon = true;
 		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
-		rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl&(~BIT6)));
-		haldata->RegFwHwTxQCtrl &= (~BIT6);
+		rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl&(~BIT(6))));
+		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
 		/*  Clear beacon valid check bit. */
 		rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
@@ -656,8 +656,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  the beacon cannot be sent by HW. */
 		/*  2010.06.23. Added by tynli. */
 		if (bSendBeacon) {
-			rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl|BIT6));
-			haldata->RegFwHwTxQCtrl |= BIT6;
+			rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl|BIT(6)));
+			haldata->RegFwHwTxQCtrl |= BIT(6);
 		}
 
 		/*  Update RSVD page location H2C to Fw. */
@@ -668,7 +668,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
-		haldata->RegCR_1 &= (~BIT0);
+		haldata->RegCR_1 &= (~BIT(0));
 		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
 	}
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 732d42ab3e0d..588520d28097 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -351,7 +351,7 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 			rtw_usleep_os(2);
 			loop = 0;
 			do {
-				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL)&BIT24);
+				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL)&BIT(24));
 				if (rstatus) {
 					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L);
 					memcpy(pbuf+(addr*8), &fifo_data, 4);
@@ -495,8 +495,8 @@ void _8051Reset88E(struct adapter *padapter)
 	u8 u1bTmp;
 
 	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
-	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT2));
-	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp|(BIT2));
+	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT(2)));
+	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp|(BIT(2)));
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
 }
 
@@ -1077,7 +1077,7 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 
 	memset((void *)tmpdata, 0xff, PGPKT_DATA_SIZE);
 
-	if (!(word_en&BIT0)) {
+	if (!(word_en&BIT(0))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[0], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[1], bPseudoTest);
@@ -1085,9 +1085,9 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[0], bPseudoTest);
 		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[1], bPseudoTest);
 		if ((data[0] != tmpdata[0]) || (data[1] != tmpdata[1]))
-			badworden &= (~BIT0);
+			badworden &= (~BIT(0));
 	}
-	if (!(word_en&BIT1)) {
+	if (!(word_en&BIT(1))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[2], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[3], bPseudoTest);
@@ -1095,9 +1095,9 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[2], bPseudoTest);
 		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[3], bPseudoTest);
 		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3]))
-			badworden &= (~BIT1);
+			badworden &= (~BIT(1));
 	}
-	if (!(word_en&BIT2)) {
+	if (!(word_en&BIT(2))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[4], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[5], bPseudoTest);
@@ -1105,9 +1105,9 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[4], bPseudoTest);
 		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[5], bPseudoTest);
 		if ((data[4] != tmpdata[4]) || (data[5] != tmpdata[5]))
-			badworden &= (~BIT2);
+			badworden &= (~BIT(2));
 	}
-	if (!(word_en&BIT3)) {
+	if (!(word_en&BIT(3))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[6], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[7], bPseudoTest);
@@ -1115,7 +1115,7 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[6], bPseudoTest);
 		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[7], bPseudoTest);
 		if ((data[6] != tmpdata[6]) || (data[7] != tmpdata[7]))
-			badworden &= (~BIT3);
+			badworden &= (~BIT(3));
 	}
 	return badworden;
 }
@@ -1493,18 +1493,18 @@ static bool wordEnMatched(struct pgpkt *pTargetPkt, struct pgpkt *pCurPkt,
 	u8 match_word_en = 0x0F;	/*  default all words are disabled */
 
 	/*  check if the same words are enabled both target and current PG packet */
-	if (((pTargetPkt->word_en & BIT0) == 0) &&
-	    ((pCurPkt->word_en & BIT0) == 0))
-		match_word_en &= ~BIT0;				/*  enable word 0 */
-	if (((pTargetPkt->word_en & BIT1) == 0) &&
-	    ((pCurPkt->word_en & BIT1) == 0))
-		match_word_en &= ~BIT1;				/*  enable word 1 */
-	if (((pTargetPkt->word_en & BIT2) == 0) &&
-	    ((pCurPkt->word_en & BIT2) == 0))
-		match_word_en &= ~BIT2;				/*  enable word 2 */
-	if (((pTargetPkt->word_en & BIT3) == 0) &&
-	    ((pCurPkt->word_en & BIT3) == 0))
-		match_word_en &= ~BIT3;				/*  enable word 3 */
+	if (((pTargetPkt->word_en & BIT(0)) == 0) &&
+	    ((pCurPkt->word_en & BIT(0)) == 0))
+		match_word_en &= ~BIT(0);				/*  enable word 0 */
+	if (((pTargetPkt->word_en & BIT(1)) == 0) &&
+	    ((pCurPkt->word_en & BIT(1)) == 0))
+		match_word_en &= ~BIT(1);				/*  enable word 1 */
+	if (((pTargetPkt->word_en & BIT(2)) == 0) &&
+	    ((pCurPkt->word_en & BIT(2)) == 0))
+		match_word_en &= ~BIT(2);				/*  enable word 2 */
+	if (((pTargetPkt->word_en & BIT(3)) == 0) &&
+	    ((pCurPkt->word_en & BIT(3)) == 0))
+		match_word_en &= ~BIT(3);				/*  enable word 3 */
 
 	*pWden = match_word_en;
 
@@ -1786,10 +1786,10 @@ static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
+		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT(1));
 	} else {
 		DBG_88E("Disable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
+		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT(1));
 	}
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
@@ -2008,7 +2008,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] = EEPROM_DEFAULT_24G_HT20_DIFF;
 				} else {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr]&0xf0)>>4;
-					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
 
@@ -2016,7 +2016,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_24G_OFDM_DIFF;
 				} else {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
-					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
 				pwrInfo24G->CCK_Diff[rfPath][TxCount] = 0;
@@ -2026,7 +2026,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
 					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
-					if (pwrInfo24G->BW40_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->BW40_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW40_Diff[rfPath][TxCount] |= 0xF0;
 				}
 
@@ -2034,7 +2034,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
-					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
 				eeAddr++;
@@ -2043,7 +2043,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
 				} else {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
-					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
 
@@ -2051,7 +2051,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
 					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
-					if (pwrInfo24G->CCK_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+					if (pwrInfo24G->CCK_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->CCK_Diff[rfPath][TxCount] |= 0xF0;
 				}
 				eeAddr++;
@@ -2121,13 +2121,13 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 		/* hw power down mode selection , 0:rf-off / 1:power down */
 
 		if (padapter->registrypriv.hwpdn_mode == 2)
-			padapter->pwrctrlpriv.bHWPowerdown = (hwinfo[EEPROM_RF_FEATURE_OPTION_88E] & BIT4);
+			padapter->pwrctrlpriv.bHWPowerdown = (hwinfo[EEPROM_RF_FEATURE_OPTION_88E] & BIT(4));
 		else
 			padapter->pwrctrlpriv.bHWPowerdown = padapter->registrypriv.hwpdn_mode;
 
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
-		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT1) ? true : false;
+		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
 
 		DBG_88E("%s...bHWPwrPindetect(%x)-bHWPowerdown(%x) , bSupportRemoteWakeup(%x)\n", __func__,
 		padapter->pwrctrlpriv.bHWPwrPindetect, padapter->pwrctrlpriv.bHWPowerdown, padapter->pwrctrlpriv.bSupportRemoteWakeup);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index f6d4029eae22..b5fb3aedc000 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -400,11 +400,11 @@ void Hal_SetAntenna(struct adapter *pAdapter)
 
 		/*  We need to close RFB by SW control */
 		if (pHalData->rf_type == RF_2T2R) {
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 1);
-			PHY_SetBBReg(pAdapter, rFPGA0_XB_RFInterfaceOE, BIT10, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 1);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(10), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(26), 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XB_RFInterfaceOE, BIT(10), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(1), 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(17), 0);
 		}
 		break;
 	case ANTENNA_B:
@@ -425,11 +425,11 @@ void Hal_SetAntenna(struct adapter *pAdapter)
 		/*  2008/10/31 MH From SD3 Willi's suggestion. We must read RF 1T table. */
 		/*  2009/01/08 MH From Sd3 Willis. We need to close RFA by SW control */
 		if (pHalData->rf_type == RF_2T2R || pHalData->rf_type == RF_1T2R) {
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 1);
-			PHY_SetBBReg(pAdapter, rFPGA0_XA_RFInterfaceOE, BIT10, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(10), 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XA_RFInterfaceOE, BIT(10), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(26), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(1), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(17), 1);
 		}
 		break;
 	case ANTENNA_AB:	/*  For 8192S */
@@ -449,10 +449,10 @@ void Hal_SetAntenna(struct adapter *pAdapter)
 		/* cosa r_ant_select_ofdm_val = 0x3321333; */
 		/*  2009/01/08 MH From Sd3 Willis. We need to enable RFA/B by SW control */
 		if (pHalData->rf_type == RF_2T2R) {
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 0);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 1);
-			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(10), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT(26), 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(1), 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT(17), 1);
 		}
 		break;
 	default:
@@ -527,7 +527,7 @@ s32 Hal_SetThermalMeter(struct adapter *pAdapter, u8 target_ther)
 
 void Hal_TriggerRFThermalMeter(struct adapter *pAdapter)
 {
-	_write_rfreg(pAdapter, RF_PATH_A, RF_T_METER_88E, BIT17 | BIT16, 0x03);
+	_write_rfreg(pAdapter, RF_PATH_A, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
 }
 
 u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter)
@@ -617,7 +617,7 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x0);
 
 		if (is92C) {
-			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT19, 0x01);
+			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT(19), 0x01);
 			rtw_usleep_os(100);
 			if (rfPath == RF_PATH_A)
 				write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x10000); /*  PAD all on. */
@@ -648,7 +648,7 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x1);
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
 		if (is92C) {
-			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT19, 0x00);
+			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT(19), 0x00);
 			rtw_usleep_os(100);
 			write_rfreg(pAdapter, RF_PATH_A, 0x00, 0x32d75); /*  PAD all on. */
 			write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x32d75); /*  PAD all on. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 58d8e0113490..f7b6402e1cd2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -178,9 +178,9 @@ phy_RFSerialRead(
 	udelay(10);/* PlatformStallExecution(10); */
 
 	if (eRFPath == RF_PATH_A)
-		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT8);
+		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT(8));
 	else if (eRFPath == RF_PATH_B)
-		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XB_HSSIParameter1, BIT8);
+		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XB_HSSIParameter1, BIT(8));
 
 	if (RfPiEnable) {	/*  Read from BBreg8b8, 12 bits for 8190, 20bits for T65 RF */
 		retValue = PHY_QueryBBReg(Adapter, pPhyReg->rfLSSIReadBackPi, bLSSIReadBackData);
@@ -582,7 +582,7 @@ PHY_BBConfig8188E(
 
 	/*  Enable BB and RF */
 	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
-	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal|BIT13|BIT0|BIT1));
+	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal|BIT(13)|BIT(0)|BIT(1)));
 
 	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
 
@@ -1011,7 +1011,7 @@ _PHY_SetBWMode92C(
 		/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
 		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC>>1));
 		PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
-		PHY_SetBBReg(Adapter, 0x818, (BIT26 | BIT27),
+		PHY_SetBBReg(Adapter, 0x818, (BIT(26) | BIT(27)),
 			     (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) ? 2 : 1);
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 2c573e86d3f8..75ec97107add 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -20,10 +20,10 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0)|BIT5|BIT6); /*  SW control led0 on. */
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0)|BIT(5)|BIT(6)); /*  SW control led0 on. */
 		break;
 	case LED_PIN_LED1:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0x0f)|BIT5); /*  SW control led1 on. */
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0x0f)|BIT(5)); /*  SW control led1 on. */
 		break;
 	default:
 		break;
@@ -48,17 +48,17 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 		if (pHalData->bLedOpenDrain) {
 			/*  Open-drain arrangement for controlling the LED) */
 			LedCfg &= 0x90; /*  Set to software control. */
-			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3));
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)));
 			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
 			LedCfg &= 0xFE;
 			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
 		} else {
-			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3|BIT5|BIT6));
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)|BIT(5)|BIT(6)));
 		}
 		break;
 	case LED_PIN_LED1:
 		LedCfg &= 0x0f; /*  Set to software control. */
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3));
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)));
 		break;
 	default:
 		break;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2bce4334ba68..9305d97fd54d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -611,7 +611,7 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 static void _BeaconFunctionEnable(struct adapter *Adapter,
 				  bool Enable, bool Linked)
 {
-	rtw_write8(Adapter, REG_BCN_CTRL, (BIT4 | BIT3 | BIT1));
+	rtw_write8(Adapter, REG_BCN_CTRL, (BIT(4) | BIT(3) | BIT(1)));
 
 	rtw_write8(Adapter, REG_RD_CTRL+1, 0x6F);
 }
@@ -636,8 +636,8 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		return;
 	DBG_88E("==>  %s ....\n", __func__);
 
-	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0)|BIT23);
-	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT13, 0x01);
+	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0)|BIT(23));
+	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
 		haldata->CurAntenna = Antenna_A;
@@ -668,13 +668,13 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 
 	if (adapt->pwrctrlpriv.bHWPowerdown) {
 		val8 = rtw_read8(adapt, REG_HSISR);
-		DBG_88E("pwrdown, 0x5c(BIT7)=%02x\n", val8);
-		rfpowerstate = (val8 & BIT7) ? rf_off : rf_on;
+		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
+		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
-		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG)&~(BIT3));
+		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG)&~(BIT(3)));
 		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
 		DBG_88E("GPIO_IN=%02x\n", val8);
-		rfpowerstate = (val8 & BIT3) ? rf_on : rf_off;
+		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
 	}
 	return rfpowerstate;
 }	/*  HalDetectPwrDownMode */
@@ -836,7 +836,7 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
 	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
-	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8|BIT1|BIT0));
+	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8|BIT(1)|BIT(0)));
 	/* Set MAX RPT MACID */
 	rtw_write8(Adapter,  REG_TX_RPT_CTRL+1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
 	/* Tx RPT Timer. Unit: 32us */
@@ -965,7 +965,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
-	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT1));
+	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT(1)));
 
 	/*  stop rx */
 	rtw_write8(Adapter, REG_CR, 0x0);
@@ -989,16 +989,16 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	/* YJ,add,111212 */
 	/* Disable 32k */
 	val8 = rtw_read8(Adapter, REG_32K_CTRL);
-	rtw_write8(Adapter, REG_32K_CTRL, val8&(~BIT0));
+	rtw_write8(Adapter, REG_32K_CTRL, val8&(~BIT(0)));
 
 	/*  Card disable power action flow */
 	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
 	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
-	rtw_write8(Adapter, REG_RSV_CTRL+1, (val8&(~BIT3)));
+	rtw_write8(Adapter, REG_RSV_CTRL+1, (val8&(~BIT(3))));
 	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
-	rtw_write8(Adapter, REG_RSV_CTRL+1, val8|BIT3);
+	rtw_write8(Adapter, REG_RSV_CTRL+1, val8|BIT(3));
 
 	/* YJ,test add, 111207. For Power Consumption. */
 	val8 = rtw_read8(Adapter, GPIO_IN);
@@ -1016,7 +1016,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 static void rtl8192cu_hw_power_down(struct adapter *adapt)
 {
 	/*  2010/-8/09 MH For power down module, we need to enable register block contrl reg at 0x1c. */
-	/*  Then enable power down control bit of register 0x04 BIT4 and BIT15 as 1. */
+	/*  Then enable power down control bit of register 0x04 BIT(4) and BIT(15) as 1. */
 
 	/*  Enable register area 0x0-0xc. */
 	rtw_write8(adapt, REG_RSV_CTRL, 0x0);
@@ -1235,10 +1235,10 @@ static void ResumeTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT6);
-	haldata->RegFwHwTxQCtrl |= BIT6;
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT(6));
+	haldata->RegFwHwTxQCtrl |= BIT(6);
 	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0xff);
-	haldata->RegReg542 |= BIT0;
+	haldata->RegReg542 |= BIT(0);
 	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
 }
 
@@ -1249,10 +1249,10 @@ static void StopTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT6));
-	haldata->RegFwHwTxQCtrl &= (~BIT6);
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
+	haldata->RegFwHwTxQCtrl &= (~BIT(6));
 	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0x64);
-	haldata->RegReg542 &= ~(BIT0);
+	haldata->RegReg542 &= ~(BIT(0));
 	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
 
 	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
@@ -1303,7 +1303,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 		/* reset TSF */
 		rtw_write8(Adapter, REG_DUAL_TSF_RST, BIT(0));
 
-		/* BIT3 - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
+		/* BIT(3) - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
 		rtw_write8(Adapter, REG_MBID_NUM, rtw_read8(Adapter, REG_MBID_NUM) | BIT(3) | BIT(4));
 
 		/* enable BCN0 Function for if1 */
@@ -1867,8 +1867,8 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		rtl8188e_set_FwMediaStatus_cmd(Adapter, (*(__le16 *)val));
 		break;
 	case HW_VAR_BCN_VALID:
-		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		rtw_write8(Adapter, REG_TDECTRL+2, rtw_read8(Adapter, REG_TDECTRL+2) | BIT0);
+		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
+		rtw_write8(Adapter, REG_TDECTRL+2, rtw_read8(Adapter, REG_TDECTRL+2) | BIT(0));
 		break;
 	default:
 		break;
@@ -1889,8 +1889,8 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
 		break;
 	case HW_VAR_BCN_VALID:
-		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2 */
-		val[0] = (BIT0 & rtw_read8(Adapter, REG_TDECTRL+2)) ? true : false;
+		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
+		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL+2)) ? true : false;
 		break;
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 63b068fa9f4d..96888d66d28c 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -67,13 +67,13 @@ enum rf_radio_path {
 
 enum wireless_mode {
 	WIRELESS_MODE_UNKNOWN = 0x00,
-	WIRELESS_MODE_A			= BIT2,
-	WIRELESS_MODE_B			= BIT0,
-	WIRELESS_MODE_G			= BIT1,
-	WIRELESS_MODE_AUTO		= BIT5,
-	WIRELESS_MODE_N_24G		= BIT3,
-	WIRELESS_MODE_N_5G		= BIT4,
-	WIRELESS_MODE_AC		= BIT6
+	WIRELESS_MODE_A			= BIT(2),
+	WIRELESS_MODE_B			= BIT(0),
+	WIRELESS_MODE_G			= BIT(1),
+	WIRELESS_MODE_AUTO		= BIT(5),
+	WIRELESS_MODE_N_24G		= BIT(3),
+	WIRELESS_MODE_N_5G		= BIT(4),
+	WIRELESS_MODE_AC		= BIT(6)
 };
 
 enum phy_rate_tx_offset_area {
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index 43f41e77a939..a73bd1a5d57b 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -42,70 +42,70 @@
 #define RTL8188E_TRANS_CARDEMU_TO_ACT														\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT1, BIT1},/* wait till 0x04[17] = 1    power ready*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0|BIT1, 0}, /* 0x02[1:0] = 0	reset BB*/			\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4|BIT3, 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, BIT0}, /*0x04[8] = 1 polling until return 0*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT0, 0}, /*wait till 0x04[8] = 0*/	\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*LDO normal mode*/	\
-	{0x0074, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*SDIO Driving*/	\
+	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), BIT(1)},/* wait till 0x04[17] = 1    power ready*/	\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0)|BIT(1), 0}, /* 0x02[1:0] = 0	reset BB*/			\
+	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4)|BIT(3), 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*0x04[8] = 1 polling until return 0*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(0), 0}, /*wait till 0x04[8] = 0*/	\
+	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*LDO normal mode*/	\
+	{0x0074, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*SDIO Driving*/	\
 
 #define RTL8188E_TRANS_ACT_TO_CARDEMU													\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
 	{0x001F, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*LDO Sleep mode*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, BIT1}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT1, 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
+	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*LDO Sleep mode*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(1), 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
 
 #define RTL8188E_TRANS_CARDEMU_TO_SUS													\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/				\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01enable WL suspend*/	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3|BIT4}, /*0x04[12:11] = 2b'11enable WL suspend for PCIe*/	\
-	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, BIT7}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
-	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
-	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01enable WL suspend*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)|BIT(4)}, /*0x04[12:11] = 2b'11enable WL suspend for PCIe*/	\
+	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, BIT(7)}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), 0}, /*wait power state to suspend*/
 
 #define RTL8188E_TRANS_SUS_TO_CARDEMU													\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/							\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), 0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), BIT(1)}, /*wait power state to suspend*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
 
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS													\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/							\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7}, /*0x24[23] = 2b'01 schmit trigger */	\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
+	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), BIT(3)}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
 	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
-	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
-	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
+	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), BIT(4)}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), BIT(0)}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), 0}, /*wait power state to suspend*/
 
 #define RTL8188E_TRANS_CARDDIS_TO_CARDEMU													\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
-	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT(0), 0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT(1), BIT(1)}, /*wait power state to suspend*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(3)|BIT(4), 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
 
 #define RTL8188E_TRANS_CARDEMU_TO_PDN												\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/							\
-	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0},/* 0x04[16] = 0*/\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7},/* 0x04[15] = 1*/
+	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/* 0x04[16] = 0*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), BIT(7)},/* 0x04[15] = 1*/
 
 #define RTL8188E_TRANS_PDN_TO_CARDEMU												\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here					 */ \
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, 0},/* 0x04[15] = 0*/
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(7), 0},/* 0x04[15] = 0*/
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 #define RTL8188E_TRANS_ACT_TO_LPS														\
@@ -116,11 +116,11 @@
 	{0x05F9, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
 	{0x05FA, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
 	{0x05FB, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0},/*CCK and OFDM are disabled,and clock are gated*/	\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(0), 0},/*CCK and OFDM are disabled,and clock are gated*/	\
 	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
 	{0x0100, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
-	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, 0},/*check if removed later*/	\
-	{0x0553, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT5, BIT5},/*Respond TxOK to scheduler*/	\
+	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), 0},/*check if removed later*/	\
+	{0x0553, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(5), BIT(5)},/*Respond TxOK to scheduler*/	\
 
 #define RTL8188E_TRANS_LPS_TO_ACT															\
 	/* format */																\
@@ -129,12 +129,12 @@
 	{0xFE58, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x84}, /*USB RPWM*/\
 	{0x0361, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x84}, /*PCIe RPWM*/\
 	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_MS}, /*Delay*/\
-	{0x0008, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*.	0x08[4] = 0		 switch TSF to 40M*/\
-	{0x0109, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT7, 0}, /*Polling 0x109[7]=0  TSF in 40M*/\
-	{0x0029, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT6|BIT7, 0}, /*.	0x29[7:6] = 2b'00	 enable BB clock*/\
-	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, BIT1}, /*.	0x101[1] = 1*/\
+	{0x0008, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(4), 0}, /*.	0x08[4] = 0		 switch TSF to 40M*/\
+	{0x0109, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT(7), 0}, /*Polling 0x109[7]=0  TSF in 40M*/\
+	{0x0029, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(6)|BIT(7), 0}, /*.	0x29[7:6] = 2b'00	 enable BB clock*/\
+	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1), BIT(1)}, /*.	0x101[1] = 1*/\
 	{0x0100, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0xFF}, /*.	0x100[7:0] = 0xFF	 enable WMAC TRX*/\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1|BIT0, BIT1|BIT0}, /*.	0x02[1:0] = 2b'11	 enable BB macro*/\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT(1)|BIT(0), BIT(1)|BIT(0)}, /*.	0x02[1:0] = 2b'11	 enable BB macro*/\
 	{0x0522, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*.	0x522 = 0*/
 
 #define RTL8188E_TRANS_END															\
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 8f62cbe9ba37..37ddb9745350 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -9,10 +9,10 @@
 #include "Hal8188EPhyCfg.h"
 
 enum RTL871X_HCI_TYPE {
-	RTW_PCIE	= BIT0,
-	RTW_USB		= BIT1,
-	RTW_SDIO	= BIT2,
-	RTW_GSPI	= BIT3,
+	RTW_PCIE	= BIT(0),
+	RTW_USB		= BIT(1),
+	RTW_SDIO	= BIT(2),
+	RTW_GSPI	= BIT(3),
 };
 
 enum _CHIP_TYPE {
@@ -264,10 +264,10 @@ enum rt_eeprom_type {
 };
 
 #define RF_CHANGE_BY_INIT	0
-#define RF_CHANGE_BY_IPS	BIT28
-#define RF_CHANGE_BY_PS		BIT29
-#define RF_CHANGE_BY_HW		BIT30
-#define RF_CHANGE_BY_SW		BIT31
+#define RF_CHANGE_BY_IPS	BIT(28)
+#define RF_CHANGE_BY_PS		BIT(29)
+#define RF_CHANGE_BY_HW		BIT(30)
+#define RF_CHANGE_BY_SW		BIT(31)
 
 enum hardware_type {
 	HARDWARE_TYPE_RTL8180,
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 2a6fd4072e00..a1f8c7fe595c 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -409,28 +409,28 @@ enum odm_common_info_def {
 
 enum odm_ability_def {
 	/*  BB ODM section BIT 0-15 */
-	ODM_BB_DIG			= BIT0,
-	ODM_BB_RA_MASK			= BIT1,
-	ODM_BB_DYNAMIC_TXPWR		= BIT2,
-	ODM_BB_FA_CNT			= BIT3,
-	ODM_BB_RSSI_MONITOR		= BIT4,
-	ODM_BB_CCK_PD			= BIT5,
-	ODM_BB_ANT_DIV			= BIT6,
-	ODM_BB_PWR_SAVE			= BIT7,
-	ODM_BB_PWR_TRA			= BIT8,
-	ODM_BB_RATE_ADAPTIVE		= BIT9,
-	ODM_BB_PATH_DIV			= BIT10,
-	ODM_BB_PSD			= BIT11,
-	ODM_BB_RXHP			= BIT12,
+	ODM_BB_DIG			= BIT(0),
+	ODM_BB_RA_MASK			= BIT(1),
+	ODM_BB_DYNAMIC_TXPWR		= BIT(2),
+	ODM_BB_FA_CNT			= BIT(3),
+	ODM_BB_RSSI_MONITOR		= BIT(4),
+	ODM_BB_CCK_PD			= BIT(5),
+	ODM_BB_ANT_DIV			= BIT(6),
+	ODM_BB_PWR_SAVE			= BIT(7),
+	ODM_BB_PWR_TRA			= BIT(8),
+	ODM_BB_RATE_ADAPTIVE		= BIT(9),
+	ODM_BB_PATH_DIV			= BIT(10),
+	ODM_BB_PSD			= BIT(11),
+	ODM_BB_RXHP			= BIT(12),
 
 	/*  MAC DM section BIT 16-23 */
-	ODM_MAC_EDCA_TURBO		= BIT16,
-	ODM_MAC_EARLY_MODE		= BIT17,
+	ODM_MAC_EDCA_TURBO		= BIT(16),
+	ODM_MAC_EARLY_MODE		= BIT(17),
 
 	/*  RF ODM section BIT 24-31 */
-	ODM_RF_TX_PWR_TRACK		= BIT24,
-	ODM_RF_RX_GAIN_TRACK		= BIT25,
-	ODM_RF_CALIBRATION		= BIT26,
+	ODM_RF_TX_PWR_TRACK		= BIT(24),
+	ODM_RF_RX_GAIN_TRACK		= BIT(25),
+	ODM_RF_CALIBRATION		= BIT(26),
 };
 
 /* 	ODM_CMNINFO_INTERFACE */
@@ -443,13 +443,13 @@ enum odm_interface_def {
 
 /*  ODM_CMNINFO_IC_TYPE */
 enum odm_ic_type {
-	ODM_RTL8192S	=	BIT0,
-	ODM_RTL8192C	=	BIT1,
-	ODM_RTL8192D	=	BIT2,
-	ODM_RTL8723A	=	BIT3,
-	ODM_RTL8188E	=	BIT4,
-	ODM_RTL8812	=	BIT5,
-	ODM_RTL8821	=	BIT6,
+	ODM_RTL8192S	=	BIT(0),
+	ODM_RTL8192C	=	BIT(1),
+	ODM_RTL8192D	=	BIT(2),
+	ODM_RTL8723A	=	BIT(3),
+	ODM_RTL8188E	=	BIT(4),
+	ODM_RTL8812	=	BIT(5),
+	ODM_RTL8821	=	BIT(6),
 };
 
 #define ODM_IC_11N_SERIES						\
@@ -475,16 +475,16 @@ enum odm_fab_Version {
 };
 
 /*  ODM_CMNINFO_RF_TYPE */
-/*  For example 1T2R (A+AB = BIT0|BIT4|BIT5) */
+/*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
 enum odm_rf_path {
-	ODM_RF_TX_A	=	BIT0,
-	ODM_RF_TX_B	=	BIT1,
-	ODM_RF_TX_C	=	BIT2,
-	ODM_RF_TX_D	=	BIT3,
-	ODM_RF_RX_A	=	BIT4,
-	ODM_RF_RX_B	=	BIT5,
-	ODM_RF_RX_C	=	BIT6,
-	ODM_RF_RX_D	=	BIT7,
+	ODM_RF_TX_A	=	BIT(0),
+	ODM_RF_TX_B	=	BIT(1),
+	ODM_RF_TX_C	=	BIT(2),
+	ODM_RF_TX_D	=	BIT(3),
+	ODM_RF_RX_A	=	BIT(4),
+	ODM_RF_RX_B	=	BIT(5),
+	ODM_RF_RX_C	=	BIT(6),
+	ODM_RF_RX_D	=	BIT(7),
 };
 
 enum odm_rf_type {
@@ -515,33 +515,33 @@ enum odm_bt_coexist {
 
 /*  ODM_CMNINFO_OP_MODE */
 enum odm_operation_mode {
-	ODM_NO_LINK		= BIT0,
-	ODM_LINK		= BIT1,
-	ODM_SCAN		= BIT2,
-	ODM_POWERSAVE		= BIT3,
-	ODM_AP_MODE		= BIT4,
-	ODM_CLIENT_MODE		= BIT5,
-	ODM_AD_HOC		= BIT6,
-	ODM_WIFI_DIRECT		= BIT7,
-	ODM_WIFI_DISPLAY	= BIT8,
+	ODM_NO_LINK		= BIT(0),
+	ODM_LINK		= BIT(1),
+	ODM_SCAN		= BIT(2),
+	ODM_POWERSAVE		= BIT(3),
+	ODM_AP_MODE		= BIT(4),
+	ODM_CLIENT_MODE		= BIT(5),
+	ODM_AD_HOC		= BIT(6),
+	ODM_WIFI_DIRECT		= BIT(7),
+	ODM_WIFI_DISPLAY	= BIT(8),
 };
 
 /*  ODM_CMNINFO_WM_MODE */
 enum odm_wireless_mode {
 	ODM_WM_UNKNOW	= 0x0,
-	ODM_WM_B	= BIT0,
-	ODM_WM_G	= BIT1,
-	ODM_WM_A	= BIT2,
-	ODM_WM_N24G	= BIT3,
-	ODM_WM_N5G	= BIT4,
-	ODM_WM_AUTO	= BIT5,
-	ODM_WM_AC	= BIT6,
+	ODM_WM_B	= BIT(0),
+	ODM_WM_G	= BIT(1),
+	ODM_WM_A	= BIT(2),
+	ODM_WM_N24G	= BIT(3),
+	ODM_WM_N5G	= BIT(4),
+	ODM_WM_AUTO	= BIT(5),
+	ODM_WM_AC	= BIT(6),
 };
 
 /*  ODM_CMNINFO_BAND */
 enum odm_band_type {
-	ODM_BAND_2_4G	= BIT0,
-	ODM_BAND_5G	= BIT1,
+	ODM_BAND_2_4G	= BIT(0),
+	ODM_BAND_5G	= BIT(1),
 };
 
 /*  ODM_CMNINFO_SEC_CHNL_OFFSET */
@@ -801,7 +801,7 @@ struct odm_dm_struct {
 	u64	*pNumTxBytesUnicast;
 	/* RX Unicast byte count */
 	u64	*pNumRxBytesUnicast;
-	/*  Wireless mode B/G/A/N = BIT0/BIT1/BIT2/BIT3 */
+	/*  Wireless mode B/G/A/N = BIT(0)/BIT(1)/BIT(2)/BIT(3) */
 	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
 	/*  Frequence band 2.4G/5G = 0/1 */
 	u8	*pBandType;
diff --git a/drivers/staging/r8188eu/include/odm_reg.h b/drivers/staging/r8188eu/include/odm_reg.h
index 81e633fcc0ac..78d7e904947c 100644
--- a/drivers/staging/r8188eu/include/odm_reg.h
+++ b/drivers/staging/r8188eu/include/odm_reg.h
@@ -84,6 +84,6 @@
 /*  Bitmap Definition */
 /*  */
 
-#define	BIT_FA_RESET					BIT0
+#define	BIT_FA_RESET					BIT(0)
 
 #endif
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index 53a2fee55e35..6f4a4bd37ec1 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -7,10 +7,10 @@
 /*  */
 /*  Define Different SW team support */
 /*  */
-#define	ODM_AP			0x01	 /* BIT0 */
-#define	ODM_ADSL		0x02	/* BIT1 */
-#define	ODM_CE			0x04	/* BIT2 */
-#define	ODM_MP			0x08	/* BIT3 */
+#define	ODM_AP			0x01	 /* BIT(0) */
+#define	ODM_ADSL		0x02	/* BIT(1) */
+#define	ODM_CE			0x04	/* BIT(2) */
+#define	ODM_MP			0x08	/* BIT(3) */
 
 #define		RT_PCI_INTERFACE				1
 #define		RT_USB_INTERFACE				2
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 7e002009f9a0..6399f645cd40 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -143,48 +143,6 @@ static inline void rtw_netif_stop_queue(struct net_device *pnetdev)
 	netif_tx_stop_all_queues(pnetdev);
 }
 
-#ifndef BIT
-	#define BIT(x)	( 1 << (x))
-#endif
-
-#define BIT0	0x00000001
-#define BIT1	0x00000002
-#define BIT2	0x00000004
-#define BIT3	0x00000008
-#define BIT4	0x00000010
-#define BIT5	0x00000020
-#define BIT6	0x00000040
-#define BIT7	0x00000080
-#define BIT8	0x00000100
-#define BIT9	0x00000200
-#define BIT10	0x00000400
-#define BIT11	0x00000800
-#define BIT12	0x00001000
-#define BIT13	0x00002000
-#define BIT14	0x00004000
-#define BIT15	0x00008000
-#define BIT16	0x00010000
-#define BIT17	0x00020000
-#define BIT18	0x00040000
-#define BIT19	0x00080000
-#define BIT20	0x00100000
-#define BIT21	0x00200000
-#define BIT22	0x00400000
-#define BIT23	0x00800000
-#define BIT24	0x01000000
-#define BIT25	0x02000000
-#define BIT26	0x04000000
-#define BIT27	0x08000000
-#define BIT28	0x10000000
-#define BIT29	0x20000000
-#define BIT30	0x40000000
-#define BIT31	0x80000000
-#define BIT32	0x0100000000
-#define BIT33	0x0200000000
-#define BIT34	0x0400000000
-#define BIT35	0x0800000000
-#define BIT36	0x1000000000
-
 extern int RTW_STATUS_CODE(int error_code);
 
 /* flags used for rtw_update_mem_stat() */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 85e66d6ca2ba..5fdc6aac917c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -4,43 +4,6 @@
 #ifndef __RTL8188E_SPEC_H__
 #define __RTL8188E_SPEC_H__
 
-#ifndef BIT
-#define BIT(x)		(1 << (x))
-#endif
-
-#define BIT0	0x00000001
-#define BIT1	0x00000002
-#define BIT2	0x00000004
-#define BIT3	0x00000008
-#define BIT4	0x00000010
-#define BIT5	0x00000020
-#define BIT6	0x00000040
-#define BIT7	0x00000080
-#define BIT8	0x00000100
-#define BIT9	0x00000200
-#define BIT10	0x00000400
-#define BIT11	0x00000800
-#define BIT12	0x00001000
-#define BIT13	0x00002000
-#define BIT14	0x00004000
-#define BIT15	0x00008000
-#define BIT16	0x00010000
-#define BIT17	0x00020000
-#define BIT18	0x00040000
-#define BIT19	0x00080000
-#define BIT20	0x00100000
-#define BIT21	0x00200000
-#define BIT22	0x00400000
-#define BIT23	0x00800000
-#define BIT24	0x01000000
-#define BIT25	0x02000000
-#define BIT26	0x04000000
-#define BIT27	0x08000000
-#define BIT28	0x10000000
-#define BIT29	0x20000000
-#define BIT30	0x40000000
-#define BIT31	0x80000000
-
 /*        8192C Regsiter offset definition */
 
 #define		HAL_PS_TIMER_INT_DELAY	50	/*   50 microseconds */
@@ -465,14 +428,14 @@
 #define	MAX_MSS_DENSITY_1T		0x0A
 
 /*  EEPROM enable when set 1 */
-#define	CmdEEPROM_En			BIT5
+#define	CmdEEPROM_En			BIT(5)
 /*  System EEPROM select, 0: boot from E-FUSE, 1: The EEPROM used is 9346 */
-#define	CmdEERPOMSEL			BIT4
-#define	Cmd9346CR_9356SEL		BIT4
+#define	CmdEERPOMSEL			BIT(4)
+#define	Cmd9346CR_9356SEL		BIT(4)
 
 /*        8192C GPIO MUX Configuration Register (offset 0x40, 4 byte) */
 #define	GPIOSEL_GPIO			0
-#define	GPIOSEL_ENBT			BIT5
+#define	GPIOSEL_ENBT			BIT(5)
 
 /*        8192C GPIO PIN Control Register (offset 0x44, 4 byte) */
 /*  GPIO pins input value */
@@ -485,18 +448,18 @@
 #define	GPIO_MOD			(REG_GPIO_PIN_CTRL+3)
 
 /* 8723/8188E Host System Interrupt Mask Register (offset 0x58, 32 byte) */
-#define	HSIMR_GPIO12_0_INT_EN		BIT0
-#define	HSIMR_SPS_OCP_INT_EN		BIT5
-#define	HSIMR_RON_INT_EN		BIT6
-#define	HSIMR_PDN_INT_EN		BIT7
-#define	HSIMR_GPIO9_INT_EN		BIT25
+#define	HSIMR_GPIO12_0_INT_EN		BIT(0)
+#define	HSIMR_SPS_OCP_INT_EN		BIT(5)
+#define	HSIMR_RON_INT_EN		BIT(6)
+#define	HSIMR_PDN_INT_EN		BIT(7)
+#define	HSIMR_GPIO9_INT_EN		BIT(25)
 
 /* 8723/8188E Host System Interrupt Status Register (offset 0x5C, 32 byte) */
-#define	HSISR_GPIO12_0_INT		BIT0
-#define	HSISR_SPS_OCP_INT		BIT5
-#define	HSISR_RON_INT_EN		BIT6
-#define	HSISR_PDNINT			BIT7
-#define	HSISR_GPIO9_INT			BIT25
+#define	HSISR_GPIO12_0_INT		BIT(0)
+#define	HSISR_SPS_OCP_INT		BIT(5)
+#define	HSISR_RON_INT_EN		BIT(6)
+#define	HSISR_PDNINT			BIT(7)
+#define	HSISR_GPIO9_INT			BIT(25)
 
 /*   8192C (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
 /*
@@ -521,51 +484,51 @@ Default: 00b.
 
 /*  88E Driver Initialization Offload REG_FDHM0(Offset 0x88, 8 bits) */
 /* IOL config for REG_FDHM0(Reg0x88) */
-#define CMD_INIT_LLT			BIT0
-#define CMD_READ_EFUSE_MAP		BIT1
-#define CMD_EFUSE_PATCH			BIT2
-#define CMD_IOCONFIG			BIT3
-#define CMD_INIT_LLT_ERR		BIT4
-#define CMD_READ_EFUSE_MAP_ERR		BIT5
-#define CMD_EFUSE_PATCH_ERR		BIT6
-#define CMD_IOCONFIG_ERR		BIT7
+#define CMD_INIT_LLT			BIT(0)
+#define CMD_READ_EFUSE_MAP		BIT(1)
+#define CMD_EFUSE_PATCH			BIT(2)
+#define CMD_IOCONFIG			BIT(3)
+#define CMD_INIT_LLT_ERR		BIT(4)
+#define CMD_READ_EFUSE_MAP_ERR		BIT(5)
+#define CMD_EFUSE_PATCH_ERR		BIT(6)
+#define CMD_IOCONFIG_ERR		BIT(7)
 
 /*  6. Adaptive Control Registers  (Offset: 0x0160 - 0x01CF) */
 /*  8192C Response Rate Set Register	(offset 0x181, 24bits) */
-#define	RRSR_1M				BIT0
-#define	RRSR_2M				BIT1
-#define	RRSR_5_5M			BIT2
-#define	RRSR_11M			BIT3
-#define	RRSR_6M				BIT4
-#define	RRSR_9M				BIT5
-#define	RRSR_12M			BIT6
-#define	RRSR_18M			BIT7
-#define	RRSR_24M			BIT8
-#define	RRSR_36M			BIT9
-#define	RRSR_48M			BIT10
-#define	RRSR_54M			BIT11
-#define	RRSR_MCS0			BIT12
-#define	RRSR_MCS1			BIT13
-#define	RRSR_MCS2			BIT14
-#define	RRSR_MCS3			BIT15
-#define	RRSR_MCS4			BIT16
-#define	RRSR_MCS5			BIT17
-#define	RRSR_MCS6			BIT18
-#define	RRSR_MCS7			BIT19
+#define	RRSR_1M				BIT(0)
+#define	RRSR_2M				BIT(1)
+#define	RRSR_5_5M			BIT(2)
+#define	RRSR_11M			BIT(3)
+#define	RRSR_6M				BIT(4)
+#define	RRSR_9M				BIT(5)
+#define	RRSR_12M			BIT(6)
+#define	RRSR_18M			BIT(7)
+#define	RRSR_24M			BIT(8)
+#define	RRSR_36M			BIT(9)
+#define	RRSR_48M			BIT(10)
+#define	RRSR_54M			BIT(11)
+#define	RRSR_MCS0			BIT(12)
+#define	RRSR_MCS1			BIT(13)
+#define	RRSR_MCS2			BIT(14)
+#define	RRSR_MCS3			BIT(15)
+#define	RRSR_MCS4			BIT(16)
+#define	RRSR_MCS5			BIT(17)
+#define	RRSR_MCS6			BIT(18)
+#define	RRSR_MCS7			BIT(19)
 
 /*  8192C Response Rate Set Register	(offset 0x1BF, 8bits) */
 /*  WOL bit information */
-#define	HAL92C_WOL_PTK_UPDATE_EVENT	BIT0
-#define	HAL92C_WOL_GTK_UPDATE_EVENT	BIT1
+#define	HAL92C_WOL_PTK_UPDATE_EVENT	BIT(0)
+#define	HAL92C_WOL_GTK_UPDATE_EVENT	BIT(1)
 
 /*        8192C BW_OPMODE bits		(Offset 0x203, 8bit) */
-#define	BW_OPMODE_20MHZ			BIT2
-#define	BW_OPMODE_5G			BIT1
+#define	BW_OPMODE_20MHZ			BIT(2)
+#define	BW_OPMODE_5G			BIT(1)
 
 /*        8192C CAM Config Setting (offset 0x250, 1 byte) */
-#define	CAM_VALID			BIT15
+#define	CAM_VALID			BIT(15)
 #define	CAM_NOTVALID			0x0000
-#define	CAM_USEDK			BIT5
+#define	CAM_USEDK			BIT(5)
 
 #define	CAM_CONTENT_COUNT		8
 
@@ -582,69 +545,69 @@ Default: 00b.
 #define	CAM_CONFIG_USEDK		true
 #define	CAM_CONFIG_NO_USEDK		false
 
-#define	CAM_WRITE			BIT16
+#define	CAM_WRITE			BIT(16)
 #define	CAM_READ			0x00000000
-#define	CAM_POLLINIG			BIT31
+#define	CAM_POLLINIG			BIT(31)
 
 #define	SCR_UseDK			0x01
 #define	SCR_TxSecEnable			0x02
 #define	SCR_RxSecEnable			0x04
 
 /*  10. Power Save Control Registers	 (Offset: 0x0260 - 0x02DF) */
-#define	WOW_PMEN			BIT0 /*  Power management Enable. */
-#define	WOW_WOMEN			BIT1 /*  WoW function on or off. */
-#define	WOW_MAGIC			BIT2 /*  Magic packet */
-#define	WOW_UWF				BIT3 /*  Unicast Wakeup frame. */
+#define	WOW_PMEN			BIT(0) /*  Power management Enable. */
+#define	WOW_WOMEN			BIT(1) /*  WoW function on or off. */
+#define	WOW_MAGIC			BIT(2) /*  Magic packet */
+#define	WOW_UWF				BIT(3) /*  Unicast Wakeup frame. */
 
 /*  12. Host Interrupt Status Registers	 (Offset: 0x0300 - 0x030F) */
 /*        8188 IMR/ISR bits */
 #define	IMR_DISABLED_88E		0x0
 /*  IMR DW0(0x0060-0063) Bit 0-31 */
-#define	IMR_TXCCK_88E			BIT30	/*  TXRPT interrupt when CCX bit of the packet is set */
-#define	IMR_PSTIMEOUT_88E		BIT29	/*  Power Save Time Out Interrupt */
-#define	IMR_GTINT4_88E			BIT28	/*  When GTIMER4 expires, this bit is set to 1 */
-#define	IMR_GTINT3_88E			BIT27	/*  When GTIMER3 expires, this bit is set to 1 */
-#define	IMR_TBDER_88E			BIT26	/*  Transmit Beacon0 Error */
-#define	IMR_TBDOK_88E			BIT25	/*  Transmit Beacon0 OK */
-#define	IMR_TSF_BIT32_TOGGLE_88E	BIT24	/*  TSF Timer BIT32 toggle indication interrupt */
-#define	IMR_BCNDMAINT0_88E		BIT20	/*  Beacon DMA Interrupt 0 */
-#define	IMR_BCNDERR0_88E		BIT16	/*  Beacon Queue DMA Error 0 */
-#define	IMR_HSISR_IND_ON_INT_88E	BIT15	/*  HSISR Indicator (HSIMR & HSISR is true, this bit is set to 1) */
-#define	IMR_BCNDMAINT_E_88E		BIT14	/*  Beacon DMA Interrupt Extension for Win7 */
-#define	IMR_ATIMEND_88E			BIT12	/*  CTWidnow End or ATIM Window End */
-#define	IMR_HISR1_IND_INT_88E		BIT11	/*  HISR1 Indicator (HISR1 & HIMR1 is true, this bit is set to 1) */
-#define	IMR_C2HCMD_88E			BIT10	/*  CPU to Host Command INT Status, Write 1 clear */
-#define	IMR_CPWM2_88E			BIT9	/*  CPU power Mode exchange INT Status, Write 1 clear */
-#define	IMR_CPWM_88E			BIT8	/*  CPU power Mode exchange INT Status, Write 1 clear */
-#define	IMR_HIGHDOK_88E			BIT7	/*  High Queue DMA OK */
-#define	IMR_MGNTDOK_88E			BIT6	/*  Management Queue DMA OK */
-#define	IMR_BKDOK_88E			BIT5	/*  AC_BK DMA OK */
-#define	IMR_BEDOK_88E			BIT4	/*  AC_BE DMA OK */
-#define	IMR_VIDOK_88E			BIT3	/*  AC_VI DMA OK */
-#define	IMR_VODOK_88E			BIT2	/*  AC_VO DMA OK */
-#define	IMR_RDU_88E			BIT1	/*  Rx Descriptor Unavailable */
-#define	IMR_ROK_88E			BIT0	/*  Receive DMA OK */
+#define	IMR_TXCCK_88E			BIT(30)	/*  TXRPT interrupt when CCX bit of the packet is set */
+#define	IMR_PSTIMEOUT_88E		BIT(29)	/*  Power Save Time Out Interrupt */
+#define	IMR_GTINT4_88E			BIT(28)	/*  When GTIMER4 expires, this bit is set to 1 */
+#define	IMR_GTINT3_88E			BIT(27)	/*  When GTIMER3 expires, this bit is set to 1 */
+#define	IMR_TBDER_88E			BIT(26)	/*  Transmit Beacon0 Error */
+#define	IMR_TBDOK_88E			BIT(25)	/*  Transmit Beacon0 OK */
+#define	IMR_TSF_BIT32_TOGGLE_88E	BIT(24)	/*  TSF Timer BIT32 toggle indication interrupt */
+#define	IMR_BCNDMAINT0_88E		BIT(20)	/*  Beacon DMA Interrupt 0 */
+#define	IMR_BCNDERR0_88E		BIT(16)	/*  Beacon Queue DMA Error 0 */
+#define	IMR_HSISR_IND_ON_INT_88E	BIT(15)	/*  HSISR Indicator (HSIMR & HSISR is true, this bit is set to 1) */
+#define	IMR_BCNDMAINT_E_88E		BIT(14)	/*  Beacon DMA Interrupt Extension for Win7 */
+#define	IMR_ATIMEND_88E			BIT(12)	/*  CTWidnow End or ATIM Window End */
+#define	IMR_HISR1_IND_INT_88E		BIT(11)	/*  HISR1 Indicator (HISR1 & HIMR1 is true, this bit is set to 1) */
+#define	IMR_C2HCMD_88E			BIT(10)	/*  CPU to Host Command INT Status, Write 1 clear */
+#define	IMR_CPWM2_88E			BIT(9)	/*  CPU power Mode exchange INT Status, Write 1 clear */
+#define	IMR_CPWM_88E			BIT(8)	/*  CPU power Mode exchange INT Status, Write 1 clear */
+#define	IMR_HIGHDOK_88E			BIT(7)	/*  High Queue DMA OK */
+#define	IMR_MGNTDOK_88E			BIT(6)	/*  Management Queue DMA OK */
+#define	IMR_BKDOK_88E			BIT(5)	/*  AC_BK DMA OK */
+#define	IMR_BEDOK_88E			BIT(4)	/*  AC_BE DMA OK */
+#define	IMR_VIDOK_88E			BIT(3)	/*  AC_VI DMA OK */
+#define	IMR_VODOK_88E			BIT(2)	/*  AC_VO DMA OK */
+#define	IMR_RDU_88E			BIT(1)	/*  Rx Descriptor Unavailable */
+#define	IMR_ROK_88E			BIT(0)	/*  Receive DMA OK */
 
 /*  IMR DW1(0x00B4-00B7) Bit 0-31 */
-#define	IMR_BCNDMAINT7_88E		BIT27	/*  Beacon DMA Interrupt 7 */
-#define	IMR_BCNDMAINT6_88E		BIT26	/*  Beacon DMA Interrupt 6 */
-#define	IMR_BCNDMAINT5_88E		BIT25	/*  Beacon DMA Interrupt 5 */
-#define	IMR_BCNDMAINT4_88E		BIT24	/*  Beacon DMA Interrupt 4 */
-#define	IMR_BCNDMAINT3_88E		BIT23	/*  Beacon DMA Interrupt 3 */
-#define	IMR_BCNDMAINT2_88E		BIT22	/*  Beacon DMA Interrupt 2 */
-#define	IMR_BCNDMAINT1_88E		BIT21	/*  Beacon DMA Interrupt 1 */
-#define	IMR_BCNDERR7_88E		BIT20	/*  Beacon DMA Error Int 7 */
-#define	IMR_BCNDERR6_88E		BIT19	/*  Beacon DMA Error Int 6 */
-#define	IMR_BCNDERR5_88E		BIT18	/*  Beacon DMA Error Int 5 */
-#define	IMR_BCNDERR4_88E		BIT17	/*  Beacon DMA Error Int 4 */
-#define	IMR_BCNDERR3_88E		BIT16	/*  Beacon DMA Error Int 3 */
-#define	IMR_BCNDERR2_88E		BIT15	/*  Beacon DMA Error Int 2 */
-#define	IMR_BCNDERR1_88E		BIT14	/*  Beacon DMA Error Int 1 */
-#define	IMR_ATIMEND_E_88E		BIT13	/*  ATIM Window End Ext for Win7 */
-#define	IMR_TXERR_88E			BIT11	/*  Tx Err Flag Int Status, write 1 clear. */
-#define	IMR_RXERR_88E			BIT10	/*  Rx Err Flag INT Status, Write 1 clear */
-#define	IMR_TXFOVW_88E			BIT9	/*  Transmit FIFO Overflow */
-#define	IMR_RXFOVW_88E			BIT8	/*  Receive FIFO Overflow */
+#define	IMR_BCNDMAINT7_88E		BIT(27)	/*  Beacon DMA Interrupt 7 */
+#define	IMR_BCNDMAINT6_88E		BIT(26)	/*  Beacon DMA Interrupt 6 */
+#define	IMR_BCNDMAINT5_88E		BIT(25)	/*  Beacon DMA Interrupt 5 */
+#define	IMR_BCNDMAINT4_88E		BIT(24)	/*  Beacon DMA Interrupt 4 */
+#define	IMR_BCNDMAINT3_88E		BIT(23)	/*  Beacon DMA Interrupt 3 */
+#define	IMR_BCNDMAINT2_88E		BIT(22)	/*  Beacon DMA Interrupt 2 */
+#define	IMR_BCNDMAINT1_88E		BIT(21)	/*  Beacon DMA Interrupt 1 */
+#define	IMR_BCNDERR7_88E		BIT(20)	/*  Beacon DMA Error Int 7 */
+#define	IMR_BCNDERR6_88E		BIT(19)	/*  Beacon DMA Error Int 6 */
+#define	IMR_BCNDERR5_88E		BIT(18)	/*  Beacon DMA Error Int 5 */
+#define	IMR_BCNDERR4_88E		BIT(17)	/*  Beacon DMA Error Int 4 */
+#define	IMR_BCNDERR3_88E		BIT(16)	/*  Beacon DMA Error Int 3 */
+#define	IMR_BCNDERR2_88E		BIT(15)	/*  Beacon DMA Error Int 2 */
+#define	IMR_BCNDERR1_88E		BIT(14)	/*  Beacon DMA Error Int 1 */
+#define	IMR_ATIMEND_E_88E		BIT(13)	/*  ATIM Window End Ext for Win7 */
+#define	IMR_TXERR_88E			BIT(11)	/*  Tx Err Flag Int Status, write 1 clear. */
+#define	IMR_RXERR_88E			BIT(10)	/*  Rx Err Flag INT Status, Write 1 clear */
+#define	IMR_TXFOVW_88E			BIT(9)	/*  Transmit FIFO Overflow */
+#define	IMR_RXFOVW_88E			BIT(8)	/*  Receive FIFO Overflow */
 
 #define	HAL_NIC_UNPLUG_ISR		0xFFFFFFFF	/*  The value when the NIC is unplugged for PCI. */
 
@@ -680,40 +643,40 @@ Current IOREG MAP
 /* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2,
  *	and BK - Bit3. */
 /* 	8723 and 88E may be not correct either in the earlier version. */
-#define		StopBecon			BIT6
-#define		StopHigh			BIT5
-#define		StopMgt				BIT4
-#define		StopBK				BIT3
-#define		StopBE				BIT2
-#define		StopVI				BIT1
-#define		StopVO				BIT0
+#define		StopBecon			BIT(6)
+#define		StopHigh			BIT(5)
+#define		StopMgt				BIT(4)
+#define		StopBK				BIT(3)
+#define		StopBE				BIT(2)
+#define		StopVI				BIT(1)
+#define		StopVO				BIT(0)
 
 /*        8192C (RCR) Receive Configuration Register(Offset 0x608, 32 bits) */
-#define	RCR_APPFCS		BIT31	/* WMAC append FCS after payload */
-#define	RCR_APP_MIC		BIT30
-#define	RCR_APP_PHYSTS		BIT28
-#define	RCR_APP_ICV		BIT29
-#define	RCR_APP_PHYST_RXFF	BIT28
-#define	RCR_APP_BA_SSN		BIT27	/* Accept BA SSN */
-#define	RCR_ENMBID		BIT24	/* Enable Multiple BssId. */
-#define	RCR_LSIGEN		BIT23
-#define	RCR_MFBEN		BIT22
-#define	RCR_HTC_LOC_CTRL	BIT14   /* MFC<--HTC=1 MFC-->HTC=0 */
-#define	RCR_AMF			BIT13	/* Accept management type frame */
-#define	RCR_ACF			BIT12	/* Accept control type frame */
-#define	RCR_ADF			BIT11	/* Accept data type frame */
-#define	RCR_AICV		BIT9	/* Accept ICV error packet */
-#define	RCR_ACRC32		BIT8	/* Accept CRC32 error packet */
-#define	RCR_CBSSID_BCN		BIT7	/* Accept BSSID match packet
+#define	RCR_APPFCS		BIT(31)	/* WMAC append FCS after payload */
+#define	RCR_APP_MIC		BIT(30)
+#define	RCR_APP_PHYSTS		BIT(28)
+#define	RCR_APP_ICV		BIT(29)
+#define	RCR_APP_PHYST_RXFF	BIT(28)
+#define	RCR_APP_BA_SSN		BIT(27)	/* Accept BA SSN */
+#define	RCR_ENMBID		BIT(24)	/* Enable Multiple BssId. */
+#define	RCR_LSIGEN		BIT(23)
+#define	RCR_MFBEN		BIT(22)
+#define	RCR_HTC_LOC_CTRL	BIT(14)   /* MFC<--HTC=1 MFC-->HTC=0 */
+#define	RCR_AMF			BIT(13)	/* Accept management type frame */
+#define	RCR_ACF			BIT(12)	/* Accept control type frame */
+#define	RCR_ADF			BIT(11)	/* Accept data type frame */
+#define	RCR_AICV		BIT(9)	/* Accept ICV error packet */
+#define	RCR_ACRC32		BIT(8)	/* Accept CRC32 error packet */
+#define	RCR_CBSSID_BCN		BIT(7)	/* Accept BSSID match packet
 					 * (Rx beacon, probe rsp) */
-#define	RCR_CBSSID_DATA		BIT6	/* Accept BSSID match (Data)*/
+#define	RCR_CBSSID_DATA		BIT(6)	/* Accept BSSID match (Data)*/
 #define	RCR_CBSSID		RCR_CBSSID_DATA	/* Accept BSSID match */
-#define	RCR_APWRMGT		BIT5	/* Accept power management pkt*/
-#define	RCR_ADD3		BIT4	/* Accept address 3 match pkt */
-#define	RCR_AB			BIT3	/* Accept broadcast packet */
-#define	RCR_AM			BIT2	/* Accept multicast packet */
-#define	RCR_APM			BIT1	/* Accept physical match pkt */
-#define	RCR_AAP			BIT0	/* Accept all unicast packet */
+#define	RCR_APWRMGT		BIT(5)	/* Accept power management pkt*/
+#define	RCR_ADD3		BIT(4)	/* Accept address 3 match pkt */
+#define	RCR_AB			BIT(3)	/* Accept broadcast packet */
+#define	RCR_AM			BIT(2)	/* Accept multicast packet */
+#define	RCR_APM			BIT(1)	/* Accept physical match pkt */
+#define	RCR_AAP			BIT(0)	/* Accept all unicast packet */
 #define	RCR_MXDMA_OFFSET	8
 #define	RCR_FIFO_OFFSET		13
 
@@ -1181,56 +1144,56 @@ Current IOREG MAP
 #define SDIO_HIMR_DISABLED			0
 
 /*  RTL8188E SDIO Host Interrupt Mask Register */
-#define SDIO_HIMR_RX_REQUEST_MSK		BIT0
-#define SDIO_HIMR_AVAL_MSK			BIT1
-#define SDIO_HIMR_TXERR_MSK			BIT2
-#define SDIO_HIMR_RXERR_MSK			BIT3
-#define SDIO_HIMR_TXFOVW_MSK			BIT4
-#define SDIO_HIMR_RXFOVW_MSK			BIT5
-#define SDIO_HIMR_TXBCNOK_MSK			BIT6
-#define SDIO_HIMR_TXBCNERR_MSK			BIT7
-#define SDIO_HIMR_BCNERLY_INT_MSK		BIT16
-#define SDIO_HIMR_C2HCMD_MSK			BIT17
-#define SDIO_HIMR_CPWM1_MSK			BIT18
-#define SDIO_HIMR_CPWM2_MSK			BIT19
-#define SDIO_HIMR_HSISR_IND_MSK			BIT20
-#define SDIO_HIMR_GTINT3_IND_MSK		BIT21
-#define SDIO_HIMR_GTINT4_IND_MSK		BIT22
-#define SDIO_HIMR_PSTIMEOUT_MSK			BIT23
-#define SDIO_HIMR_OCPINT_MSK			BIT24
-#define SDIO_HIMR_ATIMEND_MSK			BIT25
-#define SDIO_HIMR_ATIMEND_E_MSK			BIT26
-#define SDIO_HIMR_CTWEND_MSK			BIT27
+#define SDIO_HIMR_RX_REQUEST_MSK		BIT(0)
+#define SDIO_HIMR_AVAL_MSK			BIT(1)
+#define SDIO_HIMR_TXERR_MSK			BIT(2)
+#define SDIO_HIMR_RXERR_MSK			BIT(3)
+#define SDIO_HIMR_TXFOVW_MSK			BIT(4)
+#define SDIO_HIMR_RXFOVW_MSK			BIT(5)
+#define SDIO_HIMR_TXBCNOK_MSK			BIT(6)
+#define SDIO_HIMR_TXBCNERR_MSK			BIT(7)
+#define SDIO_HIMR_BCNERLY_INT_MSK		BIT(16)
+#define SDIO_HIMR_C2HCMD_MSK			BIT(17)
+#define SDIO_HIMR_CPWM1_MSK			BIT(18)
+#define SDIO_HIMR_CPWM2_MSK			BIT(19)
+#define SDIO_HIMR_HSISR_IND_MSK			BIT(20)
+#define SDIO_HIMR_GTINT3_IND_MSK		BIT(21)
+#define SDIO_HIMR_GTINT4_IND_MSK		BIT(22)
+#define SDIO_HIMR_PSTIMEOUT_MSK			BIT(23)
+#define SDIO_HIMR_OCPINT_MSK			BIT(24)
+#define SDIO_HIMR_ATIMEND_MSK			BIT(25)
+#define SDIO_HIMR_ATIMEND_E_MSK			BIT(26)
+#define SDIO_HIMR_CTWEND_MSK			BIT(27)
 
 /* RTL8188E SDIO Specific */
-#define	SDIO_HIMR_MCU_ERR_MSK			BIT28
-#define	SDIO_HIMR_TSF_BIT32_TOGGLE_MSK		BIT29
+#define	SDIO_HIMR_MCU_ERR_MSK			BIT(28)
+#define	SDIO_HIMR_TSF_BIT32_TOGGLE_MSK		BIT(29)
 
 /*  SDIO Host Interrupt Service Routine */
-#define SDIO_HISR_RX_REQUEST			BIT0
-#define SDIO_HISR_AVAL				BIT1
-#define SDIO_HISR_TXERR				BIT2
-#define SDIO_HISR_RXERR				BIT3
-#define SDIO_HISR_TXFOVW			BIT4
-#define SDIO_HISR_RXFOVW			BIT5
-#define SDIO_HISR_TXBCNOK			BIT6
-#define SDIO_HISR_TXBCNERR			BIT7
-#define SDIO_HISR_BCNERLY_INT			BIT16
-#define SDIO_HISR_C2HCMD			BIT17
-#define SDIO_HISR_CPWM1				BIT18
-#define SDIO_HISR_CPWM2				BIT19
-#define SDIO_HISR_HSISR_IND			BIT20
-#define SDIO_HISR_GTINT3_IND			BIT21
-#define SDIO_HISR_GTINT4_IND			BIT22
-#define SDIO_HISR_PSTIME			BIT23
-#define SDIO_HISR_OCPINT			BIT24
-#define SDIO_HISR_ATIMEND			BIT25
-#define SDIO_HISR_ATIMEND_E			BIT26
-#define SDIO_HISR_CTWEND			BIT27
+#define SDIO_HISR_RX_REQUEST			BIT(0)
+#define SDIO_HISR_AVAL				BIT(1)
+#define SDIO_HISR_TXERR				BIT(2)
+#define SDIO_HISR_RXERR				BIT(3)
+#define SDIO_HISR_TXFOVW			BIT(4)
+#define SDIO_HISR_RXFOVW			BIT(5)
+#define SDIO_HISR_TXBCNOK			BIT(6)
+#define SDIO_HISR_TXBCNERR			BIT(7)
+#define SDIO_HISR_BCNERLY_INT			BIT(16)
+#define SDIO_HISR_C2HCMD			BIT(17)
+#define SDIO_HISR_CPWM1				BIT(18)
+#define SDIO_HISR_CPWM2				BIT(19)
+#define SDIO_HISR_HSISR_IND			BIT(20)
+#define SDIO_HISR_GTINT3_IND			BIT(21)
+#define SDIO_HISR_GTINT4_IND			BIT(22)
+#define SDIO_HISR_PSTIME			BIT(23)
+#define SDIO_HISR_OCPINT			BIT(24)
+#define SDIO_HISR_ATIMEND			BIT(25)
+#define SDIO_HISR_ATIMEND_E			BIT(26)
+#define SDIO_HISR_CTWEND			BIT(27)
 
 /* RTL8188E SDIO Specific */
-#define	SDIO_HISR_MCU_ERR			BIT28
-#define	SDIO_HISR_TSF_BIT32_TOGGLE		BIT29
+#define	SDIO_HISR_MCU_ERR			BIT(28)
+#define	SDIO_HISR_TSF_BIT32_TOGGLE		BIT(29)
 
 #define MASK_SDIO_HISR_CLEAR				\
 	(SDIO_HISR_TXERR | SDIO_HISR_RXERR | SDIO_HISR_TXFOVW |\
@@ -1240,8 +1203,8 @@ Current IOREG MAP
 	 SDIO_HISR_PSTIMEOUT | SDIO_HISR_OCPINT)
 
 /*  SDIO HCI Suspend Control Register */
-#define HCI_RESUME_PWR_RDY		BIT1
-#define HCI_SUS_CTRL			BIT0
+#define HCI_RESUME_PWR_RDY		BIT(1)
+#define HCI_SUS_CTRL			BIT(0)
 
 /*  SDIO Tx FIFO related */
 /*  The number of Tx FIFO free page */
@@ -1275,33 +1238,33 @@ Current IOREG MAP
 
 /* 2REG_MULTI_FUNC_CTRL(For RTL8723 Only) */
 /*  Enable GPIO[9] as WiFi HW PDn source */
-#define	WL_HWPDN_EN				BIT0
+#define	WL_HWPDN_EN				BIT(0)
 /*  WiFi HW PDn polarity control */
-#define	WL_HWPDN_SL				BIT1
+#define	WL_HWPDN_SL				BIT(1)
 /*  WiFi function enable */
-#define	WL_FUNC_EN				BIT2
+#define	WL_FUNC_EN				BIT(2)
 /*  Enable GPIO[9] as WiFi RF HW PDn source */
-#define	WL_HWROF_EN				BIT3
+#define	WL_HWROF_EN				BIT(3)
 /*  Enable GPIO[11] as BT HW PDn source */
-#define	BT_HWPDN_EN				BIT16
+#define	BT_HWPDN_EN				BIT(16)
 /*  BT HW PDn polarity control */
-#define	BT_HWPDN_SL				BIT17
+#define	BT_HWPDN_SL				BIT(17)
 /*  BT function enable */
-#define	BT_FUNC_EN				BIT18
+#define	BT_FUNC_EN				BIT(18)
 /*  Enable GPIO[11] as BT/GPS RF HW PDn source */
-#define	BT_HWROF_EN				BIT19
+#define	BT_HWROF_EN				BIT(19)
 /*  Enable GPIO[10] as GPS HW PDn source */
-#define	GPS_HWPDN_EN				BIT20
+#define	GPS_HWPDN_EN				BIT(20)
 /*  GPS HW PDn polarity control */
-#define	GPS_HWPDN_SL				BIT21
+#define	GPS_HWPDN_SL				BIT(21)
 /*  GPS function enable */
-#define	GPS_FUNC_EN				BIT22
+#define	GPS_FUNC_EN				BIT(22)
 
 /* 3 REG_LIFECTRL_CTRL */
-#define	HAL92C_EN_PKT_LIFE_TIME_BK		BIT3
-#define	HAL92C_EN_PKT_LIFE_TIME_BE		BIT2
-#define	HAL92C_EN_PKT_LIFE_TIME_VI		BIT1
-#define	HAL92C_EN_PKT_LIFE_TIME_VO		BIT0
+#define	HAL92C_EN_PKT_LIFE_TIME_BK		BIT(3)
+#define	HAL92C_EN_PKT_LIFE_TIME_BE		BIT(2)
+#define	HAL92C_EN_PKT_LIFE_TIME_VI		BIT(1)
+#define	HAL92C_EN_PKT_LIFE_TIME_VO		BIT(0)
 
 #define	HAL92C_MSDU_LIFE_TIME_UNIT		128	/*  in us */
 
@@ -1311,7 +1274,7 @@ Current IOREG MAP
 #define POLLING_LLT_THRESHOLD			20
 #define POLLING_READY_TIMEOUT_COUNT		1000
 /*  GPIO BIT */
-#define	HAL_8192C_HW_GPIO_WPS_BIT		BIT2
+#define	HAL_8192C_HW_GPIO_WPS_BIT		BIT(2)
 
 /*	8192C EEPROM/EFUSE share register definition. */
 
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 9ecd75258310..8fa7aa4abb3f 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -18,13 +18,13 @@ struct sreset_priv {
 #include "rtl8188e_hal.h"
 
 #define	WIFI_STATUS_SUCCESS		0
-#define	USB_VEN_REQ_CMD_FAIL	BIT0
-#define	USB_READ_PORT_FAIL		BIT1
-#define	USB_WRITE_PORT_FAIL		BIT2
-#define	WIFI_MAC_TXDMA_ERROR	BIT3
-#define   WIFI_TX_HANG				BIT4
-#define	WIFI_RX_HANG				BIT5
-#define		WIFI_IF_NOT_EXIST			BIT6
+#define	USB_VEN_REQ_CMD_FAIL	BIT(0)
+#define	USB_READ_PORT_FAIL		BIT(1)
+#define	USB_WRITE_PORT_FAIL		BIT(2)
+#define	WIFI_MAC_TXDMA_ERROR	BIT(3)
+#define   WIFI_TX_HANG				BIT(4)
+#define	WIFI_RX_HANG				BIT(5)
+#define		WIFI_IF_NOT_EXIST			BIT(6)
 
 void sreset_init_value(struct adapter *padapter);
 void sreset_reset_value(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4e21801cbfcf..53dcf31626f2 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -7092,9 +7092,9 @@ static int rtw_mp_reset_stats(struct net_device *dev,
 	pmp_priv->rx_crcerrpktcount = 0;
 
 	/* reset phy counter */
-	write_bbreg(padapter, 0xf14, BIT16, 0x1);
+	write_bbreg(padapter, 0xf14, BIT(16), 0x1);
 	msleep(10);
-	write_bbreg(padapter, 0xf14, BIT16, 0x0);
+	write_bbreg(padapter, 0xf14, BIT(16), 0x0);
 
 	return 0;
 }
-- 
2.32.0

