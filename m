Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F6337A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCKREW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCKRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:03:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01902C061574;
        Thu, 11 Mar 2021 09:03:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ci14so47560276ejc.7;
        Thu, 11 Mar 2021 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5Nl3CoPrKUbvXcQoRdyX4Oe5Nctcc661QmqCsoFZxk=;
        b=q6FIKJwkFQWBJ1OXleqfTG1T2TT3DkkLrAwZdQI3EH9fhKo5oEz9qft+OYmencIYQ4
         jz7IDbNM3N5Nk8gEmiPbI17fjhnNGvcUS1PHGTeRBHyiIpbh0h+7uJ2owsdpeNpOPgV5
         zNttiPoV+Ax6V699cZE2C/M2rvXwe8eoQtgEeG9rOzVeqX4mdbV/riILcIHXcQCsPPHQ
         uFah9LhZ2M8BXkll+vIYAI5iwpXX+OT4rlduJKeRDp1nyBhXJU0u3u+IrGPFZzl/KwJx
         PFHO4KJrRgWtJG1lHljMuHwL0vDKBmp2RLeNnbYE2yXzG26+11zwSGI4fhxKttWn48x4
         spgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5Nl3CoPrKUbvXcQoRdyX4Oe5Nctcc661QmqCsoFZxk=;
        b=TGIyjX4roduo1oa/qE9Gb+5ga50N7O/JdI/GhKzV9cbb3XQEN/c4cc/ne1UVtDolED
         6+azITwqhEROeZiM+R/lFOQa+lx/XxXpYAjQguOR5ammaMLFjUbUjXYk0DLhvCMEPJ2V
         7avdgm239/ar01fIu3tPPfQJh6xh+Ibdyf2bMj1Pcd6VfV5UV2esusi3zrExxOva5brs
         JwQ3jI6PXSQFGQw40fwWb9Hqo4vPVWtRPZIy5F94pBcsEIYz2KAfgRmK7wPY0XePouw/
         lOxATdhEuTfSXrMIXOt37QLVzJ75H0gnieF1plUQucITBgxh9MFRkT9FJdmODiRYTeU0
         y40w==
X-Gm-Message-State: AOAM530d2gej3qN6d92Nm046RnXadfSEZlMtfaAVd6H3/Ws9QqHTyvGP
        o/zgqzhnzW6NC7reVGVZvCU=
X-Google-Smtp-Source: ABdhPJzq/YatFckEfu+VF1H6Ea1sveBij0Xf3qb2wyQA4o1MhfevCcixqQxnAVUri761sfyZf4SLXw==
X-Received: by 2002:a17:907:76bb:: with SMTP id jw27mr3981655ejc.366.1615482230637;
        Thu, 11 Mar 2021 09:03:50 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id b4sm1627205edh.40.2021.03.11.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:03:50 -0800 (PST)
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
Subject: [PATCH v6 3/3] dt-bindings: mtd: Document use of nvmem-cells compatible
Date:   Thu, 11 Mar 2021 10:57:00 +0100
Message-Id: <20210311095715.17048-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311095715.17048-1-ansuelsmth@gmail.com>
References: <20210311095715.17048-1-ansuelsmth@gmail.com>
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

