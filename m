Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694D7452ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhKPKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:18:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49500 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhKPKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637057701; x=1668593701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWYaIv1G0/vxvVKGW9HFtKBBVGBSrggh6rmJCotQKlk=;
  b=JiMI2y6sY42muNf48wG4l76PFpdi0mCmR/HfYcwhkHyLKsweojmz4CMX
   QIiU7k5ZVP+2j0jemswFwP+cfuOi4YurAcBBjylWizFSjOmt0KXeRLvuN
   bN/gzSGlavtHvRaCPJcAjwUgGTO1G/DpLDYNe3Afc/3V1t415Y6GWqWoZ
   UnYOIEF3syx+QSUnLRV3kX1bUiZrrbTGxTh9ffZrKWkqD+YrvoQkmFtqr
   hNdp4VHStxu6N0EanbrjuO5ibZro1FaeKZUdJ4GmI2MBJ1E2mfocBsJ95
   /+69GnKZmY3xBpMFJhZ68hmWvF+zTWGPJYH5cDn46EMcQgLVZh7YXnY3X
   w==;
IronPort-SDR: u5y7X9CNDuUbBUjek1juL5XxEThJpSNh/7wbQ5OOl8jBfUynq7BuqAeVySqMz/zVX1sDq9x83i
 ly/iC2ggmKl8uzNJaxzav39NgNfrUYv0q32bXWNI+9PV5E/T3s6n6TppoZ/rnNiMLu1hvtATUU
 3sMxJxdTYtUIGENfVlmlZ5dCrHTSxFG+CGlZr2r7MOjK+Mqrv0ry5PDLneyMEWH5S21nYFFVl0
 iFRBEtZVt2we517pRMJFR5wbA24yc3uG6TCe1fUgdoxxDJpu3Qp8Tzk1brZFnwa2wkV7WMhd/0
 wvoJg1oJRLwAJGVtSY+4LDo2
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="152081110"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:14:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:14:57 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:14:55 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <kuba@kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH resend v4 1/3] dt-bindings: phy: Add lan966x-serdes binding
Date:   Tue, 16 Nov 2021 11:08:16 +0100
Message-ID: <20211116100818.1615762-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the lan966x ethernet serdes phy driver bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../phy/microchip,lan966x-serdes.yaml         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
new file mode 100644
index 000000000000..6e914fbbac56
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
@@ -0,0 +1,59 @@
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
+description: |
+  Lan966x has 7 interfaces, consisting of 2 copper transceivers(CU),
+  3 SERDES6G and 2 RGMII interfaces. Two of the SERDES6G support QSGMII.
+  Also it has 8 logical Ethernet ports which can be connected to these
+  interfaces. The Serdes controller will allow to configure these interfaces
+  and allows to "mux" the interfaces to different ports.
+
+  For simple selection of the interface that is used with a port, the
+  following macros are defined CU(X), SERDES6G(X), RGMII(X). Where X is a
+  number that represents the index of that interface type. For example
+  CU(1) means use interface copper transceivers 1. SERDES6G(2) means use
+  interface SerDes 2.
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
+      - Input port to use for a given macro.
+      - The macro to be used. The macros are defined in
+        dt-bindings/phy/phy-lan966x-serdes.
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

