Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA238AE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhETMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbhETMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F618C03CCDC
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:57:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u133so9012229wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRX2JtlP6roZDHRvtYOLEAQ/K5VUocF6cJ1EiMMZE2U=;
        b=cYQfOTbe1R2YmUfbEIaXJO8PkRspZ9kSS+W9Meup0D9UVVDtZ6bGiv0OXWB5dkarTv
         kVZMww/qtdQ4hu/w+bNmO6Cn8IcFtFUSORexjjuuNP58NT6IVsgCWWpMC3imbC9SXm0x
         rW74+V4mmk4hAOP1f9J90lI1ab7VCcfWQ26HWYat2ijJvHRn5tjNVqB2t8BtZaJGRTte
         HqyTus9JJr5+lV4APOF32ptIdSw5NKYJLcmDSqcn38Tne2nZmPDYh+VwvmSMFLE9mlyh
         kt8UTYgnrx1znWStbWzE2+9NMAYweDwA0nIXoYctl1Has6yCZ2AgZRJj1B0o75eJ1J+G
         AGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRX2JtlP6roZDHRvtYOLEAQ/K5VUocF6cJ1EiMMZE2U=;
        b=kLVz0JPL0xiwdi7sFhuYptVe/cLfu2/UUUPBu91IZso9Bj8JujEWn9ByNI2CRiPlfH
         zc8UZx/4auvVpFpSXAuig7xpYor5S8kroJWVsXctcPXQDHRky31/uLzCAB9toqGkBC9p
         bfIeenjVH4BTl9NHCs321rWg0AWxGeh/FtiLVLyX5zkkBQ81qq2mu/yA7FQeZyEqFzh7
         YWbp5QHL6c0ZkA4vY3whrLNQUyIuCL4S2WE98snRF1mTym+nX1JUQ+dEHRNkNQ7GyuIU
         iypKkDSSxQQQ/dpxOrDj/p6/1/z7uSJ9WUi6u49fP9b2Atxjxm0x3hsUvRZWYyp8U3pO
         B1Kg==
X-Gm-Message-State: AOAM530uxSO2nBf1HSUZwFp3yTwp9+abfP80holyz4WyH85roBYg36BL
        OQ8yG7ouET40tUlROJnUU8TCnQ==
X-Google-Smtp-Source: ABdhPJwg7SvNLg4qlgXj4qZQTDO7gV78Dm+ivYeKMl+4ggpfyfpwNFiEnX0P3s8pNwRORC7FVUwz8Q==
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr3223262wmd.40.1621511859655;
        Thu, 20 May 2021 04:57:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z12sm3179803wmc.5.2021.05.20.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:57:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt_bindings: mtd: partitions: redboot: convert to YAML
Date:   Thu, 20 May 2021 11:57:32 +0000
Message-Id: <20210520115732.1276569-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts mtd/partitions/redboot-fis.txt to YAML.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/mtd/partitions/redboot-fis.txt   | 27 ------------
 .../bindings/mtd/partitions/redboot-fis.yaml  | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
deleted file mode 100644
index fd0ebe4e3415..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-RedBoot FLASH Image System (FIS) Partitions
-===========================================
-
-The FLASH Image System (FIS) directory is a flash description
-format closely associated with the RedBoot boot loader.
-
-It uses one single flash eraseblock in the flash to store an index of
-all images in the flash.
-
-This block size will vary depending on flash but is typically
-32 KB in size.
-
-Required properties:
-- compatible : (required) must be "redboot-fis"
-- fis-index-block : (required) a index to the eraseblock containing
-  the FIS directory on this device. On a flash memory with 32KB
-  eraseblocks, 0 means the first eraseblock at 0x00000000, 1 means the
-  second eraseblock at 0x00008000 and so on.
-
-Example:
-
-flash@0 {
-	partitions {
-		compatible = "redboot-fis";
-		fis-index-block = <0>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
new file mode 100644
index 000000000000..61e08be984b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/redboot-fis.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RedBoot FLASH Image System (FIS) Partitions
+
+description: The FLASH Image System (FIS) directory is a flash description
+    format closely associated with the RedBoot boot loader.
+    It uses one single flash eraseblock in the flash to store an index of
+    all images in the flash.
+    This block size will vary depending on flash but is typically
+    32 KB in size.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    const: redboot-fis
+
+  fis-index-block:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: a index to the eraseblock containing the FIS directory on this
+      device. On a flash memory with 32KB eraseblocks, 0 means the first
+      eraseblock at 0x00000000, 1 means the second eraseblock at 0x00008000 and so on.
+
+required:
+  - compatible
+  - fis-index-block
+
+additionalProperties: false
+
+examples:
+  - |
+    flash@0 {
+      partitions {
+        compatible = "redboot-fis";
+        fis-index-block = <0>;
+      };
+    };
-- 
2.26.3

