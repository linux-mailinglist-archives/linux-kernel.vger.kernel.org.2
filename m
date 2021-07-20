Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D333CF3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhGTEnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:43:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:5616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236743AbhGTEm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:42:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211237199"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211237199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="496035635"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2021 22:22:58 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH V2 2/3] dt-bindings: arm: Add Thunder Bay bindings
Date:   Tue, 20 Jul 2021 10:52:48 +0530
Message-Id: <1626758569-27176-3-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
References: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Pan, Kris" <kris.pan@intel.com>

Document Intel Movidius SoC code-named Thunder Bay, along with the
Thunder Bay Full and Prime configuration board.

Add maintainers for the new Intel Movidius SoC code-named Thunder Bay.

Signed-off-by: Pan, Kris <kris.pan@intel.com>
Signed-off-by: Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
---
 .../devicetree/bindings/arm/intel,thunderbay.yaml   | 21 +++++++++++++++++++++
 MAINTAINERS                                         |  5 +++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,thunderbay.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
new file mode 100644
index 0000000..2b9d5f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/intel,thunderbay.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thunder Bay platform device tree bindings
+
+maintainers:
+  - Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - intel,thunderbay
+      - const: intel,thunderbay
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 503fd21..041f9a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1992,6 +1992,11 @@ S:	Maintained
 F:	arch/arm/mach-pxa/stargate2.c
 F:	drivers/pcmcia/pxa2xx_stargate2.c
 
+ARM/INTEL THUNDERBAY ARCHITECTURE
+M:	Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
+
 ARM/INTEL XSC3 (MANZANO) ARM CORE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4

