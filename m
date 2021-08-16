Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62143EDEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHPU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhHPU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:56:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E3C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z20so34213436ejf.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhW+Yk3Dr+oVDKHJj69msiNe2yZZt/8UwwJJhFUJ7ng=;
        b=bxARJ4t3VRrCA8HEnC/l8Njr75JCymQWQXE3YZg/oyqsWMZJ2gAyuaWTSxAy4+htRo
         BzNqJDcwDMz7D3+QRtAKBAGbHYQa2ji3tc5ko3EQ6s+/6FXpb3i3++odPmZHNu1JohT4
         0JVhAX7qVfsBxe+fKq8rKWYTOXApLXPxTX7FrcnRDjo5JO4aQu3YRN3LC/e2knrG/iXz
         Ntr/3mLMEii89FJ5AMYT1uyTNSGwa5a25qqMjKqS30zfzyMFvj2232NwwrC8gOM+NaOZ
         9bXPII15N7LfOsUdRMEGWyczlGFn2YJPmZ9m5DuBquqtndljGEsjrMPg3W0vVrLKQRBc
         VwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhW+Yk3Dr+oVDKHJj69msiNe2yZZt/8UwwJJhFUJ7ng=;
        b=aPceASODGoPzLhj6kAuIa3GFxHHWBEH3+J8L3f4j2PSEoBMc9hv610IHkUV4//ATiN
         sRnukmWUpn90VID3QGMKE7VZbv1RyclO7itdgdNWeq4XXOvdDU8kDoiOZbtjK4a300E0
         NkHaT5YEpLFsKh0zIWoZ3ktMpjga5a6zXQi+Qik8ePnjGSEi6xenWFKwIAo82crQQFAG
         ZZSvg2SuxRoEAjjcpoDtj88RMgUQYb++ueBAqszliHr3ADeLUZLIHKLG8rVz3juEMSiP
         9D7+ENQqGQH2CRJ57711KeFpDmwY0QafVIOizeJ/hchEGq9qKUxmzvhrQMhubVJjgsnm
         6lwQ==
X-Gm-Message-State: AOAM530eRR94OKaZWErz4LlV0DVa5doAw/yeH02tv9RCEA88Av+Al++G
        I0O6PH0Bx43BfplRh9CLomc=
X-Google-Smtp-Source: ABdhPJy5qSB+GFxxl59kLIJ6I9Qi8ZPIEmkwVu8Oh/CVD43tz6/hqOeKWtzjFb87Ue/IbvErXjr7Rw==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr49724ejc.142.1629147372652;
        Mon, 16 Aug 2021 13:56:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id ck17sm36967edb.88.2021.08.16.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:56:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: clean up spacing style issues in hal dir, part 3
Date:   Mon, 16 Aug 2021 22:55:11 +0200
Message-Id: <20210816205511.20068-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816205511.20068-1-straube.linux@gmail.com>
References: <20210816205511.20068-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues reported by checkpatch in the remaining
files in the hal directory.

CHECK: spaces preferred around that ...

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  66 +++----
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |   2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  10 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  36 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 162 +++++++++---------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  20 +--
 7 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 60fa7e4f5f2c..ad0782259654 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -147,8 +147,8 @@ rtl8188e_PHY_RF6052SetCckTxPower(
 		if (TurboScanOff) {
 			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
 				TxAGC[idx1] =
-					pPowerlevel[idx1] | (pPowerlevel[idx1]<<8) |
-					(pPowerlevel[idx1]<<16) | (pPowerlevel[idx1]<<24);
+					pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
+					(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
 				/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
 				if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
 					TxAGC[idx1] = 0x20;
@@ -171,16 +171,16 @@ i		 *  Currently, we cannot fully disable driver dynamic
 		} else {
 			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
 				TxAGC[idx1] =
-					pPowerlevel[idx1] | (pPowerlevel[idx1]<<8) |
-					(pPowerlevel[idx1]<<16) | (pPowerlevel[idx1]<<24);
+					pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
+					(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
 			}
 			if (pHalData->EEPROMRegulatory == 0) {
 				tmpval = (pHalData->MCSTxPowerLevelOriginalOffset[0][6]) +
-						(pHalData->MCSTxPowerLevelOriginalOffset[0][7]<<8);
+						(pHalData->MCSTxPowerLevelOriginalOffset[0][7] << 8);
 				TxAGC[RF_PATH_A] += tmpval;
 
 				tmpval = (pHalData->MCSTxPowerLevelOriginalOffset[0][14]) +
-						(pHalData->MCSTxPowerLevelOriginalOffset[0][15]<<24);
+						(pHalData->MCSTxPowerLevelOriginalOffset[0][15] << 24);
 				TxAGC[RF_PATH_B] += tmpval;
 			}
 		}
@@ -206,15 +206,15 @@ i		 *  Currently, we cannot fully disable driver dynamic
 	}
 
 	/*  rf-A cck tx power */
-	tmpval = TxAGC[RF_PATH_A]&0xff;
+	tmpval = TxAGC[RF_PATH_A] & 0xff;
 	PHY_SetBBReg(Adapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, tmpval);
-	tmpval = TxAGC[RF_PATH_A]>>8;
+	tmpval = TxAGC[RF_PATH_A] >> 8;
 	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
 
 	/*  rf-B cck tx power */
-	tmpval = TxAGC[RF_PATH_B]>>24;
+	tmpval = TxAGC[RF_PATH_B] >> 24;
 	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, tmpval);
-	tmpval = TxAGC[RF_PATH_B]&0x00ffffff;
+	tmpval = TxAGC[RF_PATH_B] & 0x00ffffff;
 	PHY_SetBBReg(Adapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
 }	/* PHY_RF6052SetCckTxPower */
 
@@ -232,8 +232,8 @@ static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 	for (i = 0; i < 2; i++) {
 		powerBase0 = pPowerLevelOFDM[i];
 
-		powerBase0 = (powerBase0<<24) | (powerBase0<<16) | (powerBase0<<8) | powerBase0;
-		*(OfdmBase+i) = powerBase0;
+		powerBase0 = (powerBase0 << 24) | (powerBase0 << 16) | (powerBase0 << 8) | powerBase0;
+		*(OfdmBase + i) = powerBase0;
 	}
 	for (i = 0; i < pHalData->NumTotalRFPath; i++) {
 		/* Check HT20 to HT40 diff */
@@ -242,8 +242,8 @@ static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 		else
 			powerlevel[i] = pPowerLevelBW40[i];
 		powerBase1 = powerlevel[i];
-		powerBase1 = (powerBase1<<24) | (powerBase1<<16) | (powerBase1<<8) | powerBase1;
-		*(MCSBase+i) = powerBase1;
+		powerBase1 = (powerBase1 << 24) | (powerBase1 << 16) | (powerBase1 << 8) | powerBase1;
+		*(MCSBase + i) = powerBase1;
 	}
 }
 static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
@@ -264,7 +264,7 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 		case 0:	/*  Realtek better performance */
 				/*  increase power diff defined by Realtek for large power */
 			chnlGroup = 0;
-			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index + (rf ? 8 : 0)] +
 				((index < 2) ? powerBase0[rf] : powerBase1[rf]);
 			break;
 		case 1:	/*  Realtek regulatory */
@@ -285,7 +285,7 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 				else if (Channel == 14)		/*  Channel 14 */
 					chnlGroup = 5;
 			}
-			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index + (rf ? 8 : 0)] +
 					((index < 2) ? powerBase0[rf] : powerBase1[rf]);
 			break;
 		case 2:	/*  Better regulatory */
@@ -297,14 +297,14 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 			chnlGroup = 0;
 
 			if (index < 2)
-				pwr_diff = pHalData->TxPwrLegacyHtDiff[rf][Channel-1];
+				pwr_diff = pHalData->TxPwrLegacyHtDiff[rf][Channel - 1];
 			else if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
-				pwr_diff = pHalData->TxPwrHt20Diff[rf][Channel-1];
+				pwr_diff = pHalData->TxPwrHt20Diff[rf][Channel - 1];
 
 			if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_40)
-				customer_pwr_limit = pHalData->PwrGroupHT40[rf][Channel-1];
+				customer_pwr_limit = pHalData->PwrGroupHT40[rf][Channel - 1];
 			else
-				customer_pwr_limit = pHalData->PwrGroupHT20[rf][Channel-1];
+				customer_pwr_limit = pHalData->PwrGroupHT20[rf][Channel - 1];
 
 			if (pwr_diff >= customer_pwr_limit)
 				pwr_diff = 0;
@@ -312,18 +312,18 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 				pwr_diff = customer_pwr_limit - pwr_diff;
 
 			for (i = 0; i < 4; i++) {
-				pwr_diff_limit[i] = (u8)((pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)]&(0x7f<<(i*8)))>>(i*8));
+				pwr_diff_limit[i] = (u8)((pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index + (rf ? 8 : 0)] & (0x7f << (i * 8))) >> (i * 8));
 
 				if (pwr_diff_limit[i] > pwr_diff)
 					pwr_diff_limit[i] = pwr_diff;
 			}
-			customer_limit = (pwr_diff_limit[3]<<24) | (pwr_diff_limit[2]<<16) |
-					 (pwr_diff_limit[1]<<8) | (pwr_diff_limit[0]);
+			customer_limit = (pwr_diff_limit[3] << 24) | (pwr_diff_limit[2] << 16) |
+					 (pwr_diff_limit[1] << 8) | (pwr_diff_limit[0]);
 			writeVal = customer_limit + ((index < 2) ? powerBase0[rf] : powerBase1[rf]);
 			break;
 		default:
 			chnlGroup = 0;
-			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index + (rf ? 8 : 0)] +
 					((index < 2) ? powerBase0[rf] : powerBase1[rf]);
 			break;
 		}
@@ -340,7 +340,7 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 		/*  This mechanism is only applied when Driver-Highpower-Mechanism is OFF. */
 		if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT1)
 			writeVal = writeVal - 0x06060606;
-		*(pOutWriteVal+rf) = writeVal;
+		*(pOutWriteVal + rf) = writeVal;
 	}
 }
 static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
@@ -361,11 +361,11 @@ static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
 	for (rf = 0; rf < 2; rf++) {
 		writeVal = pValue[rf];
 		for (i = 0; i < 4; i++) {
-			pwr_val[i] = (u8)((writeVal & (0x7f<<(i*8)))>>(i*8));
+			pwr_val[i] = (u8)((writeVal & (0x7f << (i * 8))) >> (i * 8));
 			if (pwr_val[i]  > RF6052_MAX_TX_PWR)
 				pwr_val[i]  = RF6052_MAX_TX_PWR;
 		}
-		writeVal = (pwr_val[3]<<24) | (pwr_val[2]<<16) | (pwr_val[1]<<8) | pwr_val[0];
+		writeVal = (pwr_val[3] << 24) | (pwr_val[2] << 16) | (pwr_val[1] << 8) | pwr_val[0];
 
 		if (rf == 0)
 			regoffset = regoffset_a[index];
@@ -386,10 +386,10 @@ static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
 				regoffset = 0xc98;
 			for (i = 0; i < 3; i++) {
 				if (i != 2)
-					writeVal = (writeVal > 8) ? (writeVal-8) : 0;
+					writeVal = (writeVal > 8) ? (writeVal - 8) : 0;
 				else
-					writeVal = (writeVal > 6) ? (writeVal-6) : 0;
-				rtw_write8(Adapter, (u32)(regoffset+i), (u8)writeVal);
+					writeVal = (writeVal > 6) ? (writeVal - 6) : 0;
+				rtw_write8(Adapter, (u32)(regoffset + i), (u8)writeVal);
 			}
 		}
 	}
@@ -475,11 +475,11 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			break;
 		case RF_PATH_B:
 		case RF_PATH_D:
-			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16);
+			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16);
 			break;
 		}
 		/*----Set RF_ENV enable----*/
-		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV<<16, 0x1);
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
 		udelay(1);/* PlatformStallExecution(1); */
 
 		/*----Set RF_ENV output high----*/
@@ -516,7 +516,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			break;
 		case RF_PATH_B:
 		case RF_PATH_D:
-			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16, u4RegValue);
+			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
 			break;
 		}
 		if (rtStatus != _SUCCESS)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 8a668e96b764..b4b3c02cb13c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -177,7 +177,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 			rtl8188e_process_phy_info(padapter, precvframe);
 		}
 	} else if (pkt_info.bPacketToSelf || pkt_info.bPacketBeacon) {
-		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
+		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE)) {
 			if (psta)
 				precvframe->psta = psta;
 		}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 75ec97107add..452d4bb87aba 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -20,10 +20,10 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0)|BIT(5)|BIT(6)); /*  SW control led0 on. */
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
 		break;
 	case LED_PIN_LED1:
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0x0f)|BIT(5)); /*  SW control led1 on. */
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0x0f) | BIT(5)); /*  SW control led1 on. */
 		break;
 	default:
 		break;
@@ -48,17 +48,17 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 		if (pHalData->bLedOpenDrain) {
 			/*  Open-drain arrangement for controlling the LED) */
 			LedCfg &= 0x90; /*  Set to software control. */
-			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)));
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
 			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
 			LedCfg &= 0xFE;
 			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
 		} else {
-			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)|BIT(5)|BIT(6)));
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3) | BIT(5) | BIT(6)));
 		}
 		break;
 	case LED_PIN_LED1:
 		LedCfg &= 0x0f; /*  Set to software control. */
-		rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT(3)));
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
 		break;
 	default:
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 3a169392d183..a44c9598186c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -82,7 +82,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 			if (pskb) {
 				pskb->dev = padapter->pnetdev;
 				tmpaddr = (size_t)pskb->data;
-				alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+				alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
 				skb_reserve(pskb, (RECVBUFF_ALIGN_SZ - alignment));
 
 				skb_queue_tail(&precvpriv->free_recv_skb_queue, pskb);
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index a38e10b16233..8c9a651d4f44 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -61,12 +61,12 @@ void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u
 	/* offset 0 */
 	ptxdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG); /* own, bFirstSeg, bLastSeg; */
 
-	ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE+OFFSET_SZ)<<OFFSET_SHT)&0x00ff0000); /* 32 bytes for TX Desc */
+	ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) & 0x00ff0000); /* 32 bytes for TX Desc */
 
-	ptxdesc->txdw0 |= cpu_to_le32(BufferLen&0x0000ffff); /*  Buffer size + command header */
+	ptxdesc->txdw0 |= cpu_to_le32(BufferLen & 0x0000ffff); /*  Buffer size + command header */
 
 	/* offset 4 */
-	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT<<QSEL_SHT)&0x00001f00); /*  Fixed queue of Mgnt queue */
+	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT << QSEL_SHT) & 0x00001f00); /*  Fixed queue of Mgnt queue */
 
 	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
 	if (ispspoll) {
@@ -94,16 +94,16 @@ static void fill_txdesc_sectype(struct pkt_attrib *pattrib, struct tx_desc *ptxd
 		/* SEC_TYPE : 0:NO_ENC,1:WEP40/TKIP,2:WAPI,3:AES */
 		case _WEP40_:
 		case _WEP104_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x01 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _TKIP_:
 		case _TKIP_WTMIC_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x01 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _AES_:
-			ptxdesc->txdw1 |= cpu_to_le32((0x03<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw1 |= cpu_to_le32((0x03 << SEC_TYPE_SHT) & 0x00c00000);
 			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
 			break;
 		case _NO_PRIVACY_:
@@ -130,7 +130,7 @@ static void fill_txdesc_vcs(struct pkt_attrib *pattrib, __le32 *pdw)
 		*pdw |= cpu_to_le32(HW_RTS_EN);
 		/*  Set RTS BW */
 		if (pattrib->ht_en) {
-			*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(27)) : 0;
+			*pdw |= (pattrib->bwmode & HT_CHANNEL_WIDTH_40) ? cpu_to_le32(BIT(27)) : 0;
 
 			if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 				*pdw |= cpu_to_le32((0x01 << 28) & 0x30000000);
@@ -147,7 +147,7 @@ static void fill_txdesc_vcs(struct pkt_attrib *pattrib, __le32 *pdw)
 static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 {
 	if (pattrib->ht_en) {
-		*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(25)) : 0;
+		*pdw |= (pattrib->bwmode & HT_CHANNEL_WIDTH_40) ? cpu_to_le32(BIT(25)) : 0;
 
 		if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			*pdw |= cpu_to_le32((0x01 << DATA_SC_SHT) & 0x003f0000);
@@ -175,7 +175,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
-			ptxdesc = (struct tx_desc *)(pmem+PACKET_OFFSET_SZ);
+			ptxdesc = (struct tx_desc *)(pmem + PACKET_OFFSET_SZ);
 			pull = 1;
 		}
 	}
@@ -267,11 +267,11 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 				ptxdesc->txdw4 |= cpu_to_le32(BIT(24));/*  DATA_SHORT */
 			ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
 		}
-	} else if ((pxmitframe->frame_tag&0x0f) == MGNT_FRAMETAG) {
+	} else if ((pxmitframe->frame_tag & 0x0f) == MGNT_FRAMETAG) {
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32(pattrib->mac_id & 0x3f);
 
-		qsel = (uint)(pattrib->qsel&0x0000001f);
+		qsel = (uint)(pattrib->qsel & 0x0000001f);
 		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
 
 		ptxdesc->txdw1 |= cpu_to_le32((pattrib->raid << RATE_ID_SHT) & 0x000f0000);
@@ -282,7 +282,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw2 |= cpu_to_le32(BIT(19));
 
 		/* offset 12 */
-		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0FFF0000);
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0FFF0000);
 
 		/* offset 20 */
 		ptxdesc->txdw5 |= cpu_to_le32(RTY_LMT_EN);/* retry limit enable */
@@ -292,9 +292,9 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
-	} else if ((pxmitframe->frame_tag&0x0f) == TXAGG_FRAMETAG) {
+	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
 		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
-	} else if (((pxmitframe->frame_tag&0x0f) == MP_FRAMETAG) &&
+	} else if (((pxmitframe->frame_tag & 0x0f) == MP_FRAMETAG) &&
 		   (adapt->registrypriv.mp_mode == 1)) {
 		fill_txdesc_for_mp(adapt, ptxdesc);
 	} else {
@@ -308,7 +308,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 		/* offset 8 */
 
 		/* offset 12 */
-		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0fff0000);
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0fff0000);
 
 		/* offset 20 */
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
@@ -470,7 +470,7 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 
 	/* 3 2. aggregate same priority and same DA(AP or STA) frames */
 	pfirstframe = pxmitframe;
-	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset*PACKET_OFFSET_SZ);
+	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset * PACKET_OFFSET_SZ);
 	pbuf_tail = len;
 	pbuf = _RND8(pbuf_tail);
 
@@ -521,7 +521,7 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 		pxmitframe->agg_num = 0; /*  not first frame of aggregation */
 		pxmitframe->pkt_offset = 0; /*  not first frame of aggregation, no need to reserve offset */
 
-		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset*PACKET_OFFSET_SZ);
+		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
 		if (_RND8(pbuf + len) > MAX_XMITBUF_SZ) {
 			pxmitframe->agg_num = 1;
@@ -626,7 +626,7 @@ static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	if (rtw_txframes_sta_ac_pending(adapt, pattrib) > 0)
 		goto enqueue;
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 		goto enqueue;
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8948c429afd7..2e0af691310a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -188,14 +188,14 @@ static void _InitTxBufferBoundary(struct adapter *Adapter, u8 txpktbuf_bndy)
 	rtw_write8(Adapter, REG_TXPKTBUF_MGQ_BDNY, txpktbuf_bndy);
 	rtw_write8(Adapter, REG_TXPKTBUF_WMAC_LBK_BF_HD, txpktbuf_bndy);
 	rtw_write8(Adapter, REG_TRXFF_BNDY, txpktbuf_bndy);
-	rtw_write8(Adapter, REG_TDECTRL+1, txpktbuf_bndy);
+	rtw_write8(Adapter, REG_TDECTRL + 1, txpktbuf_bndy);
 }
 
 static void _InitPageBoundary(struct adapter *Adapter)
 {
 	/*  RX Page Boundary */
 	/*  */
-	u16 rxff_bndy = MAX_RX_DMA_BUFFER_SIZE_88E-1;
+	u16 rxff_bndy = MAX_RX_DMA_BUFFER_SIZE_88E - 1;
 
 	rtw_write16(Adapter, (REG_TRXFF_BNDY + 2), rxff_bndy);
 }
@@ -529,7 +529,7 @@ usb_AggSettingRxUpdate(
 	switch (haldata->UsbRxAggMode) {
 	case USB_RX_AGG_DMA:
 		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, haldata->UsbRxAggPageTimeout);
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, haldata->UsbRxAggPageTimeout);
 		break;
 	case USB_RX_AGG_USB:
 		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
@@ -537,7 +537,7 @@ usb_AggSettingRxUpdate(
 		break;
 	case USB_RX_AGG_MIX:
 		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
 		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
 		rtw_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
 		break;
@@ -603,9 +603,9 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 
 	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
 	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
-	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL+2);
-	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT+2);
-	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR+1);
+	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
+	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2);
+	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1);
 }
 
 static void _BeaconFunctionEnable(struct adapter *Adapter,
@@ -613,7 +613,7 @@ static void _BeaconFunctionEnable(struct adapter *Adapter,
 {
 	rtw_write8(Adapter, REG_BCN_CTRL, (BIT(4) | BIT(3) | BIT(1)));
 
-	rtw_write8(Adapter, REG_RD_CTRL+1, 0x6F);
+	rtw_write8(Adapter, REG_RD_CTRL + 1, 0x6F);
 }
 
 /*  Set CCK and OFDM Block "ON" */
@@ -636,7 +636,7 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		return;
 	DBG_88E("==>  %s ....\n", __func__);
 
-	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0)|BIT(23));
+	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
 	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
@@ -671,7 +671,7 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
-		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG)&~(BIT(3)));
+		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
 		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
 		DBG_88E("GPIO_IN=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
@@ -836,9 +836,9 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
 	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
-	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8|BIT(1)|BIT(0)));
+	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8 | BIT(1) | BIT(0)));
 	/* Set MAX RPT MACID */
-	rtw_write8(Adapter,  REG_TX_RPT_CTRL+1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
+	rtw_write8(Adapter,  REG_TX_RPT_CTRL + 1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
 	/* Tx RPT Timer. Unit: 32us */
 	rtw_write16(Adapter, REG_TX_RPT_TIME, 0xCdf0);
 
@@ -901,10 +901,10 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		pwrctrlpriv->rf_pwrstate = rf_on;
 
 		/*  enable Tx report. */
-		rtw_write8(Adapter,  REG_FWHW_TXQ_CTRL+1, 0x0F);
+		rtw_write8(Adapter,  REG_FWHW_TXQ_CTRL + 1, 0x0F);
 
 		/*  Suggested by SD1 pisa. Added by tynli. 2011.10.21. */
-		rtw_write8(Adapter, REG_EARLY_MODE_CONTROL+3, 0x01);/* Pretx_en, for WEP/TKIP SEC */
+		rtw_write8(Adapter, REG_EARLY_MODE_CONTROL + 3, 0x01);/* Pretx_en, for WEP/TKIP SEC */
 
 		/* tynli_test_tx_report. */
 		rtw_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
@@ -936,7 +936,7 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_USB_HRPWM, 0);
 
 	/* ack for xmit mgmt frames. */
-	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL)|BIT(12));
+	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
 
 exit:
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
@@ -965,7 +965,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
-	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT(1)));
+	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8 & (~BIT(1)));
 
 	/*  stop rx */
 	rtw_write8(Adapter, REG_CR, 0x0);
@@ -978,9 +978,9 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	val8 = rtw_read8(Adapter, REG_MCUFWDL);
 	if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
 		/*  Reset MCU 0x2[10]=0. */
-		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN+1);
+		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN + 1);
 		val8 &= ~BIT(2);	/*  0x2[10], FEN_CPUEN */
-		rtw_write8(Adapter, REG_SYS_FUNC_EN+1, val8);
+		rtw_write8(Adapter, REG_SYS_FUNC_EN + 1, val8);
 	}
 
 	/*  reset MCU ready status */
@@ -989,16 +989,16 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	/* YJ,add,111212 */
 	/* Disable 32k */
 	val8 = rtw_read8(Adapter, REG_32K_CTRL);
-	rtw_write8(Adapter, REG_32K_CTRL, val8&(~BIT(0)));
+	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
 	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
-	rtw_write8(Adapter, REG_RSV_CTRL+1, (val8&(~BIT(3))));
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
-	rtw_write8(Adapter, REG_RSV_CTRL+1, val8|BIT(3));
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	rtw_write8(Adapter, REG_RSV_CTRL + 1, (val8 & (~BIT(3))));
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	rtw_write8(Adapter, REG_RSV_CTRL + 1, val8 | BIT(3));
 
 	/* YJ,test add, 111207. For Power Consumption. */
 	val8 = rtw_read8(Adapter, GPIO_IN);
@@ -1006,9 +1006,9 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	rtw_write8(Adapter, GPIO_IO_SEL, 0xFF);/* Reg0x46 */
 
 	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL);
-	rtw_write8(Adapter, REG_GPIO_IO_SEL, (val8<<4));
-	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL+1);
-	rtw_write8(Adapter, REG_GPIO_IO_SEL+1, val8|0x0F);/* Reg0x43 */
+	rtw_write8(Adapter, REG_GPIO_IO_SEL, (val8 << 4));
+	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL + 1);
+	rtw_write8(Adapter, REG_GPIO_IO_SEL + 1, val8 | 0x0F);/* Reg0x43 */
 	rtw_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
 	haldata->bMacPwrCtrlOn = false;
 	Adapter->bFWReady = false;
@@ -1235,11 +1235,11 @@ static void ResumeTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT(6));
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) | BIT(6));
 	haldata->RegFwHwTxQCtrl |= BIT(6);
-	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0xff);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0xff);
 	haldata->RegReg542 |= BIT(0);
-	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
 }
 
 static void StopTxBeacon(struct adapter *adapt)
@@ -1249,11 +1249,11 @@ static void StopTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
 	haldata->RegFwHwTxQCtrl &= (~BIT(6));
-	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0x64);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0x64);
 	haldata->RegReg542 &= ~(BIT(0));
-	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
 
 	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
 }
@@ -1264,10 +1264,10 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 	u8 mode = *((u8 *)val);
 
 	/*  disable Port0 TSF update */
-	rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+	rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
 
 	/*  set net_type */
-	val8 = rtw_read8(Adapter, MSR)&0x0c;
+	val8 = rtw_read8(Adapter, MSR) & 0x0c;
 	val8 |= mode;
 	rtw_write8(Adapter, MSR, val8);
 
@@ -1308,7 +1308,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 
 		/* enable BCN0 Function for if1 */
 		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
-		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP|EN_BCN_FUNCTION | BIT(1)));
+		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
 
 		/* dis BCN1 ATIM  WND if if2 is station */
 		rtw_write8(Adapter, REG_BCN_CTRL_1, rtw_read8(Adapter, REG_BCN_CTRL_1) | BIT(0));
@@ -1323,7 +1323,7 @@ static void hw_var_set_macaddr(struct adapter *Adapter, u8 variable, u8 *val)
 	reg_macid = REG_MACID;
 
 	for (idx = 0; idx < 6; idx++)
-		rtw_write8(Adapter, (reg_macid+idx), val[idx]);
+		rtw_write8(Adapter, (reg_macid + idx), val[idx]);
 }
 
 static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1334,7 +1334,7 @@ static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
 	reg_bssid = REG_BSSID;
 
 	for (idx = 0; idx < 6; idx++)
-		rtw_write8(Adapter, (reg_bssid+idx), val[idx]);
+		rtw_write8(Adapter, (reg_bssid + idx), val[idx]);
 }
 
 static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1346,7 +1346,7 @@ static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 	if (*((u8 *)val))
 		rtw_write8(Adapter, bcn_ctrl_reg, (EN_BCN_FUNCTION | EN_TXBCN_RPT));
 	else
-		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg)&(~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg) & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
 }
 
 static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1360,7 +1360,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 val8;
 
-			val8 = rtw_read8(Adapter, MSR)&0x0c;
+			val8 = rtw_read8(Adapter, MSR) & 0x0c;
 			val8 |= *((u8 *)val);
 			rtw_write8(Adapter, MSR, val8);
 		}
@@ -1406,8 +1406,8 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			BrateCfg |= 0x01; /*  default enable 1M ACK rate */
 			/*  Set RRSR rate table. */
 			rtw_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
-			rtw_write8(Adapter, REG_RRSR+1, (BrateCfg >> 8) & 0xff);
-			rtw_write8(Adapter, REG_RRSR+2, rtw_read8(Adapter, REG_RRSR+2)&0xf0);
+			rtw_write8(Adapter, REG_RRSR + 1, (BrateCfg >> 8) & 0xff);
+			rtw_write8(Adapter, REG_RRSR + 2, rtw_read8(Adapter, REG_RRSR + 2) & 0xf0);
 
 			/*  Set RTS initial rate */
 			while (BrateCfg > 0x1) {
@@ -1433,25 +1433,25 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue,
 							  pmlmeinfo->bcn_interval * 1024) - 1024; /* us */
 
-			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				StopTxBeacon(Adapter);
 
 			/* disable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(3)));
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(3)));
 
 			rtw_write32(Adapter, REG_TSFTR, tsf);
-			rtw_write32(Adapter, REG_TSFTR+4, tsf>>32);
+			rtw_write32(Adapter, REG_TSFTR + 4, tsf >> 32);
 
 			/* enable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(3));
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(3));
 
-			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				ResumeTxBeacon(Adapter);
 		}
 		break;
 	case HW_VAR_CHECK_BSSID:
 		if (*((u8 *)val)) {
-			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 		} else {
 			u32 val32;
 
@@ -1468,10 +1468,10 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
 
 		/* reset TSF */
-		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0)|BIT(1)));
+		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
 
 		/* disable update TSF */
-		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
 		break;
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
@@ -1483,32 +1483,32 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
 
 			/* disable update TSF */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
 		} else { /* sitesurvey done */
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 			if ((is_client_associated_to_ap(Adapter)) ||
-			    ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE)) {
+			    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
 				/* enable to rx data frame */
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
-			} else if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+			} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 			}
-			if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
+			if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
+				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 			} else {
 				if (Adapter->in_cta_test) {
 					u32 v = rtw_read32(Adapter, REG_RCR);
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
+					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 				}
 			}
 		}
@@ -1528,7 +1528,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 				}
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
@@ -1541,9 +1541,9 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			} else if (type == 2) {
 				/* sta add event call back */
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE))
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
 					RetryLimit = 0x7;
 			}
 			rtw_write16(Adapter, REG_RL, RetryLimit << RETRY_LIMIT_SHORT_SHIFT | RetryLimit << RETRY_LIMIT_LONG_SHIFT);
@@ -1579,21 +1579,21 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_RESP_SIFS:
 		/* RESP_SIFS for CCK */
 		rtw_write8(Adapter, REG_R2T_SIFS, val[0]); /*  SIFS_T2T_CCK (0x08) */
-		rtw_write8(Adapter, REG_R2T_SIFS+1, val[1]); /* SIFS_R2T_CCK(0x08) */
+		rtw_write8(Adapter, REG_R2T_SIFS + 1, val[1]); /* SIFS_R2T_CCK(0x08) */
 		/* RESP_SIFS for OFDM */
 		rtw_write8(Adapter, REG_T2T_SIFS, val[2]); /* SIFS_T2T_OFDM (0x0a) */
-		rtw_write8(Adapter, REG_T2T_SIFS+1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
+		rtw_write8(Adapter, REG_T2T_SIFS + 1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
 		break;
 	case HW_VAR_ACK_PREAMBLE:
 		{
 			u8 regTmp;
 			u8 bShortPreamble = *((bool *)val);
 			/*  Joseph marked out for Netgear 3500 TKIP channel 7 issue.(Temporarily) */
-			regTmp = (haldata->nCur40MhzPrimeSC)<<5;
+			regTmp = (haldata->nCur40MhzPrimeSC) << 5;
 			if (bShortPreamble)
 				regTmp |= 0x80;
 
-			rtw_write8(Adapter, REG_RRSR+2, regTmp);
+			rtw_write8(Adapter, REG_RRSR + 2, regTmp);
 		}
 		break;
 	case HW_VAR_SEC_CFG:
@@ -1630,12 +1630,12 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 				/*  filled id in CAM config 2 byte */
 				if (i == 0)
-					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo)<<2);
+					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo) << 2);
 				else
 					ulContent = 0;
 				/*  polling bit, and No Write enable, and address */
-				ulCommand = CAM_CONTENT_COUNT*ucIndex+i;
-				ulCommand = ulCommand | CAM_POLLINIG|CAM_WRITE;
+				ulCommand = CAM_CONTENT_COUNT * ucIndex + i;
+				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				rtw_write32(Adapter, WCAMI, ulContent);  /* delay_ms(40); */
 				rtw_write32(Adapter, RWCAM, ulCommand);  /* delay_ms(40); */
@@ -1643,7 +1643,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		}
 		break;
 	case HW_VAR_CAM_INVALID_ALL:
-		rtw_write32(Adapter, RWCAM, BIT(31)|BIT(30));
+		rtw_write32(Adapter, RWCAM, BIT(31) | BIT(30));
 		break;
 	case HW_VAR_CAM_WRITE:
 		{
@@ -1733,18 +1733,18 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			pRegToSet = RegToSet_Normal; /*  0xb972a841; */
 			FactorToSet = *((u8 *)val);
 			if (FactorToSet <= 3) {
-				FactorToSet = (1<<(FactorToSet + 2));
+				FactorToSet = (1 << (FactorToSet + 2));
 				if (FactorToSet > 0xf)
 					FactorToSet = 0xf;
 
 				for (index = 0; index < 4; index++) {
-					if ((pRegToSet[index] & 0xf0) > (FactorToSet<<4))
-						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet<<4);
+					if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
+						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
 
 					if ((pRegToSet[index] & 0x0f) > FactorToSet)
 						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
 
-					rtw_write8(Adapter, (REG_AGGLEN_LMT+index), pRegToSet[index]);
+					rtw_write8(Adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
 				}
 			}
 		}
@@ -1835,9 +1835,9 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
-				rtw_write32(Adapter, REG_RXPKT_NUM, (rtw_read32(Adapter, REG_RXPKT_NUM)|RW_RELEASE_EN));
+				rtw_write32(Adapter, REG_RXPKT_NUM, (rtw_read32(Adapter, REG_RXPKT_NUM) | RW_RELEASE_EN));
 				do {
-					if (!(rtw_read32(Adapter, REG_RXPKT_NUM)&RXDMA_IDLE))
+					if (!(rtw_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
 				if (trycnt == 0)
@@ -1859,8 +1859,8 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_TX_RPT_MAX_MACID:
 		{
 			u8 maxMacid = *val;
-			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid+1);
-			rtw_write8(Adapter, REG_TX_RPT_CTRL+1, maxMacid+1);
+			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid + 1);
+			rtw_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
 		}
 		break;
 	case HW_VAR_H2C_MEDIA_STATUS_RPT:
@@ -1868,7 +1868,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		rtw_write8(Adapter, REG_TDECTRL+2, rtw_read8(Adapter, REG_TDECTRL+2) | BIT(0));
+		rtw_write8(Adapter, REG_TDECTRL + 2, rtw_read8(Adapter, REG_TDECTRL + 2) | BIT(0));
 		break;
 	default:
 		break;
@@ -1890,7 +1890,7 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
-		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL+2)) ? true : false;
+		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
 		break;
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
@@ -1926,7 +1926,7 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		*val = haldata->bMacPwrCtrlOn;
 		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
-		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION)&0x0000ff00) == 0) ? true : false;
+		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
 		break;
 	default:
 		break;
@@ -2133,7 +2133,7 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 
 	mask &= rate_bitmap;
 
-	init_rate = get_highest_rate_idx(mask)&0x3f;
+	init_rate = get_highest_rate_idx(mask) & 0x3f;
 
 	if (haldata->fw_ractrl) {
 		u8 arg;
@@ -2193,7 +2193,7 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	ResumeTxBeacon(adapt);
 
-	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg)|BIT(1));
+	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg) | BIT(1));
 }
 
 static void rtl8188eu_init_default_value(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8fcfe73cf5b3..b4edbfda9a18 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -114,7 +114,7 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
 	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
@@ -137,11 +137,11 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
 	request = 0x05;
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
 
-	return (u16)(le32_to_cpu(data)&0xffff);
+	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
@@ -157,7 +157,7 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
 	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
@@ -179,7 +179,7 @@ static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
 	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
 	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
@@ -203,7 +203,7 @@ static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 
 	data = cpu_to_le32(val & 0x0000ffff);
@@ -231,7 +231,7 @@ static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
 
@@ -258,7 +258,7 @@ static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = length;
 	memcpy(buf, pdata, len);
 
@@ -438,7 +438,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_copy = NULL;
 
 		if (transfer_len > 0 && pkt_cnt == 0)
-			pkt_cnt = (le32_to_cpu(prxstat->rxdw2)>>16) & 0xff;
+			pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
 
 	} while ((transfer_len > 0) && (pkt_cnt > 0));
 
@@ -573,7 +573,7 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 		}
 
 		tmpaddr = (size_t)precvbuf->pskb->data;
-		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
 		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 
 		precvbuf->phead = precvbuf->pskb->head;
-- 
2.32.0

