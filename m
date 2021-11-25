Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87345E143
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356902AbhKYUFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbhKYUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:03:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F08AC061763
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d24so13993968wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODnVjpTLttRxb05aaD1tiJImMPR2M4ruN0kVPtiNAwg=;
        b=oq44UYjhCUqKbjpyqQrmPBV473RckuYm4ABcyk2rmk5elUP4yJvPHTtbv4rrAqYMvt
         XPA+VE/Gr9vsj6TgyCcQWMHdWmNdBIPttj6r1Ay8ioqpS8pJecACGhullNYES8UKqwBg
         Mk47BN0liyiIdxDE7iP3s5dG4jG0J47p1Cr+k/moCOK/4B1D9sMDNPFvjreAx/SZn9Pa
         k+hX5aUXA5ZwNOQNADTWa/vQ8iEMWeL+oxiyBCpJx1KLN1eznCQRqUTCgrfO4GGWjnns
         KMWT6pCc2Huos/cw9tzmWxtnqa4Ir2nzKPwkI7sowjfPYJi8WgnafKUPY8TbrJh2eTAD
         gegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODnVjpTLttRxb05aaD1tiJImMPR2M4ruN0kVPtiNAwg=;
        b=c/t8tGgn2RG0L87gr0rgGT/mLE7ePIZg3tqI/3WgEQzLFCx0iIP/Bk8y4KcH2ozs0F
         wUxwUzhB1uE2y6t+401EsVneHvMVPoAtLfdb0orgbwcujK1NcEeGJWsgfgYROk3gI1yy
         NflcR1znFbKmT5RuUtcPWLPB3veLewlCPimcR5FzqNNCwhZVpI50GOMHC1sOvYdq+orP
         JnL+35xkqaxCp2VpAJkPUsHEcWNNVNdbwo0SjcijwbXdbvFoT+zvS7h9PWA6vP+Gk4dm
         unNA78kzTPVjNK1cWxE5mGCuVobNeNqO1/4DRHPLjLMTo4+4ZcPgJZTG8z/2+MrB0Nyt
         IM4g==
X-Gm-Message-State: AOAM530SPl5pYMWnOPbWTKrazk0qesR/DKySJEQv4Gzqr6wODL21qz37
        NzSiQQaH3Dh8bfZ+HEyesOM=
X-Google-Smtp-Source: ABdhPJz+8Cjzvt0+IZhAoMtYNDgYheZj7U5yyvVSr5tyTGmgnTexg4MUuz6OgmhK1rUOmY6McaM9mw==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr9886807wrc.67.1637870393725;
        Thu, 25 Nov 2021 11:59:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id h13sm3762721wrx.82.2021.11.25.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:59:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove TxCount from getTxPowerIndex88E()
Date:   Thu, 25 Nov 2021 20:59:36 +0100
Message-Id: <20211125195936.10060-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125195936.10060-1-straube.linux@gmail.com>
References: <20211125195936.10060-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In getTxPowerIndex88E() the variable TxCount is set to RF_PATH_A and
never changed. Remove the unnecessary extra variable and replace its
usage with RF_PATH_A.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 7124b9880efa..73d5eb53a927 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -611,18 +611,17 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 {
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u8 index = (channel - 1);
-	u8 TxCount = RF_PATH_A;
 
 	/*  1. CCK */
-	cckPowerLevel[TxCount] = pHalData->Index24G_CCK_Base[TxCount][index];
+	cckPowerLevel[RF_PATH_A] = pHalData->Index24G_CCK_Base[RF_PATH_A][index];
 	/* 2. OFDM */
-	ofdmPowerLevel[TxCount] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-		pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
+	ofdmPowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+		pHalData->OFDM_24G_Diff[RF_PATH_A][RF_PATH_A];
 	/*  1. BW20 */
-	BW20PowerLevel[TxCount] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
-		pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
+	BW20PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+		pHalData->BW20_24G_Diff[RF_PATH_A][RF_PATH_A];
 	/* 2. BW40 */
-	BW40PowerLevel[TxCount] = pHalData->Index24G_BW40_Base[TxCount][index];
+	BW40PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index];
 }
 
 static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
-- 
2.33.1

