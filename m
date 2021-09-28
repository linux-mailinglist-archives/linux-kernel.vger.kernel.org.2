Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3F41ABE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhI1Jci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:38 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:51011 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhI1JcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:22 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 05:32:20 EDT
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B0890C85;
        Tue, 28 Sep 2021 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821034;
        bh=CatX71RSe4cBZ47vo+0qA9ACXKr3G52arA6l0RAFgGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OU3CiAdtMLJuCOrqBhr8ogVpJui6ITSdQiYMktK6cQlMO78+x9e4lX2yF0kGCy3M2
         WmXS7tFrMzOO05gdT7pWNORCFMVuGDsw3130Lq4IAWpaoWZmPajWiHxd/K6j8+ju5/
         GWTQUWn6cyFv0j3GvC7jpkCz72+k0ouw0KpulCEo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] dt-bindings: hwmon/pmbus: Add ti,lm25066 power-management IC
Date:   Tue, 28 Sep 2021 02:22:42 -0700
Message-Id: <20210928092242.30036-9-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../bindings/hwmon/pmbus/ti,lm25066.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
new file mode 100644
index 000000000000..da8292bc32f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm25066.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: National Semiconductor/Texas Instruments LM250x6/LM506x power-management ICs
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  The LM25066 family of power-management ICs (a.k.a. hot-swap
+  controllers or eFuses in various contexts) are PMBus devices that
+  offer temperature, current, voltage, and power monitoring.
+
+  Datasheet: https://www.ti.com/lit/ds/symlink/lm25066.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,lm25056
+      - ti,lm25066
+      - ti,lm5064
+      - ti,lm5066
+      - ti,lm5066i
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt (sense) resistor value in micro-Ohms
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
+        pmic@40 {
+            compatible = "ti,lm25066";
+            reg = <0x40>;
+            shunt-resistor-micro-ohms = <675>;
+        };
+    };
-- 
2.33.0

