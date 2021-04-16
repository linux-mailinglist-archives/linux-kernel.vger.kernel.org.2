Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC7361F21
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhDPLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:50:06 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40143 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhDPLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:50:02 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C0C022255;
        Fri, 16 Apr 2021 13:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618573775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5mlW+sn5FZ7Xj6idRbO0XplNjAvnEg7p0BfoTeHt+k=;
        b=ek3NUy1sL9NBd33wOCAtZVgnMywkWLXFHPDBBdjkWZGBMwSGCTGAcP6VN0GG4ymmPezY+F
        pZ9CuQ3KaZfM1h5rYsEXZhrHpvRamgy66ZRMpJpLEl84VMpzBosVgUnSQW8pmij9VnshiO
        wXQR4RElNFyebJb+xD2Z9cG34POGTj0=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH 2/5] dt-bindings: mtd: add YAML schema for the generic MTD bindings
Date:   Fri, 16 Apr 2021 13:49:25 +0200
Message-Id: <20210416114928.27758-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416114928.27758-1-michael@walle.cc>
References: <20210416114928.27758-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MTD's common.txt to mtd.yaml.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since RFC:
 - use real device compatibles

 .../devicetree/bindings/mtd/common.txt        | 16 +-------
 .../devicetree/bindings/mtd/mtd.yaml          | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml

diff --git a/Documentation/devicetree/bindings/mtd/common.txt b/Documentation/devicetree/bindings/mtd/common.txt
index fc068b923d7a..ae16f9ea8606 100644
--- a/Documentation/devicetree/bindings/mtd/common.txt
+++ b/Documentation/devicetree/bindings/mtd/common.txt
@@ -1,15 +1 @@
-* Common properties of all MTD devices
-
-Optional properties:
-- label: user-defined MTD device name. Can be used to assign user
-  friendly names to MTD devices (instead of the flash model or flash
-  controller based name) in order to ease flash device identification
-  and/or describe what they are used for.
-
-Example:
-
-	flash@0 {
-		label = "System-firmware";
-
-		/* flash type specific properties */
-	};
+This file has been moved to mtd.yaml.
diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
new file mode 100644
index 000000000000..086b0ecd1604
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mtd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD (Memory Technology Device) Device Tree Bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+  - Richard Weinberger <richard@nod.at>
+
+properties:
+  $nodename:
+    pattern: "^flash(@.*)?$"
+
+  label:
+    description:
+      User-defined MTD device name. Can be used to assign user friendly
+      names to MTD devices (instead of the flash model or flash controller
+      based name) in order to ease flash device identification and/or
+      describe what they are used for.
+
+additionalProperties: true
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            reg = <0>;
+            compatible = "jedec,spi-nor";
+            label = "System-firmware";
+        };
+    };
+
+...
-- 
2.20.1

