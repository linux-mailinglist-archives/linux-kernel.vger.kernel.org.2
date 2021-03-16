Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A424D33D05A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhCPJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:11:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54484 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhCPJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615885827; x=1647421827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vooiXHRAN/ACdm/aZ2hlaMMqq5pvNY4gIzvnzSpHoY8=;
  b=U3CM7rnehW4+tkFeFjwx8SFxiF+Gr7IiAyedb9sEyRrmUCeBQ+BNDfKT
   A+3Wpp+k/yq2U7jUbgmFu9VmpuB8wk0AA3yZKkmWNa1pPObn2hntiQ9GZ
   GSjEw0EG30TRKtXYqlPMJdgJUldChPVHB9Bh9rtfXUwnYOZxyMCaDa6qt
   PQV5L2tqyryKDU+BCX3Cql7hpv8jyhdTtkSwYAdFL/IdVvwd3+AXJVVZz
   l/EIdJR6k/f3czR8llqnlBok+DNMO8Rr9299QdtlROOJ5g3vN9HCz44ZM
   I41sW44obXZl6tsemVm1M9yW9YiToPoalg8MQ2N4K4YeQMa/a2WWP6xbN
   g==;
IronPort-SDR: C1P9I08+0b/SQzgHmh8kodcfXW7jkqj6ktzbivIJp1NhT4DZzk1mRw8n69rYEMt8Qvy1C9K1e8
 9PS8CEK3xqVFtANpo7uoJAnjJJQHmvIdemUbQlLmMZR+CMGKAeBiAZ38KD1tcrU6TyVUwRg5za
 62eeOPEbKj+iYD8IXvDPTz/KjMph5+cQgROEIb/azwf6w2U3FuKZ1t5eeE8JIXSfdQXQv3swVB
 EEkgUNTaxALqamlullf5KXRSc+7iW9V46s6HJ6dVlSRa83yk58Mob4p2d2plUIcSogGxbpWU/Z
 0/8=
X-IronPort-AV: E=Sophos;i="5.81,251,1610434800"; 
   d="scan'208";a="110146008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 02:08:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 02:08:51 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 02:08:49 -0700
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
Subject: [PATCH v8 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Tue, 16 Mar 2021 10:08:37 +0100
Message-ID: <20210316090839.3207930-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316090839.3207930-1-steen.hegelund@microchip.com>
References: <20210316090839.3207930-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Sparx5 reset device driver bindings

The driver uses a syscon and an IO range on sparx5 for access to
the reset control and the reset status.

Sparx5 will no longer use the existing Ocelot chip reset driver, but use
this new switch reset driver as it has the reset controller interface that
allows the first client to perform the reset on behalf of all the Sparx5
component drivers.

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
2.30.2

