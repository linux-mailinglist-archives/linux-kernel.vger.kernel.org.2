Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C63D0ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhGUIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237199AbhGUH77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:59:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73441611C1;
        Wed, 21 Jul 2021 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856759;
        bh=UiGm31iNvtZ99MxpzCURtzkORD4wRkDpyBs+z354Skc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtxQCWdBRZWDky07nm1s0kA3QWg+5PTN9Vz4d5pLJr49ovk8Vo5aGmd5khMIpyIvU
         PySZgKlEja2/mUSUBfdnJ39BoepAkiTcC52s660cFip94zJNELiSze44jbP/VGQgzC
         qYqgggffENGpn3sWUxNhDo6i7jqjEeLEO06JMEdpYsrjPuJZ0h41Bt7CWOLLYPCv3r
         FBYZ8sVSu4GW5SdSSZ+7HvTnDCfNKHECECTKgYXIYYEMu33DGQMgoPb66pyXKuArce
         P5UoxTRVtg+r0gwk2WhMjdkxf5KK6xO6CWrAoUs1hhUtXwz+cE981RBWZTcABNHgYL
         CbqyDSG3IhqvA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m67l5-0022dv-Om; Wed, 21 Jul 2021 10:39:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v7 10/10] phy-hi3670-pcie: Move reset-gpios to the PCIe DT schema
Date:   Wed, 21 Jul 2021 10:39:12 +0200
Message-Id: <25f0d338b301157d4b0fe8ab97db542635dff562.1626855713.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626855713.git.mchehab+huawei@kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY interface as found on HiKey 970 uses 4 reset-gpios
instead of just one. That seems to be due to electrical
requirements, as, on HiKey 970, the PERST# signal is
provided via one GPIO per connected/available PCIe device:

- GPIO 56 has a pullup logic from 1V8 to 2V5
  connected to a PCIe bridge chip (PEX 8606);
- GPIO 25 has a pullup logic from 1V8 to 3V3
  connected to the PERST# pin at the M.2 slot;
- GPIO 220 has a pullup logic from 1V8 to 3V3
  connected to the PERST# pin at the PCIe mini slot;
- GPIO 203 has a pullup logic from 1V8 to 3V3
  connected to the PERST# pin at the Ethernet chipset.

Originally, this was mapped via the PHY interface, but, as such
design may also be used with different hardware, remap this
to use the pcie-bus DT schema.

This patch depends on a DT schema patch submitted at:
	https://github.com/devicetree-org/dt-schema/pull/56

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../phy/hisilicon,phy-hi3670-pcie.yaml        |  7 ---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  5 +-
 drivers/phy/hisilicon/phy-hi3670-pcie.c       | 54 ++++++++++---------
 3 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
index a5ea13332cac..86767c53bc91 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
@@ -42,10 +42,6 @@ properties:
       - const: apb_sys
       - const: aclk
 
-  reset-gpios:
-    description: PCI PERST reset GPIOs
-    maxItems: 4
-
   clkreq-gpios:
     description: Clock request GPIOs
     maxItems: 3
@@ -60,7 +56,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - reset-gpios
   - clkreq-gpios
   - hisilicon,eye-diagram-param
   - phy-supply
@@ -86,8 +81,6 @@ examples:
                  <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
         clock-names = "phy_ref", "aux",
                       "apb_phy", "apb_sys", "aclk";
-        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
-                      <&gpio3 1 0 >, <&gpio27 4 0 >;
         clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >, <&gpio17 0 0 >;
         hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
                                        0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 6dfcfcfeedae..a07790c76b72 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -687,9 +687,6 @@ pcie_phy: pcie-phy@fc000000 {
 				      "apb_phy", "apb_sys",
 				      "aclk";
 
-			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
-				      <&gpio3 1 0 >, <&gpio27 4 0 >;
-
 			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
 				       <&gpio17 0 0 >;
 
@@ -729,6 +726,8 @@ &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
 					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 					<0x0 0 0 4
 					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+				      <&gpio3 1 0 >, <&gpio27 4 0 >;
 		};
 
 		/* UFS */
diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 0bc0203e9140..82cc5fc4eac2 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -553,11 +553,13 @@ static int hi3670_pcie_noc_power(struct hi3670_pcie_phy *phy, bool enable)
 	return 0;
 }
 
-static int hi3670_pcie_get_apb(struct hi3670_pcie_phy *phy)
+static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 {
 	struct device_node *pcie_port;
 	struct device *dev = phy->dev;
 	struct device *pcie_dev;
+	char name[32];
+	int i;
 
 	pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
 	if (!pcie_port) {
@@ -586,6 +588,27 @@ static int hi3670_pcie_get_apb(struct hi3670_pcie_phy *phy)
 		return -ENODEV;
 	}
 
+	/* perst reset gpios */
+	phy->n_gpio_resets = of_gpio_named_count(pcie_dev->of_node,
+						 "reset-gpios");
+	if (phy->n_gpio_resets > MAX_GPIO_RESETS) {
+		dev_err(dev, "Too many GPIO resets!\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < phy->n_gpio_resets; i++) {
+		phy->gpio_id_reset[i] = of_get_named_gpio(pcie_dev->of_node,
+							  "reset-gpios", i);
+		if (phy->gpio_id_reset[i] < 0)
+			return phy->gpio_id_reset[i];
+
+		sprintf(name, "pcie_perst_%d", i);
+
+		phy->reset_names[i] = devm_kstrdup_const(dev, name,
+							 GFP_KERNEL);
+		if (!phy->reset_names[i])
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -644,16 +667,17 @@ static int hi3670_pcie_phy_init(struct phy *generic_phy)
 	int ret;
 
 	/*
-	 * The code under hi3670_pcie_get_apb() need to access the
-	 * DWC APB registers. So, get them from
-	 * the pcie driver's regmap (see pcie-kirin regmap).
+	 * The code under hi3670_pcie_get_resources_from_pcie() need to
+	 * access the reset-gpios and the APB registers, both from the
+	 * pcie-kirin driver.
 	 *
+	 * The APB is obtained via the pcie driver's regmap
 	 * Such kind of resource can only be obtained during the PCIe
 	 * power_on sequence, as the code inside pcie-kirin needs to
 	 * be already probed, as it needs to register the APB regmap.
 	 */
 
-	ret = hi3670_pcie_get_apb(phy);
+	ret = hi3670_pcie_get_resources_from_pcie(phy);
 	if (ret)
 		return ret;
 
@@ -800,26 +824,6 @@ static int hi3670_pcie_phy_get_resources(struct hi3670_pcie_phy *phy,
 	if (IS_ERR(phy->base))
 		return PTR_ERR(phy->base);
 
-	/* perst reset gpios */
-	phy->n_gpio_resets = of_gpio_named_count(np, "reset-gpios");
-	if (phy->n_gpio_resets > MAX_GPIO_RESETS) {
-		dev_err(dev, "Too many GPIO resets!\n");
-		return -EINVAL;
-	}
-	for (i = 0; i < phy->n_gpio_resets; i++) {
-		phy->gpio_id_reset[i] = of_get_named_gpio(dev->of_node,
-							  "reset-gpios", i);
-		if (phy->gpio_id_reset[i] < 0)
-			return phy->gpio_id_reset[i];
-
-		sprintf(name, "pcie_perst_%d", i);
-
-		phy->reset_names[i] = devm_kstrdup_const(dev, name,
-							 GFP_KERNEL);
-		if (!phy->reset_names[i])
-			return -ENOMEM;
-	}
-
 	/* clock request gpios */
 	phy->n_gpio_clkreq = of_gpio_named_count(np, "clkreq-gpios");
 	if (phy->n_gpio_clkreq > MAX_GPIO_CLKREQ) {
-- 
2.31.1

