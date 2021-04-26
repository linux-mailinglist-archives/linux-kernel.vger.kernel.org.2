Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7136B708
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhDZQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:40:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54216 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhDZQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:40:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QGeCgQ107008;
        Mon, 26 Apr 2021 11:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619455212;
        bh=0cmvWQtnc0irmIdmwW5bR1wAnKzv1BScw6VBk3yY69w=;
        h=From:To:CC:Subject:Date;
        b=U9qBHi/XxzZqaQYd1C5whCzH8aJHK31dxD6lYAZUgwR+zZrg3uZ9GBKoBRQR2xuJi
         DQuhHXb3hQ29ILXI8KHnnRDwQxzLsJNQzGVDG3X1cI0zLY7ZGPrJ4u0kh5h1NcFD+a
         8lAyecx02iBDZGxNaGkqE1CQRzkhjjC1KGzluJg4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QGeCtv027810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 11:40:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 11:40:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 11:40:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QGeCQx056249;
        Mon, 26 Apr 2021 11:40:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] dt-bindings: arm: firmware: Convert linaro,optee-tz to json schema
Date:   Mon, 26 Apr 2021 11:40:08 -0500
Message-ID: <20210426164008.20000-1-nm@ti.com>
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

NOTE: This change does introduce a stricter naming convention for
optee nodes.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since v1:
* Dropped un-necessary quotes around compatible
* Converted the method to enum, updated description as well
* Updated commit message to drop the 'checkpatch warning'

V1: https://lore.kernel.org/linux-arm-kernel/20210416222518.15801-1-nm@ti.com/

 .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
 .../arm/firmware/linaro,optee-tz.yaml         | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 31 deletions(-)
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
index 000000000000..c24047c1fdd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -0,0 +1,58 @@
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
+    const: optee
+
+  compatible:
+    const: linaro,optee-tz
+
+  method:
+    enum: [smc, hvc]
+    description: |
+      The method of calling the OP-TEE Trusted OS depending on smc or hvc
+      instruction usage.
+      SMC #0, register assignments
+      or
+      HVC #0, register assignments
+      register assignments are specified in drivers/tee/optee/optee_smc.h
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

