Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5841242D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379914AbhITSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:31:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46980
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378527AbhITSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:24:51 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 613D63FE02
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632162089;
        bh=Sbg5nOyZq9yC8Xn5SZzHESn4Mfz8fqz9QB4d6lh3mX0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=e2rjs5dXfxktBScflPRGrBIV1OQy87fkQM8nquN4wYzgX7ht+aG1zc5aMS60F/08p
         Y6Lz7DfMtgQ+NDcJLga74kVkWx776x0bo3m1vS7wpgmuQMP64VOY5wKzmh8NhRza5z
         h+ovstBEzPuTRB10rCMYfkbjvWcFCssmDV+oL3BdYEft0i/CUq8mGLCjT/cnSsEUgZ
         +M5ptUH54v8rctmkUf4uQc1STD16QHEpzZuHJr/tb4DRXpriOljfWTNfajtF+kYOZ9
         QGW3NlN34qtw9npTp46Bp/L6MNuAypw/oX0ATmjYCAZ3HugO6gx9ea5wUOFxG8P5K5
         Bn/UdAlpnDN3Q==
Received: by mail-wr1-f69.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso6805314wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sbg5nOyZq9yC8Xn5SZzHESn4Mfz8fqz9QB4d6lh3mX0=;
        b=stRhlCWMmHG2V++eAGJb2NohMd2UakHRseiDgp97Z7VscVzs35HYeF2N4YXBUGiA7p
         ShNqp2JY6AxmM/VhKBcsxs82n5Y1QJn2WZhhcSprpgI43Pgh5ewC5Tt63UOC7tMiiEAd
         jd/eFHvsEqDWlMEtQpFpPYnKCkmXAAjfe3YBLWfA3bgYoJA8lq96vpgVJ3gsiDJjMuym
         xPyHfEhqG/LIbP7wrBWXdHY5aq4F6I8VwwVRs+eA4/pY5jK+s4RWXb8dLAohZy07Jloa
         f5wNTfeQe3jYmCS6LcYdz9MwUi+2uSQH5jxocUBypzY1Q6d2Q33x/3JLTLct565zsbGq
         CTIw==
X-Gm-Message-State: AOAM532aPV7g9x/lg+hItgGKDuRukJvtn+NBJKsbeJH5ARP/1F5K7CKp
        EYbMO9UU6NBvOmSxcVYHmseuuiiluYjWyq1LXDfXlCbmZjeZDN1iT5P9Bm4qdvaP4Hm9x5obNTj
        OKpj6G47qmJkab4bRwqLVDwk0AG8PoBBGFk8UU/ZFUQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr29595571wro.375.1632162087329;
        Mon, 20 Sep 2021 11:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCPZmp493nU2KexX4DlFrxsQs3hL2yp6zsXResDTNt3qLAbLsP0MEP/RGzViC4mVOpx1uqbw==
X-Received: by 2002:adf:f486:: with SMTP id l6mr29595549wro.375.1632162087156;
        Mon, 20 Sep 2021 11:21:27 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e5sm10515285wrd.1.2021.09.20.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:21:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: hwmon: jedec,jc42: convert to dtschema
Date:   Mon, 20 Sep 2021 20:21:13 +0200
Message-Id: <20210920182114.339419-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Jedec JC-42.4 temperature sensor bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/jc42.txt        | 46 -------------
 .../devicetree/bindings/hwmon/jedec,jc42.yaml | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 70 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/jc42.txt b/Documentation/devicetree/bindings/hwmon/jc42.txt
deleted file mode 100644
index f569db58f64a..000000000000
--- a/Documentation/devicetree/bindings/hwmon/jc42.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Properties for Jedec JC-42.4 compatible temperature sensors
-
-Required properties:
-- compatible: May include a device-specific string consisting of the
-	      manufacturer and the name of the chip. A list of supported
-	      chip names follows.
-	      Must include "jedec,jc-42.4-temp" for any Jedec JC-42.4
-	      compatible temperature sensor.
-
-	      Supported chip names:
-		adi,adt7408
-		atmel,at30ts00
-		atmel,at30tse004
-		onnn,cat6095
-		onnn,cat34ts02
-		maxim,max6604
-		microchip,mcp9804
-		microchip,mcp9805
-		microchip,mcp9808
-		microchip,mcp98243
-		microchip,mcp98244
-		microchip,mcp9843
-		nxp,se97
-		nxp,se98
-		st,stts2002
-		st,stts2004
-		st,stts3000
-		st,stts424
-		st,stts424e
-		idt,tse2002
-		idt,tse2004
-		idt,ts3000
-		idt,ts3001
-
-- reg: I2C address
-
-Optional properties:
-- smbus-timeout-disable: When set, the smbus timeout function will be disabled.
-			 This is not supported on all chips.
-
-Example:
-
-temp-sensor@1a {
-	compatible = "jedec,jc-42.4-temp";
-	reg = <0x1a>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
new file mode 100644
index 000000000000..a7bb4e3a1c46
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/jedec,jc42.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Jedec JC-42.4 compatible temperature sensors
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    oneOf:
+      - const: jedec,jc-42.4-temp
+      - items:
+          - enum:
+              - adi,adt7408
+              - atmel,at30ts00
+              - atmel,at30tse004
+              - idt,tse2002
+              - idt,tse2004
+              - idt,ts3000
+              - idt,ts3001
+              - maxim,max6604
+              - microchip,mcp9804
+              - microchip,mcp9805
+              - microchip,mcp9808
+              - microchip,mcp98243
+              - microchip,mcp98244
+              - microchip,mcp9843
+              - nxp,se97
+              - nxp,se98
+              - onnn,cat6095
+              - onnn,cat34ts02
+              - st,stts2002
+              - st,stts2004
+              - st,stts3000
+              - st,stts424
+              - st,stts424e
+          - const: jedec,jc-42.4-temp
+
+  reg:
+    maxItems: 1
+
+  smbus-timeout-disable:
+    description: |
+      When set, the smbus timeout function will be disabled. This is not
+      supported on all chips.
+    type: boolean
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
+        temp-sensor@1a {
+            compatible = "jedec,jc-42.4-temp";
+            reg = <0x1a>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b07679009af2..15c4d3c809e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10033,6 +10033,7 @@ JC42.4 TEMPERATURE SENSOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
 F:	Documentation/hwmon/jc42.rst
 F:	drivers/hwmon/jc42.c
 
-- 
2.30.2

