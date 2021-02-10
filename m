Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133DD316237
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhBJJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:28:29 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52907 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhBJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612948894; x=1644484894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0HAeQQB1N9Hh4XYyQGC7tvske53hGh2C8RnoJBWrDU=;
  b=T30hTrQKV9/rUV0rtvzGlNoRZ9twwuBxqK6MwGthDxrquFHewF5AgmBB
   Mu6Gy4MQQ2R8bO5d16VG5obUj8FeIixIa8FSsrxMvjxAQb0iA/TxiZlGo
   mQixiJBREbJBOhg0zb2+FDHH9LW5QTnk/eIOi6EZhckWOnFn2UeX/Cki6
   YnDmZ6wlsPf9VysqNkI4kvYL6ptWAh/ZFvnGLT09YZDU/rRPCQ+e/EpT4
   H/WOazKMDLdhTT+pdgq1yFh4bE1WCURSbVL6J+MizG50c9GCRu/BuiOdt
   9pZYNkVAodFtOJZozlk7o1cgi4mdIsBNr0e7O5kAWkgWH4VPpLOB4hLTZ
   A==;
IronPort-SDR: MEghTVkivKV3Je28ILO+65t/HQnFIig0VW+On8mMHS/ksVqMTTS5baWlsX0q1B/oHcO8KKN0F3
 c5Y3Zmh07SBV3l22hIvm88tBIfEVf1d5ukjGQ8lpchH2Fm/DkgjncEqTZuLXeHpPWwFXMfGWBN
 3V/9atKpJcIP2DpgJunsbkQ8P4vjcZHALcht9wU45Mglfqxk7p9mj4XTmi12SugmR4uWTo0l0D
 BxP1+E0YUMch8QZjysxjv+O7+J+RWpOttHgZDIKzFHqTEXLX2hqPLkVxvmmu112ylLA4ApKfU6
 zqA=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="108681606"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 02:20:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 02:20:04 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 02:20:02 -0700
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
Subject: [PATCH v5 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Wed, 10 Feb 2021 10:19:50 +0100
Message-ID: <20210210091952.2013027-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210091952.2013027-1-steen.hegelund@microchip.com>
References: <20210210091952.2013027-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Sparx5 reset device driver bindings

The driver uses two IO ranges on sparx5 for access to
the reset control and the reset status.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 .../bindings/reset/microchip,rst.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
new file mode 100644
index 000000000000..80046172c9f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -0,0 +1,55 @@
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
+      - description: cpu block registers
+      - description: global control block registers
+
+  reg-names:
+    items:
+      - const: cpu
+      - const: gcb
+
+  "#reset-cells":
+    const: 1
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
+    reset: reset-controller@0 {
+        compatible = "microchip,sparx5-switch-reset";
+        #reset-cells = <1>;
+        reg = <0x0 0xd0>,
+              <0x11010000 0x10000>;
+        reg-names = "cpu", "gcb";
+    };
+
-- 
2.30.0

