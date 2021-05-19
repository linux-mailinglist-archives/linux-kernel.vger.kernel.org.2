Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25B389152
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354401AbhESOj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354323AbhESOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:39:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B62C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:38:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d78so9169384pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/W6azUUE1Twja3FY7bt61gqSPj92cSqiD8Un8maDnxA=;
        b=kCyBhJZGO6qUJrlRysy4+Nv4CLYlylZc3tBEI8W4U1wmH3c4bQXckCc3dnxJU+NfXM
         BfdBLML+2jRQsk7WbX8NvtyEOMFUbVswuY89ywECZWrUzmfTk9qhmt1uf5D6jcpufRXS
         yP9AFzCegCI6JG1SrOmPplG39WQ/edeAv/S6HT0M1Nglbcqk65abCVCFrMcHWw/83Har
         gqTrPFgc+JbKbrDf2mcgx2zCbMDDdBFPUb86BdY2y1tU/D1E9z9F3b3u7OjHBl0zJRcx
         Qh71OoJvzY7yItHn56MNpXTN86tYgAIq7n72SwydDlmTnbfDCxgx7AmKMgkcxh8r5+0j
         Qd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/W6azUUE1Twja3FY7bt61gqSPj92cSqiD8Un8maDnxA=;
        b=dRtjC8djBXfmlzLEYXM37/TqheXLqb5y8Wq1rf+x+A0WyyBo0yFkNQ+G8DcgbgM0P3
         PeOq+928iTJ0jLCTy9DF+K++WJhk3JGkRbjiNJLHXE9uzomMu7K1B1VfuvPcvG32Yoey
         2f+g4FBkRuXkh5aS6bxVZdTj12b1aZ/J/cMM6YcwvEumJ4OztIxkicnsYj0ZL6c8Bz5n
         GuFqCT7J3DqAVYSS1JvwQKN1afT84JviG0t9BuubcfyESkx80lEMdJMM0fX4ASC87gee
         RDkDMXKhXM8hJOZpL7YAYFEHGudtaGc1S6bpezQRDmiMqyGVgre7pFAOV6vY+l+XlBmd
         yd7g==
X-Gm-Message-State: AOAM532cvC4xVOZc1/Keyuu0otGfwYKwm/mYqYAJdVUxOOEQw3WkokqM
        jAeLvLgVwxr1XhzyZNFO8Eurvw==
X-Google-Smtp-Source: ABdhPJy3a7CdTIhSB/nQ28C7YaB8wfi/fMlYpHgg0TNVFLzqWwJOWMrMPmQnAruZ8wqIRwkrEOWHkQ==
X-Received: by 2002:aa7:91d4:0:b029:2c5:7d17:c20c with SMTP id z20-20020aa791d40000b02902c57d17c20cmr11250321pfa.4.1621435091682;
        Wed, 19 May 2021 07:38:11 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:11 -0700 (PDT)
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
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 07/17] arm64/dts: qcom: sdm845: Use RPMH_CE_CLK macro directly
Date:   Wed, 19 May 2021 20:06:50 +0530
Message-Id: <20210519143700.27392-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 3e482859f1ef ("dts: qcom: sdm845: Add dt entries
to support crypto engine."), we decided to use the value indicated
by constant RPMH_CE_CLK rather than using it directly.

Now that the same RPMH clock value might be used for other
SoCs (in addition to sdm845), let's use the constant
RPMH_CE_CLK to make sure that this dtsi is compatible with the
other qcom ones.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..2ec4be930fd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2316,7 +2316,7 @@ cryptobam: dma@1dc4000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0 0x01dc4000 0 0x24000>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rpmhcc 15>;
+			clocks = <&rpmhcc RPMH_CE_CLK>;
 			clock-names = "bam_clk";
 			#dma-cells = <1>;
 			qcom,ee = <0>;
@@ -2332,7 +2332,7 @@ crypto: crypto@1dfa000 {
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AHB_CLK>,
-				 <&rpmhcc 15>;
+				 <&rpmhcc RPMH_CE_CLK>;
 			clock-names = "iface", "bus", "core";
 			dmas = <&cryptobam 6>, <&cryptobam 7>;
 			dma-names = "rx", "tx";
-- 
2.31.1

