Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E12413185
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhIUKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:30:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38496
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231853AbhIUKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5DDBE3F30E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632220151;
        bh=ZNH+zxmaND7rR/DGahGvaHsh9Nt1sNcf9ALxvClhLkg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HN5VvmehAHiscpSf2dhdgOyEbpjuS5bvYJ/kSOtRW0YKtLMZAtyEpBqFN10ucNSte
         7NOUwbzN1vyyUhSeu2UJr9lJ905ydJxgZEvjr0Lavnu/ln5pmm+IOC5/Dq0Bn9QIYs
         BH/bXHKQdxSKBKOwr2da8RHIAmSvK4SPu26ut+tIyQtfFhd2sqsIE5vnAYs14t3jXF
         izOUMt3w4R+K6W1IwRLTdi18MGnY29y8e3E5R66SswJm3bas+7nAY4P4UieWtJ/Ich
         47HuofDexkSICFR8C6OOODoM3nXRLv58YfGENjzZ9M2J+7zXjVYrvySkn54Urupsld
         Ol5zuz4OuuKMg==
Received: by mail-wr1-f71.google.com with SMTP id m1-20020a056000180100b0015e1ec30ac3so8409777wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNH+zxmaND7rR/DGahGvaHsh9Nt1sNcf9ALxvClhLkg=;
        b=hnY5EGihIuhmxz2aDXx8s8IdUjRlWtftlu+tpaDgO2eIJsJCD/02qjV+wPXxhqIgTI
         xVqgLr2Wq0Nip48HolKUhN0KhTmWU0nwjmdUW7PVwMoU8u2zUvLh7JA21adjtr1bxZHm
         48OVVrYPCStuS2N72MVQii0O8URrHJr5omOXdsPmTWwL05qs4ux+4olwtmxkDrExdIEF
         qBnvGlkNlNpEMIZOTu2EUcSCs6Ylj8fVoSjRsp+ZT5sCJgCTmZ85X/eAz5RRQB8b8TZw
         v0XN2W9Iam/sWk8QzLTDyQRr7v8t5beQEyup7M4R5/rf5uY+9ccHGJNJ7NtNkPJheRwA
         WDgA==
X-Gm-Message-State: AOAM5308OZn5scL4ALVEQI3vkYaU+eMhXsjZKFXSM7OGbpFWNcoGdZtB
        wAwiLnFCeqYUcB2ck21y0MNR9MOAkc4mbDvUp0MSMv5jAMI2RJk9asxOv27p6Bd/lI3Pte/flpb
        qpSsrb3XccZDGklqn7UOhBgGtS6qwDLf61MupNxS6mw==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr35069281wrd.87.1632220151042;
        Tue, 21 Sep 2021 03:29:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjs+OrN5dFclOS7GJVsxhqz5MGX6J2vh/0CGCqdjnmGePtDYf5XKuf5XnQlhbubwp1F7GrzQ==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr35069266wrd.87.1632220150919;
        Tue, 21 Sep 2021 03:29:10 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m29sm20072380wrb.89.2021.09.21.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:29:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: hwmon: ti,tmp108: convert to dtschema
Date:   Tue, 21 Sep 2021 12:28:27 +0200
Message-Id: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TI TMP108 temperature sensor bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/ti,tmp108.yaml  | 50 +++++++++++++++++++
 .../devicetree/bindings/hwmon/tmp108.txt      | 18 -------
 2 files changed, 50 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/tmp108.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
new file mode 100644
index 000000000000..eda55bbc172d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TMP108 temperature sensor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp108
+
+  interrupts:
+    items:
+      - description: alert interrupt
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@48 {
+            compatible = "ti,tmp108";
+            reg = <0x48>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&tmp_alrt>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt b/Documentation/devicetree/bindings/hwmon/tmp108.txt
deleted file mode 100644
index 54d4beed4ee5..000000000000
--- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-TMP108 temperature sensor
--------------------------
-
-This device supports I2C only.
-
-Requires node properties:
-- compatible : "ti,tmp108"
-- reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
-
-Optional properties:
-- interrupts: Reference to the TMP108 alert interrupt.
-- #thermal-sensor-cells: should be set to 0.
-
-Example:
-	tmp108@48 {
-		compatible = "ti,tmp108";
-		reg = <0x48>;
-	};
-- 
2.30.2

