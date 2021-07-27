Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052693D7F22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhG0UVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhG0UU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E70C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l17so290172ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Qkf7InvNZ2y8KQubxZPlzmD4hgwtxBXZ9UnPUjB8P4=;
        b=ign/rhc96Qnnkp6D5zFXQmhR7tkZ4dyjHrfgzUNShMys+7SM36ilKdyas/TK1Btrua
         McsFXa9dO2RJmY9Tm+pzPLunTtzZHjUPoDSCQvhAYqe+iTBSAr/dLLbuGglSf0cwmo1Y
         rJUK0EMD6PwZxJK90hGQXr1cfYoG6cLwhIkS2SYFvdn4AQcNVBMGfpCbXKuFJLxKFNpL
         WVG9TSUs4CKb7rTB2QbrjCcY6mVblNJw32WcpCwoR255DRWAsuRUrFexBKDALZ6LHIty
         TS2u8cuF6k8tNeoOO8hPOYi+sUXDsVGep/5FjFKdBjhrNu9/odQ5AK4b27qgluuzb3DL
         P3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Qkf7InvNZ2y8KQubxZPlzmD4hgwtxBXZ9UnPUjB8P4=;
        b=GfDzEXoEWx5gDg/ag8P0TqeDAa/Uvde7O8VyMY3ALnr6a60jAAISSaQVppuf8T7azZ
         rV0nc42v/lfgGUc7M93rkB3xd/RUSPgGXhbCDEwdFc4t+WRLKA/DFEdn8+WZK77EvVtV
         yStMZf56URpU2DPuTyWt3tBNt7111K8rrhVsFhZB4D74BpK1pwOAg5wGvgZUUoniC9i0
         3NDwMlKgRsH9iOeSGm2OYnSBuVl7grvVMC5ta7tYwuveXoZVo5KQPjuDBDd3qcBn4ncO
         8RDPTjZqgEsm2zfBe4+1BERi+cwGUtypz2qIpI2VrdcJnqMgukP8BLO0XcXTLB0ZVEQp
         Zupw==
X-Gm-Message-State: AOAM533avc7v8hd4yyfhReHsOR74kH9wNmvLjgQW5s5xUQuySYURfqCq
        SHmeIEmUMwAhjxGd6zzqrcl9Kw==
X-Google-Smtp-Source: ABdhPJx/v1ZPm5XrQBnsR5Cl9DHYR9hFszKJ2oYpF2UIOp5SGvsL1FqdXp/USPHXr3JxD9FgfztsPg==
X-Received: by 2002:a05:651c:124f:: with SMTP id h15mr16696819ljh.4.1627417222057;
        Tue, 27 Jul 2021 13:20:22 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:21 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] arm64: dts: qcom: sm8250: remove mmcx regulator
Date:   Tue, 27 Jul 2021 23:20:02 +0300
Message-Id: <20210727202004.712665-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch dispcc and videocc into using MMCX domain directly. Drop the now
unused mmcx regulator.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4798368b02ef..bce5e9a9dd84 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -273,13 +273,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
-	mmcx_reg: mmcx-reg {
-		compatible = "regulator-fixed-domain";
-		power-domains = <&rpmhpd SM8250_MMCX>;
-		required-opps = <&rpmhpd_opp_low_svs>;
-		regulator-name = "MMCX";
-	};
-
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
@@ -2451,7 +2444,7 @@ videocc: clock-controller@abf0000 {
 			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>;
-			mmcx-supply = <&mmcx_reg>;
+			power-domains = <&rpmhpd SM8250_MMCX>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2720,7 +2713,7 @@ opp-358000000 {
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8250-dispcc";
 			reg = <0 0x0af00000 0 0x10000>;
-			mmcx-supply = <&mmcx_reg>;
+			power-domains = <&rpmhpd SM8250_MMCX>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&dsi0_phy 0>,
 				 <&dsi0_phy 1>,
-- 
2.30.2

