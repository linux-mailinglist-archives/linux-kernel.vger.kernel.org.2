Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1EB34D9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhC2Veo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:34:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59118 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhC2VeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617053663; x=1648589663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWx43zybGRl1W27p9a+ZDxPm9DfxI4SvhhqG+hpqZdM=;
  b=NI+bpox3aTFUCh3eEtHk4oejKBYCKODzlWWkaw46vWSDup+8wEyqaw2P
   vsMxMyhHAV61KPpxQGamIXdKohy51ZJ8Az8+eM89BIpcROzs1LsXS2+H2
   wt1jnNvHVKeZPh4+zvfLFyd4L680K5b//io1WhjWNNdP8vUBHacTv31hE
   11AVly44vwSkABQ/BKpAahE17vhZeUTBhyhIKqzZ9a4YCmlqxriPDF6mw
   EKSGe7AayTJM/2IN4K0zuqahhZo43mRz2qokYNXhK5o8PkSH8br1c6Qqd
   nRiFrwrZKKq2CqTgz0RCkPzv45/7IG7f05EXnMAlz8WSCgyVJBkyxfN2m
   g==;
IronPort-SDR: iefPtK5uxMlxkdDHD7Vev5kR4mG6QfjN2IgOtowILKunWOzNxjffjAzlxGimrrKyk5ea/4bLMi
 DRaOMbuXsvamjHuoyrS6Wnsoc9q7Ux3xmJocfreKnaVWsl2bpzTncfD/rHLd2y4yAR4mZwCvAZ
 +4YP/vz7oYHWZWRNSSDYzULLZoWXQjkSQkX+BIEcrfBsuuLz5sphDfXH2zosQosWxOmTIgN/Gq
 6OlIV3ZI3NXwUWmrDeZvCp5cLVsX2IsESTCzjME2HBdVU2W9aHqeLEH22TYfbbl/m1A9RtXD7j
 FP8=
X-IronPort-AV: E=Sophos;i="5.81,288,1610434800"; 
   d="scan'208";a="115079638"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 14:34:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 14:34:22 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 14:34:20 -0700
From:   <cristian.birsan@microchip.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [RFC PATCH 1/2] dt-bindings: usb: Add DT bindings for Microchip sama7g5 tcpc
Date:   Tue, 30 Mar 2021 00:33:56 +0300
Message-ID: <20210329213357.431083-2-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329213357.431083-1-cristian.birsan@microchip.com>
References: <20210329213357.431083-1-cristian.birsan@microchip.com>
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
 .../bindings/usb/microchip,sama7g5-tcpc.yaml  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
new file mode 100644
index 000000000000..e1b80957e111
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,sama7g5-tcpc.yaml
@@ -0,0 +1,80 @@
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
+      compatible = "microchip,sama7g5-typec";
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

