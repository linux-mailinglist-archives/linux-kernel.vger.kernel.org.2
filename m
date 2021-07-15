Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F163C9B00
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhGOJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39712 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233990AbhGOJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:08 -0400
X-UUID: d1e94a29d8c04b5485a33be92c890379-20210715
X-UUID: d1e94a29d8c04b5485a33be92c890379-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1267127530; Thu, 15 Jul 2021 17:08:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:12 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:11 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v3 01/13] dt-bindings: usb: mtu3: remove support VBUS detection of extcon
Date:   Thu, 15 Jul 2021 17:07:46 +0800
Message-ID: <1626340078-29111-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to no platforms use a multi-funtion pin to detect VBUS
status until now when support dual role mode, prefer not to
support it anymore;
Another reason is that the controller doesn't support idle status,
the dual role port works as device or as host, using an IDDIG pin
is good enough, this will help to save another multi-function pin;
And fix a typo of 'neede';
Last modify example using VBUS to turn on/off device, for device
only mode, the driver doesn't get extcon.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add Acked-by Rob
v2: no changes
---
 .../bindings/usb/mediatek,mtu3.yaml           | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index dbc7876e0a0b..2cac7a87ce36 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -106,7 +106,7 @@ properties:
   extcon:
     deprecated: true
     description: |
-      Phandle to the extcon device detecting the IDDIG/VBUS state, neede
+      Phandle to the extcon device detecting the IDDIG state, needed
       when supports dual-role mode.
       It's considered valid for compatibility reasons, not allowed for
       new bindings, and use "usb-role-switch" property instead.
@@ -230,7 +230,7 @@ examples:
         };
     };
 
-  # Enable/disable device by an input gpio for VBUS pin
+  # Dual role switch by gpio-usb-b-connector
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/power/mt2712-power.h>
@@ -244,13 +244,27 @@ examples:
         power-domains = <&scpsys MT2712_POWER_DOMAIN_USB2>;
         clocks = <&topckgen CLK_TOP_USB30_SEL>;
         clock-names = "sys_ck";
-        dr_mode = "peripheral";
+        dr_mode = "otg";
         usb-role-switch;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        host0: usb@11270000 {
+            compatible = "mediatek,mt2712-xhci", "mediatek,mtk-xhci";
+            reg = <0x11270000 0x1000>;
+            reg-names = "mac";
+            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_LOW>;
+            power-domains = <&scpsys MT2712_POWER_DOMAIN_USB>;
+            clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+            clock-names = "sys_ck", "ref_ck";
+        };
 
         connector {
             compatible = "gpio-usb-b-connector", "usb-b-connector";
             type = "micro";
-            vbus-gpios = <&pio 13 GPIO_ACTIVE_HIGH>;
+            id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+            vbus-supply = <&usb_p0_vbus>;
         };
     };
 
-- 
2.18.0

