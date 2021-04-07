Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0113561F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbhDGD3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:29:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32910 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348369AbhDGD3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:29:13 -0400
X-UUID: 7f0ae217743b49bebe40860bb5d80a16-20210407
X-UUID: 7f0ae217743b49bebe40860bb5d80a16-20210407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 732024585; Wed, 07 Apr 2021 11:29:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:52 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 4/8] dt-bindings: arm: mediatek: Add new document bindings for APU
Date:   Wed, 7 Apr 2021 11:28:02 +0800
Message-ID: <1617766086-5502-5-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D2EB6AFBFB83D479252FA785101F7A80CA89174F0CC42EEC7B63FDD3F9C9E1262000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the apusys bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../arm/mediatek/mediatek,apusys.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
new file mode 100644
index 000000000000..dc04a46f1bad
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
@@ -0,0 +1,56 @@
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
+          - mediatek,mt8192-apu_mbox
+          - mediatek,mt8192-apu_conn
+          - mediatek,mt8192-apu_vcore
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
+    apu_mbox: apu_mbox@19000000 {
+        compatible = "mediatek,mt8192-apu_mbox", "syscon";
+        reg = <0x19000000 0x1000>;
+    };
+
+  - |
+    apu_conn: apu_conn@19020000 {
+        compatible = "mediatek,mt8192-apu_conn", "syscon";
+        reg = <0x19020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apu_vcore: apu_vcore@19029000 {
+        compatible = "mediatek,mt8192-apu_vcore", "syscon";
+        reg = <0x19029000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

