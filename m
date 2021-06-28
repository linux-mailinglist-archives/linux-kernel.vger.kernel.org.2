Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB633B68ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhF1TRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhF1TRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:17:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E28DC061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:14:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g198so4243087wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+htQTyEDF+CVc+mO+s5d9t8IztHN54DhG/4dMTnUuhs=;
        b=M84CXuxddhwuBiLOn5s5lrAZLL1SfDCezNR9CfNLJ0MCC4ycfVQw0oBLTYJwtJ0cYl
         TpQVpFZvX9c5NmVMSMBNb7p2IDcGKBUfnjWbISvK4cRF8wi0l3Jq0LB16GTBHxxxRr+z
         e+ddYYTYKEtUNC+jy004NKbP+3D4/GA46E4B9CNLPF9fEUhqHgOqEs3JHnX8VU53uvwk
         2595OdvZAb6Y6ZNNTx1YwvEaDi7AAl+K9dBaCesjWJ3OSrOxvQP0zm+n3V2Ey3hNx9lK
         lsj2rkbvgcNq5oFDqZmGQWrAC+yHhHZdPpf3pJeTfCjlHXxhMeccrO06AP72HycuZCcd
         qFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+htQTyEDF+CVc+mO+s5d9t8IztHN54DhG/4dMTnUuhs=;
        b=fiWBhfeC2iTTHv0s0DacoMEBsA3/icHf3cQ3mZ3OaB8Mc4Zj7kRtAIWyAX6Z6gayjr
         mV1xluJgtMF2lYNf8RU/xrMMZXtpOfmUdXOxVuibPOBcayxNIvQbo+ai25CoJoWt3Oat
         i770HmMODiz79PCYfiajkUp8QpOSQhno0/ybDCEEOnGqNTOuF+HB/uvGVSICD6oeWho4
         Kir6y+M8NPW9TWAcags/KJTwD/y329oOwGFNSh6iawA7pSImoeQhb+xa/SCoFno/FBPI
         OeL6s/M2UZ89ckjMwEkrsODErYpCw0c9kqXMfdRLTwk66E14cW04CQk/FJ7hVMt/vo3Y
         Fw3Q==
X-Gm-Message-State: AOAM533Psm+lcfXXf+Ad8QbyKFEC9Vn2FeE4QqwDOW+3NnmsOSNtKSwY
        A6jsKAM6OQiYxnThIoTsVLlQ1w==
X-Google-Smtp-Source: ABdhPJyezEkTfArDKPV5DlchwZCsHL9GtWwN39ROTKBKy+ZAKVhOrjtAWdLO60RlnmSJF3S/SF58XA==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr28391463wmc.1.1624907687817;
        Mon, 28 Jun 2021 12:14:47 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n8sm15591229wrt.95.2021.06.28.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:14:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] dt_bindings: mtd: partitions: redboot: convert to YAML
Date:   Mon, 28 Jun 2021 19:14:40 +0000
Message-Id: <20210628191440.2823024-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts mtd/partitions/redboot-fis.txt to YAML.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- fixed yamllint errors
- removed @0 from flash

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
index 000000000000..fee8d81b5276
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
+    flash {
+      partitions {
+        compatible = "redboot-fis";
+        fis-index-block = <0>;
+      };
+    };
-- 
2.31.1

