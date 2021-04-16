Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B584A362B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhDPWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:25:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59820 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhDPWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:25:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13GMPJKm118270;
        Fri, 16 Apr 2021 17:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618611919;
        bh=utgO5PVd5wR3Tdh3aSlX3zh2ppZqzEWKNEl2e6gL+58=;
        h=From:To:CC:Subject:Date;
        b=K+k2XntQa4HadpsrzbpLPauhygzKAb5JAsgFFwlQ5h7Lob7PgI8vEhrHBgxATEyXc
         n2wfUAGEQWtAvtUyuT2rrfBQAXDKnymvhRTayocKHu5Zb6JsrAjOF5E8tHuPaV+68V
         bKvVFiwqwXzEt9jAYYYEZfYpV7U7Pi3tE3VCanEg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13GMPJlM125175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 17:25:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 17:25:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 17:25:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13GMPI2u070293;
        Fri, 16 Apr 2021 17:25:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to json schema
Date:   Fri, 16 Apr 2021 17:25:18 -0500
Message-ID: <20210416222518.15801-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert linaro,optee-tz to json schema format for better documentation
and error checks.

NOTE:
1. This change does introduce a stricter naming convention for
   optee nodes.
2. We do have false positive checkpatch warning with this patch:
   "DT binding docs and includes should be a separate patch"

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
 .../arm/firmware/linaro,optee-tz.yaml         | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
deleted file mode 100644
index d38834c67dff..000000000000
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-OP-TEE Device Tree Bindings
-
-OP-TEE is a piece of software using hardware features to provide a Trusted
-Execution Environment. The security can be provided with ARM TrustZone, but
-also by virtualization or a separate chip.
-
-We're using "linaro" as the first part of the compatible property for
-the reference implementation maintained by Linaro.
-
-* OP-TEE based on ARM TrustZone required properties:
-
-- compatible     : should contain "linaro,optee-tz"
-
-- method         : The method of calling the OP-TEE Trusted OS. Permitted
-                   values are:
-
-                   "smc" : SMC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-                   "hvc" : HVC #0, with the register assignments specified
-		           in drivers/tee/optee/optee_smc.h
-
-
-
-Example:
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
new file mode 100644
index 000000000000..6513b5ac8b2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OP-TEE Device Tree Bindings
+
+maintainers:
+  - Jens Wiklander <jens.wiklander@linaro.org>
+
+description: |
+  OP-TEE is a piece of software using hardware features to provide a Trusted
+  Execution Environment. The security can be provided with ARM TrustZone, but
+  also by virtualization or a separate chip.
+
+  We're using "linaro" as the first part of the compatible property for
+  the reference implementation maintained by Linaro.
+
+properties:
+  $nodename:
+    const: 'optee'
+
+  compatible:
+    const: linaro,optee-tz
+
+  method:
+    description: The method of calling the OP-TEE Trusted OS.
+    oneOf:
+      - description: |
+          SMC #0, with the register assignments specified
+          in drivers/tee/optee/optee_smc.h
+        items:
+          - const: smc
+      - description: |
+          HVC #0, with the register assignments specified
+          in drivers/tee/optee/optee_smc.h
+        items:
+          - const: hvc
+
+required:
+  - compatible
+  - method
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware  {
+        optee  {
+            compatible = "linaro,optee-tz";
+            method = "smc";
+        };
+    };
+
+  - |
+    firmware  {
+        optee  {
+            compatible = "linaro,optee-tz";
+            method = "hvc";
+        };
+    };
-- 
2.31.0

