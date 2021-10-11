Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634F428491
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhJKBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 21:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhJKBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 21:24:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66AC061745
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:22:18 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c14-20020a37e10e000000b0045f3f44539eso6341629qkm.14
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pelpqGop9lNK0ivkhrG4qKsEmnDb1OiP8EZo1Fz2vqE=;
        b=hp7SXw7jtocsPJY2qeNaqGCipXyVGn6axSHZaPOQaTyZ26+Xroo5tcvNvJ7ZipX/Yt
         KPq611KjO+9iLfrdcLY6JcLHrUp6OvfmMM++nkzaq2SetrEWyL8r32lOj6YyfoSXeAbH
         Fr/wOlK1kFMfP+nB54KD7G754v1lmkJIa4WbRj1jcOX+5Le/RCNazkJpvS77BNWUyuAp
         byhfpwzYyKsuqgdhQs2OMnES6J0dn7WuOPOwBixVtdqwHf8P+aWu4c75nMC8xemVADCT
         UafLuSCaCfwwYweoMppmYC52PdvcA02o/q4ywMEVWJeRJHG/Pm2Dh8/L9AR2Nr5wLA0Y
         0hPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pelpqGop9lNK0ivkhrG4qKsEmnDb1OiP8EZo1Fz2vqE=;
        b=FAZKixpvPf2JoCq4akkjMBwVIchnijYLsQ7iQHtJ5RyysxoNMdhI2rjDj4PdtoSd8l
         FQtz+C/ls1rvOHyP2HM6ZHGKQ44UZA77HriNX1NixFP5+KjbG0t+GSdfYvysqIEpoXEo
         /EpqSutKuNPDFzDH/bK5OjbMmKW4eTSpNhOetOrwI8TeyosFBlu7Tt7N5cvJ4ihhFNzD
         xK+uJv5EZh+NRaPzGTKVN/kbKmZScBX3ohb3PefGYMZ61dL/LoEr+1bGjGxiRwJn1Tgk
         i/DORe1l0mVbwAMTpaL6aP9A5dF40e5kGnWKldmk5PKHyJNiC5H4qBdcKQrPbNYHPfAv
         7Uvw==
X-Gm-Message-State: AOAM53104FE9vZUupqiElnTh7KAoho/FHyYn46lfCPsG/NXQYFLmWlip
        /QcvjQSCasC4oXMhSDNgzgGQ96U=
X-Google-Smtp-Source: ABdhPJxakqS3R8xOFBlupR06TVZ/cUaN2aXRdEF/OW4Gfgmo0Ro10oYgMUoHGtdJNMM/YAHTF5V+zHg=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:8461:b843:7404:1394])
 (user=osk job=sendgmr) by 2002:ac8:7e86:: with SMTP id w6mr11757072qtj.277.1633915336530;
 Sun, 10 Oct 2021 18:22:16 -0700 (PDT)
Date:   Sun, 10 Oct 2021 21:22:11 -0400
Message-Id: <20211011012212.91357-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v7 1/2] dt-bindings: hwmon: Add nct7802 bindings
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
Changes from PATCH v6:
- Fixed formatting error reported by yamllint

Changes from PATCH v5:
- Refactored to use patternProperties.
- Added validation for sensor-type and temperature-mode.
---
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..a0a245938528
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
+              - 0    # Local Temperature Sensor ("LTD")
+              - 1    # Remote Temperature Sensor or Voltage Sensor 1 ("RTD1")
+              - 2    # Remote Temperature Sensor or Voltage Sensor 2 ("RTD2")
+              - 3    # Remote Temperature Sensor or Voltage Sensor 3 ("RTD3")
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

