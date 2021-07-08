Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1493C169F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhGHPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhGHPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99971616EA;
        Thu,  8 Jul 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625759423;
        bh=uCwa8ScPFO0U2r/s3wua3LONDVtbY/hwWP8xPNq4Iw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkAceOckiRR6IJtjS3hcBguwcAMkbGO+QQ46rN95bMUXVvPG3wtECROAM0q1CNJX8
         BQ9urF579EYmxkHJj0T5ozj8v51kCtFWUI0BJqwMlttanq4gdoyPZt05JkLrIGCOBQ
         MvN66bNxthL6I76HwPZJETb0i3gvwXCNDY8yMqi3Ha1Ka6xKGRIu9ud7fxbrbp7QnP
         JPULNG6V2G65oUc8z2n1B5WuCszlhh8C/K2MGFWtGEK4aBQncMiEocm9LPol2PrDrV
         8LKFTOu6KFNVbZ6lkkJIQ8epvrGqRpg6OFkYhnEHzFac6xTmlic0S99dQTGDQXP7KY
         aUsQy5w1QtxEQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1WI4-008VVF-Iy; Thu, 08 Jul 2021 17:50:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH RFC 5/7] bindings: phy: add bindings for Hikey 960 PCIe PHY
Date:   Thu,  8 Jul 2021 17:50:12 +0200
Message-Id: <28b9aa4d2d182d4705d7837c9165ae7b5bd8d141.1625758732.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625758732.git.mchehab+huawei@kernel.org>
References: <cover.1625758732.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for Hikey 960 (hi3660) PCIe PHY
interface, supported via the pcie-kirin driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../phy/hisilicon,phy-hi3660-pcie.yaml        | 70 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     | 11 +--
 2 files changed, 76 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
new file mode 100644
index 000000000000..e91a38450461
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3660-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Kirin960 PCIe PHY
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |+
+  Bindings for PCIe PHY on HiSilicon Kirin 960.
+
+properties:
+  compatible:
+    const: hisilicon,hi960-pcie-phy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+    description: PHY Control registers
+
+  reg-names:
+    const: phy
+
+  clocks:
+    items:
+      - description: PCIe PHY clock
+      - description: PCIe APB PHY clock
+
+  clock-names:
+    items:
+      - const: pcie_phy_ref
+      - const: pcie_apb_phy
+
+  reset-gpios:
+    description: PCI PERST reset GPIO(s)
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie_phy: pcie-phy@f3f2000 {
+        compatible = "hisilicon,hi960-pcie-phy";
+        reg = <0x0 0xf3f20000 0x0 0x40000>;
+        reg-names = "phy";
+        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>;
+        clock-names = "pcie_phy_ref", "pcie_apb_phy";
+        reset-gpios = <&gpio11 1 0 >;
+        #phy-cells = <0>;
+      };
+    };
+...
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3a589fa4ca81..96c978db12dc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1006,8 +1006,10 @@ pcie_phy: pcie-phy@f3f2000 {
 			reg = <0x0 0xf3f20000 0x0 0x40000>;
 			reg-names = "phy";
 			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
-				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>;
-			clock-names = "pcie_phy_ref", "pcie_apb_phy";
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_apb_phy",
+				      "pcie_aclk";
 			reset-gpios = <&gpio11 1 0 >;
 			#phy-cells = <0>;
 		};
@@ -1040,9 +1042,8 @@ &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 					<0x0 0 0 4
 					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
-				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
-				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
-			clock-names = "pcie_aux", "pcie_apb_sys", "pcie_aclk";
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>;
+			clock-names = "pcie_aux", "pcie_apb_sys";
 		};
 
 		/* UFS */
-- 
2.31.1

