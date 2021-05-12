Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2D37BC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhELMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhELMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:25:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE6C061574;
        Wed, 12 May 2021 05:23:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so26805669edn.7;
        Wed, 12 May 2021 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h78YwhN4xMRG81TSgHUiA3WQy47qC8Yog5neAV6Eqi4=;
        b=GxpHjo4zgfJUFvMOvgJob7xxbs5RyJSfjQRnHhcgZDqQ1odDqvIoaMWSQk2tS0/Jud
         HXH/xxTwMUTpTNfLrODVSNOZErvIkQsOmJdNwCTsQ7qVO9LKoFXAcYUSMjIJGKT0F68w
         CwjkMhDRKpTQvPokjP7aRqb77qyUj3Ht1kBV53vipzKWVc21wvzMErr7FR9wc3n9qe4L
         OVaeT4dV+WMuG0RMRKweRKpdpI4QHdpB0bDRjkaEzHaqnlwgmER84N93v9S1Ulo1/DOx
         53rpK8qeERsNJN45lGvXqHP/6pdWT2fShNqVsxlcfPeQsJf2ICfx6xT/pUYwXD5vrhtQ
         YrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h78YwhN4xMRG81TSgHUiA3WQy47qC8Yog5neAV6Eqi4=;
        b=IKIErsmVYrkex0gyZ9zGmONPXq/OAILN2yo4z+IkQ0miBezm/jeWfg6e6fEsVkRBKE
         5xKxEafHPWiNu+IOq+LuzeliZBgstF5nwr0wgdZ1YkNyEPYgfDr6hdTokE+mDClP09JP
         xBiMDG2bkhfNwRVWjCOs0wt4f6BVm9cTHfYzDM0SjGSxqMEVP35LRfv4sVpfgO+cM8iR
         aGbhu4yokm3wwslJ5FzEhnOVO/ybrrFxZS+1WBW1dxlc0usXLjN+I/lB9l8gXOvHJ0DI
         A+k1yKrghMsuun7sGXaC1wILqLDFEseb6AxZGIWKSWAgpkfi/81KDIy/T/W3mYXW57ZW
         SNlA==
X-Gm-Message-State: AOAM530tzwXN/Eo47DwZ9RuXoe2k55zwsOpiBaJKrNN/05QUvqGugCGE
        6wnypbLReX0X/5qevqiaNAc=
X-Google-Smtp-Source: ABdhPJyv1BPiwNYodi/LIFHzMTIBBJHdn9sS3VErz1e4Sg6wt7/zpEhfHZ8CdiROeHiF8qmL1QtVng==
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr43112715edz.289.1620822235889;
        Wed, 12 May 2021 05:23:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g17sm21459665edv.47.2021.05.12.05.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 05:23:55 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, kishon@ti.com,
        vkoul@kernel.org, jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: phy: convert rockchip-usb-phy.txt to YAML
Date:   Wed, 12 May 2021 14:23:43 +0200
Message-Id: <20210512122346.9463-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210512122346.9463-1-jbx6244@gmail.com>
References: <20210512122346.9463-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with Rockchip 'usbphy' nodes are manually verified.
In order to automate this process rockchip-usb-phy.txt has to be
converted to YAML.

Add "#phy-cells", because it is a required property
by phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   | 52 -------------
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  | 86 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
deleted file mode 100644
index 4ed569046..000000000
--- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-ROCKCHIP USB2 PHY
-
-Required properties:
- - compatible: matching the soc type, one of
-     "rockchip,rk3066a-usb-phy"
-     "rockchip,rk3188-usb-phy"
-     "rockchip,rk3288-usb-phy"
- - #address-cells: should be 1
- - #size-cells: should be 0
-
-Deprecated properties:
- - rockchip,grf : phandle to the syscon managing the "general
-   register files" - phy should be a child of the GRF instead
-
-Sub-nodes:
-Each PHY should be represented as a sub-node.
-
-Sub-nodes
-required properties:
-- #phy-cells: should be 0
-- reg: PHY configure reg address offset in GRF
-		"0x320" - for PHY attach to OTG controller
-		"0x334" - for PHY attach to HOST0 controller
-		"0x348" - for PHY attach to HOST1 controller
-
-Optional Properties:
-- clocks : phandle + clock specifier for the phy clocks
-- clock-names: string, clock name, must be "phyclk"
-- #clock-cells: for users of the phy-pll, should be 0
-- reset-names: Only allow the following entries:
- - phy-reset
-- resets: Must contain an entry for each entry in reset-names.
-- vbus-supply: power-supply phandle for vbus power source
-
-Example:
-
-grf: syscon@ff770000 {
-	compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
-
-...
-
-	usbphy: phy {
-		compatible = "rockchip,rk3288-usb-phy";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usbphy0: usb-phy0 {
-			#phy-cells = <0>;
-			reg = <0x320>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
new file mode 100644
index 000000000..3b6b39da0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip USB2.0 phy
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3288-usb-phy
+      - items:
+          - enum:
+              - rockchip,rk3066a-usb-phy
+              - rockchip,rk3188-usb-phy
+          - const: rockchip,rk3288-usb-phy
+
+  "#phy-cells":
+    const: 0
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "usb-phy@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        const: phyclk
+
+      "#clock-cells":
+        const: 0
+
+      resets:
+        maxItems: 1
+
+      reset-names:
+        const: phy-reset
+
+      vbus-supply:
+        description: phandle for vbus power source
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
+
+examples:
+  - |
+    usbphy: usbphy {
+      compatible = "rockchip,rk3288-usb-phy";
+      #phy-cells = <0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      usbphy0: usb-phy@320 {
+        reg = <0x320>;
+        #phy-cells = <0>;
+      };
+    };
-- 
2.11.0

