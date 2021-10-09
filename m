Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587334276B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhJICqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhJICqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:46:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB5C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 19:44:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso11202323ybb.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kf7CalnyuFZkYhPjNjgl2jKwF5f9iQ5T88AqkNZlBhM=;
        b=PTm8Q58rLoMMQBjtuBNjPDDyRkDz2pwkEBRM+hXj/cayiP5UTNTs/DsIOuJIo2pr8j
         PsjUfcJCGaN+KPa3X5ToNlcEeDmhzr7AeUXyExEJk04ekHtZdwZT6APVAPF3w0gh9n2Z
         sex9qKGWNiDd/SFyFj2sGHBi5pHboJNtPLejyQ2eoQSDzXM6HKNLAXbUzjnxepC5r1oQ
         x9E8haah2ZJ3S89pr2zoKZwBH7QYCKa+ijIZlH0MORFigm7FRb87pmDnTjgzzfqdzsg0
         vJD5rNcIBrHYsh4n5i8Lqn4FXV2yeYFg5HMC7pH9k3tiFBMlGXoL1aG58kKG8BVCD2WO
         BAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kf7CalnyuFZkYhPjNjgl2jKwF5f9iQ5T88AqkNZlBhM=;
        b=HeIGaYIcVtiFK3DQdpLt/ES4pxH4eQYia1iz4AsSThx8V+cUxx1wL+xyhkv4od68Le
         /fCNRstNqXSTSTCgVX7WvkZw567IS/EaOElardd77sc6g15oD3AmYG87Avt7saNYk6Q+
         +S+p3eptktvfmdWImtYUw8AL6bEb3pTX8VBlGEHgmeySk5rFA0qp8h0CQ72an5IZnyJW
         e5PfMHAJx4D7lquFXOTR2KwBAwCsqsHfJ6o3m4Lg3TDFM3oOFWrg+yvZ8lIYRqWXRsA0
         +lgkprfOAyD2MtyZqLCY0vLaA9Zvpl0FRTH8g9gYNCrM4ERXQHPWGY+z6/MFEcGc+MDg
         Ws9w==
X-Gm-Message-State: AOAM530L+z2XQC4izP71yort70dH3Yx+rCdKbZqlKq1icjeM16inrpGj
        bIO8cAIIWERCirOcPsvXOnXglBQ=
X-Google-Smtp-Source: ABdhPJxv7IhrL6cbOin6c3Hmh1FGR0aqH74Axlx+fYYUsYtHZdQZNXf1WQiLRFezxS6n6yK1LPJB5yI=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:acb9:8fa6:8db4:ee39])
 (user=osk job=sendgmr) by 2002:a25:610e:: with SMTP id v14mr7909627ybb.90.1633747481732;
 Fri, 08 Oct 2021 19:44:41 -0700 (PDT)
Date:   Fri,  8 Oct 2021 22:44:29 -0400
Message-Id: <20211009024430.3322230-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add nct7802 bindings
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

