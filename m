Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B3338D60
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhCLMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhCLMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:44:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0AFC061574;
        Fri, 12 Mar 2021 04:44:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so12153629wmj.2;
        Fri, 12 Mar 2021 04:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lt9EofWzR4AT3/m5U04YrfxspMsTFMGL5r495U/zvWo=;
        b=QsaojiQnEaE9aLtszKXhSlDlbLDBDh9mM5uHsF8HNhqyYZrJIdLPfxAph5ggB1NkGe
         x1i6gCcwFt93mZAkjIlDfNc83M/BkMuE+KnYjDxpv5B0yd+YSTVA1R+NGYvAO0r09DyN
         OC3nYBqNP8JfWL3qJJaaMGduVGi4jGj2tgMdcyHS48xR7s6hR/tuaQRGZa+DHcHfLb83
         ori6W4T1gYN92WUl2O9u3v1/MsG+ia1uQ5COx7VLC3860v/pP55YIQw85Fx3EiMV6CLo
         LjwRGdCIXTBUnMuNFfYExBmvOLAbnz9Jw8eEtD2CVsgI1UQQsgpfYwZqgkvNzrXROhhA
         5CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lt9EofWzR4AT3/m5U04YrfxspMsTFMGL5r495U/zvWo=;
        b=jGLNl94coBrvhfht5QaYcWPn89CJG7nOWJ5j/Ld0LzVKOZ+vHxyM/SzpzcTAO1uWlw
         zVM1Hc5aucsG/6zQO3K5zkafAX2cK5BxYD8HacTiisuoisf8nytL8f11kuUzUgMLH6nJ
         KSI+0tQYy/xPG8y+lM+uFOwUw+6sOYYalvvKzjPB+XxsWl5hi8PnPFL5aatK1DcLVyyL
         4eVv7t/9apDx+mkHXAW05WHHB60QGgxvUYS7UZyn/JTT3mDs8QR9IH7+9wriuruE4ck7
         ZJtLcxa3CIidEJBj95qt6LY54lvU4NtoYpFHB/Ll+A0j+ogOOlc1j0fX0jVa+zutndtp
         eDgA==
X-Gm-Message-State: AOAM530eLRc5SZFZ58jzb6LpYFaccmInl29eoi0ULD7RUv4mAsQcUMrt
        Utf9NuQGCMe9xoTfR2l52LKsMl68sw8=
X-Google-Smtp-Source: ABdhPJwnt/w6O4Lr7dx7pjO+Q4z860JrbZ6+yPyLgp/QKamiikbunTensI3OL2gShE0DznO65X8rMg==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr12916923wmi.92.1615553080415;
        Fri, 12 Mar 2021 04:44:40 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id 36sm8213414wrh.94.2021.03.12.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:44:40 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Fri, 12 Mar 2021 07:28:21 +0100
Message-Id: <20210312062830.20548-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210312062830.20548-1-ansuelsmth@gmail.com>
References: <20210312062830.20548-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nvmem-cells compatible used to treat mtd partitions as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
new file mode 100644
index 000000000000..5cdd2efa9132
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
+  - $ref: /schemas/nvmem/nvmem.yaml#
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

