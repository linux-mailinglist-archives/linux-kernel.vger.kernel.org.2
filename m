Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AB3FD1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhIADbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:31:52 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30824 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhIADbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:31:50 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1813BFCo043735;
        Wed, 1 Sep 2021 11:11:15 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Sep
 2021 11:30:15 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 1/4] dt-bindings: aspeed: Add eSPI controller
Date:   Wed, 1 Sep 2021 11:30:12 +0800
Message-ID: <20210901033015.910-2-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1813BFCo043735
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for Aspeed eSPI controller

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
new file mode 100644
index 000000000000..aa91ec8caf6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Aspeed eSPI Controller
+
+maintainers:
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description:
+  Aspeed eSPI controller implements a slave side eSPI endpoint device
+  supporting the four eSPI channels, namely peripheral, virtual wire,
+  out-of-band, and flash.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2500-espi
+          - aspeed,ast2600-espi
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^espi-ctrl@[0-9a-f]+$":
+    type: object
+
+    description: Control of the four basic eSPI channels
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2500-espi-ctrl
+              - aspeed,ast2600-espi-ctrl
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      perif,memcyc-enable:
+        type: boolean
+        description: Enable memory cycle over eSPI peripheral channel
+
+      perif,memcyc-src-addr:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The Host side address to be decoded into the memory cycle over eSPI peripheral channel
+
+      perif,memcyc-size:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The size of the memory region allocated for the memory cycle over eSPI peripheral channel
+        minimum: 65536
+
+      perif,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI peripheral channel
+
+      oob,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI out-of-band channel
+
+      oob,dma-tx-desc-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 2
+        maximum: 1023
+        description: The number of TX descriptors available for eSPI OOB DMA engine
+
+      oob,dma-rx-desc-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 2
+        maximum: 1023
+        description: The number of RX descriptors available for eSPI OOB DMA engine
+
+      flash,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI flash channel
+
+      flash,safs-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2 ]
+        default: 0
+        description: Slave-Attached-Sharing-Flash mode, 0->Mix, 1->SW, 2->HW
+
+    dependencies:
+      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
+      perif,memcyc-size: [ "perif,memcyc-enable" ]
+      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
+      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
+
+    required:
+      - compatible
+      - interrupts
+      - clocks
+
+  "^espi-mmbi@[0-9a-f]+$":
+    type: object
+
+    description: Control of the PCH-BMC data exchange over eSPI peripheral memory cycle
+
+    properties:
+      compatible:
+        const: aspeed,ast2600-espi-mmbi
+
+      interrupts:
+        maxItems: 1
+
+    required:
+      - compatible
+      - interrupts
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    espi: espi@1e6ee000 {
+        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
+        reg = <0x1e6ee000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6ee000 0x1000>;
+
+        espi_ctrl: espi-ctrl@0 {
+            compatible = "aspeed,ast2600-espi-ctrl";
+            reg = <0x0 0x800>;
+            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+        };
+
+        espi_mmbi: espi-mmbi@800 {
+            compatible = "aspeed,ast2600-espi-mmbi";
+            reg = <0x800 0x50>;
+            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

