Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51642791D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbhJIKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:48:43 -0400
Received: from ixit.cz ([94.230.151.217]:41674 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244412AbhJIKsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:48:42 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 40A9E20064;
        Sat,  9 Oct 2021 12:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633776404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EA0LlA/fIa7eX/nq6fV+QazDrfjH7W/uq1vZxVoc/Cs=;
        b=ivZLgm7I/A86H9mZ8evJEQpkJWuEklb8RosEQOVBsE0sY2rnWhu54MuC1kjmJ566zffAUa
        6bb9Y0NgL2Zp13BXQSb+fTgmSuoAq5LNUZTgcQ2aY/8KSZWK2qB2az/Ix/ZTcYrUzoJujI
        r7mUc7e4oBqskeuB/sg02Rns4V+wqTA=
From:   David Heidelberg <david@ixit.cz>
To:     Stephen Warren <swarren@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>
Subject: [PATCH] WIP: dt-bindings: arm: firmware: tlm,trusted-foundations: Convert txt bindings to yaml
Date:   Sat,  9 Oct 2021 12:45:18 +0200
Message-Id: <20211009104518.45596-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Trusted Foundation binding to the YAML syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../arm/firmware/tlm,trusted-foundations.txt  | 20 --------
 .../arm/firmware/tlm,trusted-foundations.yaml | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
deleted file mode 100644
index 780d0392a66b..000000000000
--- a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Trusted Foundations
--------------------
-
-Boards that use the Trusted Foundations secure monitor can signal its
-presence by declaring a node compatible with "tlm,trusted-foundations"
-under the /firmware/ node
-
-Required properties:
-- compatible: "tlm,trusted-foundations"
-- tlm,version-major: major version number of Trusted Foundations firmware
-- tlm,version-minor: minor version number of Trusted Foundations firmware
-
-Example:
-	firmware {
-		trusted-foundations {
-			compatible = "tlm,trusted-foundations";
-			tlm,version-major = <2>;
-			tlm,version-minor = <8>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
new file mode 100644
index 000000000000..9d1857c0aa07
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/firmware/tlm,trusted-foundations.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Trusted Foundations
+
+description: |
+  Boards that use the Trusted Foundations secure monitor can signal its
+  presence by declaring a node compatible under the /firmware/ node
+
+maintainers:
+  - Stephen Warren <swarren@nvidia.com>
+
+properties:
+  $nodename:
+    const: trusted-foundations
+
+  compatible:
+    const: tlm,trusted-foundations
+
+  tlm,version-major:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: major version number of Trusted Foundations firmware
+
+  tlm,version-minor:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: minor version number of Trusted Foundations firmware
+
+required:
+  - compatible
+  - tlm,version-major
+  - tlm,version-minor
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      trusted-foundations {
+        compatible = "tlm,trusted-foundations";
+        tlm,version-major = <2>;
+        tlm,version-minor = <8>;
+      };
+    };
-- 
2.33.0

