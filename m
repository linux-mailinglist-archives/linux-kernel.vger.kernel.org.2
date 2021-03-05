Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61D432E4F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhCEJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCEJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:33:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BFC061574;
        Fri,  5 Mar 2021 01:33:07 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s23so1623029pji.1;
        Fri, 05 Mar 2021 01:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlqmHeevMmSuyU9myU0zzVc8UAGUmKSe//SxTGaHqG8=;
        b=piYgtv3h6moY2iLUdfh0qaV9PvnwRZSusUIde5rh04gNmgqdmhRtuhaP69HuYFDpqh
         Ibm2vmfmRTfDnw9pWKTtXrdRjgUboi6Z89GPH5gjit4nT5ldPxCANoL/+oTQ/3s9iqPJ
         JTVONZDVRObObRBMrBEcF0HylLy3XAquOahU8CYO1ClZZqIXDJFKRT87bW3U5cj0+5bD
         R1ApQMUUVmADSga1FcnG1dFObub9bnRUy9JHb0VnmUYboUNJzNki3j86AqSYv+2wgCin
         6kabTpw8+nbY6DByc1WhbYfV9D1rm6Na+HkFGcFlMVMpDN1ol2B6klTDMrtb+AlEoNpc
         ZF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlqmHeevMmSuyU9myU0zzVc8UAGUmKSe//SxTGaHqG8=;
        b=qMEf3eYTGLcowuPgXxIRxpJTK3KCpBjhCkhK4EPA7BsIgDtgLwJSv+M7pbOmOBPJd5
         eu/LnErYQOCTkZlYU9yR3ZDsUAfqqYG445NAytfYW3ScLLsgMxvdzpOKHOkjVFs4iKIH
         16L39wDsCeW6NVBN4QlzZ9uHY5zv+QDN0RB9MxoNGYs1swq068T7GSVtgpSeDt0sF7PJ
         6rZugHmZGOY4bZ1LWPiFC3BeCPhxIBtb4oVmyakvrjiyg9DTxYrs8jItqf6qV2ybTkn3
         X8H1/DHn4H88X09Ro50e0yOyByC6MCI3gEr/EPjh2RPpIkyk1CsKsFBbPUWreh2vjF/Y
         f+tA==
X-Gm-Message-State: AOAM532C4yu0qKmsaKw3CmOIVm6efMvmGl9pSNJwclm2i4mva1vKjBdB
        dGWnovTBCNufVAltGYbLcfkSaEIP1AA=
X-Google-Smtp-Source: ABdhPJzH/dGqeZ1ZHVVmsHM3zWtRrVX9cheaLLPZERpuKhfsIz8C7bi/VpWE7GhAa1FHEmYR2KlfKA==
X-Received: by 2002:a17:90b:947:: with SMTP id dw7mr9451009pjb.178.1614936787556;
        Fri, 05 Mar 2021 01:33:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f3sm1873967pfe.25.2021.03.05.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:33:07 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 1/2] dt-bindings: iommu: add bindings for sprd IOMMU
Date:   Fri,  5 Mar 2021 17:32:15 +0800
Message-Id: <20210305093216.201897-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305093216.201897-1-zhang.lyra@gmail.com>
References: <20210305093216.201897-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This IOMMU module can be used by Unisoc's multimedia devices, such as
display, Image codec(jpeg) and a few signal processors, including
VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..7003e12f55f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
@@ -0,0 +1,57 @@
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
+
+  clocks:
+    description:
+      Reference to a gate clock phandle, since access to some of IOMMUs are
+      controlled by gate clock, but this is not required.
+
+required:
+  - compatible
+  - reg
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu_disp: iommu@63000800 {
+      compatible = "sprd,iommu-v1";
+      reg = <0x63000800 0x80>;
+      #iommu-cells = <0>;
+    };
+
+  - |
+    iommu_jpg: iommu@62300300 {
+      compatible = "sprd,iommu-v1";
+      reg = <0x62300300 0x80>;
+      #iommu-cells = <0>;
+      clocks = <&mm_gate 1>;
+    };
+
+...
-- 
2.25.1

