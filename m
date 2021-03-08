Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC4331891
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCHU2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhCHU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:28:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18779C06174A;
        Mon,  8 Mar 2021 12:28:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so16651066edw.9;
        Mon, 08 Mar 2021 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Kh1Yf0VUjHQBBvxfg+IVIKi9UzkPdTDrtNGt4KOZsA=;
        b=pX/jKQXq2KdZr6MxLZFdppzNbSjSWsDyKMqTg8/TTNtvdfg7uqVolMffJkFaM7vcCR
         RL23RdyFQDJ5DJ1r/83TjYlZRTXhdKnhl+RMJ0j93RqhkoSM9akBU4AUwkzD806pHcI8
         aMirWvpLhYkClsn90LJNelZ4PO4Y8t9NvDmE1VVAjUTZ1uKy0NTs2VKpM/mE6hOzOHwi
         g/koRMh/Scml/NgKEGnw0ML2Mf2Dof1acym4qpNYXlG7xNHI2LlsJGw+z7KMkT4E2C/T
         n+QIYIHCw29M961Nqd2Q07oCOunN5pme+KbTtePzc+9aPTEQzHqZ/ztq3VB83qgPD/Ux
         HQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Kh1Yf0VUjHQBBvxfg+IVIKi9UzkPdTDrtNGt4KOZsA=;
        b=bxLfhVc8zcOVu02n56wg6hZeiv5DJHHUZ+9HhfhVL3RayMDsS/wOzFLSG4lppZrfVv
         PcuIqJIg2OklI/K3Z9gyJRqLvkJk+bR2p3lHI7ZMx08z716w8kxrNkYwX7XYUfXA1aGC
         I63vjf5481jrXaZaB6YzdSt7gsq0oKqPY3o/WgRF+AtcHQDFsRsjF5k40+AcsHDu24/O
         HcUeAJ6zmDuPBDOd8dpIfu1wqsgBCw9SMzrU7frcsY3wY99Zof8LplOVX/xbtNd9eNfU
         IKdA8JBnvLibOcCvHp5Dt3bjuiLo3N36xlsycwR1Ho+1UIyf+PtM0Q7ULr17VCQ36JYj
         71+g==
X-Gm-Message-State: AOAM533mg4AJIA034fDAjX6QfSZ20JLoQUSrMG6kAT6Y2LjQO7t/cfog
        o7C38hg7QX6lyPymOUeScz4=
X-Google-Smtp-Source: ABdhPJxxBg+X+ceW5D5Oo+KaGTqXQGnXUZJV6FOhnhF3Zo9R6+859iebxZ4ynklhihJlq8vTXn5DaA==
X-Received: by 2002:a50:e14d:: with SMTP id i13mr388479edl.106.1615235300732;
        Mon, 08 Mar 2021 12:28:20 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-247-48-130.retail.telecomitalia.it. [95.247.48.130])
        by smtp.googlemail.com with ESMTPSA id c18sm7624483edu.20.2021.03.08.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:28:20 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Mon,  8 Mar 2021 02:18:45 +0100
Message-Id: <20210308011853.19360-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210308011853.19360-1-ansuelsmth@gmail.com>
References: <20210308011853.19360-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nvmem-cells compatible used to treat mtd partitions as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/mtd/partitions/nvmem-cells.yaml  | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
new file mode 100644
index 000000000000..4ed246b27985
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvmem cells
+
+description: |
+  This binding can be used to treat the specific partition as a nvmem provider.
+  Each direct subnodes represents the nvmem cells and won't be parsed as fixed-partitions.
+  Fixed-partitions bindings described in fixed-partitions.yaml apply to the nvmem provider node.
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: nvmem-cells
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  reg:
+    description: partition offset and size within the flash
+    maxItems: 1
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    partitions {
+      compatible = "fixed-partitions";
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      /* ... */
+
+      };
+      art: art@1200000 {
+        compatible = "nvmem-cells";
+        reg = <0x1200000 0x0140000>;
+        label = "art";
+        read-only;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        macaddr_gmac1: macaddr_gmac1@0 {
+          reg = <0x0 0x6>;
+        };
+
+        macaddr_gmac2: macaddr_gmac2@6 {
+          reg = <0x6 0x6>;
+        };
+
+        pre_cal_24g: pre_cal_24g@1000 {
+          reg = <0x1000 0x2f20>;
+        };
+
+        pre_cal_5g: pre_cal_5g@5000{
+          reg = <0x5000 0x2f20>;
+        };
+      };
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "bootloader";
+            reg = <0x000000 0x100000>;
+            read-only;
+        };
+
+        firmware@100000 {
+            compatible = "brcm,trx";
+            label = "firmware";
+            reg = <0x100000 0xe00000>;
+        };
+
+        calibration@f00000 {
+            compatible = "nvmem-cells";
+            label = "calibration";
+            reg = <0xf00000 0x100000>;
+            ranges = <0 0xf00000 0x100000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            wifi0@0 {
+                reg = <0x000000 0x080000>;
+            };
+
+            wifi1@80000 {
+                reg = <0x080000 0x080000>;
+            };
+        };
+    };
-- 
2.30.0

