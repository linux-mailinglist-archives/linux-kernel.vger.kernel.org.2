Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5099741318F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhIUKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:30:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42864
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhIUKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 39F37402D3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632220157;
        bh=JOXzjGlmPlXzv176OGMdy7msusTrGyBdhYwvlOul8IE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GFozesAvltHwU8HIf7KK8a9A5tLwUzHwMq+5JBsVtRtdudxPxtFasQ+F5QfUaOpPk
         tadhXr8tDH7y00xHRu4V2OvZnvH4hZH8aawqSbgDd4bgrb3pOftjQcqEZvLvHiQkHw
         BehjYxwG6g04PLJM9ws5njJqDgL+anMvS7uKodQPfRLYA7h6urZqcC7jcXF7qokzrK
         D53oN4iDbwshFiTwTJttWo8EE3EzONFXcDjxtxF6Xqmuff3knRgH7HhFT0T5ib8waW
         XLk1Gc4fW7M8r+AXbX3Dfi1kxfWnMkHBq3Wi11wzL4abPiM1H1WD0/GQ/TQaKmGOUG
         2sz++wsUdQzvQ==
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adff80e000000b001601b124f50so1598705wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOXzjGlmPlXzv176OGMdy7msusTrGyBdhYwvlOul8IE=;
        b=24S2LTUtyl44ytI6hhts3uSwIhmCRhZj5WLF9n0SXziKy3VStEXiLFajVUSHBCnbx/
         QTjObgwGiK8TlRu43nueToX9PsvCYugZv02KxXUMmnf2IvwRwGwRWFYVj+8g74Hi7HV/
         ps7zKk41QgScxu9Ca5fDuBdOVjQls9FXV3eu436X57YsOYR9WTfIhAwI6kNQccEjJulL
         9lcu8poqcPpCZBCN1YrmyXONv0Y/6EDulYAjmAAsUPGaC1xTd4WDhFzRARID4m2gk3Cb
         oUyEYAcKC3/PgMj3Krx8Mo6oRpCVbVJE/wEv0gX9UCm8f8yiwNjT9JTCdvHrP+YNHiMy
         1OHw==
X-Gm-Message-State: AOAM531BROQEW6hcSbF4NU/r3KG+npY8Nl/dOmHtW5ZIpixpGbltNYez
        mOrMyuNdvQl/Xtxdtq9yE/qQs+4Yfu6YDBXCrh4AID4MAy/qZNZJWJm/RV7GS5vGq1v2ZC0wMs0
        TWW9Iw7k68XTfC6Wj3LbtV3mDzQD5qsNWDf8/4//Z5A==
X-Received: by 2002:adf:d216:: with SMTP id j22mr34546926wrh.295.1632220156546;
        Tue, 21 Sep 2021 03:29:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKogt/K6fEvl4nqJryVGtR+Bgt5oZ44S6BpR4v8fZ6A8tSIu6NyHYuSz70bv4PYE6GoKy/oQ==
X-Received: by 2002:adf:d216:: with SMTP id j22mr34546915wrh.295.1632220156416;
        Tue, 21 Sep 2021 03:29:16 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m29sm20072380wrb.89.2021.09.21.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:29:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: hwmon: microchip,mcp3021: convert to dtschema
Date:   Tue, 21 Sep 2021 12:28:31 +0200
Message-Id: <20210921102832.143352-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Microchip MCP3021 ADC bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/mcp3021.txt     | 21 ---------
 .../bindings/hwmon/microchip,mcp3021.yaml     | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/mcp3021.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/mcp3021.txt b/Documentation/devicetree/bindings/hwmon/mcp3021.txt
deleted file mode 100644
index 294318ba6914..000000000000
--- a/Documentation/devicetree/bindings/hwmon/mcp3021.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-mcp3021 properties
-
-Required properties:
-- compatible: Must be one of the following:
-	- "microchip,mcp3021" for mcp3021
-	- "microchip,mcp3221" for mcp3221
-- reg: I2C address
-
-Optional properties:
-
-- reference-voltage-microvolt
-	Reference voltage in microvolt (uV)
-
-Example:
-
-mcp3021@4d {
-	compatible = "microchip,mcp3021";
-	reg = <0x4d>;
-
-	reference-voltage-microvolt = <4500000>; /* 4.5 V */
-};
diff --git a/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
new file mode 100644
index 000000000000..c42051f8a191
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,mcp3021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP3021 A/D converter
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3021
+      - microchip,mcp3221
+
+  reg:
+    maxItems: 1
+
+  reference-voltage-microvolt:
+    description:
+      VDD supply power and reference voltage
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
+        adc@4d {
+            compatible = "microchip,mcp3021";
+            reg = <0x4d>;
+
+            reference-voltage-microvolt = <4500000>; /* 4.5 V */
+        };
+    };
-- 
2.30.2

