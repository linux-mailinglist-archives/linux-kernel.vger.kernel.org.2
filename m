Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12B838C624
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhEUMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhEUMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:02:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60ADC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:00:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g18so13080139pfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKit9IhNnje4u7TM5jWeNBt4R4Vn/cra4nG2xzvb8rE=;
        b=H7ydYfvqb2QBTbICOM+wM1WoaTY7UAWGKW2ehZY8QGtueacpOSgxqMsNwUA/BidKo1
         gw8dCHmnRA0vjV4FWbJI1QAafzodt6z5Ii+9kleUUDzpu8CROEI85v4vPDdvOwAv+O4z
         wwU2VxlHq6en5m9b3NQLzsMunYO/SFjZ30OYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKit9IhNnje4u7TM5jWeNBt4R4Vn/cra4nG2xzvb8rE=;
        b=Rdq+GD3qq8XSwNO/zFiPi7dXQN473HWpnr/0zKY16YBsUXkr4iJP3ptfdfrRxCpMbz
         BkUBnFMGIf6AGlgSFGiwD0G2nrr/SsVfan+Wjm0fzSa8bM7LffO962mlvBUrV4TIUmfD
         0nQAdfVmrTG7nXuI28MaXh9Pr1yf/VIWKYtDxBJfOlzUat+/6STuCZOr6fJwwBq1X7cv
         U6wKAnOrn8fGkNa76ARlH07Ghw6T4IZ00mxIhc/T2+xmW4vaxWGSlTlvm0HzXLsoOIS7
         UWT9daNxJ8O7N9BclTKz8hfs/CBCGqE3cR7XnQ1hHrvS420NnH8B6M26ecFOSdWrQ7/Z
         LvrQ==
X-Gm-Message-State: AOAM531/dGp0pc2gQd6Xzvv10LNnjudyEpolBBlrjXJMGPmkFICT5Ts1
        ssOuP9jUC3OHsG6tzduLJFabQg==
X-Google-Smtp-Source: ABdhPJzl+MBeN4cfrorcKpDgECjxpGGvwdcbzjuMEb1xEYIHsqFmyeAsl+FYxQNIIG0QO73USrwnFw==
X-Received: by 2002:a63:9316:: with SMTP id b22mr9704917pge.70.1621598447240;
        Fri, 21 May 2021 05:00:47 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:95:4:4821:2312:cddc:dd0f])
        by smtp.gmail.com with ESMTPSA id 21sm4077399pfh.103.2021.05.21.05.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:00:46 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        hoegsberg@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hsinyi@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v14] arm64: dts: mt8183: Add node for the Mali GPU
Date:   Fri, 21 May 2021 20:00:41 +0800
Message-Id: <20210521200038.v14.1.I9f45f5c1f975422d58b5904d11546349e9ccdc94@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic GPU node for mt8183, as well as OPP table.

Note that with the current panfrost driver, devfreq is not
actually functional, as the we do not have platform-specific
support for >1 supplies. Also, we are missing code to handle
frequency change, as the GPU frequency needs to be switched
away to a stable 26Mhz clock during the transition.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
The binding we use with out-of-tree Mali drivers includes more
clocks, this is used for devfreq: the out-of-tree driver switches
clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
switches clk_mux back to clk_main_parent:
(see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
clocks =
        <&topckgen CLK_TOP_MFGPLL_CK>,
        <&topckgen CLK_TOP_MUX_MFG>,
        <&clk26m>,
        <&mfgcfg CLK_MFG_BG3D>;
clock-names =
        "clk_main_parent",
        "clk_mux",
        "clk_sub_parent",
        "subsys_mfg_cg";
(based on discussions, this probably belongs in the clock core)

This only matters for devfreq, that is disabled anyway as we don't
have platform-specific code to handle >1 supplies.

Changes in v14:
 - Move gpu_opp_table from soc to root "/" node of dts.

Changes in v12:
 - Add gpu node to mt8183-pumpkin.dts as well (Neil Armstrong).

Changes in v11:
 - mt8183*.dts: remove incorrect supply-names

Changes in v6:
 - Add gpu regulators to kukui dtsi as well.
 - Power domains are now attached to spm, not scpsys
 - Drop R-B.

Changes in v5:
 - Rename "2d" power domain to "core2" (keep R-B again).

Changes in v4:
 - Add power-domain-names to describe the 3 domains.
   (kept Alyssa's reviewed-by as the change is minor)

Changes in v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |   5 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index edff1e03e6fe..7bc0a6a7fadf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -42,6 +42,11 @@ &auxadc {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c_pins_0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..e4e54be1c2b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -279,6 +279,11 @@ dsi_out: endpoint {
 	};
 };
 
+&gpu {
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 0aff5eb52e88..ee912825cfc6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -68,6 +68,11 @@ &auxadc {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c_pins_0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c5e822b6b77a..0afd351f9a9b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -197,6 +197,91 @@ CLUSTER_SLEEP1: cluster-sleep-1 {
 		};
 	};
 
+	gpu_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <625000>, <850000>;
+		};
+
+		opp-320000000 {
+			opp-hz = /bits/ 64 <320000000>;
+			opp-microvolt = <631250>, <850000>;
+		};
+
+		opp-340000000 {
+			opp-hz = /bits/ 64 <340000000>;
+			opp-microvolt = <637500>, <850000>;
+		};
+
+		opp-360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <643750>, <850000>;
+		};
+
+		opp-380000000 {
+			opp-hz = /bits/ 64 <380000000>;
+			opp-microvolt = <650000>, <850000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <656250>, <850000>;
+		};
+
+		opp-420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <662500>, <850000>;
+		};
+
+		opp-460000000 {
+			opp-hz = /bits/ 64 <460000000>;
+			opp-microvolt = <675000>, <850000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <687500>, <850000>;
+		};
+
+		opp-540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <700000>, <850000>;
+		};
+
+		opp-580000000 {
+			opp-hz = /bits/ 64 <580000000>;
+			opp-microvolt = <712500>, <850000>;
+		};
+
+		opp-620000000 {
+			opp-hz = /bits/ 64 <620000000>;
+			opp-microvolt = <725000>, <850000>;
+		};
+
+		opp-653000000 {
+			opp-hz = /bits/ 64 <653000000>;
+			opp-microvolt = <743750>, <850000>;
+		};
+
+		opp-698000000 {
+			opp-hz = /bits/ 64 <698000000>;
+			opp-microvolt = <768750>, <868750>;
+		};
+
+		opp-743000000 {
+			opp-hz = /bits/ 64 <743000000>;
+			opp-microvolt = <793750>, <893750>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <825000>, <925000>;
+		};
+	};
+
 	pmu-a53 {
 		compatible = "arm,cortex-a53-pmu";
 		interrupt-parent = <&gic>;
@@ -1118,6 +1203,26 @@ mfgcfg: syscon@13000000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@13040000 {
+			compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
+			reg = <0 0x13040000 0 0x4000>;
+			interrupts =
+				<GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
+
+			power-domains =
+				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
+				<&spm MT8183_POWER_DOMAIN_MFG_CORE1>,
+				<&spm MT8183_POWER_DOMAIN_MFG_2D>;
+			power-domain-names = "core0", "core1", "core2";
+
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8183-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.31.1.818.g46aad6cb9e-goog

