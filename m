Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B91427E95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 05:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJJDdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 23:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhJJDdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 23:33:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE65C061764
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 20:31:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c65-20020a251c44000000b005ba81fe4944so8226856ybc.14
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 20:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g7EJveLFxokNEPlL/tBARdXLFCbt2zr2sbuE+aH5gDg=;
        b=KvmF4L7GCUkYpLZnh/RhRG8DOvChmVQLOZS3IRfJqUg2JS7re7EKuMcJUtSZvo2Ke9
         DyZ1/eDFu1lbQG7j3JimTxNQbDpf83AdUlxOKq2E2H40NZVfnhHgj7EbnQ3/TvDBIwiq
         /Nzv841D1Zwl7uRs4KXke+l2kwUjcd5XK3dqYg+C808QhtLeDxunFo4yzDF3H80Et9lN
         LSkO+762F8e7UIzwrmGgjjlfEksmPBpDrpOHWDd4HInGbADJymkutMU75dGa7DFYVCY5
         u8VbdEWnOUe6CPKXujrLzEQ5QidtJRAjumcmX6RdIdemT11A+MgDRsuaBFrnlXhf6iae
         rjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g7EJveLFxokNEPlL/tBARdXLFCbt2zr2sbuE+aH5gDg=;
        b=V3abbvpENFgPptyl9lbDQTmPcSQndCAbn0bzIf70sIwyOrHjgNYDHtlux2I23Wmzn1
         enA6msjLhz5hPDOe0UOUjrRg3CJR6PFzi81Z4LVuSfXj6588VGSXgIsxnFp4DmLdRLmO
         05ucdagiIHEcHxBX7zhlJHEjSXkLD04zELu9hfId8v0PoySD7LWMPvXDbuSLGZwayhBh
         EdDhRXjgOWmo8esJLOLZmlr3E91Q2iOJoKNdm3OuESDi1hTY0WgrEcM3BC1yaozgBv6n
         xe85vd/q00Tr/M82Yu1qvl4ZktP6cXjVFlccE4jlm2D/kn0kPmRpZ+kR9dyvmAjv57X0
         rkxg==
X-Gm-Message-State: AOAM530ko8pf+0OjDmjrV5EyhZOv/LjqU4qCSpwRvoej3cK2r3YD/l+x
        weRU6QoFOqDLUsmUK3bBYalUWh8=
X-Google-Smtp-Source: ABdhPJwvsVg8yIJ5folfecqAnSh3yK/B7CLK30Awqsr4W6RZZDipbs8xSZDsUUSAPGv+qJjE4QiociE=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:cf37:dd81:3340:f4a7])
 (user=osk job=sendgmr) by 2002:a25:2286:: with SMTP id i128mr12286454ybi.76.1633836677363;
 Sat, 09 Oct 2021 20:31:17 -0700 (PDT)
Date:   Sat,  9 Oct 2021 23:31:11 -0400
Message-Id: <20211010033112.3621816-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v6 1/2] dt-bindings: hwmon: Add nct7802 bindings
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

This change documents the device tree bindings for the Nuvoton
NCT7802Y driver.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes from PATCH v5:
- Refactored to use patternProperties.
- Added validation for sensor-type and temperature-mode.
---
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..73fffd661f0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -0,0 +1,144 @@
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
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    properties:
+      reg:
+        items:
+          - enum:
+            - 0    # Local Temperature Sensor ("LTD")
+            - 1    # Remote Temperature Sensor or Voltage Sensor 1 ("RTD1")
+            - 2    # Remote Temperature Sensor or Voltage Sensor 2 ("RTD2")
+            - 3    # Remote Temperature Sensor or Voltage Sensor 3 ("RTD3")
+      sensor-type:
+        items:
+          - enum:
+            - temperature
+            - voltage
+      temperature-mode:
+        items:
+          - enum:
+            - thermistor
+            - thermal-diode
+    required:
+      - reg
+    allOf:
+      # For channels RTD1, RTD2 and RTD3, require sensor-type to be set.
+      # Otherwise (for all other channels), do not allow temperature-mode to be
+      # set.
+      - if:
+          properties:
+            reg:
+              items:
+                - enum:
+                  - 1
+                  - 2
+                  - 3
+        then:
+          required:
+            - sensor-type
+        else:
+          not:
+            required:
+              - sensor-type
+
+      # For channels RTD1 and RTD2 and if sensor-type is "temperature", require
+      # temperature-mode to be set. Otherwise (for all other channels or
+      # sensor-type settings), do not allow temperature-mode to be set
+      - if:
+          properties:
+            reg:
+              items:
+                - enum:
+                  - 1
+                  - 2
+            sensor-type:
+              items:
+                - enum:
+                  - temperature
+        then:
+          required:
+            - temperature-mode
+        else:
+          not:
+            required:
+              - temperature-mode
+
+    additionalProperties: false
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
+            channel@0 { /* LTD */
+              reg = <0>;
+              status = "okay";
+            };
+
+            channel@1 { /* RTD1 */
+              reg = <1>;
+              status = "okay";
+              sensor-type = "voltage";
+            };
+
+            channel@2 { /* RTD2 */
+              reg = <2>;
+              status = "okay";
+              sensor-type = "temperature";
+              temperature-mode = "thermal-diode";
+            };
+
+            channel@3 { /* RTD3 */
+              reg = <3>;
+              status = "okay";
+              sensor-type = "temperature";
+            };
+        };
+    };
-- 
2.33.0.882.g93a45727a2-goog

