Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15330ED1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhBDHPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhBDHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:15:29 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8023EC061573;
        Wed,  3 Feb 2021 23:14:49 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o16so1491359pgg.5;
        Wed, 03 Feb 2021 23:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMwV/7nsE5roUUmtI+CoFEwIDleSZQrd14tE0FVtMOE=;
        b=odzWHrloN/wRcxyb6aZFAHYcjyBk86MMT4vqy7adE/iKLC8rd9L+1d4xEbgGjQibk7
         t7gJtQpeiPluDu+WEGMn9iJjuc0zhQolSOGHM24pthstaEUhL5Mo3wERUOyAP9xXmoBl
         1nJ/uDh5uChzixEIAh0aglELcqdZIVTin+YswwF+fLO/ktGqI8XvrX/MT0qLzTMpgRRh
         KqSkkGINw6nkoqPplq9SakPBYqgdHqjnt33/xE8ow3wMO8EK6R0FaV4UOavtjozVVWBY
         WAULuMPQ/ACbvdoEMsO5ATCj5YOfM/5j+YKXLYB9YvZGBO3BRbqpeg2pIVb+VxLEcbXs
         qULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMwV/7nsE5roUUmtI+CoFEwIDleSZQrd14tE0FVtMOE=;
        b=XAkPtmPCQKsjh0cQMW5EPI8BHSAGuFSM7ik6JS9Nflbz4NnwTXppQt12QGF1dTE2ti
         SE8LxIWlJxOG/uzBR+KVn+klXXzSUJACTCcyh3jGmn642hdowRzEXUhJVGF7EjxdCXbV
         M73fu/Vzs5c6yn1akAzaAa32yT5IMSL2+4eWrCTNJ7q1tUebaRv+pY5bzR2aaDM10vyd
         OWxs6DaZrEJ2P0vHQL/kw11nN/fazHRa0jw/UITEB5ENCV7vP6+dvSrpR6FI8qPTgdxN
         coqy9OvngKMX9+4w+10In0GWNdokGqvOODRJnDXKppv41/UaK/svY4mKA2HO5dH6b31x
         xQ+g==
X-Gm-Message-State: AOAM530QUQH+E5a1irKmnnfni7/uzKRIU6DPQtQgH9UHjDIFlwrX8sKQ
        xcE/WiuWB00ZcI5rAPIVQplSP1Qtcofd0HhN
X-Google-Smtp-Source: ABdhPJyF3ezlJ8DKqXaY1mRWSpJAVhGIF9ojWcGQXuHC9TuruhLI48LoIzbQM/G3Nvdt0M6l4rjp5Q==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr7484668pgv.241.1612422889076;
        Wed, 03 Feb 2021 23:14:49 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h4sm4578855pfo.187.2021.02.03.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:14:48 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v4 1/2] dt-bindings: iommu: add bindings for sprd IOMMU
Date:   Thu,  4 Feb 2021 15:14:03 +0800
Message-Id: <20210204071404.891098-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204071404.891098-1-zhang.lyra@gmail.com>
References: <20210204071404.891098-1-zhang.lyra@gmail.com>
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
 .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
new file mode 100644
index 000000000000..36abd2187a19
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
+      register range used by IOMMU and multimedia device, the cell
+      defines the offset for IOMMU registers. Since IOMMU module shares
+      the same register range with the multimedia device which uses it.
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

