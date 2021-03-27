Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75D034B94D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC0U2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 16:28:52 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:46803 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0U2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 16:28:23 -0400
Received: by mail-oo1-f46.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so2094935oof.13;
        Sat, 27 Mar 2021 13:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNZ+EBfgEMxRAYAYmvTpo4CEdtKjfZhi1SZZY27qM3s=;
        b=AKp7L+9zfL9pYjqMX2MmZTVuEQ+Ltl0dai3IB+tstJ9xy5HmlFoaUpSNLWcpwYqyig
         UdK424ak7c3ft95+ihXzti8GiPVqZ9p0CtlvnHhG6ErdWLQ0ghYkyPb1Lbnhchw+yglU
         CJt/8i9Y+55Qq9SjFt9Jy4AO8VZr4D7kgeo3sDhFRm+UiWlCq7yLPR89h+/f+YpoX067
         CBYn6WFhseP1ggbNv4wRhvJlsrL3C6ymyPbqS+YbWyt5C5llQjciPL3+FmVOYeExQCYL
         Fvz1HktSO1fic1blrjwYrfxaIyVBQhtPXqcc/2TSub3UjEhNm6yEAMWnMLdBGdklL+QE
         6yqQ==
X-Gm-Message-State: AOAM530VwpL7iEOonX7osDlvbxJqt8ZUEw+nkZGqQYoQ9tAPU75qFJ9v
        NUGX0Vbqhq2fpfJbx4rwVYuGuLrnKA==
X-Google-Smtp-Source: ABdhPJyjnLnM810IvrzTRnhmp/iGLuoOmVrLr0coFaIMeYBRZJYgtkA8ZNolpD8nyGJ7T8AdW6pCKA==
X-Received: by 2002:a4a:4843:: with SMTP id p64mr16168509ooa.9.1616876902271;
        Sat, 27 Mar 2021 13:28:22 -0700 (PDT)
Received: from localhost.localdomain ([172.58.99.41])
        by smtp.googlemail.com with ESMTPSA id f2sm2788994oos.16.2021.03.27.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 13:28:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: usb-nop-xceiv: Convert to DT schema
Date:   Sat, 27 Mar 2021 15:28:16 -0500
Message-Id: <20210327202816.545282-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the usb-nop-xceiv binding to DT schema.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/usb-nop-xceiv.txt | 43 -------------
 .../bindings/usb/usb-nop-xceiv.yaml           | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
deleted file mode 100644
index 4dc6a8ee3071..000000000000
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-USB NOP PHY
-
-Required properties:
-- compatible: should be usb-nop-xceiv
-- #phy-cells: Must be 0
-
-Optional properties:
-- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
-  /bindings/clock/clock-bindings.txt
-  This property is required if clock-frequency is specified.
-
-- clock-names: Should be "main_clk"
-
-- clock-frequency: the clock frequency (in Hz) that the PHY clock must
-  be configured to.
-
-- vcc-supply: phandle to the regulator that provides power to the PHY.
-
-- reset-gpios: Should specify the GPIO for reset.
-
-- vbus-detect-gpio: should specify the GPIO detecting a VBus insertion
-                    (see Documentation/devicetree/bindings/gpio/gpio.txt)
-- vbus-regulator : should specifiy the regulator supplying current drawn from
-  the VBus line (see Documentation/devicetree/bindings/regulator/regulator.txt).
-
-Example:
-
-	hsusb1_phy {
-		compatible = "usb-nop-xceiv";
-		clock-frequency = <19200000>;
-		clocks = <&osc 0>;
-		clock-names = "main_clk";
-		vcc-supply = <&hsusb1_vcc_regulator>;
-		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
-		vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-		vbus-regulator = <&vbus_regulator>;
-		#phy-cells = <0>;
-	};
-
-hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
-and expects that clock to be configured to 19.2MHz by the NOP PHY driver.
-hsusb1_vcc_regulator provides power to the PHY and GPIO 7 controls RESET.
-GPIO 13 detects VBus insertion, and accordingly notifies the vbus-regulator.
diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
new file mode 100644
index 000000000000..2824c17285ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb-nop-xceiv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB NOP PHY
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: usb-nop-xceiv
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: main_clk
+
+  clock-frequency: true
+
+  '#phy-cells':
+    const: 0
+
+  vcc-supply:
+    description: phandle to the regulator that provides power to the PHY.
+
+  reset-gpios:
+    maxItems: 1
+
+  vbus-detect-gpio:
+    description: Should specify the GPIO detecting a VBus insertion
+    maxItems: 1
+
+  vbus-regulator:
+    description: Should specifiy the regulator supplying current drawn from
+      the VBus line.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    hsusb1_phy {
+        compatible = "usb-nop-xceiv";
+        clock-frequency = <19200000>;
+        clocks = <&osc 0>;
+        clock-names = "main_clk";
+        vcc-supply = <&hsusb1_vcc_regulator>;
+        reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+        vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+        vbus-regulator = <&vbus_regulator>;
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.27.0

