Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA60427CDB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJISzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhJISy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:54:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77917C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:53:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c65-20020a251c44000000b005ba81fe4944so7036747ybc.14
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wgwJpFSMXbT+4uWqtIhIbvoDsh/a6g6X6/NFZ3njfpQ=;
        b=TwQ69JXhUyNzYM3WbLwFJUjs0xoYc9mk/xEvGMxhHVRlwzhQ9bGFIlGIZmOdi+9Vmm
         HU6tV0Rhjbk3eq8spaznQFFJX8lK4MhtTX/vleQat1iVS3HZubYf16Oyacsga5R6o2b5
         2NI3NrVvm9pb3y1IP775QxrkcXn1heWcjfzw2pW6bq70Grzp1bFcv7wZkVA3ORTkGMyP
         0uPCsdjf1hMSv284t7Q0ezIPd4Zz3mLBjBaMoYXLPW3RN3vfb6qmOyYDB5TcXGoYcea5
         Fs4JfSChJ0uXS0L9UoE7naSYkfl6JAbj5IeJrLkmQ6MiQtw+x6rvFEU5tDXp3K9ye/JQ
         bj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wgwJpFSMXbT+4uWqtIhIbvoDsh/a6g6X6/NFZ3njfpQ=;
        b=w6QulSd73KQGEifHmqSe4vTJtgfiS4bld5xJDXmj16AK3tCcAD5imzR9SusSmWs9Lo
         gF9TdAJQQf31LYzByYyrLwu0LHgKDHS+l/B+z3PHlnE5j2CPEL2/nAZzGdlmriN60fhp
         2mRx5vtUy33aKiRGHRtZLCBgWvr/DTmsUZ6tLIzWeIMPfC9+paGLp7rL6+m9WcZyCFc0
         v33EId7FQXbqgKO54TTra/nQswT09SltUdB6YrEF9kC2aedUeY1r/t/71mfQRwQwtqfN
         MMLB3Z4qdMCSIsZMukbocE9DKLwpbuqyrzHQlhBAPr+mp0Ixm0MoJsnsYKkTbnvFZDpx
         qpLw==
X-Gm-Message-State: AOAM533u2mOa8oT1FWb3C0T7lyxdfy83I4x6M9IhCxlq6G5Tl6mHHjvo
        fJvlbjIuC6v1cw8kBMQYPzIo9qA=
X-Google-Smtp-Source: ABdhPJwFPYxTy4txzD+gz1J4rdpojvO6wlJdUQK+g52zLot0+bRE79OEcbNoEoR6b0yjweTrqnjug1Y=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:cf37:dd81:3340:f4a7])
 (user=osk job=sendgmr) by 2002:a25:d407:: with SMTP id m7mr10819050ybf.182.1633805581677;
 Sat, 09 Oct 2021 11:53:01 -0700 (PDT)
Date:   Sat,  9 Oct 2021 14:52:56 -0400
Message-Id: <20211009185257.2230013-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add nct7802 bindings
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
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..ff99f40034f2
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
+  channel@0:
+    type: object
+    description: Local Temperature Sensor ("LTD")
+    properties:
+      reg:
+        const: 0
+    required:
+      - reg
+
+  channel@1:
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
+  channel@2:
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
+  channel@3:
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
+            channel@0 { /* LTD */
+              reg = <0>;
+              status = "okay";
+            };
+
+            channel@1 { /* RTD1 */
+              reg = <1>;
+              status = "okay";
+              sensor-type = "temperature";
+              temperature-mode = "thermistor";
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
+              sensor-type = "voltage";
+            };
+        };
+    };
-- 
2.33.0.882.g93a45727a2-goog

