Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29F3C65A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhGLVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhGLVtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7915261279;
        Mon, 12 Jul 2021 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126410;
        bh=beQ/nlrqcVJKSEttIL89uLGSbQ5pFqjunHiG0KZXdfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9tCIeZR1TuGdinDml4bYGTVruKMlEkbU693sBjXCW1de+8wp+0ufOzPDBVm8/ZNr
         qm8FNfqjGTElc9whDyUsXcp4LAEmmxcPfaOy+PlQE+fiWcfkuRrYixf8Z/Xg4Z1rXD
         RhAQnQOtM9prREugYkEd0Nd6BkCaktWukJcQ2aoRoFssSlgCJ/DAPIWMyRVnY0DnmN
         frk8fatnqCTsRvuUe5O2VCCT17yIL9v6YSJ/wpcHpewaWDZY/eW7kcPaxIbwkSn2q4
         zy40Un1TvkXmWkgY8V9xP0E1+BzW6l+WSrFGU1JF5F+nZ54Cmn8GeV4Efd1bTJyJ4A
         KJ5Ebu7Jd6lNg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m33lI-005VRB-5m; Mon, 12 Jul 2021 23:46:48 +0200
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
Subject: [PATCH v4 1/8] dt-bindings: phy: Add bindings for HiKey 960 PCIe PHY
Date:   Mon, 12 Jul 2021 23:46:39 +0200
Message-Id: <390e7fc0cd6fa4217f5d67c74f12ea101fab3f6d.1626126198.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626126198.git.mchehab+huawei@kernel.org>
References: <cover.1626126198.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for HiKey 960 (hi3660) PCIe PHY
interface, supported via the pcie-kirin driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../phy/hisilicon,phy-hi3660-pcie.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
new file mode 100644
index 000000000000..81c93e76cef4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3660-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Kirin960 PCIe PHY
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
+    description: PCI PERST reset GPIO
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
+    #include <dt-bindings/clock/hi3660-clock.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pcie_phy: pcie-phy@f3f2000 {
+        compatible = "hisilicon,hi960-pcie-phy";
+        reg = <0x0 0xf3f20000 0x0 0x40000>;
+        reg-names = "phy";
+        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+                 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+                 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+        clock-names = "pcie_phy_ref", "pcie_aux",
+                 "pcie_apb_phy", "pcie_apb_sys",
+                 "pcie_aclk";
+        reset-gpios = <&gpio11 1 0 >;
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.31.1

