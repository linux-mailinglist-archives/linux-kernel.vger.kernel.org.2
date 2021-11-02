Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E083C4425D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhKBDBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:01:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46270 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhKBDBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:01:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1927B1A0157;
        Tue,  2 Nov 2021 03:58:37 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D440F1A00FC;
        Tue,  2 Nov 2021 03:58:36 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 09505183ACCB;
        Tue,  2 Nov 2021 10:58:34 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy support
Date:   Tue,  2 Nov 2021 10:32:31 +0800
Message-Id: <1635820355-27009-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PCIe PHY support on iMX8MM platforms.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..0844f3144887 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1135,6 +1135,19 @@ usbmisc2: usbmisc@32e50200 {
 				reg = <0x32e50200 0x200>;
 			};
 
+			pcie_phy: pcie-phy@32f00000 {
+				compatible = "fsl,imx8mm-pcie-phy";
+				reg = <0x32f00000 0x10000>;
+				clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+				clock-names = "ref";
+				assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+				assigned-clock-rates = <100000000>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
+				resets = <&src IMX8MQ_RESET_PCIEPHY>;
+				reset-names = "pciephy";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		dma_apbh: dma-controller@33000000 {
-- 
2.25.1

