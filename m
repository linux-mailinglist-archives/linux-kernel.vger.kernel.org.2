Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90556423818
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJFGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:37:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10516 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbhJFGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633502148; x=1665038148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Z8Bi3LZdhbpISPdz6t8hDlpDNz6bqK9X6f2otpmq+s=;
  b=V/nFFOKvwTvDLOY1AxspvJWivmr7wTNnkqwcI1jbecADAUVtm7CbrvoY
   BQlztiY1dhrtu7WdTcbg7rfKbxnefhXVVRwOKHBUdyNQ2/M5FJc/Pkl0u
   YXr9y/jAtQi42LZjV9PitUz7MNmeghl9ctuf8LgMxB1Xeaym0e/9hFfOp
   SD9CFHO1K169RKWm/hFArM98gNvm7DPy7pnjZe0IGONrglUaVxdL5C+nN
   UiPtQfssUrNdAM9SXbUHo/jVyY6EU6W+Suv1oroIwCtFnX25F4eKCehyt
   XRuDrDGlK5K4MfkEDzaHHgEh8zJxuW+46j/FXywBNhLAbqk7yJShz7SJx
   A==;
IronPort-SDR: qG4M2D1EIUtd2ynFZjagv7lZFwcuXwRKmyhoBIqbSfVfjy2m/a5H8/LHl2svwLkJjlPdlNGBWE
 /MwMvzVIQNXeQq2KI1uPFKWYPFFVGzoQ6Dy4XpKM57X37gRS52EoNPE/XoFte6ho9WjyQfLZ8S
 tnmEYHJ9bFLQbLTCylavGdwtLGIUmfbyaHLd+K9re8Q0AGOaSkwnAUNWtIm9nmBp0r8mwMOSkJ
 vHPbmQLC/jtr1PWKyOHdf1ST6jrz+e92zwDyG11NRg8BfXIMg/z5gyByl2UgRvNvf2hNn6aQiK
 5+aDlhn4Mie2f2nl2eWS9VhY
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="134419736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 23:35:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 23:35:33 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 23:35:30 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: Add lan966x-serdes binding
Date:   Wed, 6 Oct 2021 08:35:21 +0200
Message-ID: <20211006063523.3962427-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
References: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the lan966x ethernet serdes phy driver bindings.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../phy/microchip,lan966x-serdes.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
new file mode 100644
index 000000000000..451e78c4a172
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
@@ -0,0 +1,43 @@
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
-- 
2.33.0

