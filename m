Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E893F94D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhH0HGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:06:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58744 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244262AbhH0HGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:06:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8BFC20103C;
        Fri, 27 Aug 2021 09:05:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F6A9201022;
        Fri, 27 Aug 2021 09:05:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B684183AD29;
        Fri, 27 Aug 2021 15:05:12 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 2/3] arm: dts: imx: fix the schema check errors
Date:   Fri, 27 Aug 2021 14:42:59 +0800
Message-Id: <1630046580-19282-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- ranges property should be grouped by region, with no functional
  changes. Otherwise, schema dtbs_check would report the following errors.
"linux-imx/arch/arm/boot/dts/imx6qp-vicutp.dt.yaml: pcie@1ffc000: ranges: 'oneOf' conditional failed, one must be fixed:
        linux-imx/arch/arm/boot/dts/imx6qp-vicutp.dt.yaml: pcie@1ffc000: ranges: 'oneOf' conditional failed, one must be fixed:
                [[2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640]] is not of type 'boolean'
                True was expected
                [[2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640]] is not of type 'null'
        [2164260864, 0, 0, 33030144, 0, 65536, 2181038080, 0, 16777216, 16777216, 0, 15728640] is too long
        From schema: linux-imx/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml"
- refer to commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows").
  The num-viewport is not required anymore, remove them totally.
- dt_binding_check complains "compatible: ['fsl,imx6qp-pcie', 'snps,dw-pcie']
  is too long", remove "snps,dw-pcie" from the compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++----
 arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 arch/arm/boot/dts/imx7d.dtsi   | 7 +++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 82e01ce026ea..d5477406401a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -264,7 +264,7 @@ L2: cache-controller@a02000 {
 		};
 
 		pcie: pcie@1ffc000 {
-			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
+			compatible = "fsl,imx6q-pcie";
 			reg = <0x01ffc000 0x04000>,
 			      <0x01f00000 0x80000>;
 			reg-names = "dbi", "config";
@@ -272,10 +272,9 @@ pcie: pcie@1ffc000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
-				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			num-viewport = <4>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index b310f13a53f2..050365513836 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -110,5 +110,5 @@ &mmdc0 {
 };
 
 &pcie {
-	compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+	compatible = "fsl,imx6qp-pcie";
 };
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8516730778df..fc6334336b3d 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1395,15 +1395,15 @@ pwm8: pwm@22b0000 {
 		};
 
 		pcie: pcie@8ffc000 {
-			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
+			compatible = "fsl,imx6sx-pcie";
 			reg = <0x08ffc000 0x04000>, <0x08f00000 0x80000>;
 			reg-names = "dbi", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b0bcfa9094a3..b7735979b7e4 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -164,7 +164,7 @@ fec2: ethernet@30bf0000 {
 	};
 
 	pcie: pcie@33800000 {
-		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
+		compatible = "fsl,imx7d-pcie";
 		reg = <0x33800000 0x4000>,
 		      <0x4ff00000 0x80000>;
 		reg-names = "dbi", "config";
@@ -172,10 +172,9 @@ pcie: pcie@33800000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		bus-range = <0x00 0xff>;
-		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
+		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000>, /* downstream I/O */
+			 <0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
 		num-lanes = <1>;
-		num-viewport = <4>;
 		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-- 
2.25.1

