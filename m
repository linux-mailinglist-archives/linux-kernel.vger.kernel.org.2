Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFCF3302FF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhCGQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:34:51 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56928 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232421AbhCGQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:34:36 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127GUZET002684;
        Sun, 7 Mar 2021 08:34:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=2jRH/UyxO5Mtisgwo8cCvVO8eJzyTxoaG5bM76zfOLw=;
 b=gJv+VXNFqF4s/2iRh2EoissyVPOiBhRxA6Jke8yt51FZQqAkd7CfpgRhLEpNfizb5THU
 CHwvbACgwso9lRQsPQ9hdx877xyRQAr5mVKlnGlHI58SK02yQ4LxOCzhBM+efJJeh7TQ
 UYP4pePQ1mB+Ekk3xTUiDCKzFlU4FHdtd0/qgSzqpIRplieSQgzw6nW0bdcXzIwznfes
 kFPO6OZUDfA9hYM8U79XKBCidG8gPozBF1n/bW03Ud4+bLYZlrpzxstQ0RXoNRkuY3oi
 /Q2jL3gwPWlpcfg9SZcaojhprJF8XZE+z/RAB4nFXIdZp0iEEXojrEdrINEMOlhv3z6H kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqsr2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 08:34:14 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Mar
 2021 08:34:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Mar 2021 08:34:12 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 3F51A3F7044;
        Sun,  7 Mar 2021 08:34:08 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 3/5] devicetree/bindings: add support for CP110 UTMI PHY
Date:   Sun, 7 Mar 2021 18:33:40 +0200
Message-ID: <20210307163343.25684-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307163343.25684-1-kostap@marvell.com>
References: <20210307163343.25684-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_10:2021-03-03,2021-03-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add DTS binding for Marvell CP110 UTMI PHY

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml | 109 ++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
new file mode 100644
index 000000000000..30f3b5f32a95
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/marvell,armada-cp110-utmi-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Marvell Armada CP110/CP115 UTMI PHY
+
+maintainers:
+  - Konstantin Porotchkin <kostap@marvell.com>
+
+description:
+  On Armada 7k/8k and CN913x, there are two host and one device USB controllers.
+  Each of two exiting UTMI PHYs could be connected to either USB host or USB device
+  controller.
+  The USB device controller can only be connected to a single UTMI PHY port
+                      0.H----- USB HOST0
+  UTMI PHY0  --------/
+                      0.D-----0
+                               \------ USB DEVICE
+                      1.D-----1
+  UTMI PHY1  --------\
+                      1.H----- USB HOST1
+
+properties:
+  compatible:
+    const: marvell,cp110-utmi-phy
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  marvell,system-controller:
+    description:
+      Phandle to the system controller node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+#Required child nodes:
+
+patternProperties:
+  "^usb-phy@[0|1]$":
+    type: object
+    description:
+      Each UTMI PHY port must be represented as a sub-node.
+
+    properties:
+      reg:
+        description: phy port index.
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - marvell,system-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    cp0_utmi: utmi@580000 {
+      compatible = "marvell,cp110-utmi-phy";
+      reg = <0x580000 0x2000>;
+      marvell,system-controller = <&cp0_syscon0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cp0_utmi0: usb-phy@0 {
+        reg = <0>;
+        #phy-cells = <0>;
+      };
+
+      cp0_utmi1: usb-phy@1 {
+        reg = <1>;
+        #phy-cells = <0>;
+      };
+    };
+
+    cp0_usb3_0 {
+      usb-phy = <&cp0_usb3_0_phy0>;
+      phys = <&cp0_utmi0>;
+      phy-names = "utmi";
+      /* UTMI0 is connected to USB host controller (default mode) */
+      dr_mode = "host";
+    };
+
+    cp0_usb3_1 {
+      usb-phy = <&cp0_usb3_0_phy1>;
+      phys = <&cp0_utmi1>;
+      phy-names = "utmi";
+      /* UTMI1 is connected to USB device controller */
+      dr_mode = "peripheral";
+    };
-- 
2.17.1

