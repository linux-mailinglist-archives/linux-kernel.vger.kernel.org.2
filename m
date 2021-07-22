Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6F3D1FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhGVIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:05:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49570 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhGVICd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:02:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 628301A0D2B;
        Thu, 22 Jul 2021 10:42:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0000D1A0CFF;
        Thu, 22 Jul 2021 10:42:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A1F90183AC72;
        Thu, 22 Jul 2021 16:42:54 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC 2/2] dt-bindings: PCI: imx6: remove fsl,imx6q-pcie.txt
Date:   Thu, 22 Jul 2021 16:22:35 +0800
Message-Id: <1626942155-9209-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
References: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,imx6q-pcie.txt to yaml. The properties defined
in fsl,imx6q-pcie.txt were converted to DT schema.
Remove fsl,imx6q-pcie.txt.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.txt           | 102 ------------------
 MAINTAINERS                                   |   1 -
 2 files changed, 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
deleted file mode 100644
index 9acd92c1ff5f..000000000000
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-* Freescale i.MX6 PCIe interface
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
-
-Required properties:
-- compatible:
-	- "fsl,imx6q-pcie"
-	- "fsl,imx6sx-pcie",
-	- "fsl,imx6qp-pcie"
-	- "fsl,imx7d-pcie"
-	- "fsl,imx8mq-pcie"
-- reg: base address and length of the PCIe controller
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-	- "msi": The interrupt that is asserted when an MSI is received
-- clock-names: Must include the following additional entries:
-	- "pcie_phy"
-
-Optional properties:
-- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
-- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
-- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
-- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
-  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
-  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
-  compliant clock generator should be used and configured.
-- phys: Phandle of the Generic PHY to the PCIe PHY.
-- phy-names:  MUST be "pcie-phy".
-- reset-gpio: Should specify the GPIO for controlling the PCI bus device reset
-  signal. It's not polarity aware and defaults to active-low reset sequence
-  (L=reset state, H=operation state).
-- reset-gpio-active-high: If present then the reset sequence using the GPIO
-  specified in the "reset-gpio" property is reversed (H=reset state,
-  L=operation state).
-- vpcie-supply: Should specify the regulator in charge of PCIe port power.
-  The regulator will be enabled when initializing the PCIe host and
-  disabled either as part of the init process or when shutting down the
-  host.
-- vph-supply: Should specify the regulator in charge of VPH one of the three
-  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
-  supplies.
-
-Additional required properties for imx6sx-pcie:
-- clock names: Must include the following additional entries:
-	- "pcie_inbound_axi"
-- power-domains: Must be set to phandles pointing to the DISPLAY and
-  PCIE_PHY power domains
-- power-domain-names: Must be "pcie", "pcie_phy"
-
-Additional required properties for imx7d-pcie and imx8mq-pcie:
-- power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
-- resets: Must contain phandles to PCIe-related reset lines exposed by SRC
-  IP block
-- reset-names: Must contain the following entries:
-	       - "pciephy"
-	       - "apps"
-	       - "turnoff"
-- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
-
-Additional required properties for imx8mq-pcie:
-- clock-names: Must include the following additional entries:
-	- "pcie_aux"
-
-Example:
-
-	pcie@01000000 {
-		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-		reg = <0x01ffc000 0x04000>,
-		      <0x01f00000 0x80000>;
-		reg-names = "dbi", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
-			  0x81000000 0 0          0x01f80000 0 0x00010000
-			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
-		num-lanes = <1>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
-		clock-names = "pcie", "pcie_bus", "pcie_phy";
-	};
-
-* Freescale i.MX7d PCIe PHY
-
-This is the PHY associated with the IMX7d PCIe controller.  It's used by the
-PCI-e controller via the fsl,imx7d-pcie-phy phandle.
-
-Required properties:
-- compatible:
-	- "fsl,imx7d-pcie-phy"
-- reg: base address and length of the PCIe PHY controller
diff --git a/MAINTAINERS b/MAINTAINERS
index a616e250d846..3cfa77b7ce6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14185,7 +14185,6 @@ M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 F:	drivers/pci/controller/dwc/*imx6*
 
-- 
2.17.1

