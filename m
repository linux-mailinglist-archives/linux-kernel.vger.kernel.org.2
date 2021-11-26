Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21BA45E45C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357633AbhKZCYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:24:46 -0500
Received: from mx22.baidu.com ([220.181.50.185]:52744 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243672AbhKZCWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:22:39 -0500
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id CD61090422A0F561742E;
        Fri, 26 Nov 2021 10:19:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:18 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:18 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v3 2/3] dt-bindings: staging: Add the binding documentation for ZHOUYI AI accelerator
Date:   Fri, 26 Nov 2021 10:19:00 +0800
Message-ID: <20211126021904.32325-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126021904.32325-1-caihuoqing@baidu.com>
References: <20211126021904.32325-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
such as Allwinner R329 SOC.
Add the binding documentation for ZHOUYI AI accelerator.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v2->v3:
        *Fix unit_address_format, avoid leading 0s.

 .../bindings/staging/arm,zynpu.yaml           | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/arm,zynpu.yaml

diff --git a/Documentation/devicetree/bindings/staging/arm,zynpu.yaml b/Documentation/devicetree/bindings/staging/arm,zynpu.yaml
new file mode 100644
index 000000000000..d452c08ab4a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/arm,zynpu.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/staging/arm,zynpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM ZHOUYI AI accelerator bindings
+
+maintainers:
+  - Cai Huoqing <caihuoqing@baidu.com>
+
+description:
+  Supports ZHOUYI AI accelerator in ARM SOC.
+
+properties:
+  compatible:
+    const: armchina,zhouyi-v1
+
+  reg:
+    maxItems: 1
+
+  device_type:
+    const: zynpu
+
+  cma-reserved-bytes:
+    default: 0
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - device_type
+  - cma-reserved-bytes
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        zynpu@3050000 {
+            compatible = "armchina,zhouyi-v1";
+            reg = <0x0 0x3050000 0x0 0x1000>;
+            device_type = "zynpu";
+            cma-reserved-bytes = <0x2600000>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&clk_zynpu>,
+                     <&clk_pll_zynpu>,
+                     <&clk_zynpu_slv>;
+        };
+    };
+...
-- 
2.25.1

