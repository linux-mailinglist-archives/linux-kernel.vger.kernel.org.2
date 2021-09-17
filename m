Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2A40EFDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhIQCz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:55:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45028 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242330AbhIQCzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:55:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 586942012E9;
        Fri, 17 Sep 2021 04:54:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20B642012A5;
        Fri, 17 Sep 2021 04:54:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 80ED5183AD0B;
        Fri, 17 Sep 2021 10:54:27 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 3/4] arm64: dts: imx8mm: add the pcie phy support
Date:   Fri, 17 Sep 2021 10:31:02 +0800
Message-Id: <1631845863-24249-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PCIe PHY support on iMX8MM platforms.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  4 ++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e033d0257b5a..e7f398433486 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -289,6 +289,10 @@ pca6416: gpio@20 {
 	};
 };
 
+&pcie_phy {
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3b8390..de231d531ba4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -998,6 +998,18 @@ usbmisc2: usbmisc@32e50200 {
 				reg = <0x32e50200 0x200>;
 			};
 
+			pcie_phy: pcie-phy@32f00000 {
+				compatible = "fsl,imx8mm-pcie-phy";
+				reg = <0x32f00000 0x10000>;
+				clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+				clock-names = "phy";
+				assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+				assigned-clock-rates = <100000000>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
+				#phy-cells = <0>;
+				fsl,refclk-pad-mode = <1>;
+				status = "disabled";
+			};
 		};
 
 		dma_apbh: dma-controller@33000000 {
-- 
2.25.1

