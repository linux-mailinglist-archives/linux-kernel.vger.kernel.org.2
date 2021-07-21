Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A743D0AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhGUIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237043AbhGUH74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:59:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BC6D6120D;
        Wed, 21 Jul 2021 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856759;
        bh=eT62F16m4fmnu9+ZtQ5I8OSRvrVJgO8LuBY471amLVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br++L+BMZpXlfIiTwaiiu5mB4JjjUqyv6G64sI0V1bbQyS9c+PeZ0m7ZhzDuddfcf
         w3au81XBOfLEPCPavw40MZC1PdGN922M25MJaMAvcw4w/3WoRxzPh0iVbbN4oAMebN
         bvwpBsPghVG1CtVYDrwfuNXJdeNwOyMCvQEmEdObHqx07TDW72HWe7vILxB9qrARCm
         d6P+AS3tsD3qBsyu1mfKn/vihaIU2hB/tQMVLU4htAVv3sVz4tbOP7uSrbnxciigJ6
         FUaKlhcQIweW7Aay5dm6UnwsNqO0BMHjNTozFZIFvwCvilYRnKBRBy7BEu4acJrYZx
         dzQzuwCB6hyKQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m67l5-0022de-GT; Wed, 21 Jul 2021 10:39:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
Date:   Wed, 21 Jul 2021 10:39:08 +0200
Message-Id: <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626855713.git.mchehab+huawei@kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
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
 .../phy/hisilicon,phy-hi3670-pcie.yaml        | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
new file mode 100644
index 000000000000..a5ea13332cac
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
@@ -0,0 +1,95 @@
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
+  reset-gpios:
+    description: PCI PERST reset GPIOs
+    maxItems: 4
+
+  clkreq-gpios:
+    description: Clock request GPIOs
+    maxItems: 3
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
+  - reset-gpios
+  - clkreq-gpios
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
+        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+                      <&gpio3 1 0 >, <&gpio27 4 0 >;
+        clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >, <&gpio17 0 0 >;
+        hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
+                                       0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
+      };
+    };
-- 
2.31.1

