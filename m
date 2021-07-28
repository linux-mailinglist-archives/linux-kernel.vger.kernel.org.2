Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D823D9878
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhG1W0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhG1W0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:26:01 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 15:25:59 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.174.neoplus.adsl.tpnet.pl [83.6.168.174])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 2B4D61FAEC;
        Thu, 29 Jul 2021 00:25:57 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/39] arm64: dts: qcom: sdm630: Add USB configuration
Date:   Thu, 29 Jul 2021 00:25:10 +0200
Message-Id: <20210728222542.54269-8-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728222542.54269-1-konrad.dybcio@somainline.org>
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will let us use USB2 on our devices. The SoC
supposedly supports USB3, but there are no known
cases of devices that actually have USB3 wired up in
hardware.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f4fb7b80dc24..35ed2e17f8b6 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -904,6 +904,70 @@ spmi_bus: spmi@800f000 {
 			cell-index = <0>;
 		};
 
+		usb3: usb@a8f8800 {
+			compatible = "qcom,sdm660-dwc3", "qcom,dwc3";
+			reg = <0x0a8f8800 0x400>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "bus",
+				      "mock_utmi", "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>,
+					  <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>,
+					       <19200000>;
+
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			power-domains = <&gcc USB_30_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
+
+			resets = <&gcc GCC_USB_30_BCR>;
+
+			usb3_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0x0a800000 0xc8d0>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+
+				/*
+				 * SDM630 technically supports USB3 but I
+				 * haven't seen any devices making use of it.
+				 */
+				maximum-speed = "high-speed";
+				phys = <&qusb2phy>;
+				phy-names = "usb2-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
+			};
+		};
+
+		qusb2phy: phy@c012000 {
+			compatible = "qcom,sdm660-qusb2-phy";
+			reg = <0x0c012000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2_hstx_trim>;
+			status = "disabled";
+		};
+
 		sdhc_1: sdhci@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
-- 
2.32.0

