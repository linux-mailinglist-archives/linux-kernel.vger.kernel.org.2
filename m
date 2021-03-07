Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F083302FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhCGQeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:34:50 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59986 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhCGQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:34:37 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127GU7io001922;
        Sun, 7 Mar 2021 08:34:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jbiZDR2jx39VXbI5TMJLKY3jwlneom3cw2FMGXDlXXM=;
 b=g+DFuCeX+AGVSoSYE+jOk+HVvXs1ioqiZpyUPc/m4IQSylNspDkktKVy1Ffn7wDABcyi
 VLV39QDkAeNejWyGnCGE4sqo5BGI+vZfE/tXSRbU+wjDf1bkakWsBE8PkEAiZr6OaU0m
 GHvEhhoZUL61cGNR9WKCU9XgT2WU8H8IWFKYg9WIAaU+3Oydu0AgIDS8xV+zrMRc5gQb
 RRICpouImLNC+qoxP9by2+fxRVaLQnPnXoLe42otyrFMNXN+FPfDcg8YveWWybJ4sS3F
 xVS7s0iDKl421xUEGperUR6zMvnQZe0UqheSOQI0hocyaljy6yK2cB+2zlGxGJwr+wTG bQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqsr2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 08:34:09 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Mar
 2021 08:34:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Mar 2021 08:34:07 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id DCCCF3F7043;
        Sun,  7 Mar 2021 08:34:03 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 2/5] dt-bindings: phy: convert phy-mvebu-utmi to YAML schema
Date:   Sun, 7 Mar 2021 18:33:39 +0200
Message-ID: <20210307163343.25684-3-kostap@marvell.com>
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

The new file name is marvell,armada-3700-utmi-phy.yaml

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml | 57 ++++++++++++++++++++
 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt                | 38 -------------
 2 files changed, 57 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
new file mode 100644
index 000000000000..2437c3683326
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/marvell,armada-3700-utmi-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Marvell Armada UTMI/UTMI+ PHY
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description:
+  On Armada 3700, there are two USB controllers, one is compatible with
+  the USB2 and USB3 specifications and supports OTG. The other one is USB2
+  compliant and only supports host mode. Both of these controllers come with
+  a slightly different UTMI PHY.
+
+properties:
+  compatible:
+    enum:
+      - marvell,a3700-utmi-host-phy
+      - marvell,a3700-utmi-otg-phy
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  marvell,usb-misc-reg:
+    description:
+      Phandle on the "USB miscellaneous registers" shared region
+      covering registers related to both the host controller and
+      the PHY.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - marvell,usb-misc-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usb2_utmi_host_phy: phy@5f000 {
+      compatible = "marvell,armada-3700-utmi-host-phy";
+      reg = <0x5f000 0x800>;
+      marvell,usb-misc-reg = <&usb2_syscon>;
+      #phy-cells = <0>;
+    };
+
+    usb2_syscon: system-controller@5f800 {
+      compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
+      reg = <0x5f800 0x800>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
deleted file mode 100644
index aa99ceec73b0..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-MVEBU A3700 UTMI PHY
---------------------
-
-USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
-* Armada 3700
-
-On Armada 3700, there are two USB controllers, one is compatible with the USB2
-and USB3 specifications and supports OTG. The other one is USB2 compliant and
-only supports host mode. Both of these controllers come with a slightly
-different UTMI PHY.
-
-Required Properties:
-
-- compatible: Should be one of:
-	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
-	        the USB2 host-only controller.
-	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
-	        the USB3 and USB2 OTG capable controller.
-- reg: PHY IP register range.
-- marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
-			region covering registers related to both the host
-			controller and the PHY.
-- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
-
-
-Example:
-
-	usb2_utmi_host_phy: phy@5f000 {
-		compatible = "marvell,armada-3700-utmi-host-phy";
-		reg = <0x5f000 0x800>;
-		marvell,usb-misc-reg = <&usb2_syscon>;
-		#phy-cells = <0>;
-	};
-
-	usb2_syscon: system-controller@5f800 {
-		compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
-		reg = <0x5f800 0x800>;
-	};
-- 
2.17.1

