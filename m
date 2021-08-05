Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E261A3E12AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbhHEKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239963AbhHEKbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA33360E53;
        Thu,  5 Aug 2021 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628159465;
        bh=zu65XBxVpjazUM+E3UnPxlO5E9qLFLV5tZCxDuJiUn0=;
        h=From:To:Cc:Subject:Date:From;
        b=esZv8NEBCw/H058ypgv7duUMbhNpcjKvelWwVJyDb5lqwcngKNGQCch/nzhIiM16b
         8hRI640nTCrXhbIMbiyxXwhi1jXYLBIm5G5D9PBwP2mu5iB4wchAq+Wg3O1WMH8mFo
         hxsld+meCSwNjHTcln0DIjUbEUY34WDicdyL2oDEcNvKIYfUWOhc2jXT1+OcALtTtI
         o4WR2hnNEuToH7USMqZJxLBu0tMwUntT9+rPJNFJ2ZQURMAcjFP1bQ503KN4QEZ54W
         4ZVomGasrHqxP3EwSjFYAFWX230YqtNeK7SZlE/bO8FTYnJyIRyytLf7EOGYbHTgfr
         Ys676rC5USI3w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBaeV-001GiB-Do; Thu, 05 Aug 2021 12:31:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Thu,  5 Aug 2021 12:31:00 +0200
Message-Id: <d428b90bb655c7992e9e13fc50130ed223812d2d.1628159456.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

This patch adds binding documentation to support USB HUB and
USB data role switch of HiSilicon HiKey960 and HiKey970 boards.

[mchehab: updated OF names and added support for HiKey970]
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/misc/hisilicon,hikey-usb.yaml    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
new file mode 100644
index 000000000000..857f9bd802fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
@@ -0,0 +1,95 @@
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
+      - hisilicon,gpio_hubv1
+      - hisilicon,kirin970_hikey_usbhub
+
+  typec-vbus:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the typec-vbus gpio
+
+  otg-switch:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the otg-switch gpio
+
+  hub-vdd33-en:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the hub 3.3v power enablement gpio
+
+  hub_reset_en_gpio:
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
+      any connector to the data bus of this controller should be modelled
+      using the OF graph bindings specified, if the "usb-role-switch"
+      property is used. Note for this driver, two ports are supported,
+      the first being the endpoint that will be notified by this driver,
+      and the second being the endpoint that notifies this driver of a
+      role switch.
+
+
+required:
+  - compatible
+  - typec-vbus
+  - otg-switch
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
+        compatible = "hisilicon,gpio_hubv1";
+        typec-vbus = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+        otg-switch = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+        hub-vdd33-en = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+        usb-role-switch;
+
+        port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
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

