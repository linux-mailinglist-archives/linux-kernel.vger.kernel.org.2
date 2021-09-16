Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431FB40D4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhIPIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhIPIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:48:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689BAC061574;
        Thu, 16 Sep 2021 01:47:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v2so3346331plp.8;
        Thu, 16 Sep 2021 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZF94D2uh00bDeuG6B4pA7teMhqnKVab2rR0V0Nlfsk4=;
        b=WmBXNV97JffyoqYomMfSDWBIjZx/K2nz0ai++RlokFBjJt02LsdL/w+BIcliUkZXev
         tAFl/pMbd94UHQlMJI1BZ9jk/OSAtX/g8oWaAoyrjmQJcvZ4EvJhT/AUg7TuRA+IP5zk
         oKH3lsfBg9mviwYTG1p8Kkfu6t0cXWfgyGR+VyK2r0aowO3WjHS0CqsDwX+BW/gQHj/2
         HmpwRSeTbjFHf9xKSbaw37m3Bw6cC92XCwdTM1m+fDu2UMCatDOASgQpYykeg/2JOIdJ
         3j5wyd7U0hOkoZztI37CQCc1Os3wYrukEwOMnX80KD+/vQakb1B6+jvDbLrTiaFOWmfR
         RMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZF94D2uh00bDeuG6B4pA7teMhqnKVab2rR0V0Nlfsk4=;
        b=3tPd9Z/Jfh4A5my4DA1Nhvlb5Fc/9sIVtaF45+OyCX6uXJTGo99wqJRifrm90Mazwh
         AzQHAk9rSNmYAriV3ccn+tec6IYMeyNASpcV3BZNcevPj/LN8/2rimPRo4s2jhQVX24j
         Gyp4o2zh8ckYtYDc6d+/a6EyX7HKBugsSuqbyak2ZsEU6yGKfF0IGT8J6/qpk9Lc0831
         2oET29hTQT5lT38C/hYRiACLr7RuOMUmwOSxj6Wsd5tIRbosQMk07y2D3o8gyt10Iite
         gllvfj88E0l+NgiapFgIFW5SgtKybYg6555+O/hCElMAJYw3CBjI0i2R/RGquM1Z4+M2
         3zCQ==
X-Gm-Message-State: AOAM531VdreayTpDERuFaboneStGzY09SIrwUjsxkPJW3WY/oDR7tvYN
        +Lu2pLoU/c/wgpYlsld26kM=
X-Google-Smtp-Source: ABdhPJwdTgG0xEwzbYxYZDv9+wNK5Rzy9F0UtW40NsWL7V975Cbsm7obm1tJ1xkXkIpBLeQayCNxNg==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr3925730pjb.19.1631782054888;
        Thu, 16 Sep 2021 01:47:34 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l12sm2187621pff.182.2021.09.16.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:47:34 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Thu, 16 Sep 2021 16:47:11 +0800
Message-Id: <20210916084714.311048-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916084714.311048-1-zhang.lyra@gmail.com>
References: <20210916084714.311048-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..cf9dad06bb4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,67 @@
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
+      Clock controller for the SoC clocks. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml.
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
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
+      apahb_gate: clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
-- 
2.25.1

