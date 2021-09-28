Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40241A9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhI1Hlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239413AbhI1Hlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:41:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E384611CC;
        Tue, 28 Sep 2021 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814813;
        bh=aYODkh8cK4PFOh3SK7n+CRjrZVA5pL0qjjkMR3jTLuc=;
        h=From:To:Cc:Subject:Date:From;
        b=fePAQtm+Pa35YcJrDcs2uDZun4sJ9s6bHm194FzNqFrWbcXdnKH1haV28w34ItDYx
         S6ReBl3cfvyzAK4By3OdLJz0Us9+p49FS2D2xw0C8roilycBnNkuIKb2yIt8MV6VSb
         QIqLC99VrLP/Kag0y+CJk9tHhH5JroaQ1eAEUXc1NaLNKsve7g0nkzhpjuASjVprcD
         APUHe3cRkyEn7YvDkw1vUXqDpzfZoM++LFYrhyzFkXo0iJrbZUSfJ8tnLH57NnCysP
         lSntc+wadB6UOu7XAVCBE9GUG6AiNUp/V924mscOKKYuAlfGaqLnd69LO9blT4obeV
         oNQ0RHqTlvJcA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7il-000RWx-KV; Tue, 28 Sep 2021 09:40:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v5] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Tue, 28 Sep 2021 09:40:06 +0200
Message-Id: <f955e7dba47e2e96ca6bfe761a1f998e9b5a4c50.1632814787.git.mchehab+huawei@kernel.org>
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

[mchehab: updated OF schema and added HiKey970 example]
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/misc/hisilicon,hikey-usb.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
new file mode 100644
index 000000000000..761ab686121a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
@@ -0,0 +1,87 @@
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
+  Supports the onboard USB GPIO hubs found on HiKey960/970.
+  Such hubs require a power supply for the USB I/O. Depending on the
+  exact hub model, after USB I/O is powered up, a reset should be needed.
+
+  It also acts as a role-switch intermediary to detect the state of
+  the USB-C port, to switch the hub into dual-role USB-C or host mode,
+  which enables and powers up the onboard USB-A host ports.
+
+  Schematics about such hubs can be found here:
+    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
+    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,usbhub
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
+    $ref: /schemas/types.yaml#/definitions/phandle-array
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
+  - hub-vdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb-hub {
+        compatible = "hisilicon,usbhub";
+        typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+        otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+        hub-reset-en-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+        hub-vdd-supply = <&usb_hub_vdd>;
+        usb-role-switch;
+        port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            usb_ep0: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dwc3_role_switch>;
+            };
+            usb_ep1: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&rt1711h_ep>;
+            };
+        };
+    };
-- 
2.31.1

