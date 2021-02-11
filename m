Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F33190DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBKRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhBKQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:21:06 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61F7C061786;
        Thu, 11 Feb 2021 08:20:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d24so8897048lfs.8;
        Thu, 11 Feb 2021 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Klq+8tOZRYNtsr93x0bkE0OFCVkNgyAVAYrNdy6LlIA=;
        b=d7CSuissF1kLdNUvxsyMgjp5L79P0utUtQBK4o6sghIjh+anGrVTlyRDjO+3yLY0B8
         358tEQA5wtuE6d6DK7Pf7JJImbZRLmrMp5KLM8Wcry3sxOpEajJjHAZTnldJptxmuKy5
         gY+vzvpH2qkrZJra0KPAd4/OcxnSULKOKkTt9pastaCUspvfeQdkRl9SYKc8Liygo7Zn
         s/d1lIVUjUoPv78GfoPII1mXUJU/neI6JA/KVWVj7Qj6HYPj6qtNQB6KFGBYd1zGYe0d
         BTIKaf0D5CPMiM4aZJu9MA7wcAAmSxz9NfyhE1ofKmirZosXbNg6olULlD62OKi0+rop
         E26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Klq+8tOZRYNtsr93x0bkE0OFCVkNgyAVAYrNdy6LlIA=;
        b=Gaiaz5kljkx3VfzZ4xh/8vTwi2WSC+bn07A6imfu9HQCMjBHS+jdma/IT6pZAt22UH
         BSJ1d33HywFouKhuwsSoqP3sQU2q5eUFsHOR4eOGV2Ih23zvrluJxApVuVKeGZnAcjsB
         84WxbKNG7h/JtC322ezlvo1MU2zrD9KJm1S0BtDl9L2RO0Ll81DSADvjAQgUzYjT2LEJ
         ZjrBuRWIUqCJaRS5HnNFHDDNNsRy/Z9EOFxS5KDYcVaiHC8JeSy+4Zjt7eLe0wFlXRmg
         aA4LT4fOEr+XCNzYSar3+yNw3kSppoyzo2yituWXV9tw7RsbT3+jrFbsmo0K4PmGMuf6
         iFhg==
X-Gm-Message-State: AOAM5313JJQwYynT4dmd3krQsa3knJdOyiIiGAC8bvGYu5p6f2hCtgGH
        W7iF1UBVnFQ9+ky4M02vK/8=
X-Google-Smtp-Source: ABdhPJzAho/xEpXrHRwCUYs5X/XOO5iSDUdCi+OiIBXlAlW8Hmvg9Hr9HuhT0buIhy58eiuXoCZ2Ww==
X-Received: by 2002:a19:6d0a:: with SMTP id i10mr4612142lfc.367.1613060421764;
        Thu, 11 Feb 2021 08:20:21 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b5sm685941lfi.3.2021.02.11.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:20:21 -0800 (PST)
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
Subject: [PATCH V2 mtd/next 1/3] dt-bindings: mtd: move partition binding to its own file
Date:   Thu, 11 Feb 2021 17:20:10 +0100
Message-Id: <20210211162012.27417-1-zajec5@gmail.com>
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

