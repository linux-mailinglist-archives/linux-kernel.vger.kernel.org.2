Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B713B0588
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFVNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFVNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a11so23599672wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=sD/NI0kSg7pa+zM6LyAbeIRz9QFuoeVOvzKhCEcF6XnqDmn29LVeAaykYbmOVO8SM5
         0Xe8JgHKWrZiOarF/79i9uRGMT9ZkyGpQQdUbk2hBb2NYO95C6679YxmHyDMA6f+e0Rs
         Y075ghCe2FYt/6BFFN8nzUWDOVM/pw2LJW2CkTS/VGlsuKL7a/wAR2kug/uuimCA1Q32
         HgwG4xWcDsmEJR+ble0DJIG1uUz2i+7NPxViKNj317tolftomLc9GgeyOp+wF4jwXST5
         77D3uKt8AGIhcWDuVaqm0jEz2roBy9uahRB1y/XVbag26o9oYM/8J+xM+oz6nydGXr+t
         pnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aSbeaV8aUHmxt7bo4GWSO+UYVKMaQnwiL3Al5lNldQ=;
        b=SgaH3bPjnv0ItSdt0sW4AzqeN7wG23gsXvL1JPa5fKMMvAgXDwPtJItDKhxdp3nBcK
         EHqpFeAkM0SMfj8X08eXzK9ixdWQX7widu8RB4Q92W8j/8EIUypPqRSlxqMBWjA+mQY+
         2gOUT8JVL6zQg4LAY3t+4xLnXPnL5I0hHledlyHOmKUBKRLjTYJpjzjnxwkLCbBwl2Id
         rThVlqutiLbZhY2Cyrut3Tif0EBfBheJn1O4zL6AuYRx0YpHSlxSwMuPNC7GJr3H8qkF
         +CM1ezTHxI137xiHmNIwHaQCT3oByvWnCDsIg9vLMhB9uSN0SdNknx2JwmSGIiBkFGNg
         PLHQ==
X-Gm-Message-State: AOAM5330BoI5ueyqEQ/AoXL+Osjy+F92v72eP7Pl3hbphyMSnN5ZFpAo
        SbCSCjhYGkh+k0iHLids0hsA3W4A3LxaPA==
X-Google-Smtp-Source: ABdhPJwPwK7NzOQ+8JPE54/NQN+ICjYxw/HnFQKRFPpcepbDWgpCJTdLtF4EvXV6cS9U/jBPLs7Epw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr4585519wrr.11.1624367415446;
        Tue, 22 Jun 2021 06:10:15 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id r12sm14911926wrn.2.2021.06.22.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/17] staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
Date:   Tue, 22 Jun 2021 15:09:52 +0200
Message-Id: <8f6796cbbe726dd912fababe94b3dd1d8dcabbb7.1624367071.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
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

