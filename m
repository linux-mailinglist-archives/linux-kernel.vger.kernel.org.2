Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252C030B8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBBHfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhBBHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:35:30 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68CC06174A;
        Mon,  1 Feb 2021 23:34:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o16so14344698pgg.5;
        Mon, 01 Feb 2021 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
        b=pmpSCGCBGyZpwijywa887RwHyaZATOvgE1aNeznea8FbSQtpW7aU8gy5w1kW2zQN6/
         zV4D32ThIZX4TlupUN5CXFNfCB3zZkyp/57OWUbC0mtw++MY2kkUPe/B6lIRju2RaimH
         hiYzTMNoaECstCkIPxq3D8mOlffKQB7uZFhdWOA3ad2iN/Cy5Nf9lh3c/hRg7JYGZyLm
         EQxQt0vkLCOVaeVBxXPHSngvm5c457y6BJfANjxDj5acCJtyW6usDY91OZlsDzJCL6yk
         nwfRWfzgge7vML98i7rNTTIhcF/xejh6EV3t7/lF5mESq+WLwP/Ymgd08hXUxzRK1nqU
         A2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBNJGJWi6eP7GdgbQTp5RCUskWudTGe2wTYTqTKx4V0=;
        b=VrxyLIKigcTzIPWOmH83FAS91A+ZSqFUEQ3iWmwFl1OLUZbeZXENc2Q7G/kSnsY5lO
         xtCflpT2380NP8Bxa7psSrxQlhbeE97lLkvIMbL5wDAr+AIOGWeoqGBS1pU6dsrBobXG
         0DlfKJedIAr/UKd2hBy/rrKsIw4fNCMnl+glIupaQmUYzPpoZ0hwvXMDDO79x3KYhTDj
         10S5XHDPIoP+RE7Xr+DNMjefu7eM6OG9zOEMjzrCQs7HNo4x21RLH5WK81Ap0tWxcwVP
         ++9lZ61LGg0WcOCLXms+D1p/kAVOPf0BcOfB7cMA3RO0Yl6kzi2NudWVJ/ZwsQU4ptVN
         weDA==
X-Gm-Message-State: AOAM53153dZfU0wXuZ+kDiG0hsi3M/a3j5TCftMSBZRmQfMOsnlKdQG/
        owArAj0S5t0p3ZZ9LNopJbeeZUCIcf34cIBU
X-Google-Smtp-Source: ABdhPJwVwMqBTa3MvSnsnMCZEEm0OukPovehjbfJCq5GTvXGDy6tkb8htyb1+2SgjEufZ4hI5DIlDg==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr20368910pgb.54.1612251289802;
        Mon, 01 Feb 2021 23:34:49 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o4sm1752029pjs.57.2021.02.01.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:34:49 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: iommu: add bindings for sprd iommu
Date:   Tue,  2 Feb 2021 15:32:57 +0800
Message-Id: <20210202073258.559443-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202073258.559443-1-zhang.lyra@gmail.com>
References: <20210202073258.559443-1-zhang.lyra@gmail.com>
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

