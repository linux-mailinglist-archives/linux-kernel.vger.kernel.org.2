Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8833724F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhCKMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhCKMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:19:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C6C061574;
        Thu, 11 Mar 2021 04:19:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mj10so45777477ejb.5;
        Thu, 11 Mar 2021 04:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5Nl3CoPrKUbvXcQoRdyX4Oe5Nctcc661QmqCsoFZxk=;
        b=W9/2O2W2Nzf/YibnD9+XfwhqgdaREhr9zRG72Y3zAUhUEh6lP1D9U+PYb8DNmuS0G3
         MYopY8QagwqMioK+oK3KXWjQnkY1q88kifVpq8RiM3t2gMI4JpeP/tAnybHUrrl8sspq
         Q5kUNkJhzMl4ZNPXwBTm42CRxUnhQGG+gEGeInvNNgw1Ic4zF+YGM4IY2OwlPyzYPmhi
         I+SIEQ84HvuaPJgcIHq1Dt9d6WIam0X3OG0HjRVMLb0JXbVFgwOn6TNYf2RwnoOWYwHZ
         +/tgI9g/BIU2JT4bBzrsvzbf3FSOwEF/dY2MN32hwPRW1pZK/WBYYYg5rCRkjN6ix0uu
         rfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5Nl3CoPrKUbvXcQoRdyX4Oe5Nctcc661QmqCsoFZxk=;
        b=b1pVc5WKQdMuA6uXE8/p0uawCx0zE8MFRpYxgqjCplbu75RjwOiV0nP3SAQuPG1Awc
         9snGHoKZZKMcGM1BAfa096MoiRNVCQ7e8Dgna9CEssS1Q5gTL57ahTAITPIAQeLfZgRm
         exmWL7Oy7ylMru/+KipEMFUc7jS5jI4Z/J59K2ZywqC7H0sa8nVc82++MRaUYY/lpW1K
         5x9NIe50FkQFx9Y0Sad2/lIQ/R/Z/nADyi17wLgQwxbR0zFBuCR2r+10/lIyZa1Uh837
         pLscMB4cVEjKpTGGLWVIPFpTSuqfop1wtqkDyz1Kt6UAIu27fVSnAAjI4mPlozSVMqT5
         yvrA==
X-Gm-Message-State: AOAM533lcFxhxPBjZPf4uyoLoAyrgbBDEHWg2gB003n9UeLmrv0QF0Pd
        Q8cgWn9eYzbak0wANRzRxBU=
X-Google-Smtp-Source: ABdhPJyNq7Hxm7thpemDAQbUMAcjYcqqmdPmwbm22NHsax+E614rEyqGn+G9L+erfG40fdN/jF21tQ==
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr2876710ejc.231.1615465192231;
        Thu, 11 Mar 2021 04:19:52 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id c7sm1273748edk.50.2021.03.11.04.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:19:51 -0800 (PST)
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
Subject: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Thu, 11 Mar 2021 06:12:48 +0100
Message-Id: <20210311051309.16789-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311051309.16789-1-ansuelsmth@gmail.com>
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nvmem-cells compatible used to treat mtd partitions as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
new file mode 100644
index 000000000000..b53faf87d4e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -0,0 +1,99 @@
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
+allOf:
+  - $ref: "../../nvmem/nvmem.yaml#"
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

