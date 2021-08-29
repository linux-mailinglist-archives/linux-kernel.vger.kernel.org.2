Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2FB3FADB8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhH2SZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:25:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:63344 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhH2SZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:25:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="197736758"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="197736758"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 11:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="445519103"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2021 11:24:59 -0700
From:   rashmi.a@intel.com
To:     michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com
Subject: [PATCH v2 3/4] dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
Date:   Sun, 29 Aug 2021 23:54:42 +0530
Message-Id: <20210829182443.30802-4-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210829182443.30802-1-rashmi.a@intel.com>
References: <20210829182443.30802-1-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Binding description for Intel Thunder Bay eMMC PHY.
Added the newly introduced files into MAINTAINERS file-list

Signed-off-by: Rashmi A <rashmi.a@intel.com>
---
 .../phy/intel,phy-thunderbay-emmc.yaml        | 46 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml b/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
new file mode 100644
index 000000000000..34bdb5c4cae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,phy-thunderbay-emmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Thunder Bay eMMC PHY bindings
+
+maintainers:
+  - Srikandan Nandhini <nandhini.srikandan@intel.com>
+
+properties:
+  compatible:
+    const: intel,thunderbay-emmc-phy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: emmcclk
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+     mmc_phy@80440800 {
+     #phy-cells = <0x0>;
+     compatible = "intel,thunderbay-emmc-phy";
+     status = "okay";
+     reg = <0x80440800 0x100>;
+     clocks = <&emmc>;
+     clock-names = "emmcclk";
+     };
diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..44533319c900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9278,6 +9278,13 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
 F:	drivers/crypto/keembay/ocs-hcu.c
 F:	drivers/crypto/keembay/ocs-hcu.h
 
+INTEL THUNDER BAY EMMC PHY DRIVER
+M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
+M:	Rashmi A <rashmi.a@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
+F:	drivers/phy/intel/phy-intel-thunderbay-emmc.c
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

