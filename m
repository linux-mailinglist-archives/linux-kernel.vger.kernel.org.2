Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0045035FAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbhDNSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352594AbhDNSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sd23so24168379ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JG8RadKIrihjyXFfRsCZD83eZb8bfn2gyhoNJUeR5Lo=;
        b=F0Si20U7EEaQfivV+4peCD2C/DkpStztQBp1+C9UUNcxJe/bTDRPtK0BxiI5CgQIiZ
         yRZT6i6btwKg5jBdsr7w0rxyPMXWTsAGJTbO1c75rsD1zpLuOSov+xNGDbnMJ6UBHri/
         8zJWrvj62kFIRBWxELsa8FWSpITH3+jLU8tk2H8PhgGpJS7sn5pvrbCmiiM6REVzbsu4
         xyMxyhiNHeyqhZ8dq+6BpreBXYOqrN79ineI/ym3AAnphR46IDgh5EmaICY0z4AaFm0O
         VHedOrSSi8K+j3HHh9tx6Cq7KdMqn7w7K0d7lBDWJktWJvV+CxDYxoRPqe/F7J9l5x2N
         Yg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JG8RadKIrihjyXFfRsCZD83eZb8bfn2gyhoNJUeR5Lo=;
        b=V7vbfWsh8X0rODshjPCb/bEP8ht8HPcPD+CNRB5iigjxNWH/+A2haOHSoSL4kVKW3b
         Pg1CHnZoEZ0ZfmxoyzVD7tTLIgzgVG0rntxT8Cig5FDsiKh3GetlT+7FOumx8j/HdTxK
         WPSYmTcW6X4WMuNN7pqE/G6ES+86Ifg3l0AISzxJhDzcsCJD8KXFKz9EDVkNGO7n5ZmM
         f/HqAl8mHMCKeZmq3iOibloxuZSE/mo+Zp7HoM0V8NFCAy7puqcJMPBf/lgzEl0wtrgK
         FpemzZuIP0Bxqc9322At0wLoBVJ5gBVLgFSn1LS3bPcrX/U2sM/A0GpwlKrJRaAoMnIV
         fLbg==
X-Gm-Message-State: AOAM530drLHsfdm5crP/vJ8Kz3lHj08SWHUVeCzXbv8hpdhg/BwcXygM
        uvqmhzl7EdwjpqxcUm/8bPqZ2BbHJ0cZNg==
X-Google-Smtp-Source: ABdhPJzYRHFxRK3BCTuHuYtNaQBngvugm7MSJGBmljuM4cPPYDW5aUCi74feGWXzVfHPYAG9G/lc8A==
X-Received: by 2002:a17:906:11d8:: with SMTP id o24mr156797eja.386.1618423949321;
        Wed, 14 Apr 2021 11:12:29 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 52/57] staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable 'func_start'
Date:   Wed, 14 Apr 2021 19:11:24 +0100
Message-Id: <20210414181129.1628598-53-lee.jones@linaro.org>
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
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c:32:18: warning: variable ‘func_start’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Cesati <marcocesati@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index e3b44481bd888..956e5a725a5d7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -29,9 +29,8 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	u8 max_rf_path = 0, rf_path;
 	u8 reg_c50, reg_c58, valid_done = 0;
 	struct noise_level noise_data;
-	u32 start  = 0, func_start = 0;
+	u32 start  = 0;
 
-	func_start = jiffies;
 	pDM_Odm->noise_level.noise_all = 0;
 
 	if ((pDM_Odm->RFType == ODM_1T2R) || (pDM_Odm->RFType == ODM_2T2R))
-- 
2.27.0

