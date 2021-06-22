Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768A3B0471
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhFVMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFVMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so1652962wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=tiZjVOFAaUxbHAPVL+Ql6YbhBEZIN4m/Ar/gWbcEZTLzHmcBBAgcbYgvCdv+HJypx7
         2CBX8osXD0SW8eAyl+j9En/Iag3+oqAXj3+27/rcDN8c1aks4yFBpgENbq4ReNqxbKxG
         9/UAaqkxEmfusqV6Jlh68oOuLMcdI7WjN+1nEYICY6R0bh+U2DbUxN3tFi+vKmmSz/k7
         Wl4zxvHv1CS2cdDLb0djmIXLWwvnZIBs2aKG7RJit7gUFJcMvQCYx7DpGktWm6R5Iur+
         O3wXbEAcPcI70Ro/4faImRC2d5fB5enM5LZR0eGZcrcqSxrZ+o9DpFQgu3NMcbMb4hCM
         cMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=YKosh+ZK8y00Q9LlOQ4oeGfy+Y/cdO2T/6Enet4bcyGbyxedwWJGAt9w7U/NyM+rOd
         +fNOcB3M3suzMum5nigTjYF/FLQLZL8PD19mCJ1ej4R+V9lI3x0wXsUIUl6Ko5ALxxm+
         56f2v4ffMDnJd4GEkW8pplbOFF2ZXql/gach4oP3BKkQztAgD2UrRsV5i0Sl9Co01GHj
         AX3J3mjOMX9oT1rZVgV/qlh/DDPg1RLjoqRkl7LHzB2486c03aZLsUsQWf6dOGM0Yc6x
         KOli+xMdyzkKkkeozU5bhTh/yw4lJQPqFLcQ1sKAQt6SoqEpnMWs3J85KNMuiuNc6uOO
         89Xg==
X-Gm-Message-State: AOAM533FFvSLcuArqHRHZJsTxIvCuUClnMj594iJsj8fxfmQAuXmgG2v
        mAt7ftGveCyqa/+5RffZXijyFQoNguKfVA==
X-Google-Smtp-Source: ABdhPJyTaZ6KXTDSBknKJNK909Wa6lS7pTipWQWwQKJUmJ1I1mrzux6bu5f5crXtN5P6VUzkLc3lxg==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr4514383wrh.102.1624364995961;
        Tue, 22 Jun 2021 05:29:55 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id d15sm22240349wrb.42.2021.06.22.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
Date:   Tue, 22 Jun 2021 14:29:33 +0200
Message-Id: <ae9dcad7b9e63a06baa3be792c7e243e675e7e2a.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
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

