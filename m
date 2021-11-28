Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78EB4607E2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358825AbhK1RPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358604AbhK1RNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E57C061757
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so31393894wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsFXfqAANuiI/h15io5hKx8qixy3sChbPkqfSorjFfM=;
        b=nS+ed+GE7CAqS29r3HgW/k9ZhQ/YL02pqe5nMkLQ4O420rIFqt5asIY2BepoGrc/Jc
         6ww0mWDmyW4c4JiCuPJiP66rlJZlMmkjKMJjgH/OldlkW5MnXwz5JdqKK2ji8euW+J8m
         0DYS4G31vQCJiACeDlFp54zEzCKRwzag6IrgauaAwq78dMUXgHa1+EGORh3/DjBnKJVo
         H6nlT5RwjQqeT3ZdEFQzWCjdMOyz7Oe/CCKa2zr5CCrbHnDqPxyuXbWrfxJJpUHrsPfQ
         xg54tbENOZ0eaxofr4fCJNy8efGpx/V1SDJJnDjkcC1HZ2rAbRQOWXt+Rapwr0i7n3ex
         si+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsFXfqAANuiI/h15io5hKx8qixy3sChbPkqfSorjFfM=;
        b=NWtOHl4bv5HQqm7nozdemdda8ZxrYwrfgLEeQUzqWf0xHVr5Krljnu7Yp5jc1exFR4
         v3LFwW7m6JwK1v0Z0dnXQyTCdJvvXaT8vuDMKsd71JQTLBgiaRikeudnNYgyCk2Y4767
         Pcwrlx7J2Y4FblpwGg5jq1yPJSXYClafpQWZfyDwO+v6nRj4rJET0ycsBuvRX8SYXqdm
         IWWx+9oDUzjqjrcxB2tCUeGZK8vs5A2hsgcGT+5fftCTZtcIJ7i7eqSS3Vo6+uA+lgKC
         LlmejKhJnn2pEGa1X6YprjZbbU5PvbrWqiH65YPTJkKv7BVt5ycEe5P+XrB6AjoElk40
         mpwA==
X-Gm-Message-State: AOAM530kijDdGM5yZNNrZUP8AhvvF+QNhUXfUL8IB4kUtCcBiez4IwbS
        cBzBU38oLbBuItRIcj/LTLvUVrnBb7c=
X-Google-Smtp-Source: ABdhPJxBwVT+V6r+ikDnYsUk7RgCvk8AbO9P6TfrZSvM7oYI5fkVBNXa24tXMWW2B9L09DXMtUQrcA==
X-Received: by 2002:a05:6000:cd:: with SMTP id q13mr28114184wrx.488.1638119390527;
        Sun, 28 Nov 2021 09:09:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/10] staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
Date:   Sun, 28 Nov 2021 18:09:17 +0100
Message-Id: <20211128170924.5874-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
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
2.34.0

