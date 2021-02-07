Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60D03121F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBGGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 01:15:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51217 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229510AbhBGGPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 01:15:23 -0500
X-UUID: 0da339e9e67344f09bff9a3f937221a7-20210207
X-UUID: 0da339e9e67344f09bff9a3f937221a7-20210207
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 906172753; Sun, 07 Feb 2021 14:14:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 14:14:18 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 14:14:19 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 1/3] dt-bindings: regulator: document binding for MT6315 regulator
Date:   Sun, 7 Feb 2021 14:14:15 +0800
Message-ID: <1612678457-11548-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for MT6315 regulator driver.
Example bindings for MT6315 are added.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v3:
- correct the yaml file name.
- remove unused description.
- update the example.
---
 .../bindings/regulator/mt6315-regulator.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
new file mode 100644
index 000000000000..61dd5af80db6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mt6315-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6315 Regulator
+
+maintainers:
+  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
+
+description: |
+  The MT6315 is a power management IC (PMIC) configurable with SPMI.
+  that contains 4 BUCKs output which can combine with each other
+  by different efuse settings.
+
+properties:
+  compatible:
+    const: mediatek,mt6315-regulator
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: List of regulators and its properties
+
+    patternProperties:
+      "^vbuck[1-4]$":
+        type: object
+        $ref: "regulator.yaml#"
+
+        properties:
+          regulator-name:
+            pattern: "^vbuck[1-4]$"
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic@6 {
+      compatible = "mediatek,mt6315-regulator";
+      reg = <0x6 0>;
+
+      regulators {
+        vbuck1 {
+          regulator-compatible = "vbuck1";
+          regulator-min-microvolt = <300000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-enable-ramp-delay = <256>;
+          regulator-allowed-modes = <0 1 2 4>;
+        };
+
+        vbuck3 {
+          regulator-compatible = "vbuck3";
+          regulator-min-microvolt = <300000>;
+          regulator-max-microvolt = <1193750>;
+          regulator-enable-ramp-delay = <256>;
+          regulator-allowed-modes = <0 1 2 4>;
+        };
+      };
+    };
-- 
2.18.0

