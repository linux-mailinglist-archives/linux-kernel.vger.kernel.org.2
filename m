Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D734F296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhC3UzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:55:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29082 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhC3Uy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617137698; x=1648673698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36S8RefdtUzrcOiTkGB2HLXMtjGzysrAUbtbu1BvxSE=;
  b=elK3MNJjBhVrkawwqxhEO0Jx+jjquoJBRtqb+gFxr62vSP/yIJnNmmSL
   xWmGfuXSk5vPuQzmt/9Zp2TxIyDfF4b9g5yeIKm/BMyKuF8/rV08oS/iA
   jqnlKJqetLkdh671O+bk9qqbx0lT0JKKpjZAPhKeZqJuJPlwyd9RTY18t
   z9dXEf9fTNW+6exjQKNFm++CoX/5tiNIFCLukf1e0XRtivFP0tAdvUClJ
   Ua/574gVBLddWR4r8GAnFE5m9F1Gn+2EiI9KTnIJH6Ffzu92t/8G4L+w8
   dIQRGALyEU+HUu3txyri1LvoS23fbSvEhPdr0W6jATPyNlbmUgHNFAnY0
   Q==;
IronPort-SDR: hsq9WKfuqvnsbVGBM5d0wbXEH3TSCLVDbKXuuteQhdLFIBx0xg/RRg7F25KuZcCMAzxEB75UHx
 CJ7LtrdLUKeC5uroDwQNa8Mpko3ADu63mE8vzuSHHf8nOv2+/+zzFzW6wPthL3YMgFrQPKdPT2
 HTMfMg9nmMt/Bb018SyqDoZHaPAtoSyp+8cxugbUBGkLyCz0xXbstig88LtsjiyD+Kpcmuw6aW
 x2bn0eLJISBEL7usxwrTnPcD/XQz6m2m5cUVGliSsaz4JOlpUH9whrOEK1BVnmcu/3+jNRqVBI
 WpY=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="121143933"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 13:54:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 13:54:57 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 30 Mar 2021 13:54:55 -0700
From:   <cristian.birsan@microchip.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [RFC PATCH v2 1/2] dt-bindings: usb: Add DT bindings for Microchip sama7g5 tcpc
Date:   Tue, 30 Mar 2021 23:54:41 +0300
Message-ID: <20210330205442.981649-2-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330205442.981649-1-cristian.birsan@microchip.com>
References: <20210330205442.981649-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch adds DT bindings for the new Microchip USB Type-C Port
Controller (TCPC) embedded in sama7g5 SoC.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 .../bindings/usb/microchip,sama7g5-tcpc.yaml  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
new file mode 100644
index 000000000000..2d3289dd9ac9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/microchip,sama7g5-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip SAMA7G5 Type-C port controller bindings
+
+maintainers:
+  - Cristian Birsan <cristian.birsan@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,sama7g5-tcpc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  vbus-supply:
+    description: vbus power supply (5V) phandle
+
+  microchip,vbus-gpio:
+    description: vbus detect gpio
+
+  connector:
+    type: object
+
+    allOf:
+      - $ref: ../connector/usb-connector.yaml
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/usb/pd.h>
+    tcpcb: tcpcb@e0844000 {
+      compatible = "microchip,sama7g5-tcpc";
+      reg = <0xe0844000 0x3fff>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 95>, <&pmc PMC_TYPE_GCK 95>;
+      clock-names = "pclk", "gclk";
+
+      usb_con: connector {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "usb-c-connector";
+        label = "USB-C";
+        data-role = "device";
+        power-role = "sink";
+        try-power-role = "sink";
+        source-pdos = <PDO_FIXED(5000, 500,
+            PDO_FIXED_USB_COMM)>;
+        sink-pdos = <PDO_FIXED(5000, 500,
+            PDO_FIXED_USB_COMM)>;
+        op-sink-microwatt = <2500000>;
+
+        port@1 {
+          reg = <1>;
+          usb_con_hs: endpoint {
+            remote-endpoint = <&usb_phy1>;
+          };
+        };
+      };
+    };
+...
-- 
2.25.1

