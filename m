Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC943E139
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJ1MtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:49:22 -0400
Received: from ixit.cz ([94.230.151.217]:34996 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1MtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:49:21 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7E2E920064;
        Thu, 28 Oct 2021 14:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635425212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xgjicstCdETA5yD5ttEWNXkXTM7bl4gND1HVg9nbOM0=;
        b=bskFoIBb0rfqZ7feenbLCcXO2DyUOYsS0T3S4f0eDorElFK3n0LR9Sg27Xxe1VH0JIbwUy
        k69E186equqEEVhEasOPu7wLy8AbJzwhKCou3wg2BBemgdxs9a8Cda8cECE0B/6x0/kuEY
        cyGQkZWM6cCrvzaLVFhzto39fzb+6ug=
From:   David Heidelberg <david@ixit.cz>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings to yaml
Date:   Thu, 28 Oct 2021 14:46:38 +0200
Message-Id: <20211028124639.38420-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
binding documentation to json-schema.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/sound/wlf,wm8903.yaml | 116 ++++++++++++++++++
 .../devicetree/bindings/sound/wm8903.txt      |  82 -------------
 2 files changed, 116 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8903.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
new file mode 100644
index 000000000000..7105ed5fd6c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/wlf,wm8903.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: WM8903 audio codec
+
+description: |
+  This device supports I2C only.
+  Pins on the device (for linking into audio routes):
+      * IN1L
+      * IN1R
+      * IN2L
+      * IN2R
+      * IN3L
+      * IN3R
+      * DMICDAT
+      * HPOUTL
+      * HPOUTR
+      * LINEOUTL
+      * LINEOUTR
+      * LOP
+      * LON
+      * ROP
+      * RON
+      * MICBIAS
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  compatible:
+    const: wlf,wm8903
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  micdet-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: Default register value for R6 (Mic Bias).
+
+  micdet-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 100
+    description: The debounce delay for microphone detection in mS.
+
+  gpio-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      minItems: 5
+      maxItems: 5
+      A list of GPIO configuration register values.
+      If absent, no configuration of these registers is performed.
+      If any entry has the value 0xffffffff, that GPIO's
+      configuration will not be modified.
+
+  AVDD-supply:
+    description: Analog power supply regulator on the AVDD pin.
+
+  CPVDD-supply:
+    description: Charge pump supply regulator on the CPVDD pin.
+
+  DBVDD-supply:
+    description: Digital buffer supply regulator for the DBVDD pin.
+
+  DCVDD-supply:
+    description: Digital core supply regulator for the DCVDD pin.
+
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      wm8903: codec@1a {
+        compatible = "wlf,wm8903";
+        reg = <0x1a>;
+        interrupts = <347>;
+
+        AVDD-supply = <&fooreg_a>;
+        CPVDD-supply = <&fooreg_b>;
+        DBVDD-supply = <&fooreg_c>;
+        DCVDD-supply = <&fooreg_d>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        micdet-cfg = <0>;
+        micdet-delay = <100>;
+        gpio-cfg = <
+          0x0600 /* DMIC_LR, output */
+          0x0680 /* DMIC_DAT, input */
+          0x0000 /* GPIO, output, low */
+          0x0200 /* Interrupt, output */
+          0x01a0 /* BCLK, input, active high */
+        >;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt
deleted file mode 100644
index 6371c2434afe..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8903.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-WM8903 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "wlf,wm8903"
-
-  - reg : the I2C address of the device.
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-
-  - #gpio-cells : Should be two. The first cell is the pin number and the
-    second cell is used to specify optional parameters (currently unused).
-
-Optional properties:
-
-  - interrupts : The interrupt line the codec is connected to.
-
-  - micdet-cfg : Default register value for R6 (Mic Bias). If absent, the
-    default is 0.
-
-  - micdet-delay : The debounce delay for microphone detection in mS. If
-    absent, the default is 100.
-
-  - gpio-cfg : A list of GPIO configuration register values. The list must
-    be 5 entries long. If absent, no configuration of these registers is
-    performed. If any entry has the value 0xffffffff, that GPIO's
-    configuration will not be modified.
-
-  - AVDD-supply : Analog power supply regulator on the AVDD pin.
-
-  - CPVDD-supply : Charge pump supply regulator on the CPVDD pin.
-
-  - DBVDD-supply : Digital buffer supply regulator for the DBVDD pin.
-
-  - DCVDD-supply : Digital core supply regulator for the DCVDD pin.
-
-Pins on the device (for linking into audio routes):
-
-  * IN1L
-  * IN1R
-  * IN2L
-  * IN2R
-  * IN3L
-  * IN3R
-  * DMICDAT
-  * HPOUTL
-  * HPOUTR
-  * LINEOUTL
-  * LINEOUTR
-  * LOP
-  * LON
-  * ROP
-  * RON
-  * MICBIAS
-
-Example:
-
-wm8903: codec@1a {
-	compatible = "wlf,wm8903";
-	reg = <0x1a>;
-	interrupts = < 347 >;
-
-	AVDD-supply = <&fooreg_a>;
-	CPVDD-supply = <&fooreg_b>;
-	DBVDD-supply = <&fooreg_c>;
-	DCVDC-supply = <&fooreg_d>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	micdet-cfg = <0>;
-	micdet-delay = <100>;
-	gpio-cfg = <
-		0x0600 /* DMIC_LR, output */
-		0x0680 /* DMIC_DAT, input */
-		0x0000 /* GPIO, output, low */
-		0x0200 /* Interrupt, output */
-		0x01a0 /* BCLK, input, active high */
-	>;
-};
-- 
2.33.0

