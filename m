Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704EC434818
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhJTJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:45:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52247 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723005; x=1666259005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ja2MGEUdtoK6a+79ZH8FcrgzovK6lvKjDzDMIfNVJs=;
  b=KQ9dz3DMRsjbA++wVsfnD4VbW/DoSiEYP1hlVQnGTSV218GM882KQwdJ
   X8zj/tq+vnT9uab3MkewAdsoXdjz6w0IZWeDfXxNMPfR3dqNDDeWBgNVt
   nbuX7Eaw053QCefOdUp4LW3lXLWo4idahKR1n4tVgOxKEpydK9AR3Vf6e
   atULKsxLPgXOhTXEQgO6NaGRTf4lGcrglFS8caKWUNnoIJ8BdTGHvu8JW
   +Lnqrnvb9uQ4QqDmNM0BZJvJ+3t5Z1AirPpbMyJzCN5AJCOhOiUg+Gvil
   Yb7YCC2cIP0ApyPMj3wXroYzub5mWAIN8wS370ufZZL1/Lc8cNnoDwJHO
   w==;
IronPort-SDR: yf0OUjPEOKpSQTUv+8yEcg7A1OY9x75vUXKVtPwz+dgk3UuUmTg77PaZqiHbCmrvDlwXveYEeo
 Aj/yQ1ORdF69ZymmW0k5NzfSPAJBSjgF9p3pU8zyF/2JblF6C1TGn5jQCxK+OFGAXdCsoAuFhu
 VND5i9maQnlVUBzsz1C+f00tT+JZeWBoPkmY/L0K8eY2W2IrJdrnpI0Sl2OpoXCHcaIcD2FmDx
 +9bcM7yO/e1+PzY7BtFZwiDofqHdv1wTbxoCkKLG0czzPjOAnWPEVvEgBUkOvsyZbVslGTpeCP
 ycJIMKMEL3oyK1pJ6w1ZY/V7
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="141015574"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:43:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:43:24 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:43:22 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: phy: Add lan966x-serdes binding
Date:   Wed, 20 Oct 2021 11:42:27 +0200
Message-ID: <20211020094229.1760793-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
References: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the lan966x ethernet serdes phy driver bindings.

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

