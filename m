Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603A42F12D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhJOMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:44:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50449 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbhJOMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634301604; x=1665837604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFhnSGyMQDVLLTdJBAuezExujaSNKafiTG09LfRK2zA=;
  b=vur40sFF0rJS8uuxN0ZZ9j8XVsoC0zCuUufc2wNJdQXRlfq91AUzScLK
   tF2DIxVUYTFdg/9C3HZ00MMpIQCLsSc6xwRn4dzXdci1jRlAPaEp41law
   U4Yw4fLUUbBtjMqomNE/lpj+h2h4y3/oQMx/7szyZzLWEU5fVjxK7ywsn
   TBc7GgHTj4txp5XPv6nNxQkW3i5qTWidHhKkly/SsVQTaRL4VrkC1Qcp+
   O7sEXBJWAF+toOC5F0d1AKcpdHFiQSvnw8OoXpXI2bwpMR3w9YvWt/HE7
   49FU583Wmw47Emb2GelW48TM1y36ekiCTqLqkHY+t0kWuuYgcY3s/Cgh1
   w==;
IronPort-SDR: UapXFEetIrlcNLwdnSOYDsjB+xKztjNIjiotAGYk/V9MX3gGfcl1IUQ53wFhVBUxmHh87UXvSG
 +AG9ok3CZhNLeR8H5T2sDy2CxdRLJwGP4eohaSeGsUilbV4oTgZDUaxCOKYwdizLl/FKj/HcGJ
 2GaGR7im+jG28QavjIWCgahKrZtziG5+1aK5rWAWqOnDK4jUcBb8fk30mH1W8M1EZ/4wUZ2Bjp
 wOuclpUW/78ClNTl4V/YGO93o69Vbx6Kwvg2d0QovBw4iwfnVZwyTsnGzUYbcdWhs/7QSksefg
 kfxWqgLFb4iN/mfmeLe7PG3m
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73070427"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 05:40:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 05:40:01 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 05:40:00 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: phy: Add lan966x-serdes binding
Date:   Fri, 15 Oct 2021 14:39:18 +0200
Message-ID: <20211015123920.176782-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015123920.176782-1-horatiu.vultur@microchip.com>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the lan966x ethernet serdes phy driver bindings.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../phy/microchip,lan966x-serdes.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
new file mode 100644
index 000000000000..8902466831c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/microchip,lan966x-serdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Lan966x Serdes controller
+
+maintainers:
+  - Horatiu Vultur <horatiu.vultur@microchip.com>
+
+properties:
+  $nodename:
+    pattern: "^serdes@[0-9a-f]+$"
+
+  compatible:
+    const: microchip,lan966x-serdes
+
+  reg:
+    items:
+      - description: HSIO registers
+      - description: HW_STAT register
+
+  '#phy-cells':
+    const: 2
+    description: |
+      - Port index
+      - Serdes index
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    serdes: serdes@e2004010 {
+      compatible = "microchip,lan966x-serdes";
+      reg = <0xe202c000 0x9c>, <0xe2004010 0x4>;
+      #phy-cells = <2>;
+    };
+
+...
-- 
2.33.0

