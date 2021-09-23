Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF241585B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhIWGnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbhIWGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:43:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD4C061756;
        Wed, 22 Sep 2021 23:42:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f129so5366650pgc.1;
        Wed, 22 Sep 2021 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjXFxHdfgRe4csUdQcW9D9OMyyk/+vQphLsOmm54Tzk=;
        b=mj0D9/sZVwnudpHtOOAVprSXAl915IshjB6JD0OcjT5F3gmTGB+/1c6+/kNG3awXAH
         1mQS1PdIuCLnGmF3lfFAu+G2R1F/CPFnSUroijmoD/LOtVfmpD2HJNdl7DyCdaP6qI/w
         kO3+c0ryf3piJ+LqeKcTbtegPXZGB4RFsKno1UBJGYCg+956Hs9mQ8dZESFnKinuxl7W
         qnswec1I4CcNm0F2Y/EXcTTAH/N6ZKzkn1byapWQp9U2ydHC/QlkLXEpb0p3ek7sSzf/
         Kja4Yc3TqEBTzlxcchFdnwXzBoHE2Qa67pTSK+emfdJjrgYhQVbkk7QkLdQuvCVrPd1O
         4qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjXFxHdfgRe4csUdQcW9D9OMyyk/+vQphLsOmm54Tzk=;
        b=qWlYqBIzNu3Ub3w4ZPXJpMFnjnGrwkxM2INSh1e/kJwg5qWRbGHmuVL+Uv3vLcJmYV
         BQaK60otmEvmpwp64/+nB9oz9kV/GMSz/iJEoV+fvl347zrcuMrNzmHvzm6NawWS5W6i
         mBzl9q5QaLu3Gl/ZVEnOmg+FqxBATkTGjGy16I1oJzzu2FH/jGQ3szANyNpP4c2j+VQ0
         PV7osUQJwgP4ucgdiEFQhjEYKErh4/RZ9IPEWnYHW0qYSoupw+B86HYGHJ37IOthOvnt
         bIul719RUSjSU8SD3/veaJi4u7Xvnwzk7nlKhNoaX50uRUAXCGe8RO2xlb3PDGwfIpP5
         6m5g==
X-Gm-Message-State: AOAM532Z9XTvimjmbEJo50gxH9dkYd98MFYGjov0m00blC4yjVKBfpdM
        q5cEfHwasZHjeo6YGWvm2dQo9kjIukE=
X-Google-Smtp-Source: ABdhPJzZy04YmQ5WrxG2cEDx3Vd9PFyWmyQFCdkiI9Ywblwpcfakj5eWppf942gD++T2vDQEZOcgRQ==
X-Received: by 2002:a62:f241:0:b0:44b:3078:d7f5 with SMTP id y1-20020a62f241000000b0044b3078d7f5mr2784140pfl.58.1632379320959;
        Wed, 22 Sep 2021 23:42:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w11sm4779474pgf.5.2021.09.22.23.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:42:00 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Thu, 23 Sep 2021 14:41:35 +0800
Message-Id: <20210923064137.60722-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923064137.60722-1-zhang.lyra@gmail.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..3522f3d2d8de
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    # Child node
+    type: object
+    $ref: "../clock/sprd,ums512-clk.yaml"
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.25.1

