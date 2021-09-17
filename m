Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674740F3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbhIQIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbhIQIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:08:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y132so6639801wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMgAMgH3MmqC9sXi5CWxbKAA+xovQlt0HhV9hlPVqn8=;
        b=SICtbYxI15Jr7lsJ2h7oLdqkNlflpkOdQxKVLleSrntOvgkgmg2Vr0nrs/f3kDC8c1
         Ly9LJ82jS2rI8avkQHgZiTyOj0Cf7+5Z+4wbuKWQX6ZAXCE3hNEMpNhgebDlAT/HklUo
         BTEPBnzuAGFonf66JSuj65h/OJZsb8DJoNtBeHIE1tsC8ih4wju0zMjys4nrYD7Kn0lh
         ZanYOCvL0As2aGti39swGhHi06xAwJDyAcNjhPKOJiyMm/x7ffiJjLdcZ6ai80WUnAy0
         td9fgSk7swKXcX2N1sDmEUO3xduFgAw2qgDSdoJTmp5pTFNo5o7kXnE2jQUruVs+vV3J
         3WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMgAMgH3MmqC9sXi5CWxbKAA+xovQlt0HhV9hlPVqn8=;
        b=zyDsNgC33GIc70FJiab2Uk4HLP5vx72kM+z+gHwDB7F3hUPJFISrCqC2QHnbyT4jc0
         HViALJz9iAaJJivi4R+8TtDtZpUR6MlqD/Sy2wjQDfVTs8Cuf7xmguj+IS1KxdJ4F5iL
         5F1JX8AoJezfLbbCSOx0ow2ZP2aLxW4+yGzLChEyb2SUeoRc8o4CoxSqslPnR8xheFOV
         o01pGfdxh+5Wq1VzplAuko5ub2kk3WUSQnub0mYEMybIWaFd0IBMFLHrBTn2UnoXC63K
         CHInC6ylpTgOH9/aQmOLfWxEmmhKBHnN14viBOcoNzgPlB1lL/jpMuQbzR4A5XDeei5n
         TbMg==
X-Gm-Message-State: AOAM532Cw5IhIG7xUdm57rxL6/N8I4obbMv6s7onQ4FIX3iesDIE8pTw
        Hmso91m5BPVJhRjkDZCUK7k=
X-Google-Smtp-Source: ABdhPJz7xok3bPHEX65OfP9iLIVIuAqqDEzG/ztScQhbSBa2GPYHzJgHT70R9KaZbIkg96+ysgn6Dg==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr13953911wmp.165.1631865994117;
        Fri, 17 Sep 2021 01:06:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id r129sm5690890wmr.7.2021.09.17.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:06:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove NumTotalRFPath from struct hal_data_8188e
Date:   Fri, 17 Sep 2021 10:06:14 +0200
Message-Id: <20210917080615.25819-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917080615.25819-1-straube.linux@gmail.com>
References: <20210917080615.25819-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NumTotalRFPath is 1 in this driver and it is only used as exit condition
in for loops. Since NumTotalRFPath is always 1, all the loops have only a
single iteration. So we can remove the for loops and the NumTotalRFPath
variable.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  50 +++----
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |   5 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 141 +++++++++---------
 .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
 5 files changed, 97 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 6776e1d1c6d4..179dc209a68f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1691,7 +1691,6 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	pHalData->VersionID = ChipVersion;
 
 	pHalData->rf_type = RF_1T1R;
-	pHalData->NumTotalRFPath = 1;
 
 	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
 }
@@ -1999,7 +1998,8 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct txpowerinfo24g pwrInfo24G;
-	u8 rfPath, ch, group;
+	u8 rfPath = 0;
+	u8 ch, group;
 	u8 TxCount;
 
 	Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
@@ -2007,31 +2007,29 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	if (!AutoLoadFail)
 		pHalData->bTXPowerDataReadFromEEPORM = true;
 
-	for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
-		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
-			hal_get_chnl_group_88e(ch, &group);
+	for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
+		hal_get_chnl_group_88e(ch, &group);
 
-			pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
-			if (ch == 14)
-				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
-			else
-				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
-
-			DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
-			DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
-			DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
-		}
-		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
-			pHalData->CCK_24G_Diff[rfPath][TxCount] = pwrInfo24G.CCK_Diff[rfPath][TxCount];
-			pHalData->OFDM_24G_Diff[rfPath][TxCount] = pwrInfo24G.OFDM_Diff[rfPath][TxCount];
-			pHalData->BW20_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW20_Diff[rfPath][TxCount];
-			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
-			DBG_88E("======= TxCount %d =======\n", TxCount);
-			DBG_88E("CCK_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]);
-			DBG_88E("OFDM_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]);
-			DBG_88E("BW20_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]);
-			DBG_88E("BW40_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]);
-		}
+		pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
+		if (ch == 14)
+			pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
+		else
+			pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
+
+		DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
+		DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
+		DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
+	}
+	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
+		pHalData->CCK_24G_Diff[rfPath][TxCount] = pwrInfo24G.CCK_Diff[rfPath][TxCount];
+		pHalData->OFDM_24G_Diff[rfPath][TxCount] = pwrInfo24G.OFDM_Diff[rfPath][TxCount];
+		pHalData->BW20_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW20_Diff[rfPath][TxCount];
+		pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
+		DBG_88E("======= TxCount %d =======\n", TxCount);
+		DBG_88E("CCK_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]);
+		DBG_88E("OFDM_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]);
+		DBG_88E("BW20_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]);
+		DBG_88E("BW40_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]);
 	}
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index eb9e32dfcbe7..67ee8dff6349 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -143,12 +143,11 @@ void Hal_SetChannel(struct adapter *pAdapter)
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
 	struct mp_priv	*pmp = &pAdapter->mppriv;
 	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
-	u8		eRFPath;
+	u8		eRFPath = 0;
 	u8		channel = pmp->channel;
 
 	/*  set RF channel register */
-	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
-		_write_rfreg(pAdapter, eRFPath, ODM_CHANNEL, 0x3FF, channel);
+	_write_rfreg(pAdapter, eRFPath, ODM_CHANNEL, 0x3FF, channel);
 	Hal_mpt_SwitchRfSetting(pAdapter);
 
 	SelectChannel(pAdapter, channel);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 521ecdbe5520..bb0cda0c16a0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -863,7 +863,7 @@ void PHY_SetBWMode8188E(struct adapter *Adapter, enum ht_channel_width Bandwidth
 
 static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 {
-	u8 eRFPath;
+	u8 eRFPath = 0;
 	u32 param1, param2;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 
@@ -876,10 +876,8 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	/* s2. RF dependent command - CmdID_RF_WriteReg, param1=RF_CHNLBW, param2=channel */
 	param1 = RF_CHNLBW;
 	param2 = channel;
-	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++) {
-		pHalData->RfRegChnlVal[eRFPath] = ((pHalData->RfRegChnlVal[eRFPath] & 0xfffffc00) | param2);
-		PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
-	}
+	pHalData->RfRegChnlVal[eRFPath] = ((pHalData->RfRegChnlVal[eRFPath] & 0xfffffc00) | param2);
+	PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
 }
 
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 03b68b3e3550..63e85052cc98 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -235,17 +235,17 @@ static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 		powerBase0 = (powerBase0 << 24) | (powerBase0 << 16) | (powerBase0 << 8) | powerBase0;
 		*(OfdmBase + i) = powerBase0;
 	}
-	for (i = 0; i < pHalData->NumTotalRFPath; i++) {
-		/* Check HT20 to HT40 diff */
-		if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
-			powerlevel[i] = pPowerLevelBW20[i];
-		else
-			powerlevel[i] = pPowerLevelBW40[i];
-		powerBase1 = powerlevel[i];
-		powerBase1 = (powerBase1 << 24) | (powerBase1 << 16) | (powerBase1 << 8) | powerBase1;
-		*(MCSBase + i) = powerBase1;
-	}
+
+	/* Check HT20 to HT40 diff */
+	if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
+		powerlevel[i] = pPowerLevelBW20[i];
+	else
+		powerlevel[i] = pPowerLevelBW40[i];
+	powerBase1 = powerlevel[i];
+	powerBase1 = (powerBase1 << 24) | (powerBase1 << 16) | (powerBase1 << 8) | powerBase1;
+	*(MCSBase + i) = powerBase1;
 }
+
 static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 				    u8 index, u32 *powerBase0, u32 *powerBase1,
 				    u32 *pOutWriteVal)
@@ -458,70 +458,68 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	struct bb_reg_def *pPhyReg;
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u32 u4RegValue = 0;
-	u8 eRFPath;
+	u8 eRFPath = 0;
 	int rtStatus = _SUCCESS;
 
-	/* 3----------------------------------------------------------------- */
-	/* 3 <2> Initialize RF */
-	/* 3----------------------------------------------------------------- */
-	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++) {
-		pPhyReg = &pHalData->PHYRegDef[eRFPath];
-
-		/*----Store original RFENV control type----*/
-		switch (eRFPath) {
-		case RF_PATH_A:
-		case RF_PATH_C:
-			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
-			break;
-		case RF_PATH_B:
-		case RF_PATH_D:
-			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16);
-			break;
-		}
-		/*----Set RF_ENV enable----*/
-		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
-		udelay(1);/* PlatformStallExecution(1); */
-
-		/*----Set RF_ENV output high----*/
-		PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
-		udelay(1);/* PlatformStallExecution(1); */
-
-		/* Set bit number of Address and Data for RF register */
-		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
-		udelay(1);/* PlatformStallExecution(1); */
-
-		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
-		udelay(1);/* PlatformStallExecution(1); */
-
-		/*----Initialize RF fom connfiguration file----*/
-		switch (eRFPath) {
-		case RF_PATH_A:
-			if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
-				rtStatus = _FAIL;
-			break;
-		case RF_PATH_B:
+	/* Initialize RF */
+
+	pPhyReg = &pHalData->PHYRegDef[eRFPath];
+
+	/*----Store original RFENV control type----*/
+	switch (eRFPath) {
+	case RF_PATH_A:
+	case RF_PATH_C:
+		u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
+		break;
+	case RF_PATH_B:
+	case RF_PATH_D:
+		u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16);
+		break;
+	}
+	/*----Set RF_ENV enable----*/
+	PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
+	udelay(1);/* PlatformStallExecution(1); */
+
+	/*----Set RF_ENV output high----*/
+	PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
+	udelay(1);/* PlatformStallExecution(1); */
+
+	/* Set bit number of Address and Data for RF register */
+	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
+	udelay(1);/* PlatformStallExecution(1); */
+
+	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
+	udelay(1);/* PlatformStallExecution(1); */
+
+	/*----Initialize RF fom connfiguration file----*/
+	switch (eRFPath) {
+	case RF_PATH_A:
 		if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
-				rtStatus = _FAIL;
-			break;
-		case RF_PATH_C:
-			break;
-		case RF_PATH_D:
-			break;
-		}
-		/*----Restore RFENV control type----*/;
-		switch (eRFPath) {
-		case RF_PATH_A:
-		case RF_PATH_C:
-			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
-			break;
-		case RF_PATH_B:
-		case RF_PATH_D:
-			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
-			break;
-		}
-		if (rtStatus != _SUCCESS)
-			goto phy_RF6052_Config_ParaFile_Fail;
+			rtStatus = _FAIL;
+		break;
+	case RF_PATH_B:
+	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
+			rtStatus = _FAIL;
+		break;
+	case RF_PATH_C:
+		break;
+	case RF_PATH_D:
+		break;
+	}
+	/*----Restore RFENV control type----*/;
+	switch (eRFPath) {
+	case RF_PATH_A:
+	case RF_PATH_C:
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
+		break;
+	case RF_PATH_B:
+	case RF_PATH_D:
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
+		break;
 	}
+	if (rtStatus != _SUCCESS)
+		goto phy_RF6052_Config_ParaFile_Fail;
+
 	return rtStatus;
 
 phy_RF6052_Config_ParaFile_Fail:
@@ -530,11 +528,8 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 int PHY_RF6052_Config8188E(struct adapter *Adapter)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	int rtStatus = _SUCCESS;
 
-	pHalData->NumTotalRFPath = 1;
-
 	/*  */
 	/*  Config BB and RF */
 	/*  */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index e7e7064dd356..94d5992cca19 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -228,7 +228,6 @@ struct hal_data_8188e {
 	/* rf_ctrl */
 	u8	rf_chip;
 	u8	rf_type;
-	u8	NumTotalRFPath;
 
 	u8	BoardType;
 
-- 
2.33.0

