Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA6324D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhBYJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:52:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhBYJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614246694; x=1645782694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8JlkBIXU9RIfmWMf1pSI/1PVwzWXTFhhtOgb2/+pQ4=;
  b=N20jLW14XnDTeyqw9cH5vdNo17X5v59Kmen8EpYrRcx8EjXk9T+G4OYT
   LtFNg6sjE5PTRwrXdG3hAHZVuXxO8xNA6yObuT3GR4AX3rQPf4bngvT2j
   1ZF8sAhp54DU4+ZCSkxO7brP0hIHTCthrv8gqMaMChJoMzxaMQ/QXpQuw
   zqVAmLWy1+d4QnAIhdnjGCe+Dt4XiJGZIvjymIyn6397c9IEOwrIY2w+K
   tesLkECZaCPwvCMtFIFHbsGuV1fiBsOA3NXCptRvrPiNkPVfwmkhu2zBI
   P6GLU+MQcpDDZuDMXR6UHWIt7p2fdUf3P6bfpDZx4CXV5HISU6Q9yrDOh
   A==;
IronPort-SDR: d29DXv9AI2WB9M2DicsSXI5EB3bx+6CQrNa3Vnzxzu9sJ8yDipoLzzIL6lE+egphe4B8znOKPj
 FKJKNfbMlSFuX0ldtvy5ShxCucVGFPx/qgA2Rv1hBri4hLocIPfH4F6m5cVEQ7a1UParRoItK2
 ECzk7Zflqg4uitsz6EmYtx4mSHgFVQnvVysPBflur4DgJl/z4PAmCpo8crjf41CqSUHP7HzREU
 z11rnfQEM1Tg86sZzes7z4eCCYLehOqBFPijBDBwr0r8LoI04cs4+KXPM5N/kuSqqwSksuXtw4
 Ox8=
X-IronPort-AV: E=Sophos;i="5.81,205,1610434800"; 
   d="scan'208";a="107917688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2021 02:50:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 02:50:17 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 25 Feb 2021 02:50:15 -0700
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
Subject: [PATCH v6 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Thu, 25 Feb 2021 10:50:03 +0100
Message-ID: <20210225095005.1510846-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225095005.1510846-1-steen.hegelund@microchip.com>
References: <20210225095005.1510846-1-steen.hegelund@microchip.com>
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
2.30.0

