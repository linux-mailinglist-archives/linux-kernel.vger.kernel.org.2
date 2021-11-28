Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C284607E3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358847AbhK1RPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358606AbhK1RNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE2C061758
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i12so12694355wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbQpxrlX3u2T8LjW6UHxKKJ6H/TsR/HXA2XP3vkB7hs=;
        b=RY7sbza6RseE4sGzdBTZUx9XUJjXYWZfY6zUtbZevL77CO4mMrHyASbg3MzD8vkFxx
         G6dpaxM3ddfy2j+NcJ18RECp/xX/MwMbPYe/+rgmX07NyPLM/75+twOEONcCR2EycGxj
         5awuRLsK1JQh0b2/X7A1OtaGqcKpOSDt6XnGVlJLkRnlXTQC18CI0AOZv0cACLyrNWho
         4Ejf0v2HGgIXHIThli52XZ423DSXqXI8PchuznrbGWfz4oKjLMx78K6iH5gIx2B1TZGh
         ZDuXUV8rGxUWrnHHIgJrnYTmlgI3C0wKMA0Ri76FX2AGpZ2Dir5CC3IYwl33gOiiPZjV
         VuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EbQpxrlX3u2T8LjW6UHxKKJ6H/TsR/HXA2XP3vkB7hs=;
        b=TDzucuDtLqi6a32giE8nx2OpwDqMUqyyXGYecMs1XHkCvPiuwVx6oPQtC2ceOaOJy6
         qfa3GUMncW4OpAhxX9uu4A59MhG0k3uBNm7h5psUhTkZQIbUltiR/vWGBPwq6vL2wQPh
         l266hk2l6vreJcprg5Rf6mO6DJAvaWJLm0yijH32u83t7Esl5UYNv+Z6C4hv/saShlud
         nqVG2V+LeVB2YXfNw+NgNLEPJn4yQgl1jMkNI+oRf8YtDavve8MjSEnPv0joSHPcQnVy
         ARSg8eIV+1IW30MTv5E88xaP7ACTzHimf8uYyVs2LfnHdMJY1NsA7GkixB3zhecqGx20
         sucw==
X-Gm-Message-State: AOAM530sByTJN108VKcgw1oE1OcOwvZhdgZjCRJk4c7KQTWmsItWFZ/t
        jqRxieV5Q3vmRkYQLOqyitR5Pb1jH9U=
X-Google-Smtp-Source: ABdhPJw+MTEnJEEQlP6qzJxBHrGZ4WcbDldQ2CFfioNNUCBWXiUllj+gsWsw+ioF84r/Cxhhsgb6vA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr30763305wmk.92.1638119391201;
        Sun, 28 Nov 2021 09:09:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 04/10] staging: r8188eu: remove rf_type from getTxPowerIndex88E()
Date:   Sun, 28 Nov 2021 18:09:18 +0100
Message-Id: <20211128170924.5874-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pHalData->rf_type is always RF_1T1R. As a result the variable
path_nums is always set to 1 and the for loop is entered only
once with TxCount = 0. Also RF_PATH_A = 0. Remove the unneeded
check for pHalData->rf_type and resulting dead code from
getTxPowerIndex88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 80 +++----------------
 1 file changed, 12 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 258349e6104f..7124b9880efa 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -611,74 +611,18 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 {
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u8 index = (channel - 1);
-	u8 TxCount = 0, path_nums;
-
-	if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
-		path_nums = 1;
-	else
-		path_nums = 2;
-
-	for (TxCount = 0; TxCount < path_nums; TxCount++) {
-		if (TxCount == RF_PATH_A) {
-			/*  1. CCK */
-			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
-			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-				pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
-			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-				pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
-			/* 2. BW40 */
-			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
-		} else if (TxCount == RF_PATH_B) {
-			/*  1. CCK */
-			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
-			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[TxCount][RF_PATH_A] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-			/* 2. BW40 */
-			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
-		} else if (TxCount == RF_PATH_C) {
-			/*  1. CCK */
-			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
-			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-			/* 2. BW40 */
-			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
-		} else if (TxCount == RF_PATH_D) {
-			/*  1. CCK */
-			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
-			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-
-			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
-			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
-			pHalData->BW20_24G_Diff[TxCount][index];
-
-			/* 2. BW40 */
-			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
-		}
-	}
+	u8 TxCount = RF_PATH_A;
+
+	/*  1. CCK */
+	cckPowerLevel[TxCount] = pHalData->Index24G_CCK_Base[TxCount][index];
+	/* 2. OFDM */
+	ofdmPowerLevel[TxCount] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+		pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
+	/*  1. BW20 */
+	BW20PowerLevel[TxCount] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+		pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
+	/* 2. BW40 */
+	BW40PowerLevel[TxCount] = pHalData->Index24G_BW40_Base[TxCount][index];
 }
 
 static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
-- 
2.34.0

