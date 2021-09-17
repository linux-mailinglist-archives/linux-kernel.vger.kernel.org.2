Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179A240F99A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhIQNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:54:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54007 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbhIQNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631886789; x=1663422789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pPAzBKiBLjqg+RYO95Pl2gUVVqxff8BfJCiP9Q+qtCE=;
  b=iv3NClS3q+4l36ALRXpPozeeOA29UTTHToU5vh5lKqIQXhmfv64U8Eiw
   sQnn4h7ynMyRTN3osk9SUoyKECsVG2eMGTEBPYdskZc4uczhFjTemrR/K
   MINYX7qaqWq+AtAyFUEEnAsuGGlkLikfR52Iwrq/F2Se1rDTf50ELAa3+
   7WStBHEo5B0YYQ7fQv0SV8t9PpkwzXxJL3jJ5N5r+/0HEjAH5BUuAyIlx
   MbbzL/phwmfGzJaRZbgANfLyYM8Zz0YJ79PJQdI2ycN6+IfW05YjewRGM
   d45795AVFApXPM+kXZfspvrpx9b5qlrNITAK3v6vUBfdVpCxCvHqCBRnU
   A==;
IronPort-SDR: nDByM33zTweFGq8UHRwlXh3TPJOGHsH/YPeSrNogoZQtgioeESINA83wSX/l6tqZJZXhyDv9Cf
 3Fb3OTdb3yAIx5hey+rH81GOvZisKh6Dxe0wBhWa1bsSgtuuH/6IsxrEY8y4bmfDZbz0YNemej
 M86mrPFhiJtyjV1Xu0DeDte/+pIapypuhtFleakaahHNtjZ6Noyffj6Gp3I96nbPo3xhiTn1YF
 4MZez9KC2oUvUnZ1LD6ihcLyvJzZzH/Ev//HmqdNVd4an7MyJfz0pdaQFXNNXr09C0WLDwZ/HZ
 DZQGIbGq36jz62IDuQJBOFf2
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="129684061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 06:53:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 06:53:08 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 06:53:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v5 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Fri, 17 Sep 2021 19:21:41 +0530
Message-ID: <20210917135142.9689-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
References: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v4 -> v5:
- In v4 dt-bindings, missed adding "clock-names" in required
  properties and example. So, added them.

v3 -> v4:
- Updated "clocks" description.
- Added "clock-names".

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated example provided for clk controller DT node.

 .../bindings/clock/microchip,lan966x-gck.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..e6b4ed3b0c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966X Generic Clock Controller
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
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
+    items:
+      - description: CPU clock source
+      - description: DDR clock source
+      - description: System clock source
+
+  clock-names:
+    items:
+      - const: cpu_clk
+      - const: ddr_clk
+      - const: sys_clk
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+        clock-names = "cpu_clk", "ddr_clk", "sys_clk";
+        reg = <0xe00c00a8 0x38>;
+    };
+...
-- 
2.17.1

