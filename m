Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7E413190
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhIUKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:31:07 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42838
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbhIUKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2398402CE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632220155;
        bh=myEI9udE32HikY6HV94XXW8Fjm7KphRiRgu8VFe3DLw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=I7TSE4mk0gRFzfjvxw+7Joj3Fa6ZZusfIEDvgEKWE9cQAfsnlh7O9KErWFm5404/z
         ZVcFlM1+QyuWWCKyAvCaTZ6AvL6ONt4xlIvOr4inwVR2N7ijNgfsTSro4W4MSr8xiX
         4QvGyVJh53B2Q+zFi4BHJuqdPcUMcpLnNvgBtLsAKRPTMCM0ijKwUShZxlZAXNnamh
         g0cXiofQc4ngYLLP2iCTOhqi944RWi7YzhwvlNryYxF7qkSAdkWqEFtEBkNCjLNQYh
         7oY7jMjAp18a2zi6R66jvcpxCBmjvfzct1ZxI6DE5hoaHoY8xTg+F4CCwBOkUFq/dC
         EblmUJY8D/2FA==
Received: by mail-wr1-f72.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso8424641wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myEI9udE32HikY6HV94XXW8Fjm7KphRiRgu8VFe3DLw=;
        b=vL823p3LPOPqHlNXD2uDJwe7+4c3YhkIgra2D0fAZ7Jmqoh0BrZykRYe4BA7CO3XIp
         LjCHFZn6qZl9KLm0duaW9mgLsDdy7eLfuKvL+NKopfBLR3YPbbdDCvAhNZF/cINcOwJJ
         +Meb57rpvTt9z0W/WV91UDRL1fOOKBDiiEC82t/QpYXGyKgPuEHoYIasmcBc5BkEUXWN
         EgCVx4cS6kIcHHEpNYhkUcKjFeiKSN7/rfF8DgyWk5sqSjVGD2fhLLiMu1Z7oC4R3TpT
         IshSFfsj8CaCM8X+S2SzNo7LqejGuXp4Z20EX+6ZTgOzFHbSWHmx+EZdaHAjB/pmBbpu
         H9eA==
X-Gm-Message-State: AOAM531ezsUZuX/AzoZ5b7Q3iWRxJ0sURkdso53PIQaAMy/igS/PaZuy
        kSrDmoJMIGSVkpDzL/RXxKMSfMk1FLFoxkJtTBOH2eFF8FUGImf/txGzEk6cXVPJtYi+85Zt/El
        RVNF7+PfW02FNjWVUJVG++26Skmu6fSfLsmtniexh0g==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr3703313wmc.23.1632220155327;
        Tue, 21 Sep 2021 03:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8CsNDEe2FpMPJma0T72qL/+ZrHrId9tNK6g3AcRCWKUzyTZt5iXmYH317au3rv9NQnSAlEg==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr3703294wmc.23.1632220155132;
        Tue, 21 Sep 2021 03:29:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m29sm20072380wrb.89.2021.09.21.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:29:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: hwmon: lltc,ltc4151: convert to dtschema
Date:   Tue, 21 Sep 2021 12:28:30 +0200
Message-Id: <20210921102832.143352-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LTC4151 current and voltage sensor bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/hwmon/lltc,ltc4151.yaml          | 41 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ltc4151.txt     | 18 --------
 2 files changed, 41 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc4151.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
new file mode 100644
index 000000000000..4b5851c326f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/lltc,ltc4151.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTC4151 High Voltage I2C Current and Voltage Monitor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: lltc,ltc4151
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt resistor value in micro-Ohms
+    default: 1000
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
+        sensor@6e {
+            compatible = "lltc,ltc4151";
+            reg = <0x6e>;
+            shunt-resistor-micro-ohms = <1500>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/ltc4151.txt b/Documentation/devicetree/bindings/hwmon/ltc4151.txt
deleted file mode 100644
index d008a5ef525a..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ltc4151.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-LTC4151 High Voltage I2C Current and Voltage Monitor
-
-Required properties:
-- compatible: Must be "lltc,ltc4151"
-- reg: I2C address
-
-Optional properties:
-- shunt-resistor-micro-ohms
-	Shunt resistor value in micro-Ohms
-	Defaults to <1000> if unset.
-
-Example:
-
-ltc4151@6e {
-	compatible = "lltc,ltc4151";
-	reg = <0x6e>;
-	shunt-resistor-micro-ohms = <1500>;
-};
-- 
2.30.2

