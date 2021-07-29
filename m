Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824873DA2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhG2L4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234979AbhG2L4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 694E460F23;
        Thu, 29 Jul 2021 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627559793;
        bh=nwAM8QY+x471etO2KMwuk1C3sqssSURF/22fBW46n34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1RRqz3l61jc4JsTWP6MVUXA145SzIrsQz1JKCkejGR7OpVABEEEDlYdGfJ9yLyGZ
         6JMIghimKn8VoOaggS5diNOzeTcwwOEhxlOoOf1PMY802Or9DAKjtYW+iKoowwZxWy
         pf8NEa/sglcvSPmKE8uD5FcsOYgR4Xk429yW0YPT3NXrzjxwkz2GsIylc5C6CFKOWa
         Ri0+dwH60UCkleoAlW60dn3CMdCOQl1hvLB0XqtxMlcbHhekC1jnZEUYcAGYNAdAlY
         iXgA/0nNtkwPb+TOSDiZ9CTwr8mmduk+q+Lfa5Bf/bCDr3moHGWQNCBO0KLxdyBan/
         KpcoNYNfXG7Jw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m94eN-004d28-Ec; Thu, 29 Jul 2021 13:56:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5/5] arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller hardware
Date:   Thu, 29 Jul 2021 13:56:28 +0200
Message-Id: <261a7accef272a1f5fc774e1e3c6e179dd16a85a.1627559126.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627559126.git.mchehab+huawei@kernel.org>
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add DTS bindings for the HiKey 970 board's PCIe hardware.

Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 99 +++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 20698cfd0637..2cf19c8960f3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -176,6 +176,12 @@ sctrl: sctrl@fff0a000 {
 			#clock-cells = <1>;
 		};
 
+		pmctrl: pmctrl@fff31000 {
+			compatible = "hisilicon,hi3670-pmctrl", "syscon";
+			reg = <0x0 0xfff31000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		iomcu: iomcu@ffd7e000 {
 			compatible = "hisilicon,hi3670-iomcu", "syscon";
 			reg = <0x0 0xffd7e000 0x0 0x1000>;
@@ -659,6 +665,99 @@ gpio28: gpio@fff1d000 {
 			clock-names = "apb_pclk";
 		};
 
+		its_pcie: interrupt-controller@f4000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xf5100000 0x0 0x100000>;
+		};
+
+		pcie_phy: pcie-phy@fc000000 {
+			compatible = "hisilicon,hi970-pcie-phy";
+			reg = <0x0 0xfc000000 0x0 0x80000>;
+
+			phy-supply = <&ldo33>;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+			clock-names = "phy_ref", "aux",
+				      "apb_phy", "apb_sys",
+				      "aclk";
+
+			/* vboost iboost pre post main */
+			hisilicon,eye-diagram-param = <0xffffffff 0xffffffff
+						       0xffffffff 0xffffffff
+						       0xffffffff>;
+
+			#phy-cells = <0>;
+		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin970-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000000>,
+			      <0x0 0xfc180000 0x0 0x1000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "config";
+			bus-range = <0x0  0x1>;
+			msi-parent = <&its_pcie>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			phys = <&pcie_phy>;
+			ranges = <0x02000000 0x0 0x00000000
+				  0x0 0xf6000000
+				  0x0 0x02000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0x0 0 0 1
+					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 2
+					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 3
+					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 4
+					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+			reset-gpios = <&gpio7 0 0 >;
+
+			pcie@4,0 { // Lane 4: M.2
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 1 0>;
+				clkreq-gpios = <&gpio27 3 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pcie@5,0 { // Lane 5: Mini PCIe
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 2 0>;
+				clkreq-gpios = <&gpio17 0 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pcie@7,0 { // Lane 7: Ethernet
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 3 0>;
+				clkreq-gpios = <&gpio20 0 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
 		/* UFS */
 		ufs: ufs@ff3c0000 {
 			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
-- 
2.31.1

