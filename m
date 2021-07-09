Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CEB3C2266
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGIKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhGIKoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA19613F0;
        Fri,  9 Jul 2021 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625827311;
        bh=m59H58S8c6uJmUxjlwS9k0tBdkqFiZIxmvII33/F3pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SslcZji14eYszw8cDvpsfM8KITDXGg+CWncX5fUuz0NXcIxEYebukwcpftPMSPKsi
         OJQaVqH/hzX9FY6T/BH1nwFf65zUpB4XhdGAnHLHCry2Vd0MUpEr1/gojp/fYU0Bpp
         zdy+HKeWUoFzTuf8FACkfnSKhZ9AQoDsAzssUP/baWB1xYx2RmDpPb6/W4zNnhcoCl
         bXDraS2bm3x4+0hDcMSKO6HmUzK/Dl5Rc1h7wimkUCTqWl5zfyuDha+8M8w2GRwTHi
         50EmuXR3PcvLwUpyjzjawpFPOqxkOOd1yOGnzUxJsYeMjdw+RN5ISbSVQtLQnV1LmA
         d4ApfW5g5CCwQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1nx7-00B5G4-LF; Fri, 09 Jul 2021 12:41:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v3 9/9] arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller hardware
Date:   Fri,  9 Jul 2021 12:41:45 +0200
Message-Id: <c5bcb6cc896a0d48ed53d243f6c4b1cc1e7ea235.1625826353.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625826353.git.mchehab+huawei@kernel.org>
References: <cover.1625826353.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add DTS bindings for the Hikey 970 board's PCIe hardware.

Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 72 +++++++++++++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 6476149d99e3..f54dab70f01b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
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
@@ -660,6 +666,72 @@ gpio28: gpio@fff1d000 {
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
+			reg-names = "phy";
+
+			phy-supply = <&ldo33>;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				      "pcie_apb_phy", "pcie_apb_sys",
+				      "pcie_aclk";
+
+			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+				      <&gpio3 1 0 >, <&gpio27 4 0 >;
+
+			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
+				       <&gpio17 0 0 >;
+
+			/* vboost iboost pre post main */
+			hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
+						       0xFFFFFFFF 0xFFFFFFFF
+						       0xFFFFFFFF>;
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
+			interrupts = <0 283 4>;
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
+		};
+
 		/* UFS */
 		ufs: ufs@ff3c0000 {
 			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 48c739eacba0..03452e627641 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -73,7 +73,6 @@ ldo33: LDO33 { /* PEX8606 */
 					regulator-name = "ldo33";
 					regulator-min-microvolt = <2500000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
 				};
 
 				ldo34: LDO34 { /* GPS AUX IN VDD */
-- 
2.31.1

