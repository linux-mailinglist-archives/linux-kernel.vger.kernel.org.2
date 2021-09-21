Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB55412B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhIUCMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbhIUB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA3C09395B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:46:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so208982601qvt.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X0g37Ri5sxxIVy0NRE3UYDG3npfIU5zLh9WBLDKQV3s=;
        b=PBUUSrGiOy3GrxFoJKwe5V6d8XZpVtpYTK/90NV2fwHOfVXqV+lyrTVCpBXxymdjnP
         q2pYCOHf0/gm35/TVyUpIzq4K0hDqNwZOiQDPbb89UOTj7kdrP/PJNGIYPlAr7jrDa42
         4S9WEayhnVpg7vUt/hk1nyERZHJHJ6CdsCrqgpI6OEyF8+VWBssv6gMUFSlkNscfwc7D
         t79W9/uTJ7zANZ/2RiOXJZR/J0vT3apfMYpze8c0JjelvRj9ufIH92ELkHYDm2ZZQVAE
         2v50W45fA6G7YFfvTWkGVCbnUWi6QbuyUIVzTmjchUYVniKKf7ypoUG23BPJ4SZayWpk
         dSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X0g37Ri5sxxIVy0NRE3UYDG3npfIU5zLh9WBLDKQV3s=;
        b=nmU9aoqAd5DtiLu72EI5FhrUtwkU1Gkr6b1ftrbAEXdHIpVlbpdGKmJmdSKK1irk3E
         DrE1P09m2O5Tl5amhkA5UAG4HR4k/HQNSWPrpAsJUhYPwjhY2Lix4mRGfLWttbjFmir4
         wE33k9y4nj+NKrY1ZTKfxLfcsjRIZRF8+4uX2Ur/6QmF6SrtPum/rtqwBcHD5muYVJ/h
         TkOCpf+0Me81geTghOFrsKw68HQaK09lARMrfQCth/Bq+K53R2LvYIz52SpL5XgVZ1lS
         ZM4fFEnCx3FC9P6pUrkTCBA9QVSqXGrR/4CY8MDYZA11GJVyb4GzitwxbG9j06ulwm+D
         Hddw==
X-Gm-Message-State: AOAM533UxCSpdQCsaZ+gSaIkZTVcbSt6YRSEB8FpXLSlxWZL2U+YDs1M
        te/DdOx6AKCaUIsgQM6w/IClokA=
X-Google-Smtp-Source: ABdhPJzSaxyd34Xwh925O9wn2RVv6+oVvg145u9Qm7XirosQNqRDYbQX+JZU2Q6gBT8fJRq/vQbQXIA=
X-Received: from osk.cam.corp.google.com ([2620:0:1004:1a:fbed:324c:ca6c:1142])
 (user=osk job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr28192853qvv.57.1632185212089; Mon, 20 Sep 2021 17:46:52 -0700 (PDT)
Date:   Mon, 20 Sep 2021 20:46:26 -0400
Message-Id: <20210921004627.2786132-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add nct7802 bindings
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
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
new file mode 100644
index 000000000000..7512acbc9d1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -0,0 +1,92 @@
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
+  temperature-sensors:
+    type: object
+    description:
+      |
+      Configuration for temperature sensors. If temperature-sensors
+      is not provided at all, the internal temperature sensor will be
+      enabled. If temperature-sensors is provided, only the listed
+      sensors will be configured as specified. The runtime configuration
+      for un-listed sensors will not be touched in the chip. This allows
+      sensors to be configured at power-up time from an EEPROM connected
+      to the chip and at the sime time allows to override these settings
+      using device tree configuration.
+
+    properties:
+      ltd:
+        type: object
+        description: Internal Temperature Sensor ("LTD")
+
+      rtd3:
+        type: object
+        description:
+          |
+          Remote Temperature Sensor ("RTD3"). This sensor only supports
+          thermistor mode.
+
+    patternProperties:
+      "^rtd[1-2]$":
+        type: object
+        description: Remote Temperature Sensor ("RTDx")
+        properties:
+          "type":
+            description: Sensor type (3=thermal diode, 4=thermistor).
+            allOf:
+              - $ref: "http://devicetree.org/schemas/types.yaml#/definitions/uint32"
+              - items:
+                  - enum: [ 3, 4 ]
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
+            temperature-sensors {
+                ltd {
+                  status = "disabled";
+                };
+
+                rtd1 {
+                  status = "okay";
+                  type = <4> /* thermistor */;
+                };
+            };
+        };
+    };
-- 
2.33.0.464.g1972c5931b-goog

