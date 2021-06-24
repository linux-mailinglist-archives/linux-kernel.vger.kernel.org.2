Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5473B25AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFXDqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:46:33 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:36182 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFXDqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:46:22 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 15O3hoKK023941; Thu, 24 Jun 2021 12:43:50 +0900
X-Iguazu-Qid: 2wGrD5gLVJpuNZD3lg
X-Iguazu-QSIG: v=2; s=0; t=1624506230; q=2wGrD5gLVJpuNZD3lg; m=h4DpzGxt0EuktOw7oq1VrB5vUx7smE9ntpLMQ4cDavs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 15O3hmeW015679
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 12:43:49 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 96A0210011D;
        Thu, 24 Jun 2021 12:43:48 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 15O3hlsR008907;
        Thu, 24 Jun 2021 12:43:48 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v3 3/4] dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
Date:   Thu, 24 Jun 2021 12:43:36 +0900
X-TSB-HOP: ON
Message-Id: <20210624034337.282386-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for SMU (System Management Unit) controller of
Toshiba Visconti TMPV770x SoC series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../clock/toshiba,tmpv770x-pismu.yaml         | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml

diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
new file mode 100644
index 000000000000..18fdf4f2831b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pismu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 TMPV770x SMU controller Device Tree Bindings
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description:
+  Toshia Visconti5 SMU (System Management Unit) which supports the clock
+  and resets on TMPV770x.
+
+properties:
+  compatible:
+    const: toshiba,tmpv7708-pismu
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pismu: pismu@24200000 {
+            compatible = "toshiba,tmpv7708-pismu";
+            reg = <0 0x24200000 0 0x2140>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+    };
+...
-- 
2.32.0

