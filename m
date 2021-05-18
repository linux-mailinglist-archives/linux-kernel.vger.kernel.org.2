Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF82387E06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350982AbhERQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbhERQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:58:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88FC061761;
        Tue, 18 May 2021 09:57:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so15643662ejc.10;
        Tue, 18 May 2021 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9oPRfPgvlocsiFSFvUCwi7MVnKk8KLH2Kuos4BaavcY=;
        b=cghBxpZFSevRzbEgKl7VhA9nz/fSgraSrimImam6yAKQKBSkBGsPWjwI5QuM0VBmsE
         qQQbQb592yxCuFGGkSLA7ty20d1ziFzo1aAxUz03mz163b+1HfCiWLwjcQHqelYgsh+N
         8PtRQzblyIRPM3JLXtJhlTVuKKg7ncK36677r1cFjLK2hc+ZCSmQ/AZIFwAXTA6Zihok
         YmXM02vTutIvJImNqvx5yDo8c+c9Q7FKAydTTFM6PloiwtDY00lw9KI0y2JBsZLGBpRy
         QVSJl/LIOSpLcnayblLzW8UdIRpcbmVj6L2i4L5eV1/Vu5FuRqay/7EYUQcrqUiJpVuT
         Fw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9oPRfPgvlocsiFSFvUCwi7MVnKk8KLH2Kuos4BaavcY=;
        b=XsL9S4a8c9aqzfBvgm+7b8Kic6ErcKEskOPQ2NoO9k7IbvS9Lf1iIXp8rJG8Dr9fDd
         cE6+7RL4McaCdUMb+AJufNJPPvjYWD+tQaty140UFRToWtj2jyAxjgOs6BHAedRX+T34
         R/wA6T51/wiAE+kC4+Ix2gdTVADfUosYPmR0F7c532Jj4Mouk8EzAK/hRqw3wmc5C6kc
         Z2Yp84qajVWCXnK4kIOT16LCDK7Yvu4h/pYgBvuA88H5HkdL+F9ZtZdmRZ+UjLkX6UKs
         Jj05wd8bnEB1Mvg9kWp55SpwUqYEPGgO/rBo2tP17c7ed5P7gRPPjUHDMALz2mLmH7Au
         cg6g==
X-Gm-Message-State: AOAM532e7mxlgbWD3AOtFyDXtb1IEgMOosMsVt7E+syGoysPB0B0qnmN
        avbe7zPo/I487I+uVlOg4DM=
X-Google-Smtp-Source: ABdhPJyCiaDiRFlxOOXYERxZFxdFggZiuFqEaCfF6xubgjYHPNusrJLBmpzhmi+IDAWRg3VzSMoy3Q==
X-Received: by 2002:a17:906:b0d:: with SMTP id u13mr6749791ejg.159.1621357028351;
        Tue, 18 May 2021 09:57:08 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm13525676edi.32.2021.05.18.09.57.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 09:57:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: phy: convert rockchip-usb-phy.txt to YAML
Date:   Tue, 18 May 2021 18:56:55 +0200
Message-Id: <20210518165658.12764-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210518165658.12764-1-jbx6244@gmail.com>
References: <20210518165658.12764-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with Rockchip 'usbphy' nodes are manually verified.
In order to automate this process rockchip-usb-phy.txt has to be
converted to YAML.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6
  remove some #phy-cells
---
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   | 52 --------------
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  | 81 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 52 deletions(-)
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
index 000000000..f0fc8275d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
@@ -0,0 +1,81 @@
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
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
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

