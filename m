Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB85B333531
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhCJF0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhCJFZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:25:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D33C061762
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:25:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e6so10619548pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 21:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCnpcLpuqTdHmtaa7vEu9Tx55M7Ej3EbyXNq00c5adU=;
        b=sJR0eTnWGvsWHfKsGs1GxG5L1cwoqOeg3Yd0ioLF14Xa3dmshqNyd1Gl4BzpsteYUz
         DHpLTFAWqi5QMX8fFbywmvPnSZBQtkuHyoyvXfxDn0/JLUjpY6vYxSyHcrE7RqqfC804
         4WgBcuXlgH9BPCmvnFp8UKsJRVJLQQezriFNkQvo9y+Z+Zthu2nsTVZJeE9WNj8g6jA9
         cELC7WpcQnuQJFdOIm3iD8rOdfsdx46CY7iRF3/2Mee6KJyUU5S+fPq4MHxJk0eT2TDO
         lhJvDD6/zSv5yBOXG/fI4ppo/D0ryDRleseOhCQuueTh3ASNP/xDxukS+M77Mnbxb5No
         IAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCnpcLpuqTdHmtaa7vEu9Tx55M7Ej3EbyXNq00c5adU=;
        b=jpA3230bA8wtZ9dE2aLdGS5YP9nH7UwM08+921iNVuGXLMZslHaSoH4ppUIOAEMdi6
         LFGb2lQkPOUISv8RmOdzbbXMn2HI5eik479/IMB7jrmwGRn0EAj9mhn16PesCgd8lXWe
         f9dU8NnbpCumM2WBVmhMwbZ+oFIE69meG4EspDDMkYHcWuwAyNhYjt7JrDupYqYGsLYF
         1fv+VfqefXroiegdYClEGmPsMTHe6jH+Lk0bJBIyo5y2zyxKnSrbWMZGUdmC9AHR20w2
         /lD5RwZzL9XnWxDbYgpqm6YUqE/yG3YwSt6CSh8Bi2cQ6Uqiuf9CZw5oOzIe4eAEbpFP
         ZRLw==
X-Gm-Message-State: AOAM530XiarVg2XvNuejLeiK3owSzac+E68Us6efQ7EEXUBdnUEB2rkV
        av4MoWl/XtqHcj/5FxNjxciXWQ==
X-Google-Smtp-Source: ABdhPJzmRPeOWu16uPBVPML5utQZj0PB0c1OsJTfAdIhHMoFqp1dfNL6o3ViJOXYPndUKRT5BvtY4Q==
X-Received: by 2002:a65:6a44:: with SMTP id o4mr1313921pgu.312.1615353950393;
        Tue, 09 Mar 2021 21:25:50 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:9f4:a436:21bd:7573:25c0:73a0])
        by smtp.gmail.com with ESMTPSA id g7sm13915224pgb.10.2021.03.09.21.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 21:25:50 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 4/8] dt-bindings/clock: qcom: sm8250: Add gcc clocks for sm8250 crypto block
Date:   Wed, 10 Mar 2021 10:54:59 +0530
Message-Id: <20210310052503.3618486-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310052503.3618486-1-bhupesh.sharma@linaro.org>
References: <20210310052503.3618486-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the global clock controller (gcc) clocks required
by the sm8250 crypto block to function to the dt-binding header file
(namely: GCC_CE1_AHB_CLK, GCC_CE1_AXI_CLK and GCC_CE1_CLK).

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sm8250.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sm8250.h b/include/dt-bindings/clock/qcom,gcc-sm8250.h
index 7b7abe327e37..6c58320238c4 100644
--- a/include/dt-bindings/clock/qcom,gcc-sm8250.h
+++ b/include/dt-bindings/clock/qcom,gcc-sm8250.h
@@ -207,6 +207,9 @@
 #define GCC_VIDEO_AXI0_CLK					197
 #define GCC_VIDEO_AXI1_CLK					198
 #define GCC_VIDEO_XO_CLK					199
+#define GCC_CE1_AHB_CLK						200
+#define GCC_CE1_AXI_CLK						201
+#define GCC_CE1_CLK						202
 
 /* GCC resets */
 #define GCC_GPU_BCR						0
-- 
2.29.2

