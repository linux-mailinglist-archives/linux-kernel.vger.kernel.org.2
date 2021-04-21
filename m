Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CFE36648C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhDUE3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:29:14 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46631 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhDUE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:29:10 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 18C0B580E2F;
        Wed, 21 Apr 2021 00:28:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Apr 2021 00:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7ftHhxVB5eXEL
        G1y8+aU0dRkGQEOD2zNCoIhNhEyKAw=; b=QWwdL+2L5oBlgMrit6PZ9xAdPLH+K
        jMt/UcIRg77wRDPDvyiB5MkV4B9o4CV/Wux4jks2GUbrQKx4HxcDFgK4kDw/pZTf
        XP9lxzECFOve6GRnMDNEuOFSJwRp4INtexB6j72B/c2bVLp7sh/35/wRzTSwJiuV
        ivh2DV9npRPD/H1azYj/cDSsNRkchPQwuMTNLF3fl6NaBk6Q8DJPHDvVSeWQWn4i
        rA4NHuWQ8ln0nK7VNGD/ZzfZ1zn46AeumnuqKAKmV+HgXRAx+1EAJZc0RRvetlgZ
        nR/9qtZhWwu+E5iwhKVk+f2AQ5P+8YVgMKxlyitYAl0EzMmdnm6RWfwjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7ftHhxVB5eXELG1y8+aU0dRkGQEOD2zNCoIhNhEyKAw=; b=W6J1FID5
        d9IiiDxATMQY1qGxuDlSmfTtPe6r7g2KZukdJZ0A/KWWE9sajIfC6vgiA8o2soRN
        QYWAy7O9y/8K8t4QDEro7VESCDWI3eMxDc9rTTHRlqh8owScdrfeXDEAle67tO8e
        8fnxML2qQV1Clu3qS7t1p128TUTdZL1UmT3u7lsTrkkqdz7cJGK+gfmhjlKSN6ry
        psDPqJFesUyHD5XWmQ2Ata83+W0ZMA+0IhyS38ITrI57YHlwY9L5pcz8y4yFLeJV
        sU+1E5C+fRJoalE8SRUPuQPItcF0xmd7tYDMZ1hdlDmAmOmcLhIyJ1tPR3Qfagj+
        05HTQTt7T7HnpQ==
X-ME-Sender: <xms:9Kl_YJdC8lu6HqLVVSVbu69KT78FcVwVechSxmHfFxpGZJ2uK8f4Gw>
    <xme:9Kl_YHMgJGuFs4NQ7zvaGuOkMsAoW6l_zHo-ZmCz38aRZ-kIPNglrmf4IEKeDbUf6
    5rt9y_6hetUGtfATw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9Kl_YCh77a4gz06h_-tBhYXJJC0y1XsFSnRLjtnNsObsoZbLcSIwvA>
    <xmx:9Kl_YC_MhlUQ2l9a5K8bHxsfYUySRuTvx560uvge-uDNHDEkkNvSIw>
    <xmx:9Kl_YFvubr_gwIbWLRBgW0dAdE-lojGFLasxMnQsKOwtVypQl-R9jQ>
    <xmx:9ql_YLB9EUu-3PnLdvzc0z95FlKuOOcU7KHf1eDlgfQHc2g1d9j_Mg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A6AD240066;
        Wed, 21 Apr 2021 00:28:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3 glue
Date:   Tue, 20 Apr 2021 23:28:33 -0500
Message-Id: <20210421042834.27309-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421042834.27309-1-samuel@sholland.org>
References: <20210421042834.27309-1-samuel@sholland.org>
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
index 000000000000..86efd6d21ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/allwinner,sun50i-h6-dwc3#
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
+    $ref: allwinner,sun50i-h6-usb3-phy.yaml#
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

