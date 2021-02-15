Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5005531C06C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhBORYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhBOQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:21:10 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DAAC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:16:44 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id r77so6783825qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kj5RYWMStNtaZP0xbHAzdpdla7U4CbWpMCjfpqO3Muw=;
        b=Ro/tnvtkBFbFHRzdDRU/kYg/kM/nhwfgJ+U+9OlbaMxkSjiVfunT2tAAUSmHe+5FnI
         ISoIdoGYFxVo5b0H68oa4gLoEarvUKrNAg0f1MrAwdYS10EaeiDN+KOTZ+nXAJ8p2uZC
         4oaLhYwnrYUDYaN0tDq8RbEB4GuX34S5DC5j/BbQasPGoysPgPtIRsAboatOtDTTDPEX
         uVH6HbZELpPZ9UWTsco30tQuVNHYtV4dV03qIvFkUmAZQn72/PaIDeedIIq5giKndAZ7
         EF+bEOYVNHptG1mP5G+1Sz6B/+bTlv5mxhpCXQvC7CQR/smY9oH6LLF3jf07C4kc2KHC
         1Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kj5RYWMStNtaZP0xbHAzdpdla7U4CbWpMCjfpqO3Muw=;
        b=TWVzuweiNiRtAppaRjR2wGITpwLwi/hggnlGTJU0keLKLyEfBZxkodyAsRxeqUdbOs
         rO+E6Sl7nwT5PJtC1KE7+Xdj2G+ZqtcSlJ9h4ofsqyBT5Q9Y1aQoevFhrZDahxFYWoq9
         oU0aU425F5+V7ppkJwDuIel9bCVZbIv18Jl3mvW55bBBaHC94pbrbb9B3FmhlVCGQCg5
         RBD9AMDQaDu+p6TNFcwYpitWkOz3roynKIYLDdF2oDccyu8980UE95k7RjRxgvNmD1iV
         0vsb2wAE6KB0DyRRHMqRGtgqJUpLMku4aOg24mVAdygqPe+DapcQhsz8kK+BitwRbI2D
         /wHA==
X-Gm-Message-State: AOAM531eqx8n1uJ2LqqOa8gl1zkxczeEsLhm5Oi8Y+VLAQL/ngmJg/oC
        EJOeEH2aOMFnK7AAc59Hq/62cA==
X-Google-Smtp-Source: ABdhPJytoZNNizkftzSXutfU2BKPN7HNcFzzW4dr/jO9DQ7Kx907xNvWLMwq3O28SwjC799g+wisng==
X-Received: by 2002:a05:620a:102a:: with SMTP id a10mr15830136qkk.324.1613405803880;
        Mon, 15 Feb 2021 08:16:43 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id j124sm12225227qkf.113.2021.02.15.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:16:43 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8250: fix display nodes
Date:   Mon, 15 Feb 2021 11:15:34 -0500
Message-Id: <20210215161537.14696-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210215161537.14696-1-jonathan@marek.ca>
References: <20210215161537.14696-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply these fixes to the newly added sm8250 display ndoes
 - Use sm8250 compatibles instead of sdm845 compatibles
 - Remove "notused" interconnect (which apparently was blindly copied from
   my old patches)
 - Use dispcc node example from dt-bindings, removing clocks which aren't
   documented or used by the driver and fixing the region size.

Fixes: 7c1dffd471b1 ("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 33 ++++++++--------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 947e1accae3a..35f45f5e1c76 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2323,14 +2323,13 @@ usb_2_dwc3: dwc3@a800000 {
 		};
 
 		mdss: mdss@ae00000 {
-			compatible = "qcom,sdm845-mdss";
+			compatible = "qcom,sm8250-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
 			reg-names = "mdss";
 
-			interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_DISPLAY_CFG>,
-					<&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
+			interconnects = <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
 					<&mmss_noc MASTER_MDP_PORT1 &mc_virt SLAVE_EBI_CH0>;
-			interconnect-names = "notused", "mdp0-mem", "mdp1-mem";
+			interconnect-names = "mdp0-mem", "mdp1-mem";
 
 			power-domains = <&dispcc MDSS_GDSC>;
 
@@ -2356,7 +2355,7 @@ mdss: mdss@ae00000 {
 			ranges;
 
 			mdss_mdp: mdp@ae01000 {
-				compatible = "qcom,sdm845-dpu";
+				compatible = "qcom,sm8250-dpu";
 				reg = <0 0x0ae01000 0 0x8f000>,
 				      <0 0x0aeb0000 0 0x2008>;
 				reg-names = "mdp", "vbif";
@@ -2580,36 +2579,22 @@ opp-358000000 {
 
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8250-dispcc";
-			reg = <0 0x0af00000 0 0x20000>;
+			reg = <0 0x0af00000 0 0x10000>;
 			mmcx-supply = <&mmcx_reg>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&dsi0_phy 0>,
 				 <&dsi0_phy 1>,
 				 <&dsi1_phy 0>,
 				 <&dsi1_phy 1>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <&sleep_clk>;
+				 <&dp_phy 0>,
+				 <&dp_phy 1>;
 			clock-names = "bi_tcxo",
 				      "dsi0_phy_pll_out_byteclk",
 				      "dsi0_phy_pll_out_dsiclk",
 				      "dsi1_phy_pll_out_byteclk",
 				      "dsi1_phy_pll_out_dsiclk",
-				      "dp_link_clk_divsel_ten",
-				      "dp_vco_divided_clk_src_mux",
-				      "dptx1_phy_pll_link_clk",
-				      "dptx1_phy_pll_vco_div_clk",
-				      "dptx2_phy_pll_link_clk",
-				      "dptx2_phy_pll_vco_div_clk",
-				      "edp_phy_pll_link_clk",
-				      "edp_phy_pll_vco_div_clk",
-				      "sleep_clk";
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.26.1

