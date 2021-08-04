Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DED3DFBF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhHDHTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235762AbhHDHTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:19:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 625E760F8F;
        Wed,  4 Aug 2021 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628061541;
        bh=+H9v5GjIE5Eik9iuQ3wu2uXDaeBxC37Uf+jlcQ4RMI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGAkVlwXXMuFhU087pFHbMBw4KFpyKBaasbiFJrwmlBUHwwtbt8vVD54/8XXLFT4m
         OqspaUAYPa8aRwF116gwclVXhsUWeKKacDsjRiF9c28u3q0ke5XhL3SdsR/E2BVbcu
         NQ+kgA6elxuh2wOkYhAZsMizK+BecFCQaIKiYmJn2VRzkt6kjmfFrCHV3QVxuu00Xw
         KLJ+otbB7D+OawqonSB1MhEdkFGGeR0q7oftvy7N6opvr92kB2AN8IqQfOXpJZdiVw
         FE/3lHwwss2FkYFcXqMMQ08bt8HcBxdk0oz+gqYwvx4VbKCYGZUoofbgSHUfbmOdJn
         WmlS6Y88evoYg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBBB5-000BlP-9c; Wed, 04 Aug 2021 09:18:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 4/4] dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
Date:   Wed,  4 Aug 2021 09:18:57 +0200
Message-Id: <461495431dd28ad2779658659f137db4bd747aa8.1628061310.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628061310.git.mchehab+huawei@kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for HiKey 970 (hi3670) PCIe PHY
interface, supported via the pcie-kirin driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../phy/hisilicon,phy-hi3670-pcie.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
new file mode 100644
index 000000000000..17367a0275fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3670-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Kirin970 PCIe PHY
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |+
+  Bindings for PCIe PHY on HiSilicon Kirin 970.
+
+properties:
+  compatible:
+    const: hisilicon,hi970-pcie-phy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+    description: PHY Control registers
+
+  phy-supply:
+    description: The PCIe PHY power supply
+
+  clocks:
+    items:
+      - description: PCIe PHY clock
+      - description: PCIe AUX clock
+      - description: PCIe APB PHY clock
+      - description: PCIe APB SYS clock
+      - description: PCIe ACLK clock
+
+  clock-names:
+    items:
+      - const: phy_ref
+      - const: aux
+      - const: apb_phy
+      - const: apb_sys
+      - const: aclk
+
+  hisilicon,eye-diagram-param:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Eye diagram for phy.
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - hisilicon,eye-diagram-param
+  - phy-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi3670-clock.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pcie_phy: pcie-phy@fc000000 {
+        compatible = "hisilicon,hi970-pcie-phy";
+        reg = <0x0 0xfc000000 0x0 0x80000>;
+        #phy-cells = <0>;
+        phy-supply = <&ldo33>;
+        clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+                 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+                 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+        clock-names = "phy_ref", "aux",
+                      "apb_phy", "apb_sys", "aclk";
+        hisilicon,eye-diagram-param = <0xffffffff 0xffffffff
+                                       0xffffffff 0xffffffff 0xffffffff>;
+      };
+    };
-- 
2.31.1

