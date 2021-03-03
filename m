Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3AE32BBD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356175AbhCCNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:01:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62731 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842821AbhCCINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614759225; x=1646295225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZMP0RR3DfODg8HK1LLJY82GvxRtZDSQ6PcUVaezXGH8=;
  b=dMGuKFUX9ydCs6FcMcWOc1EaeWscQn6nU945q0tcgdQ2XKAUjy6W/gR9
   gH9qxtZlutMyb3ylH+rnhycFSHaUWG1RPBWs4+ga04dCsu2HsmaDVhzCx
   pZLPIqmwxP+8J5ZBWWYD2Cbbt4ixtNsJG4x/124vDnJIYtACoCzjaBUTX
   JX1oa8+rn3F7Of8YxLzhZEJvGkeCcF5wJlQakRs1Mi+zJRJ/AW4pLeFMn
   8dkY55Ll0egMYX94Pm1TnVuvPvpDxcZQkEnf1zNW6j4wtsgnErB1zR79E
   nkVQIQ/64vNUS+4a/ACYWdlJGczpYYVAwXyTlpkSvT3olIe7ilGA4lBnE
   A==;
IronPort-SDR: v2JYbKbUMSSPrPQTX4TtccihZaZ6+iCt9eaDV7iyFxqSrLFv2OzyhopjBDR49AXRT1IiPidZWv
 kPMHgnl/Ysm0jt/3QURloWWkypnuOTh+k9FsbDwRM2A1d1ej4ZoXVprasjxLDEJuEtucoiCuDe
 0Y73KsGH6x3f8EdedDs+YkJNCw/4QBZRCTDD0ZzYzdqW/59oXu0KPqcicmqNvC4Ji4Acn1tDrV
 KsdRssA4G9d8FzP/sZKUeTG1DxU8/GmbTcP42tCcn/jB/4Xh+hgRaLYz4hPaIDTkdgulaP69Z4
 +L4=
X-IronPort-AV: E=Sophos;i="5.81,219,1610434800"; 
   d="scan'208";a="105779094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2021 01:12:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 01:12:07 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 3 Mar 2021 01:12:05 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Wed, 3 Mar 2021 09:11:56 +0100
Message-ID: <20210303081158.684532-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303081158.684532-1-steen.hegelund@microchip.com>
References: <20210303081158.684532-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Sparx5 reset device driver bindings

The driver uses a syscon and an IO range on sparx5 for access to
the reset control and the reset status.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 .../bindings/reset/microchip,rst.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
new file mode 100644
index 000000000000..370579aeeca1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip Sparx5 Switch Reset Controller
+
+maintainers:
+  - Steen Hegelund <steen.hegelund@microchip.com>
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+description: |
+  The Microchip Sparx5 Switch provides reset control and implements the following
+  functions
+    - One Time Switch Core Reset (Soft Reset)
+
+properties:
+  $nodename:
+    pattern: "^reset-controller@[0-9a-f]+$"
+
+  compatible:
+    const: microchip,sparx5-switch-reset
+
+  reg:
+    items:
+      - description: global control block registers
+
+  reg-names:
+    items:
+      - const: gcb
+
+  "#reset-cells":
+    const: 1
+
+  cpu-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access CPU reset
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#reset-cells"
+  - cpu-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    reset: reset-controller@11010008 {
+        compatible = "microchip,sparx5-switch-reset";
+        reg = <0x11010008 0x4>;
+        reg-names = "gcb";
+        #reset-cells = <1>;
+        cpu-syscon = <&cpu_ctrl>;
+    };
+
-- 
2.30.1

