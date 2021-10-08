Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D086C426618
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhJHImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:42:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45680 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236195AbhJHImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:42:32 -0400
X-UUID: 640cd50e4be74a288750845f5a7eac3d-20211008
X-UUID: 640cd50e4be74a288750845f5a7eac3d-20211008
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1160262783; Fri, 08 Oct 2021 16:40:34 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 16:40:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Oct
 2021 16:40:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Oct 2021 16:40:32 +0800
From:   Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH v2] dt-bindings: mediatek: add adsp-mbox document
Date:   Fri, 8 Oct 2021 16:40:30 +0800
Message-ID: <20211008084030.2439-1-Allen-KH.Cheng@mediatek.com>
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
 .../bindings/mailbox/mtk,adsp-mbox.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
new file mode 100644
index 000000000000..9028e403ceda
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
@@ -0,0 +1,76 @@
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
+  mbox0 is handling ipc reply
+  mbox1 is handling ipc request
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
+    description: 
+      Physical address base for dsp mbox base registers.
+    maxItems: 2
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: reg_mbox0 
+      - const: reg_mbox1
+
+  interrupts:
+    description: 
+      adsp mbox interrupt
+    maxItems: 2
+    minItems: 2
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
+    adsp_mailbox:adsp_mailbox@10816000 {
+        compatible = "mediatek,mt8195-adsp-mbox";
+        #mbox-cells = <1>;
+        reg = <0x10816000 0x1000>,
+              <0x10817000 0x1000>;
+        reg-names = "reg_mbox0", "reg_mbox1";
+        interrupts = <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "irq_mbox0", "irq_mbox1";
+    };
+
-- 
2.18.0

