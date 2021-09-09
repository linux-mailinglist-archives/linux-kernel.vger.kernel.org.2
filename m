Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E116404874
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhIIKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:31:09 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:8036 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhIIKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:30:59 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 189A9ire075151;
        Thu, 9 Sep 2021 18:09:44 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Sep
 2021 18:29:14 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <joel@jms.id.au>, <andrew@aj.id.au>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     <osk@google.com>, <yulei.sh@bytedance.com>
Subject: [PATCH v3 1/3] dt-bindings: aspeed: Add UART routing controller
Date:   Thu, 9 Sep 2021 18:29:05 +0800
Message-ID: <20210909102907.32037-2-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909102907.32037-1-chiawei_wang@aspeedtech.com>
References: <20210909102907.32037-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 189A9ire075151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for Aspeed UART routing controller.

Signed-off-by: Oskar Senft <osk@google.com>
Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../bindings/soc/aspeed/uart-routing.yaml     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
new file mode 100644
index 000000000000..e7071f1abc03
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2018 Google LLC
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/aspeed/uart-routing.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Aspeed UART Routing Controller
+
+maintainers:
+  - Oskar Senft <osk@google.com>
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+description:
+  The Aspeed UART routing control allow to dynamically route the inputs for
+  the built-in UARTS and physical serial I/O ports.
+
+  This allows, for example, to connect the output of UART to another UART.
+  This can be used to enable Host <-> BMC communication via UARTs, e.g. to
+  allow access to the Host's serial console.
+
+  This driver is for the BMC side. The sysfs files allow the BMC userspace
+  which owns the system configuration policy, to configure how UARTs and
+  physical serial I/O ports are routed.
+
+  Two types of files, uart* and io*, are presented in sysfs. The uart*
+  configures the input signal of a UART controller whereas io* configures
+  that of a physical serial port.
+
+  When read, each file shows the list of available options with currently
+  selected option marked by brackets "[]". The list of available options
+  depends on the selected file.
+
+  e.g.
+  cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+  [io1] io2 io3 io4 uart2 uart3 uart4 io6
+
+  In this case, UART1 gets its input from IO1 (physical serial port 1).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-uart-routing
+          - aspeed,ast2500-uart-routing
+          - aspeed,ast2600-uart-routing
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    lpc: lpc@1e789000 {
+        compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
+        reg = <0x1e789000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e789000 0x1000>;
+
+        uart_routing: espi-routing@98 {
+            compatible = "aspeed,ast2600-uart-routing";
+            reg = <0x98 0x8>;
+        };
+    };
-- 
2.17.1

