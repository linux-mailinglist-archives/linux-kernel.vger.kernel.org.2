Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4F4123CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378997AbhITS1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:27:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50932
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351817AbhITSUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:20:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01F483F32A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632161958;
        bh=IpPIuwvUbTgzHyTe+fBxia//tw9/orKJf90Kejz8OkM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ICCEjlvWaj2l676K7JAg30HcL/rny9lMuC0cswOxhUO5AU6tsnu5zWZccNHyE9u3m
         5s3aAHNM39Fg5IMwlHZwKNizSAuC8YGYRef8BhJ4inENvkDJKw0exZz9y9nS/FKHWw
         yFM713PHK416BNKx9/nJ5zuibBJEkdUjGYl6UwK2PqILTnh1nQBii/dM87ACSWsmgx
         /yabxZde9/Oy0pHw9NxBHu0nMj5vJEvcnUqXfgwwwlL8kWJ3ZWxxRJwIKHztHC30/V
         W7P1dnDS/gzTcgwGUGn3eX5pkNtICAXYcZFt1YFu0nOfSBDkiVwdja/ZK7OVE/870i
         7hYyQpz610OAg==
Received: by mail-wr1-f69.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso5465940wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpPIuwvUbTgzHyTe+fBxia//tw9/orKJf90Kejz8OkM=;
        b=u7YoOXjhi18/G/NdPJVzmY5dm7ByrVlShLkOS4hnL0r9DaPaZU9rq7oYJl/YyFu9yl
         znHJPGACblG11Yx+RdLqHCI7SXRESR4iAlfui7elUxrkOdc7cwyVPh7QG8eEpLvaknD6
         8OU0QLmaszhtoyFNmPe1tO/kjkF1G7VRmLxTC9Tvo7r0bFW2mbvwtyjeH19ec1IJ/Rj6
         KcUOfpWn/gFbCsTVHXkUJEr9kgXHhdJmVFCpBjTpqF2LDxlC9Cma+oKb9tIjW61Lwl5u
         F0MtdVeex6A0X580D9IqqRG0rjPNqa55DmSuCF0UT4RVElKJWgRAgpZwLN1kBpGCnHg1
         ogAw==
X-Gm-Message-State: AOAM530GugAYmq0rhDKgImh1FXX3cZHRTXqtluTtlS/GHzlt7yJgdTbB
        8oPaS5qtcfJOSTfsQ2e405N+NyQ6rN/klMvd3VGTcvdUB9u7SoKQERknDTh0kDQM/qBdlBEGTK6
        bFcqxHtfw5N/Or0eVO2fdD18E6m2ui13KdeTOD4xoRA==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr415424wme.45.1632161957599;
        Mon, 20 Sep 2021 11:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk3ndi0x9YmEkaswh9wkxZ0jfLmzGnCgJTsvCobsHFor57aOQOFUNbyDw0BoCKMIAZZuiWTg==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr415406wme.45.1632161957432;
        Mon, 20 Sep 2021 11:19:17 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i27sm253134wmb.40.2021.09.20.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:19:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: lm90: convert to dtschema
Date:   Mon, 20 Sep 2021 20:19:12 +0200
Message-Id: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the National LM90 hwmon sensor bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Drop adi,adt7461 from trivial-devices.
---
 .../devicetree/bindings/hwmon/lm90.txt        | 51 ------------
 .../bindings/hwmon/national,lm90.yaml         | 79 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 -
 MAINTAINERS                                   |  2 +-
 4 files changed, 80 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/national,lm90.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
deleted file mode 100644
index 398dcb965751..000000000000
--- a/Documentation/devicetree/bindings/hwmon/lm90.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* LM90 series thermometer.
-
-Required node properties:
-- compatible: manufacturer and chip name, one of
-		"adi,adm1032"
-		"adi,adt7461"
-		"adi,adt7461a"
-		"gmt,g781"
-		"national,lm90"
-		"national,lm86"
-		"national,lm89"
-		"national,lm99"
-		"dallas,max6646"
-		"dallas,max6647"
-		"dallas,max6649"
-		"dallas,max6657"
-		"dallas,max6658"
-		"dallas,max6659"
-		"dallas,max6680"
-		"dallas,max6681"
-		"dallas,max6695"
-		"dallas,max6696"
-		"onnn,nct1008"
-		"winbond,w83l771"
-		"nxp,sa56004"
-		"ti,tmp451"
-
-- reg: I2C bus address of the device
-
-- vcc-supply: vcc regulator for the supply voltage.
-
-Optional properties:
-- interrupts: Contains a single interrupt specifier which describes the
-              LM90 "-ALERT" pin output.
-              See interrupt-controller/interrupts.txt for the format.
-
-- #thermal-sensor-cells: should be set to 1. See thermal/thermal-sensor.yaml
-	      for details. See <include/dt-bindings/thermal/lm90.h> for the
-	      definition of the local, remote and 2nd remote sensor index
-	      constants.
-
-Example LM90 node:
-
-temp-sensor {
-	compatible = "onnn,nct1008";
-	reg = <0x4c>;
-	vcc-supply = <&palmas_ldo6_reg>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
-	#thermal-sensor-cells = <1>;
-}
diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
new file mode 100644
index 000000000000..e712117da3df
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/national,lm90.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LM90 series thermometer
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    enum:
+      - adi,adm1032
+      - adi,adt7461
+      - adi,adt7461a
+      - dallas,max6646
+      - dallas,max6647
+      - dallas,max6649
+      - dallas,max6657
+      - dallas,max6658
+      - dallas,max6659
+      - dallas,max6680
+      - dallas,max6681
+      - dallas,max6695
+      - dallas,max6696
+      - gmt,g781
+      - national,lm86
+      - national,lm89
+      - national,lm90
+      - national,lm99
+      - nxp,sa56004
+      - onnn,nct1008
+      - ti,tmp451
+      - winbond,w83l771
+
+
+  interrupts:
+    items:
+      - description: |
+          Single interrupt specifier which describes the LM90 "-ALERT" pin
+          output.
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  vcc-supply:
+    description: phandle to the regulator that provides the +VCC supply
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@4c {
+            compatible = "onnn,nct1008";
+            reg = <0x4c>;
+            vcc-supply = <&palmas_ldo6_reg>;
+            interrupt-parent = <&gpio>;
+            interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+            #thermal-sensor-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1e4b3464d734..1eb4ce7dcdfd 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -41,10 +41,6 @@ properties:
           - adi,adp5585-02
             # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
-            # +/-1C TDM Extended Temp Range I.C
-          - adi,adt7461
-            # +/-1C TDM Extended Temp Range I.C
-          - adt7461
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
             # i2c serial eeprom  (24cxx)
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b990794ec35..b07679009af2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10928,7 +10928,7 @@ LM90 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwmon/lm90.txt
+F:	Documentation/devicetree/bindings/hwmon/national,lm90.yaml
 F:	Documentation/hwmon/lm90.rst
 F:	drivers/hwmon/lm90.c
 F:	include/dt-bindings/thermal/lm90.h
-- 
2.30.2

