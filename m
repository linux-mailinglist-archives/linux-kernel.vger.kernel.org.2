Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499342791A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhJIKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:46:39 -0400
Received: from ixit.cz ([94.230.151.217]:41654 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244544AbhJIKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:46:34 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AEA0420064;
        Sat,  9 Oct 2021 12:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633776274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s131/szhZQJcT42zguyRZMn4H+/xcH/hdWtFJwYz2wM=;
        b=IVjXIfoPDUx3s9ZIJzF8H6DZPht0ohiIk2KPyZjZA1nZ4w3/VEKHpcw0I0rbLAp6nhBd23
        8JuCsTaJ+D+VB1rcCXhbzNpHll4UVWMkfF7Pa8q+7Z1nbzNIU1buNlbVPJaccPo0/PLU+Q
        vLjqxSRB4wm+eMuHZKDcnUrvK38dLCQ=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt bindings to yaml
Date:   Sat,  9 Oct 2021 12:43:09 +0200
Message-Id: <20211009104309.45117-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert fan devices connected to GPIOs to the YAML syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
 .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
deleted file mode 100644
index f4cfa350f6a1..000000000000
--- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Bindings for fan connected to GPIO lines
-
-Required properties:
-- compatible : "gpio-fan"
-
-Optional properties:
-- gpios: Specifies the pins that map to bits in the control value,
-  ordered MSB-->LSB.
-- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
-  control value that should be set to achieve them. This array
-  must have the RPM values in ascending order.
-- alarm-gpios: This pin going active indicates something is wrong with
-  the fan, and a udev event will be fired.
-- #cooling-cells: If used as a cooling device, must be <2>
-  Also see:
-  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-  min and max states are derived from the speed-map of the fan.
-
-Note: At least one the "gpios" or "alarm-gpios" properties must be set.
-
-Examples:
-
-	gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio1 14 1
-			 &gpio1 13 1>;
-		gpio-fan,speed-map = <0    0
-				      3000 1
-				      6000 2>;
-		alarm-gpios = <&gpio1 15 1>;
-	};
-	gpio_fan_cool: gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio2 14 1
-			 &gpio2 13 1>;
-		gpio-fan,speed-map =	<0    0>,
-					<3000 1>,
-					<6000 2>;
-		alarm-gpios = <&gpio2 15 1>;
-		#cooling-cells = <2>; /* min followed by max */
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
new file mode 100644
index 000000000000..e2db65d58a92
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/hwmon/gpio-fan.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bindings for fan connected to GPIO lines
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  compatible:
+    const: gpio-fan
+
+  gpios:
+    description: |
+      Specifies the pins that map to bits in the control value,
+      ordered MSB-->LSB.
+
+  gpio-fan,speed-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 254
+    description: |
+      A mapping of possible fan RPM speeds and the
+      control value that should be set to achieve them. This array
+      must have the RPM values in ascending order.
+
+  alarm-gpios:
+    description: |
+      This pin going active indicates something is wrong with
+      the fan, and a udev event will be fired.
+
+  '#cooling-cells':
+    const: 2
+
+required:
+  - compatible
+  - gpio-fan,speed-map
+
+anyOf:
+  - required: [gpios]
+  - required: [alarm-gpios]
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio_fan {
+      compatible = "gpio-fan";
+      gpios = <&gpio1 14 1
+               &gpio1 13 1>;
+      gpio-fan,speed-map = <0    0
+                            3000 1
+                            6000 2>;
+      alarm-gpios = <&gpio1 15 1>;
+    };
+  - |
+    gpio_fan_cool: gpio_fan {
+      compatible = "gpio-fan";
+      gpios = <&gpio2 14 1
+               &gpio2 13 1>;
+      gpio-fan,speed-map = <0    0
+                            3000 1
+                            6000 2>;
+      alarm-gpios = <&gpio2 15 1>;
+      #cooling-cells = <2>; /* min followed by max */
+    };
-- 
2.33.0

