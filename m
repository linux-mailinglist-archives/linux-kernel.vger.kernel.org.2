Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702AA3190E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBKRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhBKQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:21:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B30C0613D6;
        Thu, 11 Feb 2021 08:20:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so8930039lfg.5;
        Thu, 11 Feb 2021 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WpoZRJbhDf8nOoFeDPqKJ512Il9p1PZRrO8Rys09/E=;
        b=eByUleltSsDabJSARAXb5WFg5+LXtrKg7AY6TIk0O9ksaNguT5kRzw6PmUzTAosxis
         iNShdt9aBkOXFdRyoaDfxL5nBj5AyVaDaLCfi4GIRXdNbQCvj3FNHy4xyQk4XsiRZz3n
         WimIRpS8aRhTESVPYaI7d3fcs5MrWy0iYjIVbU849oSNuGy0kI4QsmPVMH0N8+7FbCr6
         VMHYqmHNH6Avq4XMeHQZrPxgDeWjWaTCKOD5koVK42fjkij0RN/Lp7nIMKNNsrZPWQ20
         QBUV/l3peoDFe/mbmqRF9muDf+EFFPXOTlcnO7HRwksZJmK6nV6PVXwDWamiaor/e+Xw
         En9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WpoZRJbhDf8nOoFeDPqKJ512Il9p1PZRrO8Rys09/E=;
        b=pXDBr6K8jTbsGvUov8k0i5HKYlVfOjpyC3kNY5zQCgQ7ZiSRUkEK+B04kqAs1kOLoS
         EkcshPYFdRy6JpI2H7ahdV4s15Nt3nClT9qfYqWG8SOtlRCkedFrSmPShGTXZCcWIrBn
         g9JaFyy78tma6gf1WYRKy4IL7q3GI2MphMlpQuaEzpIzFIdpksq28DJ5qdfSVTttFEyT
         fQZ3lgtZSLsG6wR5zUC+DTN4tECIFBll58WIcg/4ijWcENEs51t9fCyMy1k628m/vUFA
         WnxEWQYCPA8TNJM16tnPI74iCgBH84XFfugD10ZmXcRsx04Y2Yl52uadCL8Rb524Lj1k
         iqQQ==
X-Gm-Message-State: AOAM5309aJgOoNItKRLrd8PkBr12OYqY6Epq2K/60FhAnvWxtvDlPBpw
        1+GW3V9aNbgmDLZFDi/fCAg=
X-Google-Smtp-Source: ABdhPJzja81XJ6PEVGOSRsOZMSj5zqLEbPhy1Lu7xHQa/hCANZF3lbGArnTjoNKjzSxwFJoZt/TpXg==
X-Received: by 2002:ac2:4ade:: with SMTP id m30mr5152152lfp.231.1613060426406;
        Thu, 11 Feb 2021 08:20:26 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b5sm685941lfi.3.2021.02.11.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:20:25 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 mtd/next 2/3] dt-bindings: mtd: add binding for BCM4908 partitions
Date:   Thu, 11 Feb 2021 17:20:11 +0100
Message-Id: <20210211162012.27417-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211162012.27417-1-zajec5@gmail.com>
References: <20210211162012.27417-1-zajec5@gmail.com>
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

