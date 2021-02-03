Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3430D5F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhBCJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhBCJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:09:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1AC061573;
        Wed,  3 Feb 2021 01:08:02 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so16865634pgc.8;
        Wed, 03 Feb 2021 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
        b=KMPbBYyLh4qQHs05QbeBHjZsRM8xJCZqoLV4jmxvxGh9VSJYY3tqs3KSgOuS/vkZPa
         /VF6M0NN3pl7lNwnoxe55k0Fq2BMz+FEAC0yZR5Xh1q5rqvlfMqu8BQct6pplCDxvN/X
         VtUMl3rUhzIhsK+0N5Sd19LyDexd/4jgZUTex/AjvORZ4PU98zqOL0H+uKHW55UeM4j4
         GVAgryL62ak360L4TrJizJLWdmJq6ioYMtowxDs9dXYAYouEh969NSRSHXOi6tzRC7ZG
         dRv9oEHlOzuEEWwWu19nbcj9nFfZTYxH4DXC8dbw2GqDly0W7nmJAucGWmWsdn+Umr/2
         72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
        b=jnSwPRFyJc3wux/WmlgrLjUZjRoK0IEYiqDiC89rWHFvGYGjAAxcxDquJEd+0TwCse
         Pj8OxLtXszMakrBLAl/ukciRsyHQ0+N7s8O9vq4Kqx3Y/ft3j/yVU65ybRiITdRv+Aax
         ulwsUe6OQ/WUlrVmESkGN3Vq5xa+eDISzoHvXxnu7mYBvDcqGsSiftgTCtZMgSNMAChi
         KrvphmUBZYmOFy7vhzQ71rEUTQnLsLzMe4AHJizq9/SLufhMG6Tkt1QjDaXBP5W/af6R
         7LNc5JkkXTw/styHcKAiTWoobOHix0H9Hbqsz3ZehswXmPyFBFr24m1CyPuHKmU/wcbl
         rYdw==
X-Gm-Message-State: AOAM5302YqNrZImuNXz4fH/pG0S8FgMYfTQzm0IBJEHEcNDNS5qwo6gj
        PZZz0lwjSeql44/WQi0wGbo=
X-Google-Smtp-Source: ABdhPJyon0Q21+AWXR2McqbrrUaVGjOGMgM5ykj/OuwX2mo8spdaqpXn5ey5eVy3BBFR//zq36f7dg==
X-Received: by 2002:a63:d601:: with SMTP id q1mr2555343pgg.417.1612343282495;
        Wed, 03 Feb 2021 01:08:02 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y12sm1586403pfp.166.2021.02.03.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:08:01 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date:   Wed,  3 Feb 2021 17:07:26 +0800
Message-Id: <20210203090727.789939-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203090727.789939-1-zhang.lyra@gmail.com>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This iommu module can be used by Unisoc's multimedia devices, such as
display, Image codec(jpeg) and a few signal processors, including
VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..4fc99e81fa66
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc IOMMU and Multi-media MMU
+
+maintainers:
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,iommu-v1
+
+  "#iommu-cells":
+    const: 0
+    description:
+      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
+      additional information needs to associate with its master device.
+      Please refer to the generic bindings document for more details,
+      Documentation/devicetree/bindings/iommu/iommu.txt
+
+  reg:
+    maxItems: 1
+    description:
+      Not required if 'sprd,iommu-regs' is defined.
+
+  clocks:
+    description:
+      Reference to a gate clock phandle, since access to some of IOMMUs are
+      controlled by gate clock, but this is not required.
+
+  sprd,iommu-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Reference to a syscon phandle plus 1 cell, the syscon defines the
+      register range used by the iommu and the media device, the cell
+      defines the offset for iommu registers. Since iommu module shares
+      the same register range with the media device which uses it.
+
+required:
+  - compatible
+  - "#iommu-cells"
+
+oneOf:
+  - required:
+      - reg
+  - required:
+      - sprd,iommu-regs
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu_disp: iommu-disp {
+      compatible = "sprd,iommu-v1";
+      sprd,iommu-regs = <&dpu_regs 0x800>;
+      #iommu-cells = <0>;
+    };
+
+  - |
+    iommu_jpg: iommu-jpg {
+      compatible = "sprd,iommu-v1";
+      sprd,iommu-regs = <&jpg_regs 0x300>;
+      #iommu-cells = <0>;
+      clocks = <&mm_gate 1>;
+    };
+
+...
-- 
2.25.1

