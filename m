Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443C84607E4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358869AbhK1RPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358648AbhK1RNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4CC061759
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so31347011wrw.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxZ0KofGh2uxqP5kVqaEZl862FeeQxlLxUXNxJ6Ab/U=;
        b=U35qfvEj6qT6CoP6mXzGTvFmNIacPLYWKF9TPZBEdClMYKgorjKAgKikODiXskmAWI
         SRmqCRCWG4h95ccMe6hh0sHMjVx5JtQ4l+Cs+xaeFwSWwNaZBizFskuXAn46gWJQ4h99
         Phz3By7hhDD02X2scCRrhb5KabScmlRbILmmFmn3wH88kEYQJo29VFFFtHuYqZjvBgrO
         J7i2MsN/SsvtSk0XjCq/jD/k6SRyBMUNiOj3e8nncRZnw16sjNlqM1Xl5tOoUBrxzJIw
         h5VhySlkkk8mFyJua+LH2jFCzeMcpE9pfGg5lfPyqQk3s8HLQewtdbexQ3mAfU2/i5d+
         jtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxZ0KofGh2uxqP5kVqaEZl862FeeQxlLxUXNxJ6Ab/U=;
        b=ariJwK6/4Uz+Lfv3M+pIdU6MzkzvepuMfHRlVXg65vDyKV8xyDxeO9+CeUgMrmaZNJ
         J3gaYTj7jw5/86iKBPHgRRCDq3yqMkRabQBxcOR1IATMSBgbKVWh8IVrrQ6PVQIyci7i
         sB2lBDmhxmMJ2ai8s+VOlYflYbQAdnB3Ib0WzsGLi09STDE0ji+MHmCY7oiaXyTM+QCP
         oxbuG+svSxNF75mh9DrWT2HWoniPJxbKTmahuePQYrSJqSPuzCsf1Vo14AylsUEcLfxf
         avzNcfxmPzoBi6e4s8X7ad/S4YTDmulEuSn1kCmuGH+Eqc6ziVqSVAvYAC43PT5UnTAR
         A0ag==
X-Gm-Message-State: AOAM530DkBtzVnO3vKAHqjdC4XhcaQTeQ/0FWyjEb2COPePsxpOZFG2V
        Dl8BP0RM221VNumEx+cUi9Q=
X-Google-Smtp-Source: ABdhPJxYSFQ+DX7oFcEKXp61g2qW0la3h7bEUCH2k7ekca+y9t9Tu2Ym4rtQOxxx0KM0n0pSQyS8sA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr27945466wrl.24.1638119391842;
        Sun, 28 Nov 2021 09:09:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:51 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 05/10] staging: r8188eu: remove TxCount from getTxPowerIndex88E()
Date:   Sun, 28 Nov 2021 18:09:19 +0100
Message-Id: <20211128170924.5874-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
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
2.34.0

