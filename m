Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C843D3AD999
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhFSKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhFSKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB5C061767
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so10327364wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=Q0azFpGXsNN66/8Sj2LgkoZJ6eN884VR3awDIz4TJgf5fD2dc5gbi0mSBcqd1xNcSj
         U8ukrv88cSMoV31HPnmxpDPez+3CYqDwjHCs7ZAhedj7WU+IrBRRU/XUk6r5UTKcFhJX
         UHjVDdZsljkKDUANUCg7yEsaGi2/8f5mc32OJuoBdqUQKP9ReDwA3446hpIyoMiLeyZ9
         AZP3J+06u8a4UefAipLZrGmR+TwtsixBgEyt869YWLD4qjQq4T3dVdMiG447RjrCFpZg
         pcZOwQQouFaek2skYPKcW8M8wRVJBYBkieyvHUcVuE9oytvZVt6Na6QYBDvc9bM4C73C
         fivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=KkAOyO8Oncf12sprGayhRKjFw4j/j0uOn+73z0J/R2D8YPbaWeAEQQoYqNfQXbEkKz
         ffjIRwF3TuAFvNAUmRM1AvtPMZ6ySQUxOqXU273btTWmTlslsPJyz5Idl5E8wdvVLCn3
         6QkJQJRwqcSFTju6Q2cMLz9rRfzBEV7cSuoEjmEBojXn4wFiWSCBbbRcPeKsnPk7r8qD
         SaDmvuhwTmBDRtecrE3Vm8IIG7qHKZwD7chHhb3hiWG3z/Y1eJUWeSfuMemiW0EKQNzY
         +l4YZFk1pdQMAiIdaxDSc8dLsZiF7YQvMD2+wzAJy33ealqdoI0qQhtD3cktf5OsQk5j
         8cWA==
X-Gm-Message-State: AOAM532fw4HEuo7N7BCl5EoqjG+C4+1hIMV422ZexDtEdpbEZaeXHOVj
        FBZU+113LwFfdAg9tOJZI9EvbFq7zLWMgQ==
X-Google-Smtp-Source: ABdhPJxDbG4F6aRfUgEj7qX7pFUk1GhET89T/BPq+6EAiYCMs4wLqdEyl5CoyVmlkh6AVZm99y6BOA==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr8631797wmj.145.1624099654342;
        Sat, 19 Jun 2021 03:47:34 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id i21sm12704202wmq.12.2021.06.19.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
Date:   Sat, 19 Jun 2021 12:47:11 +0200
Message-Id: <ae9dcad7b9e63a06baa3be792c7e243e675e7e2a.1624099125.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

beautify function prototypes in incldue/hal_com_phycfg.h
in order to ease grep searches.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../rtl8723bs/include/hal_com_phycfg.h        | 188 +++++-------------
 1 file changed, 48 insertions(+), 140 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index a30e1e09826d..3d95ab1986b1 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -70,147 +70,55 @@ struct bb_register_def {
 
 };
 
-u8
-PHY_GetTxPowerByRateBase(
-struct adapter *Adapter,
-u8 		RfPath,
-u8 		TxNum,
-enum rate_section	RateSection
-	);
-
-u8
-PHY_GetRateSectionIndexOfTxPowerByRate(
-struct adapter *padapter,
-u32 		RegAddr,
-u32 		BitMask
-	);
-
-void
-PHY_GetRateValuesOfTxPowerByRate(
-struct adapter *padapter,
-u32 		RegAddr,
-u32 		BitMask,
-u32 		Value,
-u8		*RateIndex,
-s8		*PwrByRateVal,
-u8		*RateNum
-	);
-
-u8
-PHY_GetRateIndexOfTxPowerByRate(
-u8 Rate
-	);
-
-void
-PHY_SetTxPowerIndexByRateSection(
-struct adapter *padapter,
-u8 		RFPath,
-u8 		Channel,
-u8 		RateSection
-	);
-
-s8
-PHY_GetTxPowerByRate(
-struct adapter *padapter,
-u8 	RFPath,
-u8 	TxNum,
-u8 	RateIndex
-	);
-
-void
-PHY_SetTxPowerByRate(
-struct adapter *padapter,
-u8 	RFPath,
-u8 	TxNum,
-u8 	Rate,
-s8			Value
-	);
-
-void
-PHY_SetTxPowerLevelByPath(
-struct adapter *Adapter,
-u8 	channel,
-u8 	path
-	);
-
-void
-PHY_SetTxPowerIndexByRateArray(
-struct adapter *padapter,
-u8 		RFPath,
-enum channel_width	BandWidth,
-u8 		Channel,
-u8		*Rates,
-u8 		RateArraySize
-	);
-
-void
-PHY_InitTxPowerByRate(
-struct adapter *padapter
-	);
-
-void
-PHY_StoreTxPowerByRate(
-struct adapter *padapter,
-u32 		RfPath,
-u32 		TxNum,
-u32 		RegAddr,
-u32 		BitMask,
-u32 		Data
-	);
-
-void
-PHY_TxPowerByRateConfiguration(
-	struct adapter *padapter
-	);
-
-u8
-PHY_GetTxPowerIndexBase(
-struct adapter *padapter,
-u8 		RFPath,
-u8 		Rate,
-enum channel_width	BandWidth,
-u8 		Channel
-	);
+u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath, u8 TxNum,
+			    enum rate_section RateSection);
+
+u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter *padapter, u32	RegAddr,
+					  u32 BitMask);
+
+void PHY_GetRateValuesOfTxPowerByRate(struct adapter *padapter, u32 RegAddr,
+				      u32 BitMask, u32 Value, u8 *RateIndex,
+				      s8 *PwrByRateVal, u8 *RateNum);
+
+u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate);
+
+void PHY_SetTxPowerIndexByRateSection(struct adapter *padapter, u8 RFPath, u8 Channel,
+				      u8 RateSection);
+
+s8 PHY_GetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8	TxNum, u8 RateIndex);
+
+void PHY_SetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8 TxNum, u8 Rate,
+			  s8 Value);
+
+void PHY_SetTxPowerLevelByPath(struct adapter *Adapter, u8 channel, u8 path);
+
+void PHY_SetTxPowerIndexByRateArray(struct adapter *padapter, u8 RFPath,
+				    enum channel_width BandWidth, u8 Channel,
+				    u8 *Rates, u8 RateArraySize);
+
+void PHY_InitTxPowerByRate(struct adapter *padapter);
+
+void PHY_StoreTxPowerByRate(struct adapter *padapter, u32 RfPath, u32 TxNum,
+			    u32	RegAddr, u32 BitMask, u32 Data);
+
+void PHY_TxPowerByRateConfiguration(struct adapter *padapter);
+
+u8 PHY_GetTxPowerIndexBase(struct adapter *padapter, u8 RFPath, u8 Rate,
+			   enum channel_width BandWidth, u8 Channel);
 
 s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 RegPwrTblSel,
-		      enum channel_width Bandwidth,
-u8 		RfPath,
-u8 		DataRate,
-u8 		Channel
-	);
-
-void
-PHY_SetTxPowerLimit(
-struct adapter *Adapter,
-u8 			*Regulation,
-u8 			*Bandwidth,
-u8 			*RateSection,
-u8 			*RfPath,
-u8 			*Channel,
-u8 			*PowerLimit
-	);
-
-void
-PHY_ConvertTxPowerLimitToPowerIndex(
-struct adapter *Adapter
-	);
-
-void
-PHY_InitTxPowerLimit(
-struct adapter *Adapter
-	);
-
-s8
-PHY_GetTxPowerTrackingOffset(
-	struct adapter *padapter,
-	u8 	Rate,
-	u8 	RFPath
-	);
-
-void
-Hal_ChannelPlanToRegulation(
-struct adapter *Adapter,
-u16 			ChannelPlan
-	);
+		      enum channel_width Bandwidth, u8 RfPath, u8 DataRate,
+		      u8 Channel);
+
+void PHY_SetTxPowerLimit(struct adapter *Adapter, u8 *Regulation, u8 *Bandwidth,
+			 u8 *RateSection, u8 *RfPath, u8 *Channel, u8 *PowerLimit);
+
+void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter);
+
+void PHY_InitTxPowerLimit(struct adapter *Adapter);
+
+s8 PHY_GetTxPowerTrackingOffset(struct adapter *padapter, u8 Rate, u8 RFPath);
+
+void Hal_ChannelPlanToRegulation(struct adapter *Adapter, u16 ChannelPlan);
 
 #endif /* __HAL_COMMON_H__ */
-- 
2.20.1

