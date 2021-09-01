Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE273FD97B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbhIAMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244025AbhIAMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2173E61027;
        Wed,  1 Sep 2021 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630499024;
        bh=N9lbTjJlj0yx4DKnB+275T4Sv/VPSnubH8M17RH0TBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXklHO7Uy4sUYDeL0f/Z8MfUkr8vHf8n6mVhWD4dGBhQLAJpO7AMZWF7QtuhtJ3EJ
         I0XZAxIhiFuqU3tQrfGKvGvO6Ek8t0FOgixYq0MkL/ebp365Wi3gCLhlrONY/g1PWE
         aW2+m6nF/v/rEBIt/lJZ5Khq8d8NT//LUbqgdHy+TIfIPuRlYwQjACHW7CUWtZlKmn
         ksd8GijHVJOItEqf1NFHGKWDyB3lf+xTqGQXPdvvr/iHwO+dp8NPPnUn9t47A4cQYA
         sJj+FaZzbDsNIYZWdFAyHU9lr/8eaJt/WUlghxWZjrFBw6al056W1dmUlMNjY4fpzD
         kLL/HqTv7UG1A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLPHJ-00H8Z1-3L; Wed, 01 Sep 2021 14:23:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Wed,  1 Sep 2021 14:23:37 +0200
Message-Id: <f81388b12162702b925bf1a7d97836982b5cd785.1630498020.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630498020.git.mchehab+huawei@kernel.org>
References: <cover.1630498020.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

This patch adds binding documentation to support USB HUB and
USB data role switch of HiSilicon HiKey960 and HiKey970 boards.

[mchehab: updated OF schema and added HiKey970 example]
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/misc/hisilicon,hikey-usb.yaml    | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
new file mode 100644
index 000000000000..3c2a4ce4d637
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiKey960/970 onboard USB GPIO Hub
+
+maintainers:
+  - John Stultz <john.stultz@linaro.org>
+
+description: |
+  Supports the onboard USB GPIO hub found on HiKey960/970.
+  The HUB, which acts as a role-switch intermediary to detect the state of
+  the USB-C port, to switch the hub into dual-role USB-C or host mode,
+  which enables the onboard USB-A host ports.
+
+  Schematics about the hub can be found here:
+    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
+    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hikey960-usbhub
+      - hisilicon,hikey970-usbhub
+
+  typec-vbus-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the typec-vbus gpio
+
+  otg-switch-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the otg-switch gpio
+
+  hub-reset-en-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the hub reset gpio
+
+  usb-role-switch:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Support role switch.
+
+  hub-vdd-supply:
+    description: regulator for hub power
+
+  port:
+    description: |
+      describe hadware connections between USB endpoints.
+      Two ports are supported: the first being the endpoint that will
+      be notified by this driver, and the second being the endpoint
+      that notifies this driver of a role switch.
+
+required:
+  - compatible
+  - typec-vbus-gpio
+  - otg-switch-gpio
+  - hub-vdd-supply
+  - usb-role-switch
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    hisi_hikey_usb: hisi_hikey_usb {
+        compatible = "hisilicon,hikey960-usbhub";
+        typec-vbus-gpio = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+        otg-switch-gpio = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+        hub-vdd-supply = <&usb_hub>;
+        usb-role-switch;
+        port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            hikey_usb_ep0: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dwc3_role_switch>;
+            };
+            hikey_usb_ep1: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&rt1711h_ep>;
+            };
+        };
+    };
+
+    hisi-hikey-usb: hisi-hikey-usb {
+        compatible = "hisilicon,hikey970-usbhub";
+        typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+        otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+        hub-reset-en-gpios = <&gpio0 3 0>;
+        hub-vdd-supply = <&ldo17>;
+        usb-role-switch;
+        port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            hikey_usb_ep0: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dwc3_role_switch>;
+            };
+            hikey_usb_ep1: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&rt1711h_ep>;
+            };
+        };
+    };
-- 
2.31.1

