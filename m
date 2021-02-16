Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9131D14E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBPT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBPT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:57:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111CC061786;
        Tue, 16 Feb 2021 11:56:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so13789866edd.5;
        Tue, 16 Feb 2021 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+rzS0sRv0J3BMSreb/SAsip/5NpGgjcUC0WZfb9UMo=;
        b=P829sFMk/HWVFCWbkQIJU/89lQDZeC45HCHpcn9LsGhhvULh0Rc8y5ABYl2SNV1+c+
         v1DyM6QoHi4WKWeTdxZDhcipCVlUrUt5PLqwc9Iq/ZsWOTNLL3GuAdXw4Yxe/fiQIKZ5
         MpRAQpj66M2vXLc5FrNEYppq+8Pgdr+JtQsID7fVfQqTRDkAfOifeU5gH7ViTt5FRk3o
         PINFRppuVBcSVy6xTiTgfTESUakptpbgK4x+Fq/ggWFawDmpqkMQDohBfuGuPXtDhtxI
         t+g+HQwu0/F5odB0Mkj7T1abe8Go2xl+84IIRqtrOUzZ15YzlbB5kGvs9csejtNAx17r
         es9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+rzS0sRv0J3BMSreb/SAsip/5NpGgjcUC0WZfb9UMo=;
        b=OJ8n5oPezLtL4MTtiP8t5OEPrxw61AXSLj+ks1VYlKOaBKxYH1sBecVUzS4OZ4flR/
         jy1SB6l+Z5b5N5aw+g0TPwx9V/NQ+N1KX2kD5e5KiGsf4bjd9RxWm8GhkHJxVFCkFXO9
         ItVKSrN8mSDSYlARiOvdsDk070oTap8Sz1Ra3yt3+scdmEUg8dgWtfSmZi7pbDL5ZwN4
         Yaw6hVjXJfAicSs4ECvUWcfrrHjApiDO/EHS6MevI90MPFRvbWz8ZCNNPo9Udi7+T9hl
         ynIGzvsQaxGN1dgOAQZxDW6GeqE4JABqFDAve4/5g/ZzfsYvdUjjVyB0TNJzJ2qsOrI6
         8WCA==
X-Gm-Message-State: AOAM531mGPMauGdJ/+QycHJ40eqQKTCzUz3t60zhcY2tIwLNh6EpWUg6
        9BY0n7CPymyStnWujMStwLo=
X-Google-Smtp-Source: ABdhPJxSU1ROjWCus6NqmtJLmIujUXHamSni+RhVcPcKr6gQPFjIzIAsjejgqQwMC97UpYq4eB/bwg==
X-Received: by 2002:a05:6402:3494:: with SMTP id v20mr23442045edc.146.1613505406562;
        Tue, 16 Feb 2021 11:56:46 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id rh22sm963332ejb.105.2021.02.16.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:56:46 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: mtd: Document use of nvmem-partitions compatible
Date:   Tue, 16 Feb 2021 20:56:11 +0100
Message-Id: <20210216195618.27959-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216195618.27959-1-ansuelsmth@gmail.com>
References: <20210216195618.27959-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nvmem-partitions compatible used to treat mtd partitions as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/nvmem-partitions.yaml      | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml
new file mode 100644
index 000000000000..1ff283febcaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/nvmem-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvmem partitions
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
+    const: nvmem-partitions
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  reg:
+    description: partition's offset and size within the flash
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
+        compatible = "nvmem-partitions";
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
+            compatible = "nvmem-partitions";
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

