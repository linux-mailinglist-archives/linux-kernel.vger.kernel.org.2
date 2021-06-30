Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4763B8331
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhF3Nee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbhF3Ne0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:34:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABCC061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:31:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w19so5130881lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3exyYm4G9uHzjfpwtNXEP0h5KI9rcHvoMctYz/watFE=;
        b=L0bxnSWjx3k3iWHrn61sHM9Ao+xJnFBhzKxTxMs4oPEPpU6an9QRCp05t7CY4Rk22g
         MERWCsq7FVxJ+JT7p5zFtOONn6DWoEQqmfvFtWAK1qwLV4Z1PRlTha2ru7BxI8Id+TnO
         SE+npLMoLOqk2ygjbaIt/2wW3JYldgRsciyVQIib8RjGOpzC57J6B0dqi2Dvq6EpApqd
         p3KtRHL4yE9cuUdtKHRSMDXHAc1Z4MsP176pFCLPp7Ol0g/PPW0W5MbNdAy1tNy8IjJF
         KHRTmhSY2oDbJhxr5rTvqYajttVapZW3yBgDbE6SSg5phUUABg3tokRffSUBmWZ7sSbL
         78Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3exyYm4G9uHzjfpwtNXEP0h5KI9rcHvoMctYz/watFE=;
        b=MEvOuYlqJNA8PURmE7NumucWjdFQ9x/8T4XUX8enzBhK9ynHuQab603A9yvE8UxhNG
         aPrIdTMeQilvOpm/s+98fMa6jzBdU02HxfKOLe0Y6Gq5d01pD21rGC3jM7LtXQrdpJOU
         +5S8jrtZzJuvz25UfRsc4ZtA/dYlpQrMlBQou24L3dS6JiI0kVh4wP8U3TTsNuHbiFet
         M+woMRx32Q0uePRv4hTXjgCLh5H1DD7TfN5qn+mkgAiHxOqWmvEsGxaf4GZG74OOoE5e
         KATi3tDAC3cixRPll1o2EajYRyGqxQXYbFJzgVi/EPw2+Eg8faLfSaGYL50OyioPixLL
         QtKQ==
X-Gm-Message-State: AOAM533CSSwu3g4KGZeWyiXsZGENWJr5Wl003Keh72u9Ik6QojpZigmE
        x7RwiULzjImGE1Z191PjJnvJww==
X-Google-Smtp-Source: ABdhPJwT2Y5p4mxOgC2/R7wN5wg2/5kjrxBtYFprHmU5KJtLYKUMICRVS0/0fA5/tHHA4UNRZXSVqw==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr2512957lfr.507.1625059915723;
        Wed, 30 Jun 2021 06:31:55 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x20sm1578098lfd.128.2021.06.30.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 06:31:55 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: qcom: sm8250: remove mmcx regulator
Date:   Wed, 30 Jun 2021 16:31:47 +0300
Message-Id: <20210630133149.3204290-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
References: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch dispcc and videocc into using MMCX domain directly. Drop the now
unused mmcx regulator.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4c0de12aaba6..1c8478d1247d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -271,13 +271,6 @@ memory@80000000 {
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
@@ -2362,7 +2355,8 @@ videocc: clock-controller@abf0000 {
 			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>;
-			mmcx-supply = <&mmcx_reg>;
+			power-domains = <&rpmhpd SM8250_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2627,7 +2621,8 @@ opp-358000000 {
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8250-dispcc";
 			reg = <0 0x0af00000 0 0x10000>;
-			mmcx-supply = <&mmcx_reg>;
+			power-domains = <&rpmhpd SM8250_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&dsi0_phy 0>,
 				 <&dsi0_phy 1>,
-- 
2.30.2

