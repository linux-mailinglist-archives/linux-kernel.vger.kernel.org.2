Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008F3351213
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhDAJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhDAJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CDC06178C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so1161426eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHe1PdxpLWNY/oUwDctd3fxOVFZ+6y7BNO4mwEPdNFM=;
        b=Pi7Qs8CQmjoQQgZM22idpg99oqa+DTMDkHhsErdA2e1d0m62w7/M1r1qsU9qku/GXR
         DBvtvJUG0yRbl4AK8bgJTuos4dFyslWg3nrIOjR4o/Lfugl5G4FLBp4+LRzE3IFEfGth
         x+ZzmuIo8B+9ptre6s+DepV8ZgoNp/DsVsOa5MBXa+C+ZU756KbYYuMUBNTO5TJKn9Ix
         1NJePh3OJaLhkLKxxDOQd6nYpLiIIyX+Si6KUWF8f3GgUjNv5PD7e+jBShmvtwOAlIgi
         FSovI9y0X9P0ztEhP4nP7Rv2cp6i4oja9KbdbNOB683EPTEQzzGoUoENyjJ6Sqgv1As/
         2FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHe1PdxpLWNY/oUwDctd3fxOVFZ+6y7BNO4mwEPdNFM=;
        b=tH2WqQxxjEI2nf4dd+0H2VwgoWXxS0sUpBVHK3G82ZarqsxT69FDgSSF9yZacXYKRx
         3mEADm5mQS2qt1DVYHiWb3MDrnIiRVfOY2gz2sc4aA7Qla0tf4x31d+CRjy0tGkntGBZ
         ANsPIKdOxqnvD/UtAgsWt5hhJGHvZSqmzFgvnnVyDk4pTWufd5FIbTsFm92gfyaG7c0B
         056A5bSGmDkkUFVyr67JnubIudu/sXNMZJx9X5gumV+ChswwiSg1o4YVWMx4eyqrfaEU
         0UhrMZsXHEz+XZprUlTA2MJ//Lf5kcpcVUeQ23nBeCGD+W2x2k86GB2FFS+FtQyRxXdt
         dnow==
X-Gm-Message-State: AOAM533Bdw6ZHPR9DFtwTR8/ccVWoTAQKNQItjeZe1wedP1QD822v8cY
        2bnMxuo8Y48WYx4hSRWhu5k=
X-Google-Smtp-Source: ABdhPJy6ft7+i4r3fnb1Wh3YDVKm21FlQFQ2aCyy4G1fjdxfgPP5x3BxBPIsPDpspNnMTdpA1sTg0g==
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr9075349edc.210.1617268928211;
        Thu, 01 Apr 2021 02:22:08 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id q16sm3285610edv.61.2021.04.01.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 27/49] staging: rtl8723bs: remove empty #ifdef blocks in hal/rtl8723b_hal_init.c
Date:   Thu,  1 Apr 2021 11:20:57 +0200
Message-Id: <5a857cdd2707efd3213a9db8899afa711bb32d88.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty #ifdef blocks

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 20b66bf942e4..fbc6ef0cfe0c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2486,8 +2486,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
 				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
 			}
-#ifdef DEBUG
-#endif
 		}
 
 		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
@@ -2496,8 +2494,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 			pHalData->BW20_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW20_Diff[rfPath][TxCount];
 			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
 
-#ifdef DEBUG
-#endif
 		}
 	}
 
-- 
2.20.1

