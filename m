Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3F361BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbhDPIlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:41:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53338 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbhDPIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618562464; x=1650098464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lTZOjpt/PsZ0L6mL9vuEq3HADt4pfMakp+8pxOPEJk=;
  b=lGofTreeGtdrhRbb3kbrSgNqezIGn0Sxd7XspPXTKPtzGPX1qdYBTMMz
   Wba1ONTnzElddmyOS++BBhytngSAwIdmbzJr0l1r00KkbRwYChuSKHFh3
   Cj1Hq0wwHlQweVg1QK0xZAqbpFtsP6ioc6wrBiXSxkWLbc0Zz4H0+CRQj
   UdmAIl4HNlMvUaVyxyPCZR7yv/uURwVrund4uRNFCIEOM/yQkOdrdioy8
   iAuxfNrsLNZIEFIoOyo7GXs1kt+gc9qvAra84d+vT/0gC5NRvWsBvO7EM
   O5MGilK2Ocbjt419l0360wnidolvNablyzUvGtmG6Vj2z9kKUgvWF6t2I
   g==;
IronPort-SDR: Ha6NQ0j0CyD2wsaq7XsdO2Euv7+sh+eBpsXlZ5y52Mx46fmY+ed1kesyLwx2NelqvkM/NxS1E5
 RgAWy0HfIdM9ErtRcbk6MB3H++4cREZE7mkVSlisjsA6x49BYSHDjo2jQt8GAWHWDe2WYITkwp
 Oy/GOPAqlDHBFObS8LGAssse1rV8N9vexGmGf9RC2yM37FIicaoNfMtiyQSAc0GqCO7ocWG044
 7/MTFtgT0y48H4pQCEkiIP1SYuwK40lIutn1H8MRJYeiCEFH5xkhv9ZfVF/y2LPeF1914XgLZ9
 b5w=
X-IronPort-AV: E=Sophos;i="5.82,226,1613458800"; 
   d="scan'208";a="116692462"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Apr 2021 01:41:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 01:41:01 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Apr 2021 01:40:59 -0700
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
        <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: [PATCH v9 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Fri, 16 Apr 2021 10:40:52 +0200
Message-ID: <20210416084054.2922327-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416084054.2922327-1-steen.hegelund@microchip.com>
References: <20210416084054.2922327-1-steen.hegelund@microchip.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.31.1

