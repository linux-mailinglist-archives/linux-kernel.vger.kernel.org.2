Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDB438320
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJWKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 06:16:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230255AbhJWKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:16:35 -0400
X-UUID: 74f2f8acf60949d096959b675c76eeac-20211023
X-UUID: 74f2f8acf60949d096959b675c76eeac-20211023
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1807914588; Sat, 23 Oct 2021 18:14:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 23 Oct 2021 18:14:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Oct 2021 18:14:11 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Chun-Jie Chen" <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 3/7] dt-bindings: arm: mediatek: Add new document bindings for APU
Date:   Sat, 23 Oct 2021 18:13:30 +0800
Message-ID: <20211023101334.27686-4-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211023101334.27686-1-flora.fu@mediatek.com>
References: <20211023101334.27686-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the apusys bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../arm/mediatek/mediatek,apusys.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
new file mode 100644
index 000000000000..0f08a6c79f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,apusys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek APUSYS Controller
+
+maintainers:
+  - Flora Fu <flora.fu@mediatek.com>
+
+description:
+  The Mediatek apusys controller provides functional configurations and clocks
+  to the system.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-apu-conn
+          - mediatek,mt8192-apu-vcore
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    apu_conn: apu_conn@19020000 {
+        compatible = "mediatek,mt8192-apu-conn", "syscon";
+        reg = <0x19020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apu_vcore: apu_vcore@19029000 {
+        compatible = "mediatek,mt8192-apu-vcore", "syscon";
+        reg = <0x19029000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

