Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C14108A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhIRVMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhIRVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 17:12:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 14:10:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c21so43749903edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6s3ZT8nHvntaFksPfC9W/kvVwun4lsOMkuiIbQjL1Q=;
        b=MquEKw8vCh/IXwZ8UutkCIDpvJnIT8HihM3YA721zs2Eic57OicfZvb/EkLIDyAW4J
         dgEpzVyEwYraQ66EgxV4oEMjdHFsFpzibP17nvIwTDxHDv3mPCnH4YmefeZLorFf/UKe
         eARDVDh876kKCdqC3DjpyUl4DA0PpOvxfUL/ZZw3s8TykRxYUSFaJNA2D6RQZpkT7f01
         SKXoUQcgYtCV/b3DmTh082DZRunln1KbabJLXYCbSwoa78vfMRkmL09QmmGAWNnhc00w
         +BtXphAzXv6LWGCo9STvN1jpv2BN02vlFJCCAdlWESErp9mUoTZXtQ8LP095DnuMB4FI
         6N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6s3ZT8nHvntaFksPfC9W/kvVwun4lsOMkuiIbQjL1Q=;
        b=XDisY+gk1n2AFZKDu0V2JUBQgEZA106z508ez6QNH1X86h8WJ+ZW+bbdxbjxgvLow2
         EwGUjoCtVyYLtjO0txDMpd1PIbJGWOZc0Q6DrdmGktdG6X53OJNboHYrR8lulIFpewik
         ffDYl8tDTbo9PnLLXw3XcVtu1iK2CgS2dlG3a6de/6FELs/o2RN4MTDLXdEPW/3gYbpq
         84G0kAluYj7alhuvC45tfQlcshl5+UFiXpBLhfUYq9j1LXTb5KrGAnjllnkEMBZ6W6oB
         EospOFKMFxi26KSOVWQlcaDEJa71hp/4Eh/8I9XbfdG00GYisFEiqFqhTG9loWZOocT/
         buYw==
X-Gm-Message-State: AOAM531MSyQ7x9GxzOH17waoiqFACsEyScm5sBtLJ2fGkd31pKwoAspA
        UIUTcutaHq8UIm7Ix88IwYI=
X-Google-Smtp-Source: ABdhPJwhZ+x4uN2I3z2hLEWAkFkZfBn9DuoYqT01fS5ahPmuBrwxuoJV9RlaYOMgbPEBTyV//FHjWg==
X-Received: by 2002:a17:906:468a:: with SMTP id a10mr19864268ejr.523.1631999454195;
        Sat, 18 Sep 2021 14:10:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id o13sm2582812ejm.56.2021.09.18.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 14:10:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove ODM_SingleDualAntennaDetection()
Date:   Sat, 18 Sep 2021 23:10:46 +0200
Message-Id: <20210918211046.6865-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_SingleDualAntennaDetection() is not used, remove it.
It is the only user of odm_PHY_SaveAFERegisters() and
odm_PHY_ReloadAFERegisters() so remove these functions as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 223 --------------------------
 drivers/staging/r8188eu/include/odm.h |   2 -
 2 files changed, 225 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index d23e9296a10e..7bd2a35f5eee 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1715,229 +1715,6 @@ void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm)
 	pDM_SWAT_Table->ANTB_ON = true;
 }
 
-/* 2 8723A ANT DETECT */
-
-static void odm_PHY_SaveAFERegisters(struct odm_dm_struct *pDM_Odm, u32 *AFEReg, u32 *AFEBackup, u32 RegisterNum)
-{
-	u32 i;
-
-	/* RTPRINT(FINIT, INIT_IQK, ("Save ADDA parameters.\n")); */
-	for (i = 0; i < RegisterNum; i++)
-		AFEBackup[i] = ODM_GetBBReg(pDM_Odm, AFEReg[i], bMaskDWord);
-}
-
-static void odm_PHY_ReloadAFERegisters(struct odm_dm_struct *pDM_Odm, u32 *AFEReg, u32 *AFEBackup, u32 RegiesterNum)
-{
-	u32 i;
-
-	for (i = 0; i < RegiesterNum; i++)
-		ODM_SetBBReg(pDM_Odm, AFEReg[i], bMaskDWord, AFEBackup[i]);
-}
-
-/* 2 8723A ANT DETECT */
-/*  Description: */
-/* 	Implement IQK single tone for RF DPK loopback and BB PSD scanning. */
-/* 	This function is cooperated with BB team Neil. */
-bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
-{
-	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
-	u32 CurrentChannel, RfLoopReg;
-	u8 n;
-	u32 Reg88c, Regc08, Reg874, Regc50;
-	u8 initial_gain = 0x5a;
-	u32 PSD_report_tmp;
-	u32 AntA_report = 0x0, AntB_report = 0x0, AntO_report = 0x0;
-	bool bResult = true;
-	u32 AFE_Backup[16];
-	u32 AFE_REG_8723A[16] = {
-		rRx_Wait_CCA, rTx_CCK_RFON,
-		rTx_CCK_BBON, rTx_OFDM_RFON,
-		rTx_OFDM_BBON, rTx_To_Rx,
-		rTx_To_Tx, rRx_CCK,
-		rRx_OFDM, rRx_Wait_RIFS,
-		rRx_TO_Rx, rStandby,
-		rSleep, rPMPD_ANAEN,
-		rFPGA0_XCD_SwitchControl, rBlue_Tooth};
-
-	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A | ODM_RTL8192C)))
-		return bResult;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
-		return bResult;
-
-	if (pDM_Odm->SupportICType == ODM_RTL8192C) {
-		/* Which path in ADC/DAC is turnned on for PSD: both I/Q */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(10) | BIT(11), 0x3);
-		/* Ageraged number: 8 */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(12) | BIT(13), 0x1);
-		/* pts = 128; */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(14) | BIT(15), 0x0);
-	}
-
-	/* 1 Backup Current RF/BB Settings */
-
-	CurrentChannel = ODM_GetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask);
-	RfLoopReg = ODM_GetRFReg(pDM_Odm, RF_PATH_A, 0x00, bRFRegOffsetMask);
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, ODM_DPDT, Antenna_A);  /*  change to Antenna A */
-	/*  Step 1: USE IQK to transmitter single tone */
-
-	ODM_StallExecution(10);
-
-	/* Store A Path Register 88c, c08, 874, c50 */
-	Reg88c = ODM_GetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord);
-	Regc08 = ODM_GetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord);
-	Reg874 = ODM_GetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord);
-	Regc50 = ODM_GetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, bMaskDWord);
-
-	/*  Store AFE Registers */
-	odm_PHY_SaveAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
-
-	/* Set PSD 128 pts */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT(14) | BIT(15), 0x0);  /* 128 pts */
-
-	/*  To SET CH1 to do */
-	ODM_SetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask, 0x01);     /* Channel 1 */
-
-	/*  AFE all on step */
-	ODM_SetBBReg(pDM_Odm, rRx_Wait_CCA, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_CCK_RFON, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_CCK_BBON, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_OFDM_RFON, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_OFDM_BBON, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_To_Rx, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rTx_To_Tx, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rRx_CCK, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rRx_OFDM, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rRx_Wait_RIFS, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rRx_TO_Rx, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rStandby, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rSleep, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rPMPD_ANAEN, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_SwitchControl, bMaskDWord, 0x6FDB25A4);
-	ODM_SetBBReg(pDM_Odm, rBlue_Tooth, bMaskDWord, 0x6FDB25A4);
-
-	/*  3 wire Disable */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord, 0xCCF000C0);
-
-	/* BB IQK Setting */
-	ODM_SetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord, 0x000800E4);
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22208000);
-
-	/* IQK setting tone@ 4.34Mhz */
-	ODM_SetBBReg(pDM_Odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008C1C);
-	ODM_SetBBReg(pDM_Odm, rTx_IQK, bMaskDWord, 0x01007c00);
-
-	/* Page B init */
-	ODM_SetBBReg(pDM_Odm, rConfig_AntA, bMaskDWord, 0x00080000);
-	ODM_SetBBReg(pDM_Odm, rConfig_AntA, bMaskDWord, 0x0f600000);
-	ODM_SetBBReg(pDM_Odm, rRx_IQK, bMaskDWord, 0x01004800);
-	ODM_SetBBReg(pDM_Odm, rRx_IQK_Tone_A, bMaskDWord, 0x10008c1f);
-	ODM_SetBBReg(pDM_Odm, rTx_IQK_PI_A, bMaskDWord, 0x82150008);
-	ODM_SetBBReg(pDM_Odm, rRx_IQK_PI_A, bMaskDWord, 0x28150008);
-	ODM_SetBBReg(pDM_Odm, rIQK_AGC_Rsp, bMaskDWord, 0x001028d0);
-
-	/* RF loop Setting */
-	ODM_SetRFReg(pDM_Odm, RF_PATH_A, 0x0, 0xFFFFF, 0x50008);
-
-	/* IQK Single tone start */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
-	ODM_SetBBReg(pDM_Odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
-	ODM_StallExecution(1000);
-	PSD_report_tmp = 0x0;
-
-	for (n = 0; n < 2; n++) {
-		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
-		if (PSD_report_tmp > AntA_report)
-			AntA_report = PSD_report_tmp;
-	}
-
-	PSD_report_tmp = 0x0;
-
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);  /*  change to Antenna B */
-	ODM_StallExecution(10);
-
-	for (n = 0; n < 2; n++) {
-		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
-		if (PSD_report_tmp > AntB_report)
-			AntB_report = PSD_report_tmp;
-	}
-
-	/*  change to open case */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, 0);  /*  change to Ant A and B all open case */
-	ODM_StallExecution(10);
-
-	for (n = 0; n < 2; n++) {
-		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
-		if (PSD_report_tmp > AntO_report)
-			AntO_report = PSD_report_tmp;
-	}
-
-	/* Close IQK Single Tone function */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	PSD_report_tmp = 0x0;
-
-	/* 1 Return to antanna A */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
-	ODM_SetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord, Reg88c);
-	ODM_SetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord, Regc08);
-	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, Reg874);
-	ODM_SetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, 0x7F, 0x40);
-	ODM_SetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, bMaskDWord, Regc50);
-	ODM_SetRFReg(pDM_Odm, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, CurrentChannel);
-	ODM_SetRFReg(pDM_Odm, RF_PATH_A, 0x00, bRFRegOffsetMask, RfLoopReg);
-
-	/* Reload AFE Registers */
-	odm_PHY_ReloadAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
-
-	if (pDM_Odm->SupportICType == ODM_RTL8723A) {
-	/* 2 Test Ant B based on Ant A is ON */
-		if (mode == ANTTESTB) {
-			if (AntA_report >= 100) {
-				if (AntB_report > (AntA_report + 1))
-					pDM_SWAT_Table->ANTB_ON = false;
-				else
-					pDM_SWAT_Table->ANTB_ON = true;
-			} else {
-				pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
-				bResult = false;
-			}
-		} else if (mode == ANTTESTALL) {
-			/* 2 Test Ant A and B based on DPDT Open */
-			if ((AntO_report >= 100) & (AntO_report < 118)) {
-				if (AntA_report > (AntO_report + 1))
-					pDM_SWAT_Table->ANTA_ON = false;
-				else
-					pDM_SWAT_Table->ANTA_ON = true;
-
-				if (AntB_report > (AntO_report + 2))
-					pDM_SWAT_Table->ANTB_ON = false;
-				else
-					pDM_SWAT_Table->ANTB_ON = true;
-			}
-		}
-	} else if (pDM_Odm->SupportICType == ODM_RTL8192C) {
-		if (AntA_report >= 100) {
-			if (AntB_report > (AntA_report + 2)) {
-				pDM_SWAT_Table->ANTA_ON = false;
-				pDM_SWAT_Table->ANTB_ON = true;
-				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);
-			} else if (AntA_report > (AntB_report + 2)) {
-				pDM_SWAT_Table->ANTA_ON = true;
-				pDM_SWAT_Table->ANTB_ON = false;
-				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
-			} else {
-				pDM_SWAT_Table->ANTA_ON = true;
-				pDM_SWAT_Table->ANTB_ON = true;
-			}
-		} else {
-			pDM_SWAT_Table->ANTA_ON = true; /*  Set Antenna A on as default */
-			pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
-			bResult = false;
-		}
-	}
-	return bResult;
-}
-
 /* Justin: According to the current RRSI to adjust Response Frame TX power, 2012/11/05 */
 void odm_dtc(struct odm_dm_struct *pDM_Odm)
 {
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 265583a43494..b38129d2fa38 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -1131,8 +1131,6 @@ void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
 
 void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm);
 
-bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode);
-
 void odm_dtc(struct odm_dm_struct *pDM_Odm);
 
 #endif
-- 
2.33.0

