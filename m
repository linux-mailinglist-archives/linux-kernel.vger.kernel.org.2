Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7640A335
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhINCSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50530 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237242AbhINCSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:11 -0400
X-UUID: 3ee23014ce584708ba92ae2226e7a721-20210914
X-UUID: 3ee23014ce584708ba92ae2226e7a721-20210914
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 656889272; Tue, 14 Sep 2021 10:16:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:16:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:16:48 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v3 01/24] dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock
Date:   Tue, 14 Sep 2021 10:16:10 +0800
Message-ID: <20210914021633.26377-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation for system clock
and functional clock on Mediatek MT8195.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 254 ++++++++++++++++++
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |  73 +++++
 2 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
new file mode 100644
index 000000000000..17fcbb45d121
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -0,0 +1,254 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Functional Clock Controller for MT8195
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The clock architecture in Mediatek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The devices except apusys_pll provide clock gate control in different IP blocks.
+  The apusys_pll provides Plls which generated from SoC 26m for AI Processing Unit.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8195-scp_adsp
+          - mediatek,mt8195-imp_iic_wrap_s
+          - mediatek,mt8195-imp_iic_wrap_w
+          - mediatek,mt8195-mfgcfg
+          - mediatek,mt8195-vppsys0
+          - mediatek,mt8195-wpesys
+          - mediatek,mt8195-wpesys_vpp0
+          - mediatek,mt8195-wpesys_vpp1
+          - mediatek,mt8195-vppsys1
+          - mediatek,mt8195-imgsys
+          - mediatek,mt8195-imgsys1_dip_top
+          - mediatek,mt8195-imgsys1_dip_nr
+          - mediatek,mt8195-imgsys1_wpe
+          - mediatek,mt8195-ipesys
+          - mediatek,mt8195-camsys
+          - mediatek,mt8195-camsys_rawa
+          - mediatek,mt8195-camsys_yuva
+          - mediatek,mt8195-camsys_rawb
+          - mediatek,mt8195-camsys_yuvb
+          - mediatek,mt8195-camsys_mraw
+          - mediatek,mt8195-ccusys
+          - mediatek,mt8195-vdecsys_soc
+          - mediatek,mt8195-vdecsys
+          - mediatek,mt8195-vdecsys_core1
+          - mediatek,mt8195-vencsys
+          - mediatek,mt8195-vencsys_core1
+          - mediatek,mt8195-apusys_pll
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
+    scp_adsp: clock-controller@10720000 {
+        compatible = "mediatek,mt8195-scp_adsp";
+        reg = <0x10720000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_s: clock-controller@11d03000 {
+        compatible = "mediatek,mt8195-imp_iic_wrap_s";
+        reg = <0x11d03000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_w: clock-controller@11e05000 {
+        compatible = "mediatek,mt8195-imp_iic_wrap_w";
+        reg = <0x11e05000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mfgcfg: clock-controller@13fbf000 {
+        compatible = "mediatek,mt8195-mfgcfg";
+        reg = <0x13fbf000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vppsys0: clock-controller@14000000 {
+        compatible = "mediatek,mt8195-vppsys0";
+        reg = <0x14000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    wpesys: clock-controller@14e00000 {
+        compatible = "mediatek,mt8195-wpesys";
+        reg = <0x14e00000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    wpesys_vpp0: clock-controller@14e02000 {
+        compatible = "mediatek,mt8195-wpesys_vpp0";
+        reg = <0x14e02000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    wpesys_vpp1: clock-controller@14e03000 {
+        compatible = "mediatek,mt8195-wpesys_vpp1";
+        reg = <0x14e03000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vppsys1: clock-controller@14f00000 {
+        compatible = "mediatek,mt8195-vppsys1";
+        reg = <0x14f00000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys: clock-controller@15000000 {
+        compatible = "mediatek,mt8195-imgsys";
+        reg = <0x15000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys1_dip_top: clock-controller@15110000 {
+        compatible = "mediatek,mt8195-imgsys1_dip_top";
+        reg = <0x15110000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys1_dip_nr: clock-controller@15130000 {
+        compatible = "mediatek,mt8195-imgsys1_dip_nr";
+        reg = <0x15130000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys1_wpe: clock-controller@15220000 {
+        compatible = "mediatek,mt8195-imgsys1_wpe";
+        reg = <0x15220000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    ipesys: clock-controller@15330000 {
+        compatible = "mediatek,mt8195-ipesys";
+        reg = <0x15330000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys: clock-controller@16000000 {
+        compatible = "mediatek,mt8195-camsys";
+        reg = <0x16000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawa: clock-controller@1604f000 {
+        compatible = "mediatek,mt8195-camsys_rawa";
+        reg = <0x1604f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_yuva: clock-controller@1606f000 {
+        compatible = "mediatek,mt8195-camsys_yuva";
+        reg = <0x1606f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawb: clock-controller@1608f000 {
+        compatible = "mediatek,mt8195-camsys_rawb";
+        reg = <0x1608f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_yuvb: clock-controller@160af000 {
+        compatible = "mediatek,mt8195-camsys_yuvb";
+        reg = <0x160af000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_mraw: clock-controller@16140000 {
+        compatible = "mediatek,mt8195-camsys_mraw";
+        reg = <0x16140000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    ccusys: clock-controller@17200000 {
+        compatible = "mediatek,mt8195-ccusys";
+        reg = <0x17200000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys_soc: clock-controller@1800f000 {
+        compatible = "mediatek,mt8195-vdecsys_soc";
+        reg = <0x1800f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys: clock-controller@1802f000 {
+        compatible = "mediatek,mt8195-vdecsys";
+        reg = <0x1802f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys_core1: clock-controller@1803f000 {
+        compatible = "mediatek,mt8195-vdecsys_core1";
+        reg = <0x1803f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vencsys: clock-controller@1a000000 {
+        compatible = "mediatek,mt8195-vencsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vencsys_core1: clock-controller@1b000000 {
+        compatible = "mediatek,mt8195-vencsys_core1";
+        reg = <0x1b000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apusys_pll: clock-controller@190f3000 {
+        compatible = "mediatek,mt8195-apusys_pll";
+        reg = <0x190f3000 0x1000>;
+        #clock-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
new file mode 100644
index 000000000000..57a1503d95fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek System Clock Controller for MT8195
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The clock architecture in Mediatek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The apmixedsys provides most of PLLs which generated from SoC 26m.
+  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
+  The infracfg_ao and pericfg_ao provides clock gate in peripheral and infrastructure IP blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8195-topckgen
+          - mediatek,mt8195-infracfg_ao
+          - mediatek,mt8195-apmixedsys
+          - mediatek,mt8195-pericfg_ao
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
+    topckgen: syscon@10000000 {
+        compatible = "mediatek,mt8195-topckgen", "syscon";
+        reg = <0x10000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    infracfg_ao: syscon@10001000 {
+        compatible = "mediatek,mt8195-infracfg_ao", "syscon";
+        reg = <0x10001000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apmixedsys: syscon@1000c000 {
+        compatible = "mediatek,mt8195-apmixedsys", "syscon";
+        reg = <0x1000c000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    pericfg_ao: syscon@11003000 {
+        compatible = "mediatek,mt8195-pericfg_ao", "syscon";
+        reg = <0x11003000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

