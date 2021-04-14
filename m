Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC035FA97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhDNSPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352468AbhDNSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49299C061347
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba6so24832695edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzsQ++5tggOH/lyoVRZjANgz+vVvSO5T9YRzCRDRV4k=;
        b=Oguy02argzP0OY63vLYHiwuzVKhU7VAGRl8tFcP/38mFmLLpDgxB+wIP2qWuc+gUBd
         LlR68ZrOfi5jdO1Mp8UjFYNC6m4r2r/+nEJo1rNzyUAfQatM3t4ENMqk7BczVEuCdpuD
         hjDSTHIJwuDJhVsCxDW/lNb47yeqoNWbkn67DexsFwftsniniVXACi6KpBNyr41rMsJ7
         eTWt5Iiv5kQtXatxJ1efGuIQdMfOOwO28k/uKFHEXS6qUwNs5I162MlSVdv6OZBTdaNs
         wwjXMUWufW22B2IaW3hNSFRnGLuiYjQZWHZx/ePgAIl0solvukh+8egZ7USLgD6ySx0Q
         0teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzsQ++5tggOH/lyoVRZjANgz+vVvSO5T9YRzCRDRV4k=;
        b=CvQjWWixtZt59i7mtld5B1lg98x3ultYHIPzrkgmj+0UsZR/7xvhb1CaYTDVn/QJc0
         Xf2IQCI/Eic/+NhD+AErw1CB+21f49mntM0LCt0FE7OSzDTg3dIZ8toR7vtSCw0+Gh6x
         HomcMHgc/kuVLFYl89rB7+JwnWKNZ36B7qBhWT3Ezd8cYz3HD/XXGvCuZRXezX76brPK
         eCssrx2m7p6AlgIb2ylzNeYmR4cco7G9EtDtIRv8ZIb3DNgOqMv3iCOXEUyNh0WM2E7b
         29r0F5hAdmniFDvHb91R4FhQldfOJSmw+3EKT0gBn6FFErnWpCXIqabhTKltO514ntYG
         NXWQ==
X-Gm-Message-State: AOAM5313GszgPSH9/5VkZZW2QzuU3GSJhPlVrjgwi/ZRl7oXjIKRpVm5
        yQAjZCU7m6MvM31EldiE5bnSXA==
X-Google-Smtp-Source: ABdhPJwt4k0Jy20LqyFC525+9zQaFI+Q10g56qWYsmqDCQsXKo1JIec1cgT4PZOBV+8oJ13yM5oJBQ==
X-Received: by 2002:a05:6402:b9b:: with SMTP id cf27mr216271edb.60.1618423936105;
        Wed, 14 Apr 2021 11:12:16 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 40/57] staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable and dead code
Date:   Wed, 14 Apr 2021 19:11:12 +0100
Message-Id: <20210414181129.1628598-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c: In function ‘odm_InbandNoise_Monitor_NSeries’:
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c:32:34: warning: variable ‘func_end’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Cesati <marcocesati@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index c3de123e2a487..e3b44481bd888 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -29,7 +29,7 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	u8 max_rf_path = 0, rf_path;
 	u8 reg_c50, reg_c58, valid_done = 0;
 	struct noise_level noise_data;
-	u32 start  = 0, func_start = 0, func_end = 0;
+	u32 start  = 0, func_start = 0;
 
 	func_start = jiffies;
 	pDM_Odm->noise_level.noise_all = 0;
@@ -150,12 +150,6 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	if (bPauseDIG)
 		odm_PauseDIG(pDM_Odm, ODM_RESUME_DIG, IGIValue);
 
-	func_end = jiffies_to_msecs(jiffies - func_start);
-	/* printk("%s noise_a = %d, noise_b = %d noise_all:%d (%d ms)\n", __func__, */
-	/* pDM_Odm->noise_level.noise[ODM_RF_PATH_A], */
-	/* pDM_Odm->noise_level.noise[ODM_RF_PATH_B], */
-	/* pDM_Odm->noise_level.noise_all, func_end); */
-
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_DebugControlInbandNoise_Nseries() <==\n"));
 	return pDM_Odm->noise_level.noise_all;
 
-- 
2.27.0

