Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7340D2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhIPF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:59:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:43524 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbhIPF7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:59:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="209583425"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="209583425"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 22:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="471234622"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2021 22:58:26 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: Add Thunder Bay bindings
Date:   Thu, 16 Sep 2021 11:28:17 +0530
Message-Id: <1631771898-18702-3-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
References: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>

Document Intel Movidius SoC code-named Thunder Bay, along with the
Thunder Bay Full and Prime configuration board.

Add maintainers for the new Intel Movidius SoC code-named Thunder Bay.

Signed-off-by: Kris, Pan <kris.pan@intel.com>
Signed-off-by: Kenchappa, Demakkanavar <kenchappa.demakkanavar@intel.com>
---
 .../devicetree/bindings/arm/intel,thunderbay.yaml  | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,thunderbay.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
new file mode 100644
index 0000000..50050f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/intel,thunderbay.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thunder Bay platform device tree bindings
+
+maintainers:
+  - Kenchappa, Demakkanavar <kenchappa.demakkanavar@intel.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - intel,thunderbay-s02
+          - intel,thunderbay-s03
+          - intel,thunderbay-s12
+          - intel,thunderbay-s13
+          - intel,thunderbay-full
+      - const: intel,thunderbay-hddl
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 503fd21..c32255e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1992,6 +1992,11 @@ S:	Maintained
 F:	arch/arm/mach-pxa/stargate2.c
 F:	drivers/pcmcia/pxa2xx_stargate2.c
 
+ARM/INTEL THUNDERBAY ARCHITECTURE
+M:	Kenchappa, Demakkanavar <kenchappa.demakkanavar@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
+
 ARM/INTEL XSC3 (MANZANO) ARM CORE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4

