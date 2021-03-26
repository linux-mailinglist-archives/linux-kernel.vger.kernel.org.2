Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD85434A28E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCZHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:34:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36124 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230006AbhCZHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:33:43 -0400
X-UUID: 7b2b6fd4dfcc4c9bb225866e54b9e144-20210326
X-UUID: 7b2b6fd4dfcc4c9bb225866e54b9e144-20210326
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 467795610; Fri, 26 Mar 2021 15:33:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 15:33:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 15:33:19 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nina Wu <Nina-CM.Wu@mediatek.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: devapc: Update bindings
Date:   Fri, 26 Mar 2021 15:31:10 +0800
Message-ID: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

To support newer hardware architecture of devapc,
update device tree bindings.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/devapc.yaml   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
index 31e4d3c..489f6a9 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
@@ -20,9 +20,27 @@ properties:
   compatible:
     enum:
       - mediatek,mt6779-devapc
+      - mediatek,mt8192-devapc
+
+  version:
+    description: The version of the hardware architecture
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    maxItems: 1
+
+  slave_type_num:
+    description: The number of the devapc set
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 4]
+    maxItems: 1
 
   reg:
     description: The base address of devapc register bank
+    maxItems: 4
+
+  vio_idx_num:
+    description: The number of the devices controlled by devapc
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     maxItems: 1
 
   interrupts:
@@ -39,7 +57,10 @@ properties:
 
 required:
   - compatible
+  - version
+  - slave_type_num
   - reg
+  - vio_idx_num
   - interrupts
   - clocks
   - clock-names
@@ -53,8 +74,28 @@ examples:
 
     devapc: devapc@10207000 {
       compatible = "mediatek,mt6779-devapc";
+      version = <1>;
+      slave_type_num = <1>;
       reg = <0x10207000 0x1000>;
+      vio_idx_num = <511>;
       interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
       clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
       clock-names = "devapc-infra-clock";
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+
+    devapc: devapc@10207000 {
+        compatible = "mediatek,mt8192-devapc";
+        version = <2>;
+        slave_type_num = <4>;
+        reg = <0 0x10207000 0 0x1000>,
+            <0 0x10274000 0 0x1000>,
+            <0 0x10275000 0 0x1000>,
+            <0 0x11020000 0 0x1000>;
+        vio_idx_num = <367 292 242 58>;
+        interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
+        clock-names = "devapc-infra-clock";
+    };
-- 
2.6.4

