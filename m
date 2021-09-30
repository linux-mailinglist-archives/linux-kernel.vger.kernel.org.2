Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B441D4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhI3HlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:41:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39399 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbhI3HlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632987577; x=1664523577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/f7Tvos+nOKVB4h/HYfwf4TdPoy8XxtG9ZvPV5MKsw=;
  b=Qo8S3EJy0K017QVyCXkNwZTdwEVIMZVbgsNKPmb8sq4gN86SNpc6Vrgn
   pzt3SjA9jaaGZY6HW5v0Z3reVc3wxCruuY8muwW0up3ceZ4RXHrpn3XNG
   UUBnY+t/MnkclB+9uSCBQjdRTVdMGunflkmKOmAj5nSl/8f5ukgZ0TULK
   qVXtVov/hIAbP65arIg4u/UM9SrsQbORiV2uJXHIeVvW4KtT/Uwi0jV9G
   XXWIHKwtK6qmAjI9534iAecAVzdzG2YiaAOMcHpMtx7jle6vqkel/GK5t
   2pmfuWUPzKvSuhXHaFiBEDoaB8QwNzc8bONYBm8Sy3J1q/u4HxL6w4hJW
   g==;
IronPort-SDR: 7/xcplz3vwQAs9yDrccZ9nJsDKZkvkKuG2jSHbRK4y2KkguZnMdCcaNzGz/+EWbGjyoEKuEAsM
 BYMYfAIrxn7paQiGUh8cJZ/H1/TW9DrSkZGQuFAyRjcKzPACH5C3cIb66ksbRgrl7lxFx2f0EX
 dK2+SXmhqbZDFDt0rM71dwfkcx/r8jG0P4myqQiGONufG3EOSU4zIiE69XfTHzo4G2oaS66tCz
 iquUex6rkHcnUv8SVBJJflIW2MBLewqjlmUNN5dZQ+nL20D/YSxn0q8XMdFpg8G2IAZTOuq2JF
 xS28cf8S9g22dzTw3Vn8buU0
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="146229522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 00:39:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 00:39:35 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 00:39:33 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/3] dt-bindings: phy: Add lan966x-serdes binding
Date:   Thu, 30 Sep 2021 09:38:20 +0200
Message-ID: <20210930073822.2709955-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930073822.2709955-1-horatiu.vultur@microchip.com>
References: <20210930073822.2709955-1-horatiu.vultur@microchip.com>
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
index 000000000000..03a2854a2b09
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
+    pattern: "serdes"
+
+  compatible:
+    const: microchip,lan966x-serdes
+
+  switch-syscon:
+    description: |
+      Handle to general configuration block
+    maxItems: 1
+
+  '#phy-cells':
+    const: 2
+    description: |
+      First argument represents the port index,
+      the second one represents the serdes index.
+
+required:
+  - compatible
+  - '#phy-cells'
+  - switch-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    serdes: serdes {
+      compatible = "microchip,lan966x-serdes";
+      #phy-cells = <2>;
+      switch-syscon = <&switch_ctrl>;
+    };
+
+...
-- 
2.33.0

