Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784A2361D77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbhDPJc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:32:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39475 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241822AbhDPJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:32:53 -0400
X-UUID: 56d9d2d805df476ebd285e5fa8ebc74b-20210416
X-UUID: 56d9d2d805df476ebd285e5fa8ebc74b-20210416
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 190938495; Fri, 16 Apr 2021 17:32:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 17:32:22 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 17:32:22 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: memory: Add binding for MediaTek DRAM Controller
Date:   Fri, 16 Apr 2021 17:32:15 +0800
Message-ID: <1618565538-6972-2-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation of the device-tree binding for
MediaTek DRAM Controller.

Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
---
 .../memory-controllers/mediatek,dramc.yaml         |  162 ++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
new file mode 100644
index 0000000..18f77c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2021 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/mediatek,dramc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek DRAM Controller
+
+maintainers:
+  - Po-Kai Chi <pk.chi@mediatek.com>
+
+description: |
+  MediaTek DRAM controller (DRAMC) provides an interface to query information
+  about DRAM which collected from bootloader and device tree.
+  This is mainly used by MediaTek Extended Memory Interface (EMI) and DVFS Resource
+  Control (DVFSRC).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt6779-dramc
+
+  reg:
+    description:
+      Base address of MediaTek DRAM related hardware modules, each channel has
+      its own base address in order of
+      DRAMC_AO_{CH}, DRAMC_NAO_{CH}, DDRPHY_AO_{CH}.
+    minItems: 3            # 3 * N channels
+    maxItems: 6
+
+  mediatek,dram-type:
+    description:
+      The DRAM type of current DRAM chip.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+
+  mediatek,support-channel-cnt:
+    description:
+      The maximum DRAM channel count supported by SoC.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  mediatek,channel-cnt:
+    description:
+      The DRAM channel count of current DRAM chip.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  mediatek,rank-cnt:
+    description:
+      The DRAM rank count of current DRAM chip.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 2
+
+  mediatek,rank-size:
+    description:
+      An array of 64-bits unsigned integer that describes the size of each
+      DRAM rank.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 1
+    maxItems: 2
+    items:
+      minimum: 0x0
+      maximum: 0x100000000    # support up to 4GB in single rank
+
+  mediatek,mr-cnt:
+    description:
+      Specifies how many sets of DRAM mode register information to provide.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 40    # total 40 MRs for JEDEC LPDDR4X
+
+  mediatek,mr:
+    description:
+      Pair of DRAM mode register information.
+      This property is filled in by bootloader according to the board hardware
+      configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    maxItems: 40    # align with mediatek,mr-cnt
+    items:
+      items:
+        - description:
+            Mode register index
+        - description:
+            Mode register value
+
+  mediatek,freq-cnt:
+    description:
+      Specifies how many sets of DRAM data clock rate supported by SoC.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mediatek,freq-step:
+    description:
+      The DRAM data clock rate may be slightly different from those defined
+      by the specification due to errors in multiples of the base frequency.
+      This describe the mapping from real data clock rate measured by
+      frequency meter to JEDEC data clock rate.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description:
+            Real data rate
+        - description:
+            Spec data rate
+
+required:
+  - compatible
+  - reg
+  - mediatek,dram-type
+  - mediatek,support-channel-cnt
+  - mediatek,channel-cnt
+  - mediatek,rank-cnt
+  - mediatek,mr-cnt
+  - mediatek,freq-cnt
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dramc@10230000 {
+            compatible = "mediatek,mt6779-dramc";
+            reg = <0 0x10230000 0 0x2000>, /* DRAMC AO CHA */
+                <0 0x10240000 0 0x2000>,   /* DRAMC AO CHB */
+                <0 0x10234000 0 0x1000>,   /* DRAMC NAO CHA */
+                <0 0x10244000 0 0x1000>,   /* DRAMC NAO CHB */
+                <0 0x10238000 0 0x2000>,   /* DDRPHY AO CHA */
+                <0 0x10248000 0 0x2000>;   /* DDRPHY AO CHB */
+            mediatek,dram-type = <0>;
+            mediatek,support-channel-cnt = <2>;
+            mediatek,channel-cnt = <2>;
+            mediatek,rank-cnt = <2>;
+            mediatek,rank-size = <0x40000000 0x40000000>;
+            mediatek,mr-cnt = <1>;
+            mediatek,mr = <0x5 0xff>;
+            mediatek,freq-cnt = <6>;
+            mediatek,freq-step = <3718 3733>,
+                    <3094 3200>,
+                    <2392 2400>,
+                    <1534 1600>,
+                    <1196 1200>,
+                    <754 800>;
+        };
+    };
-- 
1.7.9.5

