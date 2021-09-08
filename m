Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030C1403927
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351586AbhIHLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:50:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57626 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351496AbhIHLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631101748; x=1662637748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IJzUTubxDUwl5su3QPbEKI+MlLxshdcIy7LIdDNq1Y8=;
  b=M7SgDO3Sm79uhfzLtuQHfFfQbURJhAZYH2R+7h5tUE1j4zGjVQ65wxdS
   dzJkN1uGArlN1mF5zhxInc3osGIlsSCG84x+xDzv5IwkyeQCaj6k17Srz
   ia/8djySpNyXmtqdbKYTWlZYWh7fIqYsSxFGbO30PK4nkYhdQI0TUfIBY
   ZXoSGieseOggiMcL5WhLMcnJKcvUjofdWoxiWcxRVUpoHPV7Vou6hQ0o1
   q5KGkzhrc6bmIJBRGaEbxdvhZdshWWC2raxi8JUE9ZSGFFBFUMPVPCVqt
   cwvYF4VG0J6xcov86LzRrIOMUpni/UAahEPq4Nu0LLOmCBVvMTTcGyaso
   g==;
IronPort-SDR: mIUbWEL961g0oskuyNoyRW5gpNk5Us3/EyDrhoP5QoRbQFGZWSZJ1yFfb+NTyE7SaaYPBaRTuH
 dGSqd5+3+LVd9ZtB5jdV1vKAe5HsGbF9IKH4Lg9GUkpMc50vpU27Z80nto8XsASWMjJGr4cZNV
 3OFOrM6Lxx36ul0n70OCgKpUffRJoc+Sgox5fav535/A01UfpFV1G4bPkLCFyJ8Ogsxk0As77g
 JdS/8rnaFszdPwcYNFYPxgi6FSVoivtWMSG1z7c1LAPK6YUgI94VlRE/BV9qjpAfzv0oTviWAf
 3vTRHjddRps3Q77yg/Jz/J01
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="135795780"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 04:49:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 04:49:08 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 04:49:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Wed, 8 Sep 2021 17:18:44 +0530
Message-ID: <20210908114844.22131-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com>
References: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
- Updated example provided for clk controller DT node.

 .../bindings/clock/microchip,lan966x-gck.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..cb8c1f5002f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,64 @@
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
+    cpu_clk: cpu_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <600000000>;
+    };
+
+    ddr_clk: ddr_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <300000000>;
+    };
+
+    sys_clk: sys_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <162500000>;
+    };
+
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+        reg = <0xe00c00a8 0x38>;
+    };
+...
-- 
2.17.1

