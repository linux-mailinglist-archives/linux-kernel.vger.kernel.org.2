Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C504D36F461
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhD3DUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:20:09 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57607 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhD3DUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:20:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 958CC5809A8;
        Thu, 29 Apr 2021 23:19:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 29 Apr 2021 23:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zsgS/p6h6LoM1
        J8DV/As4w6mpp5Hjtcaqy0MGncfGb0=; b=IVsYgx6Erbps3DgoGNfDzo/Dnv+W7
        sX5dHISsksPYcGH8ivoGx0d37/qXrbx4dN2E9pMrSfWk156r1MjXW+PL2AkoYwpL
        gamy1ihTjJAvFO7V8QHuf1YGlt2vj5va4P6f/hXR+v4sXxi3n0fpXF/0rKIVHFGF
        Q21OZw4lYHlG7/DMPZHW9XgLSuX2nNIDcuZA4SCd3HtDbochEMAlksxcsRA9lz/q
        AyyF0QDLkKCBRA42ccZcoCU21kk3TFI4aLRsS0oRW379U2jMEZ7kbL6H0HBwCyJ2
        Lx4n3Xqssv2f7dzcibMzdD1cdzd+8WuHI1tHWGoyuv+/Tn7UjlaUiBOPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zsgS/p6h6LoM1J8DV/As4w6mpp5Hjtcaqy0MGncfGb0=; b=cNpNOlW3
        AuctOc5lh4O+sPjFtMK1RMY968PFYAz7eSWZbjlBu6Lau8lCjrZyx37CAwKzeimQ
        FWcVe4FooA9Bfd6xhZccFK90XH9oKWonQzLqce1ao5iRZ7gPrEgqJg8s7Udc/2PG
        JJ5iZrROaVgXo9bF6hT9mnmLdsZX9h58wUu4T+i+qd218gvwBOfWJfRFlFKkUjz7
        AcpAu5yhUvRYvTd073ME2qESj9owFvADP7kvBy8QXnb8tufzZ9EKmhPvbCK9/Os4
        lkqUrfW+RkPD6ylOAlcxwszxRmyJ7LEdZFNu2oH/pFLVMCUR29KsaC1ZVXs7v+gP
        c93znQ4HxEO5Ig==
X-ME-Sender: <xms:M3eLYNjtvhRbxk22WIaCiCeU3NWSqXS-MkxmYqaNXnGM_rUzWxRwUg>
    <xme:M3eLYCBxETrowlmwqaUuZ3TF2_rhPQb9TIjXbAg9KVbgm8M4nnomJa4DnRBQX2dkk
    jaAp6BiqOCmZkCUgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:M3eLYNFC8GXIGtFuqHo6fiMUzeMqh7U3bf1itF7AsFd8vL6vo_mePA>
    <xmx:M3eLYCSl415GyMNpwJo0Q7eUWFdkqPueByMA0QueLZh03rgR0ioUiA>
    <xmx:M3eLYKxsv57SBgwKU2whVxQ9R6ua7cFv2litdS8_T4Ft5jMXtexVmw>
    <xmx:M3eLYOdWfFB-em7dvyZR1KTlNMemnElENRiScqLKaZZdafj46dZG4g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 23:19:14 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3 glue
Date:   Thu, 29 Apr 2021 22:19:11 -0500
Message-Id: <20210430031912.42252-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430031912.42252-1-samuel@sholland.org>
References: <20210430031912.42252-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RST_BUS_XHCI reset line in the H6 affects both the DWC3 core and the
USB3 PHY. This suggests the reset line controls the USB3 IP as a whole.
Represent this by attaching the reset line to a glue layer device.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
new file mode 100644
index 000000000000..936b5c74043f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/allwinner,sun50i-h6-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 DWC3 USB controller
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  compatible:
+    const: allwinner,sun50i-h6-dwc3
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges: true
+
+  resets:
+    maxItems: 1
+
+# Required child node:
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    $ref: ../phy/allwinner,sun50i-h6-usb3-phy.yaml#
+
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - ranges
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    usb3: usb@5200000 {
+        compatible = "allwinner,sun50i-h6-dwc3";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        resets = <&ccu RST_BUS_XHCI>;
+
+        dwc3: usb@5200000 {
+            compatible = "snps,dwc3";
+            reg = <0x05200000 0x10000>;
+            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&ccu CLK_BUS_XHCI>,
+                     <&ccu CLK_BUS_XHCI>,
+                     <&rtc 0>;
+            clock-names = "ref", "bus_early", "suspend";
+            dr_mode = "host";
+            phys = <&usb3phy>;
+            phy-names = "usb3-phy";
+        };
+
+        usb3phy: phy@5210000 {
+            compatible = "allwinner,sun50i-h6-usb3-phy";
+            reg = <0x5210000 0x10000>;
+            clocks = <&ccu CLK_USB_PHY1>;
+            resets = <&ccu RST_USB_PHY1>;
+            #phy-cells = <0>;
+        };
+    };
-- 
2.26.3

