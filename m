Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B326344E59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhCVSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:20:25 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:47545 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhCVSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:20:09 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A561A2224F;
        Mon, 22 Mar 2021 19:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616437207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qw8umJ2JoyZ8T0bgCSEERZKN81p4KztCiLS9kzIRYso=;
        b=RNQEXo0C8OUA6uRVl2yUsqB98r2YYrxfTL8VbFlkXWdFPwAXR6ZF1bGN5vzGgSLbOmJe8X
        HpwP6e1aog5RaiKkb969xPhWkBrHRw7i5NeoW9cgtGWv0pEzd+hFGnYBQpN2DlqWoHfknt
        9IjyQLCMtvszXWHvvus1YzptrnAbtIc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 2/4] dt-bindings: mtd: add YAML schema for the generic MTD bindings
Date:   Mon, 22 Mar 2021 19:19:47 +0100
Message-Id: <20210322181949.2805-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322181949.2805-1-michael@walle.cc>
References: <20210322181949.2805-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MTD's common.txt to mtd.yaml.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Btw, I've asked Miquel if I can add it as the maintainer.

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
index 000000000000..321259aab0f6
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
+            compatible = "some,flash";
+            label = "System-firmware";
+        };
+    };
+
+...
-- 
2.20.1

