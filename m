Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81AC45E141
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356823AbhKYUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbhKYUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:03:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so13893799wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0/+FVbmz3ZoXYwB+U+QV/+unmh1ykLuUGfSEjydxaQ=;
        b=AgK40Tknb6IwT7M0ylBv9MCHjD/mkseQR8WFTvwiBpAQBK56u025zxD5FYE9szdWXk
         /c9gezlnKZhhKnTOF16jfOKyL81ByQognQUJaILorQ4gagLjr7PuM8w9tPwj8OeyyH6u
         Z4k9nyYWDyhjlJZWE77iTA1sOP6QP97AWLTL+YxbG4B8g/xfN9Ha+dkUsWEHyX0OKSK3
         ny50bXbMv9gRnepL+EIgelv5apTIGTYIBH3wG9gkfK8KaShJtDb/lZIu32NQl72uQB6s
         cnVOc/6Gjcgn8cGHgs+RrGwHz8r9KGNAeWuGbneSBl2nu3V6VVMFbN3wta5GOVQz+mdf
         aq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0/+FVbmz3ZoXYwB+U+QV/+unmh1ykLuUGfSEjydxaQ=;
        b=FGUexgZ8/eVDqNcci/QUuhTXxwCaW3Vmd6tFg2rl1M+fH9aGlx/NLOlDaCojFrcjgK
         9oX+BJGDpzsL3AXEkKD9WgG0sMWWu529T31x/e6b84WrRozN3t2mvkMbbh/lEGHt+o2F
         NQbhSH7+Zpr0tTluKUr6TcUtY5uC4MJ4j+ZGHhgfHUxWeGVsVqrL4IsJR2HpkUAE79oF
         0NzBKUhfBZ2F1h4VzdoW2JGqBTUFzUwIa1p4k1oafGsahD0JTyHmwJLKW7OEBnF/385+
         7K2sCBFRP48FoPfXDI5O+3QJN4naMKXmgR/ibPWM8Pde3HhdDKM9NBSD3pZkJDKK/KHE
         M/yg==
X-Gm-Message-State: AOAM5317zpMqweCnjKYA8bjhQYF1IFdVlVKdOOowgEv4ExcIkaEZgm3O
        Ea51n67Jf/bZt6bhbmKW05A=
X-Google-Smtp-Source: ABdhPJx0os0MQLQmHnSqWkYUBH/rMZMNuhpgSnVJ77ya9HoACudWqhnAr70TthZZZZ9s1f2bxCpVtg==
X-Received: by 2002:adf:f749:: with SMTP id z9mr9698775wrp.379.1637870390162;
        Thu, 25 Nov 2021 11:59:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id h13sm3762721wrx.82.2021.11.25.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:59:49 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
Date:   Thu, 25 Nov 2021 20:59:34 +0100
Message-Id: <20211125195936.10060-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125195936.10060-1-straube.linux@gmail.com>
References: <20211125195936.10060-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pHalData->rf_type is always RF_1T1R. Remove unnecessary checks and
related dead code from storePwrIndexDiffRateOffset().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 47402851700b..258349e6104f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -506,8 +506,7 @@ void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMa
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][4] = Data;
 	if (RegAddr == rTxAGC_A_Mcs15_Mcs12) {
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][5] = Data;
-		if (pHalData->rf_type == RF_1T1R)
-			pHalData->pwrGroupCnt++;
+		pHalData->pwrGroupCnt++;
 	}
 	if (RegAddr == rTxAGC_B_Rate18_06)
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][8] = Data;
@@ -523,11 +522,8 @@ void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMa
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][11] = Data;
 	if (RegAddr == rTxAGC_B_Mcs11_Mcs08)
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][12] = Data;
-	if (RegAddr == rTxAGC_B_Mcs15_Mcs12) {
+	if (RegAddr == rTxAGC_B_Mcs15_Mcs12)
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][13] = Data;
-		if (pHalData->rf_type != RF_1T1R)
-			pHalData->pwrGroupCnt++;
-	}
 }
 
 static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
-- 
2.33.1

