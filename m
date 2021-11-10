Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C044BF92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhKJLEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhKJLDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1506101pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbwxx26uDNHirCinQNPTtkR73Falpq6kV84mw3b4gxU=;
        b=CiBhkcMOkMYi3No6OK/yH20y8kyu27LK4Ih7rmhd657Sa0Dfp7lv1T9XO+wQxYk2s1
         HTDtlRGuvb4dR8jPsNqMiuCNQt4hZidfWUZT8Yfs47T0jZ+M1Mk+AK0SsWNV1OhxU2+4
         olIVs+kkWgORbpcI8/NtYUtPgugb79UD0HMCKxg4Qbbxgvg/LbxGtiP8Pfx2cMi32AS1
         0/TozZdkF+aYkIUtf+TEbaJzC6ZbzeoWCo9GAYCtcbyRQKqmW1VCLzqONwjLqVI7oOnk
         /mC3xM7dwa33rdplml64ouhLUujDZqRyDZ5OFgL29m/ctb6L2P3fVa0AN+0d2t+oKvkJ
         6afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbwxx26uDNHirCinQNPTtkR73Falpq6kV84mw3b4gxU=;
        b=A3Diq8uQ1Zepv5mke7VFn+0jlkA/zceX6XhSeLeQdsj8EYZZjS27muxpsMqFeXKr6v
         pOM7i6N2ckRvFJiSMnVAP043XCcpqJ3E8+NYajF1x4a1YBK1/uaQXv+230631BWVWkE1
         KM7swjsFL7FvCUtUUamw02u4FqphkOJ2ul0i7YJ/ClrFD/YwdufT0gGkI1WIGX7/q7XP
         UwXSaop2Goh0KyymP2dKSeJFCuT1F5K0QSIQrBJTFLAh6nx+hv2wJJ3p9y11LaxYROP4
         hDzEj/2wuoVFg1EJvU4BgYeV1wopukhKwhp2CSLETGL1cp2yoYFFOPWu0ZB3hqqSByNM
         kElw==
X-Gm-Message-State: AOAM532s/mxryTX+e4iZbRhmu1EqvWF4+U2SdpDeeSPuow1/xYppNXNy
        QTrVe396acIgE9LGX22W2/X4LA==
X-Google-Smtp-Source: ABdhPJx4fMgUFVQjw1MR6UEwOKaZ33xFJl3hfs2RwNICZF+dUyxrI5MshS62cr+NF5LOrPy31w92dQ==
X-Received: by 2002:a17:902:f2c2:b0:141:9ce8:930f with SMTP id h2-20020a170902f2c200b001419ce8930fmr14718759plc.68.1636542042702;
        Wed, 10 Nov 2021 03:00:42 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:42 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 12/22] arm64/dts: qcom: Use new compatibles for crypto nodes
Date:   Wed, 10 Nov 2021 16:29:12 +0530
Message-Id: <20211110105922.217895-13-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are using soc specific qce crypto IP compatibles
in the bindings now, use the same in the device tree files
which include the crypto nodes.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 933b56103a46..f477d026c949 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -204,7 +204,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq6018-qce";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				<&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 526087586ba4..8e7cbadff25a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2329,7 +2329,7 @@ cryptobam: dma-controller@1dc4000 {
 		};
 
 		crypto: crypto@1dfa000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,sdm845-qce";
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AXI_CLK>,
-- 
2.31.1

