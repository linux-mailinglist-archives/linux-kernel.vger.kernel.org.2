Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE94331958A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBKWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBKWFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:05:47 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2177C061756;
        Thu, 11 Feb 2021 14:05:06 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r23so9294371ljh.1;
        Thu, 11 Feb 2021 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WpoZRJbhDf8nOoFeDPqKJ512Il9p1PZRrO8Rys09/E=;
        b=d6eKi29VImUi+4NGmgn29Z2XCYqijuDTVuFjOcxYPBBXDVeO41HPVLSJToBrzNhSzw
         6rdBDopbMZWSEk4zI12j+9Ybr5xMw56t9C67pEj2x7zBX/wbigY+0s5WDGdBLBguJcNN
         Sb93OcucDGNccLIrCFNj561hN/fG/32ACkK9I2+4rHJtfBXyquVa3qRNZMO+yQ0m48xM
         qu8VX01vjMvFQ84RICeFAFRHYRvzVdlmx/G784cosF17gJEZFMWVeXk/2jr0Uzg0nQhS
         hdQC3GU+E8ItCU+C4JZnsAHZO1v0vApiA3vZQcWZpkuNlcmUPYwLwpDzRn8/HT68RYPC
         GcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WpoZRJbhDf8nOoFeDPqKJ512Il9p1PZRrO8Rys09/E=;
        b=oOws6E3Y6Y9hXl33BUE6JHXUhKmmcTnAuyq9skjoIFZgnvz/Tl3HuCLxQGUlwf+Vz/
         G9pOdqEp6WkqMKKkaZmjMpkeGn8f/viPbTb78ht5i1PYUBfDJK6fg05WwbfroBmvJ/br
         ScvTTAjeMtWt6GNGsLbMd2GZEbTRk+70cT7Nh4qlCv4UNJPL5yvyotkiPwLsu1Wp534p
         d3vnr3EMkJXDkqIqxH/UpgDSeshVH/RoLg19eoO048TT8FP6sPuT11hYsJMSF8JEh925
         l4ngCl6r+7N9f/gMZP0esrDz1Idjv/gex61d6HXjFdZ7xHPzbkpNlNHQfSwxUvBMFbEf
         u0EQ==
X-Gm-Message-State: AOAM532b+h1QggC7Lo34m+gN4QUVL7/Qv8PLki431ogN41mQ6JxigC2G
        61aMGMHqy+vPIuBZ2oECbYE=
X-Google-Smtp-Source: ABdhPJz9/pqRJZERBqZYNejhrYDhFmoxupgsVASPNdY27cesCgSyFOn+wHgyzocuSKaoi6RHFHWa3Q==
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr6249535ljq.108.1613081104860;
        Thu, 11 Feb 2021 14:05:04 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o14sm1056649ljp.48.2021.02.11.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:05:04 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 mtd/next 2/3] dt-bindings: mtd: add binding for BCM4908 partitions
Date:   Thu, 11 Feb 2021 23:04:26 +0100
Message-Id: <20210211220427.27104-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211220427.27104-1-zajec5@gmail.com>
References: <20210211220427.27104-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses fixed partitions layout but function of some partitions may
vary. Some devices use multiple firmware partitions and those partitions
should be marked to let system discover their purpose.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use enum: [ 1, 2 ] for address & size
    Use ^partition@[0-9a-f]+$ pattern ("partition" was added)
    Drop unneeded allOf
    Add unevaluatedProperties
---
 .../partitions/brcm,bcm4908-partitions.yaml   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
new file mode 100644
index 000000000000..7b113e5e3421
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/brcm,bcm4908-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4908 partitioning
+
+description: |
+  Broadcom BCM4908 CFE bootloader supports two firmware partitions. One is used
+  for regular booting, the other is treated as fallback.
+
+  This binding allows defining all fixed partitions and marking those containing
+  firmware. System can use that information e.g. for booting or flashing
+  purposes.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: brcm,bcm4908-partitions
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    $ref: "partition.yaml#"
+    properties:
+      compatible:
+        const: brcm,bcm4908-firmware
+    unevaluatedProperties: false
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "brcm,bcm4908-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "cferom";
+            reg = <0x0 0x100000>;
+        };
+
+        partition@100000 {
+            compatible = "brcm,bcm4908-firmware";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@1000000 {
+            compatible = "brcm,bcm4908-firmware";
+            reg = <0x1000000 0xf00000>;
+        };
+
+        partition@1f00000 {
+            label = "calibration";
+            reg = <0x1f00000 0x100000>;
+        };
+    };
-- 
2.26.2

