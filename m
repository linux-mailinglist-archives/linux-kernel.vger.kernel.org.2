Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F114253AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbhJGNIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:08:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35348 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233143AbhJGNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:08:51 -0400
X-UUID: fbc2f5d81ff347659b3219736ff982b2-20211007
X-UUID: fbc2f5d81ff347659b3219736ff982b2-20211007
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 693638722; Thu, 07 Oct 2021 21:06:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Oct 2021 21:06:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Oct
 2021 21:06:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 21:06:44 +0800
From:   Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH] dt-bindings: mediatek: add adsp-mbox document
Date:   Thu, 7 Oct 2021 21:06:41 +0800
Message-ID: <20211007130641.3589-1-Allen-KH.Cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds document for mediatek adsp mbox

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
---
 .../bindings/mailbox/mtk,adsp-mbox.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
new file mode 100644
index 000000000000..d45b93025428
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mtk,adsp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek ADSP mailbox
+
+maintainers:
+  - Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
+
+description: |
+  The MTK ADSP mailbox Inter-Processor Communication (IPC) enables the SoC
+  to ommunicate with ADSP by passing messages through two mailbox channels.
+  The MTK ADSP mailbox IPC also provides the ability for one processor to
+  signal the other processor using interrupts.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8195-adsp-mbox
+
+  "#mbox-cells":
+    const: 1
+
+  reg:
+    items:
+      - description: adsp mbox0 registers
+      - description: adsp mbox1 registers
+
+  reg-names:
+    items:
+      - const: reg_mbox0 
+      - const: reg_mbox1
+
+  interrupts:
+    items:
+      - description: adsp mbox0 interrupt
+      - description: adsp mbox1 interrupt
+
+  interrupt-names:
+    items:
+      - const: irq_mbox0 
+      - const: irq_mbox1
+
+required:
+  - compatible
+  - "#mbox-cells"
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    adsp_mailbox@adsp_mailbox@10816000 {
+        compatible = "mediatek,mt8195-adsp-mbox";
+        #mbox-cells = <1>;
+        reg = <0 0x10816000 0 0x1000>,
+              <0 0x10817000 0 0x1000>;
+        reg-names = "reg_mbox0", "reg_mbox1";
+        interrupts = <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH 0>,
+                 <GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "irq_mbox0", "irq_mbox0";
+    };
+
-- 
2.18.0

