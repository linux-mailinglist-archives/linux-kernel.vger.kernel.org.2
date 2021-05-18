Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2838832B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhERXaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:30:39 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35813 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbhERXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:30:26 -0400
Received: by mail-ot1-f41.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so10174475otg.2;
        Tue, 18 May 2021 16:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tznLAoW/H/BXwcG+qjqbkNuE2MqDDRn3toY3xzTYmA=;
        b=M+CnmK36B7uJoiaZWyHKFqsUsosjwXm9XIjf8WH6c0Dvp2EbT9JogcinOn1gJHFeHB
         jsBjmtFzgEomPgPCkCGrNmalSTv0KtmecjYsmNMWbDDAT8xsY+9T0qwKATBms/QhNc+u
         VMt4WDjnJQZAeAjDqaA79eK5t0VLCiNgOx3YodDcXigM3H7vdpnj2Jnqq3lgE8LH+FmX
         4x8wFQEvSykMCDZV1ZSWIeW6DkZRMjF3dIPFyoisnT0FHvYV2Ena13sp3YTrAgm1M3Ho
         /uwkFDsszlEK4pkrsmAcGJldo91XRHy5o+xg54AI1XvE0Jw5KiPKpr133cwXv7H+PbT6
         jIRw==
X-Gm-Message-State: AOAM533aFRXFEu+rahDuhPkGaxeGf7arl/VNNOsUU+dOc1+iIUPO+mmG
        /Z2uXw//YUA32afLqaHYSX/muMXtZQ==
X-Google-Smtp-Source: ABdhPJwBlUAMVWSjjsTdGyMAtvojq/C1sSoYaw30a+vKKLTxvfnvgBtHXSjFUFkw/Owi7iNxs7qH9Q==
X-Received: by 2002:a9d:c24:: with SMTP id 33mr6029092otr.289.1621380547123;
        Tue, 18 May 2021 16:29:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d19sm3985608oop.26.2021.05.18.16.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:29:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/6] dt-bindings: i2c: i2c-mux-pca954x: Convert to DT schema
Date:   Tue, 18 May 2021 18:28:57 -0500
Message-Id: <20210518232858.1535403-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518232858.1535403-1-robh@kernel.org>
References: <20210518232858.1535403-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/i2c/i2c-mux-pca954x.txt          |  74 ------------
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 106 ++++++++++++++++++
 2 files changed, 106 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
deleted file mode 100644
index 9f3f3eb67e87..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-* NXP PCA954x I2C bus switch
-
-The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
-
-Required Properties:
-
-  - compatible: Must contain one of the following.
-    "nxp,pca9540",
-    "nxp,pca9542",
-    "nxp,pca9543",
-    "nxp,pca9544",
-    "nxp,pca9545",
-    "nxp,pca9546", "nxp,pca9846",
-    "nxp,pca9547", "nxp,pca9847",
-    "nxp,pca9548", "nxp,pca9848",
-    "nxp,pca9849"
-
-  - reg: The I2C address of the device.
-
-  The following required properties are defined externally:
-
-  - Standard I2C mux properties. See i2c-mux.txt in this directory.
-  - I2C child bus nodes. See i2c-mux.txt in this directory.
-
-Optional Properties:
-
-  - reset-gpios: Reference to the GPIO connected to the reset input.
-  - idle-state: if present, overrides i2c-mux-idle-disconnect,
-    Please refer to Documentation/devicetree/bindings/mux/mux-controller.yaml
-  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
-    children in idle state. This is necessary for example, if there are several
-    multiplexers on the bus and the devices behind them use same I2C addresses.
-  - interrupts: Interrupt mapping for IRQ.
-  - interrupt-controller: Marks the device node as an interrupt controller.
-  - #interrupt-cells : Should be two.
-    - first cell is the pin number
-    - second cell is used to specify flags.
-    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example:
-
-	i2c-switch@74 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x74>;
-
-		interrupt-parent = <&ipic>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-
-			eeprom@54 {
-				compatible = "atmel,24c08";
-				reg = <0x54>;
-			};
-		};
-
-		i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-
-			rtc@51 {
-				compatible = "nxp,pcf8563";
-				reg = <0x51>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
new file mode 100644
index 000000000000..82d9101098c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCA954x I2C bus switch
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description:
+  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-mux.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,pca9540
+      - nxp,pca9542
+      - nxp,pca9543
+      - nxp,pca9544
+      - nxp,pca9545
+      - nxp,pca9546
+      - nxp,pca9547
+      - nxp,pca9548
+      - nxp,pca9849
+      - nxp,pca9846
+      - nxp,pca9847
+      - nxp,pca9848
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  reset-gpios:
+    maxItems: 1
+
+  i2c-mux-idle-disconnect:
+    type: boolean
+    description: Forces mux to disconnect all children in idle state. This is
+      necessary for example, if there are several multiplexers on the bus and
+      the devices behind them use same I2C addresses.
+
+  idle-state:
+    description: if present, overrides i2c-mux-idle-disconnect
+    $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-mux@74 {
+            compatible = "nxp,pca9548";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x74>;
+
+            interrupt-parent = <&ipic>;
+            interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            i2c@2 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <2>;
+
+                eeprom@54 {
+                    compatible = "atmel,24c08";
+                    reg = <0x54>;
+                };
+            };
+
+            i2c@4 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <4>;
+
+                rtc@51 {
+                    compatible = "nxp,pcf8563";
+                    reg = <0x51>;
+                };
+            };
+        };
+    };
+...
-- 
2.27.0

