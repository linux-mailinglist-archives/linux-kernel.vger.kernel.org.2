Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704FA435072
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhJTQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:44:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:42:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v203-20020a25c5d4000000b005bb21580411so31057954ybe.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nYDqdSCOLsb3EuBLqgFuRJT/AkynPzPSYq70WD81Abg=;
        b=cE1mIAYH4KApryiQBNCgeGgi/7dza9hmjDenIG4kFkhMhVVfaTHhMZU/EaX0hSpug8
         oMjw1HswhrCmhKOzmt9GZwH6rXUQMlVCZotaqcNSV1R82/XtAkJDLm0E0QPdAsP/G9BP
         GGPn7XYyDM09cIjSx0A+6E+htQoSGA1FFqf4aF1XF65SNeGS65l5mJXAiF07CEqFJTmE
         37RcUaBp9KgnGiQ7tb5Uf+DXZiQIUAyYZQBvAc1UY/sBFwu+YUodAo8REQy48YVJfu2J
         mBksT9Vm9LeTzOiTp/uP0IdSsURS3N/2PlmD7a2xW0RLXIBNys4tR9mL+kgiVTyAnbKX
         0nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nYDqdSCOLsb3EuBLqgFuRJT/AkynPzPSYq70WD81Abg=;
        b=SIaxzdYwt4qIwl2uEqkMR8bne4z1W2AQ2Mjyomi5sn59jSsVaoxJGFsg01hDvaoRVb
         DBMcq4YU/2SvWNnh9+F8NwYla6MNMuXy1kpeqfGW7MpmjoN2U/HOONe3g/IzaHYJhDoy
         2o9SHGb2zUlKRi9Aof++8apQBris1lKaxbL4g3idgoSKuQQnGBAOSRiPDfquZJ7Y332A
         JMoHXoTUsIa7lNYbrZYXQ+qvPaGwjO0kLwXVR6HH+LbeeAfKupM2FLKQB/0vOIjg7Ewr
         9NKKguJcb3e/BMmaAJaqJ0it4nygqhJMsYjGuB1t3TAIKZdpqKxRgZ3dubDtPLae+HZ3
         dNXA==
X-Gm-Message-State: AOAM531uvIpunCAYbs94j15E6E+eJRledwgcZHu9d1/dQZRczWHTKOao
        LzXThJV5KcA2aemL6PxnIwsJhdg=
X-Google-Smtp-Source: ABdhPJwQlhj86xuuPxYWBoeHQjgOZy5Ow4QsywzliDa0jyy2ruS1Fa1TpRjg57ug7oOBwvgj7Rb8anM=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:a607:1490:fbbf:43bc])
 (user=osk job=sendgmr) by 2002:a25:c696:: with SMTP id k144mr125766ybf.296.1634748137022;
 Wed, 20 Oct 2021 09:42:17 -0700 (PDT)
Date:   Wed, 20 Oct 2021 12:42:12 -0400
Message-Id: <20211020164213.174597-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v8 1/2] dt-bindings: hwmon: Add nct7802 bindings
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
Changes from PATCH v7:
- Implemented review comments:
  - Added blank lines to increase readability.
  - Moved "additionalProperties" up to increase readability.

Changes from PATCH v6:
- Fixed formatting error reported by yamllint

Changes from PATCH v5:
- Refactored to use patternProperties.
- Added validation for sensor-type and temperature-mode.
---
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..2f0620ecccc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -0,0 +1,145 @@
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
+additionalProperties: false
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
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        items:
+          - enum:
+              - 0    # Local Temperature Sensor ("LTD")
+              - 1    # Remote Temperature Sensor or Voltage Sensor 1 ("RTD1")
+              - 2    # Remote Temperature Sensor or Voltage Sensor 2 ("RTD2")
+              - 3    # Remote Temperature Sensor or Voltage Sensor 3 ("RTD3")
+
+      sensor-type:
+        items:
+          - enum:
+              - temperature
+              - voltage
+
+      temperature-mode:
+        items:
+          - enum:
+              - thermistor
+              - thermal-diode
+
+    required:
+      - reg
+
+    allOf:
+      # For channels RTD1, RTD2 and RTD3, require sensor-type to be set.
+      # Otherwise (for all other channels), do not allow temperature-mode to be
+      # set.
+      - if:
+          properties:
+            reg:
+              items:
+                - enum:
+                    - 1
+                    - 2
+                    - 3
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
+                    - 1
+                    - 2
+            sensor-type:
+              items:
+                - enum:
+                    - temperature
+        then:
+          required:
+            - temperature-mode
+        else:
+          not:
+            required:
+              - temperature-mode
+
+required:
+  - compatible
+  - reg
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
+            };
+
+            channel@1 { /* RTD1 */
+              reg = <1>;
+              sensor-type = "voltage";
+            };
+
+            channel@2 { /* RTD2 */
+              reg = <2>;
+              sensor-type = "temperature";
+              temperature-mode = "thermal-diode";
+            };
+
+            channel@3 { /* RTD3 */
+              reg = <3>;
+              sensor-type = "temperature";
+            };
+        };
+    };
-- 
2.33.0.1079.g6e70778dc9-goog

