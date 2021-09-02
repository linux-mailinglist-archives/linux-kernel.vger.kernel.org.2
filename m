Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF813FEB4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbhIBJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:31:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12952 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbhIBJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630575001; x=1662111001;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=oCI7E4Q4DoyRlmDw/ZqrPAS45RlJSJQFyUnKmrgoz2c=;
  b=2oLGti+iBY7DfNa0gCnY3MeC8DlZMJGpSTDOaX3mtJssYA6BKBpHDq9o
   VMFcAaPU+JSZq0vgfu2itb2UjPeT8AmitOX6wZyj/syAMxKVWj2oxiv7r
   qQkpg3Byc9QcqDSpvW11jxMv/2cjUBrXzz1ne8PjeeL3D7r8ZCCnfCg4S
   PMZQ7tgsBTnOp5y/GE5Lz9zS7aX0nbQEQ1jPn28jxiCfL5Wk2D3XbfjcF
   GuG+M+r3eAVh70xS5xZPdmudnTsJk5tCRbppc7JfKueDtaBQdnjDox+T+
   Rbbx3kDildWjrPLtc+CVawp85M/POtGkTeOVSZW4h6ezuj2ccR/BIlrU1
   w==;
IronPort-SDR: 121PtC9YuB4rSAqB6V6SkE7pJ2GTFJYbql3lt3Soj6KV4KMUvnvCLcbYmIIYz9ixERreW9O1eI
 4hQEAdZDB3SEyKconmgI10+TfdVD/4/hlHyDfS3xVVeq3UZ06aHvwanHbnu0ZfipcfI97jdag0
 1AUM0Df4uPPW0nhKy0DHVqfkGA8bZLFqy/kMuoyhWXVPadofHlIxPwnfOq9Ifd/I/aPoQRV6K2
 NQ3EmP+tAk19EZ/4qGSQaSYWAsMBMHT4mGsWwBArv5bJFFlyvPHCRnToW0AhkRI494HtAV/rzx
 k8elLjy84QhA2s8H1T/R4PFn
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="68000947"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 02:30:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 02:30:00 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Sep 2021 02:29:56 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Thu, 2 Sep 2021 14:59:54 +0530
Message-ID: <20210902092954.28359-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../bindings/clock/microchip,lan966x-gck.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..0df765f628c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966X Generic Clock Controller
+
+maintainers:
+  - Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description: |
+  The LAN966X Generic clock controller contains 3 PLLs - cpu_clk,
+  ddr_clk and sys_clk. This clock controller generates and supplies
+  clock to various peripherals within the SoC.
+
+properties:
+  compatible:
+    const: microchip,lan966x-gck
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>;
+        reg = <0xe00c00a8 0x38>;
+    };
+...
--
2.17.1

