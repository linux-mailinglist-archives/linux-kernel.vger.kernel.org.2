Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853013C659A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhGLVtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhGLVtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD8D6127C;
        Mon, 12 Jul 2021 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126410;
        bh=se9640ubWAMBXq29BIJQe5nQYy9uHVZjbLlOIKUMhLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tzme3igZKEHLOMV16XBq5zEfe5uaV9zJg8ad1AC4ANtAgGWFpkw1J1/8N0gEIvr+C
         OikIXWexA9+NCAHmGXQACkyaVccJ44QpYcZAEJgdlBwApm9SwnJqforvwg/vbhRpYz
         MZAbRpSciphkIQGVT+7eW2NDVj1IFZMlw2o6TBM4U8mpiw1Haq6sTS1JJvoXYP9zRi
         88lvnPtzdVOLOmEuwZojHFJVXihvDbe11wFmLs26rLuN7+N8OJPEJcqal0ayaIPMra
         fzxmrJOSph0A8096yJv2FbYw8Z4aas6+rqXEir8OmX3ZBOwlnsA2MtJD9tQxZAAb5T
         ctwddhwIxi9pQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m33lI-005VRE-70; Mon, 12 Jul 2021 23:46:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 2/8] dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
Date:   Mon, 12 Jul 2021 23:46:40 +0200
Message-Id: <baa7e71e13953b28a11fffdcef35195099feb7fd.1626126198.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626126198.git.mchehab+huawei@kernel.org>
References: <cover.1626126198.git.mchehab+huawei@kernel.org>
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
 .../phy/hisilicon,phy-hi3670-pcie.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
new file mode 100644
index 000000000000..976ab6fe7b0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
@@ -0,0 +1,101 @@
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
+  reg-names:
+    const: phy
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
+      - const: pcie_phy_ref
+      - const: pcie_aux
+      - const: pcie_apb_phy
+      - const: pcie_apb_sys
+      - const: pcie_aclk
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
+  - reg-names
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
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pcie_phy: pcie-phy@fc000000 {
+        compatible = "hisilicon,hi970-pcie-phy";
+        reg = <0x0 0xfc000000 0x0 0x80000>;
+        reg-names = "phy";
+        #phy-cells = <0>;
+        phy-supply = <&ldo33>;
+        clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+                 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+                 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+        clock-names = "pcie_phy_ref", "pcie_aux",
+                      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
+        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+                      <&gpio3 1 0 >, <&gpio27 4 0 >;
+        clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >, <&gpio17 0 0 >;
+        hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
+                                       0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
+      };
+    };
+...
-- 
2.31.1

