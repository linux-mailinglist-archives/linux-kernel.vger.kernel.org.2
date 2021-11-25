Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320B445E142
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356866AbhKYUFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350098AbhKYUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:03:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC1C061761
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so13910146wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XIxFmbmWp8UNhN55bamLP0PSNC4syh5hVwDeqjzzjA=;
        b=SM2wHLNVQ56VRhmxfSVgSBsmH8aTHALI5IrHO/i0zkeap+3Pw0QqPNtrMai928eBdb
         eQzMxeLxFs5N0xIAn4AqQOVVR7GXtG9/HQY1G+IVNEC5Cr8Rvx6zamy3TfnPq3Mq4e6E
         f0n67reW+4jfyfW1xYjpcLtPqxIOu6YehSZZE8qtmBMdWXl91GUGXlbPo8LjFYi0jsT5
         bAHQeEe9vabXUysd8R+NwLoq1ARMhZRDm24QPakW/awzyzsodjSwqnf9C7Nq9ZLKLbVe
         gUVu+3H0y76fo//El3N6JB9Sm/i9sRa45YFPtDR5Suf7Sv2zMfKVK9G1MmgpI9CCzlfU
         63VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XIxFmbmWp8UNhN55bamLP0PSNC4syh5hVwDeqjzzjA=;
        b=Pc7BS71+1TD8sFhVfCx2XnyMTDyHmqy2pvyK7DUD/nQ1mdcYuGDNQqVrUuHoXwiqPh
         3jRsEmWkEmAk4If+gBsGLc6fToz+Sjtbf2eFgWXOs/nVrHR6+0Wcn0Xs6ZjZqtNrytSt
         eCpI0Jpzx3FAQKK492TLoyONy3CkmYgWoBDWEw3gjc/9D/cKJa7KOVaAqHnhuz9INi1d
         ByQYlWQwH3t/buDvKkVfZwOGtxl9fGixd2wbqXW/S4WG7dk0LEWVzJd9tLRlD/h72JOH
         cmHUhtfCFH89nJh+96xK8apnX1kGuwPQO7VcYGvOAFYYKn1j7dr2OA7GhowsSAFdbqt7
         c4HA==
X-Gm-Message-State: AOAM530qRLs6qtohkD9ZbEpsAySwbQOzBYwZqaXVBxelMbRuZ7+vZmIe
        EAuZ+/SV3s9tSrpHZ0v8+Fc=
X-Google-Smtp-Source: ABdhPJxmbEZ/C3mKh9MuRZ2lsFDqVBRuC2Hnbrm1HTBLS3bJFYxGbVQjMU9N65yM5pltsRcmNKx48g==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr9331658wrw.151.1637870390811;
        Thu, 25 Nov 2021 11:59:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id h13sm3762721wrx.82.2021.11.25.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:59:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove rf_type from getTxPowerIndex88E()
Date:   Thu, 25 Nov 2021 20:59:35 +0100
Message-Id: <20211125195936.10060-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125195936.10060-1-straube.linux@gmail.com>
References: <20211125195936.10060-1-straube.linux@gmail.com>
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
2.33.1

