Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8843E2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJ1OA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:00:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42598 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231151AbhJ1OAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:00:13 -0400
X-UUID: 1464a5cd677e45688009f47e60029246-20211028
X-UUID: 1464a5cd677e45688009f47e60029246-20211028
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1669125369; Thu, 28 Oct 2021 21:57:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Oct 2021 21:57:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 28 Oct 2021 21:57:43 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 2/2] dt-bindings: dsp: mediatek: Add mt8195 DSP binding support
Date:   Thu, 28 Oct 2021 21:57:37 +0800
Message-ID: <20211028135737.8625-3-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211028135737.8625-1-yc.hung@mediatek.com>
References: <20211028135737.8625-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the mt8195 DSP device tree node.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
---
 .../bindings/dsp/mtk,mt8195-dsp.yaml          | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
new file mode 100644
index 000000000000..f113f71ca094
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mtk,mt8195-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek mt8195 DSP core
+
+maintainers:
+  - YC Hung <yc.hung@mediatek.com>
+
+description: |
+  Some boards from mt8195 contain a DSP core used for
+  advanced pre- and post- audio processing.
+properties:
+  compatible:
+    const: mediatek,mt8195-dsp
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: mux for audio dsp clock
+      - description: 26M clock
+      - description: mux for audio dsp local bus
+      - description: default audio dsp local bus clock source
+      - description: clock gate for audio dsp clock
+      - description: mux for audio dsp access external bus
+
+  clock-names:
+    items:
+      - const: adsp_sel
+      - const: clk26m_ck
+      - const: audio_local_bus
+      - const: mainpll_d7_d2
+      - const: scp_adsp_audiodsp
+      - const: audio_h
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    maxItems: 2
+
+  mbox-names:
+    description:
+      Specifies the mailboxes used to communicate with audio DSP
+    items:
+      - const: mbox0
+      - const: mbox1
+
+  memory-region:
+    description:
+      phandle to a node describing reserved memory (System RAM memory)
+      used by DSP (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 2
+
+  sound:
+    description:
+      Sound subnode includes ASoC platform, DPTx codec node, and
+      HDMI codec node.
+
+    type: object
+
+    properties:
+      mediatek,platform:
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        description: The phandle of MT8195 ASoC platform.
+
+      mediatek,dptx-codec:
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        description: The phandle of MT8195 Display Port Tx codec node.
+
+      mediatek,hdmi-codec:
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        description: The phandle of MT8195 HDMI codec node.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - memory-region
+  - power-domains
+  - mbox-names
+  - mboxes
+  - sound
+
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adsp: adsp@10803000 {
+       compatible =  "mediatek,mt8195-dsp";
+       reg = <0x10803000  0x1000>,
+             <0x10840000  0x40000>;
+       reg-names = "cfg", "sram";
+       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
+       interrupt-names = "wdt";
+       clocks = <&topckgen 10>, //CLK_TOP_ADSP
+                <&clk26m>,
+                <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
+                <&topckgen 136>, //CLK_TOP_MAINPLL_D7_D2
+                <&scp_adsp 0>, //CLK_SCP_ADSP_AUDIODSP
+                <&topckgen 34>; //CLK_TOP_AUDIO_H
+       clock-names = "adsp_sel",
+                     "clk26m_ck",
+                     "audio_local_bus",
+                     "mainpll_d7_d2",
+                     "scp_adsp_audiodsp",
+                     "audio_h";
+       memory-region = <&adsp_dma_mem_reserved>,
+                       <&adsp_mem_reserved>;
+       power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
+       mbox-names = "mbox0", "mbox1";
+       mboxes = <&adsp_mailbox 0>, <&adsp_mailbox 1>;
+       status = "disabled";
+       sound {
+              mediatek,dptx-codec = <&dp_tx>;
+              mediatek,hdmi-codec = <&hdmi0>;
+              mediatek,platform = <&afe>;
+             };
+       };
-- 
2.18.0

