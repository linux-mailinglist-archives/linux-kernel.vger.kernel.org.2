Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20483B82DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhF3NcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:32:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55689 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234806AbhF3NcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:32:16 -0400
X-UUID: 746b58de288542539fd2b4bf176f4276-20210630
X-UUID: 746b58de288542539fd2b4bf176f4276-20210630
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 991012664; Wed, 30 Jun 2021 21:29:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 21:29:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 21:29:41 +0800
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
Subject: [v11 01/19] dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock
Date:   Wed, 30 Jun 2021 21:27:46 +0800
Message-ID: <20210630132804.20436-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630132804.20436-1-chun-jie.chen@mediatek.com>
References: <20210630132804.20436-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation for system clock
and functional clock on Mediatek MT8192.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../arm/mediatek/mediatek,mt8192-clock.yaml   | 214 ++++++++++++++++++
 .../mediatek/mediatek,mt8192-sys-clock.yaml   |  64 ++++++
 2 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
new file mode 100644
index 000000000000..d60a8655ce9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
@@ -0,0 +1,214 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Functional Clock Controller for MT8192
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The Mediatek functional clock controller provides various clocks on MT8192.
+
+properties:
+  compatible:
+    - enum:
+      - mediatek,mt8192-scp_adsp
+      - mediatek,mt8192-imp_iic_wrap_c
+      - mediatek,mt8192-audsys
+      - mediatek,mt8192-imp_iic_wrap_e
+      - mediatek,mt8192-imp_iic_wrap_s
+      - mediatek,mt8192-imp_iic_wrap_ws
+      - mediatek,mt8192-imp_iic_wrap_w
+      - mediatek,mt8192-imp_iic_wrap_n
+      - mediatek,mt8192-msdc_top
+      - mediatek,mt8192-msdc
+      - mediatek,mt8192-mfgcfg
+      - mediatek,mt8192-mmsys
+      - mediatek,mt8192-imgsys
+      - mediatek,mt8192-imgsys2
+      - mediatek,mt8192-vdecsys_soc
+      - mediatek,mt8192-vdecsys
+      - mediatek,mt8192-vencsys
+      - mediatek,mt8192-camsys
+      - mediatek,mt8192-camsys_rawa
+      - mediatek,mt8192-camsys_rawb
+      - mediatek,mt8192-camsys_rawc
+      - mediatek,mt8192-ipesys
+      - mediatek,mt8192-mdpsys
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
+    scp_adsp: clock-controller@10720000 {
+        compatible = "mediatek,mt8192-scp_adsp";
+        reg = <0x10720000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_c: clock-controller@11007000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_c";
+        reg = <0x11007000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    audsys: clock-controller@11210000 {
+        compatible = "mediatek,mt8192-audsys";
+        reg = <0x11210000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_e: clock-controller@11cb1000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_e";
+        reg = <0x11cb1000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_s: clock-controller@11d03000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_s";
+        reg = <0x11d03000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_ws: clock-controller@11d23000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_ws";
+        reg = <0x11d23000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_w: clock-controller@11e01000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_w";
+        reg = <0x11e01000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imp_iic_wrap_n: clock-controller@11f02000 {
+        compatible = "mediatek,mt8192-imp_iic_wrap_n";
+        reg = <0x11f02000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    msdc_top: clock-controller@11f10000 {
+        compatible = "mediatek,mt8192-msdc_top";
+        reg = <0x11f10000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    msdc: clock-controller@11f60000 {
+        compatible = "mediatek,mt8192-msdc";
+        reg = <0x11f60000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mfgcfg: clock-controller@13fbf000 {
+        compatible = "mediatek,mt8192-mfgcfg";
+        reg = <0x13fbf000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mmsys: clock-controller@14000000 {
+        compatible = "mediatek,mt8192-mmsys";
+        reg = <0x14000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys: clock-controller@15020000 {
+        compatible = "mediatek,mt8192-imgsys";
+        reg = <0x15020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys2: clock-controller@15820000 {
+        compatible = "mediatek,mt8192-imgsys2";
+        reg = <0x15820000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys_soc: clock-controller@1600f000 {
+        compatible = "mediatek,mt8192-vdecsys_soc";
+        reg = <0x1600f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys: clock-controller@1602f000 {
+        compatible = "mediatek,mt8192-vdecsys";
+        reg = <0x1602f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vencsys: clock-controller@17000000 {
+        compatible = "mediatek,mt8192-vencsys";
+        reg = <0x17000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys: clock-controller@1a000000 {
+        compatible = "mediatek,mt8192-camsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawa: clock-controller@1a04f000 {
+        compatible = "mediatek,mt8192-camsys_rawa";
+        reg = <0x1a04f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawb: clock-controller@1a06f000 {
+        compatible = "mediatek,mt8192-camsys_rawb";
+        reg = <0x1a06f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawc: clock-controller@1a08f000 {
+        compatible = "mediatek,mt8192-camsys_rawc";
+        reg = <0x1a08f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    ipesys: clock-controller@1b000000 {
+        compatible = "mediatek,mt8192-ipesys";
+        reg = <0x1b000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mdpsys: clock-controller@1f000000 {
+        compatible = "mediatek,mt8192-mdpsys";
+        reg = <0x1f000000 0x1000>;
+        #clock-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
new file mode 100644
index 000000000000..ca9ac938f76c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-sys-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek System Clock Controller for MT8192
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The Mediatek system clock controller provides various clocks and system configuration
+  like reset and bus protection on MT8192.
+
+properties:
+  compatible:
+    - enum:
+      - mediatek,mt8192-topckgen
+      - mediatek,mt8192-infracfg
+      - mediatek,mt8192-pericfg
+      - mediatek,mt8192-apmixedsys
+    - const: syscon
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
+        compatible = "mediatek,mt8192-topckgen", "syscon";
+        reg = <0x10000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    infracfg: syscon@10001000 {
+        compatible = "mediatek,mt8192-infracfg", "syscon";
+        reg = <0x10001000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    pericfg: syscon@10003000 {
+        compatible = "mediatek,mt8192-pericfg", "syscon";
+        reg = <0x10003000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apmixedsys: syscon@1000c000 {
+        compatible = "mediatek,mt8192-apmixedsys", "syscon";
+        reg = <0x1000c000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

