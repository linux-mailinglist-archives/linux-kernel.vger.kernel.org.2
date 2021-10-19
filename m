Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED09433529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhJSLzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:55:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23127 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhJSLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634644376; x=1666180376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRRz1nNIWjB/2Qd5vtJTIW1MSGHtqheYR/LSlSqAPzQ=;
  b=qERxe4SkJvzuDxRHbPBI/qgl+Ng1jlU4zVXFlJEeubNygA/4zxmc5i3J
   zvFjhfod3HNvPzGIZeBD3mkWpu/z76SYbYqUKHhiYA323wTpkV3oosrrk
   rMX6Yc7LLZRLGTeT26cO+SY/X/paAhfNSoNSCqkzn4MX63Mi9/kym2n7m
   JdAa5xyE+DWayfcT1/YlAzYp8PQzKIiU72N/ySAJN1XxoLIHTvSZSYZBB
   b+l1ZKVB9z6cP2PUkYnbpzaAXD9eX1Z2b1RipAypEUDnn8ht4KQcy2NmQ
   /VUxcDkUjVJyFeASjL0G/yJQehsT/7foFpfspWlEW2KzuLI1QK4LFzl32
   g==;
IronPort-SDR: AFMg66B7I2yFkqRdv4ebKKLWO8otPcNC3oGfdp2vU8FIFBAMsPUv5lAZZcv9E0PognLU0lBVQL
 P76zm8dHQufIeKuGlJzECu4wX0EEXiEb5OI0A6d0n24j+56iHl5iLRY2BCZcvVpQenqJCPdg1k
 Ev67KhlKSrWVLb3okVK8HAJSH0mCVziRXUGRLQmEP3qoyBqzJztRdHk+HL0HtN3W4sIH7EDbnR
 TiXrXf0sTNcFsOKeCfyZCIPoL2wwsgWG8a8CQLwm0Bkd28am6LF+4aq2B7aO/LHmFm/zydxnwO
 OspJ3Z1NKCifDvrQlRPXHYf3
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="136094500"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 04:52:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 04:52:50 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 04:52:49 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] dt-bindings: reset: lan966x phy reset driver bindings
Date:   Tue, 19 Oct 2021 13:52:04 +0200
Message-ID: <20211019115205.1516311-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
References: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the lan966x phy reset device driving bindings.
It is using register access for the internal PHYs and toggles
GPIO for external PHYs.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../bindings/reset/lan966x-phy,rst.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
new file mode 100644
index 000000000000..35a32458cafe
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/lan966x-phy,rst.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip Lan966x PHY Reset
+
+maintainers:
+  - Horatiu Vultur <horatiu.vultur@microchip.com>
+
+description: |
+  The Microchip Lan966x Switch provides 2 internal PHY which needs to be
+  released from reset before they can be accessed. Also it might have external
+  PHYs which requires to toggle a GPIO before the access to the PHYs.
+
+properties:
+  $nodename:
+    pattern: "^phy-reset@[0-9a-f]+$"
+
+  compatible:
+    const: microchip,lan966x-phy-reset
+
+  reg:
+    items:
+      - description: internal phy reset registers
+
+  reg-names:
+    const: phy
+
+  "#reset-cells":
+    const: 1
+
+  external-phy-reset-gpios:
+    description: used for release of reset of the external PHY
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy_reset: phy-reset@e2010010 {
+        compatible = "microchip,lan966x-phy-reset";
+        reg = <0xe2010010 0x14>;
+        reg-names = "phy";
+        #reset-cells = <1>;
+    };
-- 
2.33.0

