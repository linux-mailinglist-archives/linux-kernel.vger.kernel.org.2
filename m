Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5533497D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhCJVIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhCJVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A2C061574;
        Wed, 10 Mar 2021 13:08:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p7so30228874eju.6;
        Wed, 10 Mar 2021 13:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFPq8+0A2tlhUqOfS/rUAsa/NrqBUr4EOZh4j7x/kE8=;
        b=JbnVyzZa1vdrvsdVaMOgex/cASkTjl1o4wSqdy14c7b1cs35dkpyoTqPxMe1iZ9xIW
         ozDMZGxem6kIz3SrNxj/XwIj6Oz+YQerhEm1fq7m2uOXwXBbePy7gZB5Yxoyd8/5/9Y9
         WRGJthxCeqLJNNJYOhHbxxt5qD19bXL7h17RbTDMGo8Mo3L0CGueOfFhhUYFmyidoSS0
         vpqpXTT4fLoH5li48+5BHthS0qw75PWV+te4UCj1EuPSODlJ6ezWXyMHEsIW8mq5XtIo
         TV1TMxDIxZrwx0/vXmU6Kfwkt2slS7+cD1JhxiY9CV68Ve4mFC15ddlmWkI4x/BiUrPz
         US1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFPq8+0A2tlhUqOfS/rUAsa/NrqBUr4EOZh4j7x/kE8=;
        b=b/zvrDhZBVTiWtlvbB3LcqnL0xgEGZGl1mcViyzIZ4AY8PuKUswT1j43N5kxIleay5
         unfAm5FR35QuqoxjC+TjCl42JH8m+quBK3876wVTKSbp4+f2obmt3wL8IqTdBsyKyzaw
         SbXNQ+xKq8l9O/tv7/XyMePjWcRPiYJTWLndAA86ukGNT9QG7ELFk6W9BkVY1TV7E+Qz
         QxvyjeHS/DcKMTMZ4HO2bn+3bfD/AUE5a+qJ3q5aAeBDV0zthpcniL6WVHS0ov63GaDG
         tPGRCrR/KmfkCLYv97odrJlWewKw10rpZLTujSzAgmQnAQjffrLgoXiALdcYDUGsFN4Y
         l8Fg==
X-Gm-Message-State: AOAM5308k3U4dZ4lVX/tB43KxWavgQ2MNCutTVJb+Xd8nHAYF0BlxLVi
        6cNnfY5GrU7Md2nH9KRWxgs=
X-Google-Smtp-Source: ABdhPJxMhxvqt2uc/XnQM5SDA5v8uHHMAXEtGaa7sBmASydWA4ifJqbigVy0BKUn8EKN7vpqd7KmOQ==
X-Received: by 2002:a17:906:688:: with SMTP id u8mr360665ejb.38.1615410501645;
        Wed, 10 Mar 2021 13:08:21 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id f19sm252947edu.12.2021.03.10.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:08:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Wed, 10 Mar 2021 22:08:02 +0100
Message-Id: <20210310210812.8880-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310210812.8880-1-ansuelsmth@gmail.com>
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nvmem-cells compatible used to treat mtd partitions as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/mtd/partitions/nvmem-cells.yaml  | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
new file mode 100644
index 000000000000..f70d7597a6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvmem cells
+
+description: |
+  Any partition containing the compatible "nvmem-cells" will register as a
+  nvmem provider.
+  Each direct subnodes represents a nvmem cell following the nvmem binding.
+  Nvmem binding to declare nvmem-cells can be found in:
+  Documentation/devicetree/bindings/nvmem/nvmem.yaml
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: nvmem-cells
+
+required:
+  - compatible
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

