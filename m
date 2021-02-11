Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008031958E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBKWFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhBKWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:05:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C4C061574;
        Thu, 11 Feb 2021 14:05:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m22so10371988lfg.5;
        Thu, 11 Feb 2021 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Klq+8tOZRYNtsr93x0bkE0OFCVkNgyAVAYrNdy6LlIA=;
        b=oYiGIo/8ghS7Kt+K/u7rrUNxTWDlauSpHl0PtnNPH9ThzvUYO7QnDSAyxINKWXb24Q
         eF3xHjP6xtziLYrGp2Wlkw3Qa6o3MqeV0VOQDDxYIcO9UWEmMKOV3JhCYtdBtatNC/lA
         Qo137FbEYUS2NgpXEfP05ZyI75q3/SqJzzjrCGFK0wXYh9IeDaSUvlfZ21oSuVZpHoHv
         gOdf9WTCG72wCRkwR7Y72lvZbjBpTmntx4IzICa6dWs5nZP19Rvo8N/rsZbG2DghHp6V
         X6smJe+qQzBFcswQOH++x7FI3ZPS83NddHyceTF38Ds/351Gmd5XOCY1t0GFXgYKXkRh
         BR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Klq+8tOZRYNtsr93x0bkE0OFCVkNgyAVAYrNdy6LlIA=;
        b=jBJqP/Le2h5Esaql7G4RBdAvXCQVE6DTy1XbhVKvz7qqL03FkMZGHob4U0WkaLaAcO
         n4Yti7NTfTk8UG6SnL1JW7zdEbp3IClHX3iyQ9Di8tFD6pFSOBX1+DM/9NYtxJYNitE4
         /fuX4k+OJGAYZrcVrVgFl2gx6mi0kZjOfSZ8IXO2W0dkjylXx3ilVeMQy5DfgRz4vX47
         LKDZ6ZhKYVnYxfnD0Yvjb5zxvNc80thur61bNV7MqTqvra1vXc5tl2gNHH5F37KKUEWQ
         +Bqsp5qobkXiK8yYWKHNx2R58ln++yizPfxhXWGm2moLXpfkeGmirlUtIA1OPfp00Vjk
         uTow==
X-Gm-Message-State: AOAM5304xV9ASC19eNcd5bmPKJQV1EB0eIObt3He/5mivPz9VXebdBvS
        a7BlaEZ9BqLHEM3lC9xOuF/+KPkNKH0=
X-Google-Smtp-Source: ABdhPJx6uQMREOyVzNXR50iOdrGDXjLGFHjWoNAiaKRdpPu0UFxSxDBMXNekysVE2UmxF5IpOxxVcw==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr27958lfi.616.1613081102987;
        Thu, 11 Feb 2021 14:05:02 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o14sm1056649ljp.48.2021.02.11.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:05:02 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 mtd/next 1/3] dt-bindings: mtd: move partition binding to its own file
Date:   Thu, 11 Feb 2021 23:04:25 +0100
Message-Id: <20210211220427.27104-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Single partition binding is quite common and may be:
1. Used by multiple parsers
2. Extended for more specific cases

Move it to separated file to avoid code duplication.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../mtd/partitions/fixed-partitions.yaml      | 33 +------------
 .../bindings/mtd/partitions/partition.yaml    | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 6d4a3450e064..ea4cace6a955 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -27,38 +27,7 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    description: node describing a single flash partition
-    type: object
-
-    properties:
-      reg:
-        description: partition's offset and size within the flash
-        maxItems: 1
-
-      label:
-        description: The label / name for this partition. If omitted, the label
-          is taken from the node name (excluding the unit address).
-
-      read-only:
-        description: This parameter, if present, is a hint that this partition
-          should only be mounted read-only. This is usually used for flash
-          partitions containing early-boot firmware images or data which should
-          not be clobbered.
-        type: boolean
-
-      lock:
-        description: Do not unlock the partition at initialization time (not
-          supported on all devices)
-        type: boolean
-
-      slc-mode:
-        description: This parameter, if present, allows one to emulate SLC mode
-          on a partition attached to an MLC NAND thus making this partition
-          immune to paired-pages corruptions
-        type: boolean
-
-    required:
-      - reg
+    $ref: "partition.yaml#"
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
new file mode 100644
index 000000000000..e1ac08064425
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition
+
+description: |
+  This binding describes a single flash partition. Each partition must have its
+  relative offset and size specified. Depending on partition function extra
+  properties can be used.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  reg:
+    description: partition's offset and size within the flash
+    maxItems: 1
+
+  label:
+    description: The label / name for this partition. If omitted, the label
+      is taken from the node name (excluding the unit address).
+
+  read-only:
+    description: This parameter, if present, is a hint that this partition
+      should only be mounted read-only. This is usually used for flash
+      partitions containing early-boot firmware images or data which should
+      not be clobbered.
+    type: boolean
+
+  lock:
+    description: Do not unlock the partition at initialization time (not
+      supported on all devices)
+    type: boolean
+
+  slc-mode:
+    description: This parameter, if present, allows one to emulate SLC mode
+      on a partition attached to an MLC NAND thus making this partition
+      immune to paired-pages corruptions
+    type: boolean
+
+required:
+  - reg
+
+additionalProperties: true
-- 
2.26.2

