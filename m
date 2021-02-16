Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354AC31D210
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBPV2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBPV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:28:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FAC061788;
        Tue, 16 Feb 2021 13:27:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v7so15030894wrr.12;
        Tue, 16 Feb 2021 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+rzS0sRv0J3BMSreb/SAsip/5NpGgjcUC0WZfb9UMo=;
        b=caRYm4JRhNEpJJ5ON0GqN4amrinIZlbOoymCBoNa2y3NhBJxpxqy9oH9+MLXDdT6mQ
         fM0an6mHcEWV9uTmEBs3SJjnQWUn0u2ydFzLfd74I+rt3aTG8mgS44IfTRkMOKSpLNKo
         tpvQmkyMOIEQvMzU4Uy0Wi5cR5mrtUHrSGgh40oUi3v9wH9pAtweVQVLzuEG4TuSn0nX
         ew0xBYMn9ZLqbGnLbB3AxGlmgUfEDGYna0nT0rq12RstesvqkxiDk6auQnHZFlDbIbKG
         yFOu7g1dwn7eclpPNbKp7+9RTZqNv1D3odJFy3AcOuvzxwwn7BMAdUIzJICErS3oDAn7
         bNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+rzS0sRv0J3BMSreb/SAsip/5NpGgjcUC0WZfb9UMo=;
        b=Sq81RZFVebBytuGJRw0POaoCqo8wsKdAjnLiin2jH0w4GAxobGZ8OXOQKw22EqXV7V
         uxHEihGg/Hot2RbqJUeb+2oiLOTKF67ukiJrkhLoxCWOIuVlUhLcR5xi+WSsyCBRq3XW
         Yg4aZz1D8IRoUU959YZP0ngNs6KgtJGMcKJHm/FxfOAOkVYdTB3YXf5xei4HGeyyPNyH
         ncGAwGmKPuaUZXrj9vAI73CBTaCy6E7jBYd5B5UPN/aEvWcv0WKAJhHgrr/KT8AIj5qw
         0jAxueM6SOVwyzLes+DiqLE9hXwn4k0xZ+mEnspPvvX1+rfsV1wRTivC5dScIhqcw3td
         KlWw==
X-Gm-Message-State: AOAM531D3iCBg52hXRontk8zeNd2O9vwTd3aW6kS0IolgcZOWBI96TrL
        kK8RdvO2dfjPJ/YGsPI9DurTTE72gMo=
X-Google-Smtp-Source: ABdhPJzpGa895LxR+1I55koS/MCG0yUrUf4FciTfVyz+UK47hf3qpzinn/2+isQbyz2+D8Y0rgXnkQ==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr13973220wrw.279.1613510835780;
        Tue, 16 Feb 2021 13:27:15 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id s14sm7132182wmj.23.2021.02.16.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:27:15 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions compatible
Date:   Tue, 16 Feb 2021 22:26:28 +0100
Message-Id: <20210216212638.28382-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216212638.28382-1-ansuelsmth@gmail.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
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

