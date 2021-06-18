Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C93AC776
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhFRJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:31:57 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232640AbhFRJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:31:55 -0400
X-UUID: c39ff8a565b447fb8dcf05c9e8d20529-20210618
X-UUID: c39ff8a565b447fb8dcf05c9e8d20529-20210618
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906582260; Fri, 18 Jun 2021 17:29:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 17:29:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 17:29:24 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/13] dt-bindings: usb: mtu3: remove support VBUS detection of extcon
Date:   Fri, 18 Jun 2021 17:29:06 +0800
Message-ID: <1624008558-16949-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 683F4A938518A05BE0FAEA58AB85DE011FA94647943A74AC8979B9B37CEBA1692000:8
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

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
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

