Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8D4276C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhJIDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhJIDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:00:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:59:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so15172768yba.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kf7CalnyuFZkYhPjNjgl2jKwF5f9iQ5T88AqkNZlBhM=;
        b=Ql7DVirqHyWKvhHv5RTenTZ97vcqpw08NbUhpJBtD1bPP8hGQBHt5JK57pME40uBIt
         Jdxwl1FS2iOAraJx/ARCzFdu/AsAtU+Iwf3fatndjJMLLvXcRwfIz4MHwt8FFlYsOkFV
         oPznFm2+iK7ZDsz/ozIMsV2I6FW97Tvt++ytP1hE8EdXTkAHSGArQaj2fSZhdFiPv+7I
         nGlB6Vxxp9OhvTsiSO32W+RpqsrA8xH5GBKbGR1uWfJkMktoD/97XYLtZAbWa/S+N4JW
         TF/g7kv26UHmMNUk2tYgNKPLX7vUW32ETtvjyQ7F0hFvG25U7FGHZkIPLiPO7q2lIXRC
         yznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kf7CalnyuFZkYhPjNjgl2jKwF5f9iQ5T88AqkNZlBhM=;
        b=xHaKXEAZJD8CzHtbNnF2ZclKc/vrEUfLcCqMU95h8IK60F92e7rVa3mzUYcgG+GDDP
         JtjDYYrXiIjOtmhoC061TB/OVojH4P6pP4bUfpnGk1h1X6XUmcGZLX5q4rcv5rp5YmFJ
         qiKj2UDWwmDaAcdGZjNjmQaSeohd202pQRBewhLK9g6BAVkIzOiGLfyd0+Y7KTTVjm87
         47OBWS2rWTToAycI1TXtVDRP6tL+rALWNArRZriAxIP+tcml5y/JngXBDxuUr6Sj7LtM
         H78EBTTEvFqt4K7XcTqEoU7fSaWX0bt5QVpYPLRZXPhBKGPFIzC/Touv3uARuUnUBsUu
         DBTQ==
X-Gm-Message-State: AOAM5322gWLHZAUWBUK3ZTKRW13PWfgKit44tNOSB71Z169okRBEtQGB
        Vdx1GovGgrQbWiEkOU7uQqO6nZs=
X-Google-Smtp-Source: ABdhPJyU/TodyBwpj0FQcBOdGczlr3Z+KthsCP5SqDy7zMCa9a2c7kGISIxRpK5CaTR0SmzO2TRLF4w=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:acb9:8fa6:8db4:ee39])
 (user=osk job=sendgmr) by 2002:a25:610e:: with SMTP id v14mr7956450ybb.90.1633748341880;
 Fri, 08 Oct 2021 19:59:01 -0700 (PDT)
Date:   Fri,  8 Oct 2021 22:58:57 -0400
Message-Id: <20211009025858.3326725-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 1/2] dt-bindings: hwmon: Add nct7802 bindings
From:   Oskar Senft <osk@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the Nuvoton NCT7802Y driver.

Signed-off-by: Oskar Senft <osk@google.com>
---
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..a97b89d0d197
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7802Y Hardware Monitoring IC
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
+  5 remote temperature sensors with SMBus interface.
+
+  Datasheets:
+    https://www.nuvoton.com/export/resource-files/Nuvoton_NCT7802Y_Datasheet_V12.pdf
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7802
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  input@0:
+    type: object
+    description: Local Temperature Sensor ("LTD")
+    properties:
+      reg:
+        const: 0
+    required:
+      - reg
+
+  input@1:
+    type: object
+    description: Remote Temperature Sensor or Voltage Sensor ("RTD1")
+    properties:
+      reg:
+        const: 1
+      sensor-type:
+        items:
+          - enum:
+              - temperature
+              - voltage
+      temperature-mode:
+        items:
+          - enum:
+              - thermistor
+              - thermal-diode
+    required:
+      - reg
+      - sensor-type
+
+  input@2:
+    type: object
+    description: Remote Temperature Sensor or Voltage Sensor ("RTD2")
+    properties:
+      reg:
+        const: 2
+      sensor-type:
+        items:
+          - enum:
+              - temperature
+              - voltage
+      temperature-mode:
+        items:
+          - enum:
+              - thermistor
+              - thermal-diode
+    required:
+      - reg
+      - sensor-type
+
+  input@3:
+    type: object
+    description: Remote Temperature Sensor or Voltage Sensor ("RTD3")
+    properties:
+      reg:
+        const: 3
+      sensor-type:
+        items:
+          - enum:
+              - temperature
+              - voltage
+    required:
+      - reg
+      - sensor-type
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nct7802@28 {
+            compatible = "nuvoton,nct7802";
+            reg = <0x28>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            input@0 { /* LTD */
+              reg = <0>;
+              status = "okay";
+            };
+
+            input@1 { /* RTD1 */
+              reg = <1>;
+              status = "okay";
+              sensor-type = "temperature";
+              temperature-mode = "thermistor";
+            };
+
+            input@2 { /* RTD2 */
+              reg = <2>;
+              status = "okay";
+              sensor-type = "temperature";
+              temperature-mode = "thermal-diode";
+            };
+
+            input@3 { /* RTD3 */
+              reg = <3>;
+              status = "okay";
+              sensor-type = "voltage";
+            };
+        };
+    };
-- 
2.33.0.882.g93a45727a2-goog

