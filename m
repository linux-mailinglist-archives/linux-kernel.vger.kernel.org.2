Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB33438DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhJYDNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:13:31 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:40336 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhJYDNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:13:21 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 19P3Ak3W014990; Mon, 25 Oct 2021 12:10:46 +0900
X-Iguazu-Qid: 2wGrDIThyzSYy5fl18
X-Iguazu-QSIG: v=2; s=0; t=1635131446; q=2wGrDIThyzSYy5fl18; m=LAhFUcExfCUisuJKhnlwuS2rtYHwTY1M8NfTLcfJCXA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 19P3Ahrf037122
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 12:10:45 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id AB9C5100098;
        Mon, 25 Oct 2021 12:10:43 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 19P3AhLB004082;
        Mon, 25 Oct 2021 12:10:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
Date:   Mon, 25 Oct 2021 12:10:35 +0900
X-TSB-HOP: ON
Message-Id: <20211025031038.4180686-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Rob Herring <robh@kernel.org>

---

    v4 -> v5:
       - Add Reviewed-by: Rob Herring <robh@kernel.org>.
    v3 -> v4:
       - Fix node name to clock-controller.
       - Remove osc2-clk-frequency, and this defines to DT as
         fixed-clock.
       - Add clocks.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

 .../clock/toshiba,tmpv770x-pipllct.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml

diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
new file mode 100644
index 000000000000..7b7300ce96d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pipllct.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 TMPV770X PLL Controller Device Tree Bindings
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description:
+  Toshia Visconti5 PLL controller which supports the PLLs on TMPV770X.
+
+properties:
+  compatible:
+    const: toshiba,tmpv7708-pipllct
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    description: External reference clock (OSC2)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+
+    osc2_clk: osc2-clk {
+      compatible = "fixed-clock";
+      clock-frequency = <20000000>;
+      #clock-cells = <0>;
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pipllct: clock-controller@24220000 {
+            compatible = "toshiba,tmpv7708-pipllct";
+            reg = <0 0x24220000 0 0x820>;
+            #clock-cells = <1>;
+            clocks = <&osc2_clk>;
+        };
+    };
+...
-- 
2.33.0


