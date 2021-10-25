Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088E7438DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhJYDNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:13:23 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:59254 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJYDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:13:20 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 19P3Aklj019662; Mon, 25 Oct 2021 12:10:46 +0900
X-Iguazu-Qid: 2wGrDIThyzSYy5fl17
X-Iguazu-QSIG: v=2; s=0; t=1635131446; q=2wGrDIThyzSYy5fl17; m=30q0tgRCzueoAjor9eoF3X01O+yA80jsF0SCYvXQ+e8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 19P3Aijo028598
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 12:10:45 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id F29DD10008D;
        Mon, 25 Oct 2021 12:10:43 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 19P3AhCK015754;
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
Subject: [PATCH v5 2/4] dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
Date:   Mon, 25 Oct 2021 12:10:36 +0900
X-TSB-HOP: ON
Message-Id: <20211025031038.4180686-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for SMU (System Management Unit) controller of
Toshiba Visconti TMPV770x SoC series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Rob Herring <robh@kernel.org>

---

    v4 -> v5:
       - Add Reviewed-by: Rob Herring <robh@kernel.org>.
       - v5: Update to use syscon.
    v3 -> v4:
      - Move reset dt-binding header file.
      - Move clock dt-binding header file.
      - Change dt-binding header's License to 'GPL-2.0-only OR
        BSD-2-Clause'
      - Fix node name to clock-controller.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

 .../clock/toshiba,tmpv770x-pismu.yaml         |  52 +++++
 include/dt-bindings/clock/toshiba,tmpv770x.h  | 181 ++++++++++++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h  |  41 ++++
 3 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
 create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
 create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h

diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
new file mode 100644
index 000000000000..ed79f16fe6bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
@@ -0,0 +1,52 @@
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
+    items:
+      - const: toshiba,tmpv7708-pismu
+      - const: syscon
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
+        pismu: syscon@24200000 {
+            compatible = "toshiba,tmpv7708-pismu", "syscon";
+            reg = <0 0x24200000 0 0x2140>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
new file mode 100644
index 000000000000..5fce713001fd
--- /dev/null
+++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
+#define _DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_
+
+/* PLL */
+#define TMPV770X_PLL_PIPLL0		0
+#define TMPV770X_PLL_PIPLL1		1
+#define TMPV770X_PLL_PIDNNPLL		2
+#define TMPV770X_PLL_PIETHERPLL		3
+#define TMPV770X_PLL_PIDDRCPLL		4
+#define TMPV770X_PLL_PIVOIFPLL		5
+#define TMPV770X_PLL_PIIMGERPLL		6
+#define TMPV770X_NR_PLL		7
+
+/* Clocks */
+#define TMPV770X_CLK_PIPLL1_DIV1	0
+#define TMPV770X_CLK_PIPLL1_DIV2	1
+#define TMPV770X_CLK_PIPLL1_DIV4	2
+#define TMPV770X_CLK_PIDNNPLL_DIV1	3
+#define TMPV770X_CLK_DDRC_PHY_PLL0	4
+#define TMPV770X_CLK_DDRC_PHY_PLL1	5
+#define TMPV770X_CLK_D_PHYPLL		6
+#define TMPV770X_CLK_PHY_PCIEPLL	7
+#define TMPV770X_CLK_CA53CL0		8
+#define TMPV770X_CLK_CA53CL1		9
+#define TMPV770X_CLK_PISDMAC		10
+#define TMPV770X_CLK_PIPDMAC0		11
+#define TMPV770X_CLK_PIPDMAC1		12
+#define TMPV770X_CLK_PIWRAM		13
+#define TMPV770X_CLK_DDRC0		14
+#define TMPV770X_CLK_DDRC0_SCLK		15
+#define TMPV770X_CLK_DDRC0_NCLK		16
+#define TMPV770X_CLK_DDRC0_MCLK		17
+#define TMPV770X_CLK_DDRC0_APBCLK	18
+#define TMPV770X_CLK_DDRC1		19
+#define TMPV770X_CLK_DDRC1_SCLK		20
+#define TMPV770X_CLK_DDRC1_NCLK		21
+#define TMPV770X_CLK_DDRC1_MCLK		22
+#define TMPV770X_CLK_DDRC1_APBCLK	23
+#define TMPV770X_CLK_HOX		24
+#define TMPV770X_CLK_PCIE_MSTR		25
+#define TMPV770X_CLK_PCIE_AUX		26
+#define TMPV770X_CLK_PIINTC		27
+#define TMPV770X_CLK_PIETHER_BUS	28
+#define TMPV770X_CLK_PISPI0		29
+#define TMPV770X_CLK_PISPI1		30
+#define TMPV770X_CLK_PISPI2		31
+#define TMPV770X_CLK_PISPI3		32
+#define TMPV770X_CLK_PISPI4		33
+#define TMPV770X_CLK_PISPI5		34
+#define TMPV770X_CLK_PISPI6		35
+#define TMPV770X_CLK_PIUART0		36
+#define TMPV770X_CLK_PIUART1		37
+#define TMPV770X_CLK_PIUART2		38
+#define TMPV770X_CLK_PIUART3		39
+#define TMPV770X_CLK_PII2C0		40
+#define TMPV770X_CLK_PII2C1		41
+#define TMPV770X_CLK_PII2C2		42
+#define TMPV770X_CLK_PII2C3		43
+#define TMPV770X_CLK_PII2C4		44
+#define TMPV770X_CLK_PII2C5		45
+#define TMPV770X_CLK_PII2C6		46
+#define TMPV770X_CLK_PII2C7		47
+#define TMPV770X_CLK_PII2C8		48
+#define TMPV770X_CLK_PIGPIO		49
+#define TMPV770X_CLK_PIPGM		50
+#define TMPV770X_CLK_PIPCMIF		51
+#define TMPV770X_CLK_PIPCMIF_AUDIO_O	52
+#define TMPV770X_CLK_PIPCMIF_AUDIO_I	53
+#define TMPV770X_CLK_PICMPT0		54
+#define TMPV770X_CLK_PICMPT1		55
+#define TMPV770X_CLK_PITSC		56
+#define TMPV770X_CLK_PIUWDT		57
+#define TMPV770X_CLK_PISWDT		58
+#define TMPV770X_CLK_WDTCLK		59
+#define TMPV770X_CLK_PISUBUS_150M	60
+#define TMPV770X_CLK_PISUBUS_300M	61
+#define TMPV770X_CLK_PIPMU		62
+#define TMPV770X_CLK_PIGPMU		63
+#define TMPV770X_CLK_PITMU		64
+#define TMPV770X_CLK_WRCK		65
+#define TMPV770X_CLK_PIEMM		66
+#define TMPV770X_CLK_PIMISC		67
+#define TMPV770X_CLK_PIGCOMM		68
+#define TMPV770X_CLK_PIDCOMM		69
+#define TMPV770X_CLK_PICKMON		70
+#define TMPV770X_CLK_PIMBUS		71
+#define TMPV770X_CLK_SBUSCLK		72
+#define TMPV770X_CLK_DDR0_APBCLKCLK	73
+#define TMPV770X_CLK_DDR1_APBCLKCLK	74
+#define TMPV770X_CLK_DSP0_PBCLK		75
+#define TMPV770X_CLK_DSP1_PBCLK		76
+#define TMPV770X_CLK_DSP2_PBCLK		77
+#define TMPV770X_CLK_DSP3_PBCLK		78
+#define TMPV770X_CLK_DSVIIF0_APBCLK	79
+#define TMPV770X_CLK_VIIF0_APBCLK	80
+#define TMPV770X_CLK_VIIF0_CFGCLK	81
+#define TMPV770X_CLK_VIIF1_APBCLK	82
+#define TMPV770X_CLK_VIIF1_CFGCLK	83
+#define TMPV770X_CLK_VIIF2_APBCLK	84
+#define TMPV770X_CLK_VIIF2_CFGCLK	85
+#define TMPV770X_CLK_VIIF3_APBCLK	86
+#define TMPV770X_CLK_VIIF3_CFGCLK	87
+#define TMPV770X_CLK_VIIF4_APBCLK	88
+#define TMPV770X_CLK_VIIF4_CFGCLK	89
+#define TMPV770X_CLK_VIIF5_APBCLK	90
+#define TMPV770X_CLK_VIIF5_CFGCLK	91
+#define TMPV770X_CLK_VOIF_SBUSCLK	92
+#define TMPV770X_CLK_VOIF_PROCCLK	93
+#define TMPV770X_CLK_VOIF_DPHYCFGCLK	94
+#define TMPV770X_CLK_DNN0		95
+#define TMPV770X_CLK_STMAT		96
+#define TMPV770X_CLK_HWA0		97
+#define TMPV770X_CLK_AFFINE0		98
+#define TMPV770X_CLK_HAMAT		99
+#define TMPV770X_CLK_SMLDB		100
+#define TMPV770X_CLK_HWA0_ASYNC		101
+#define TMPV770X_CLK_HWA2		102
+#define TMPV770X_CLK_FLMAT		103
+#define TMPV770X_CLK_PYRAMID		104
+#define TMPV770X_CLK_HWA2_ASYNC		105
+#define TMPV770X_CLK_DSP0		106
+#define TMPV770X_CLK_VIIFBS0		107
+#define TMPV770X_CLK_VIIFBS0_L2ISP	108
+#define TMPV770X_CLK_VIIFBS0_L1ISP	109
+#define TMPV770X_CLK_VIIFBS0_PROC	110
+#define TMPV770X_CLK_VIIFBS1		111
+#define TMPV770X_CLK_VIIFBS2		112
+#define TMPV770X_CLK_VIIFOP_MBUS	113
+#define TMPV770X_CLK_VIIFOP0_PROC	114
+#define TMPV770X_CLK_PIETHER_2P5M	115
+#define TMPV770X_CLK_PIETHER_25M	116
+#define TMPV770X_CLK_PIETHER_50M	117
+#define TMPV770X_CLK_PIETHER_125M	118
+#define TMPV770X_CLK_VOIF0_DPHYCFG	119
+#define TMPV770X_CLK_VOIF0_PROC		120
+#define TMPV770X_CLK_VOIF0_SBUS		121
+#define TMPV770X_CLK_VOIF0_DSIREF	122
+#define TMPV770X_CLK_VOIF0_PIXEL	123
+#define TMPV770X_CLK_PIREFCLK		124
+#define TMPV770X_CLK_SBUS		125
+#define TMPV770X_CLK_BUSLCK		126
+#define TMPV770X_NR_CLK			127
+
+/* Reset */
+#define TMPV770X_RESET_PIETHER_2P5M	0
+#define TMPV770X_RESET_PIETHER_25M	1
+#define TMPV770X_RESET_PIETHER_50M	2
+#define TMPV770X_RESET_PIETHER_125M	3
+#define TMPV770X_RESET_HOX		4
+#define TMPV770X_RESET_PCIE_MSTR	5
+#define TMPV770X_RESET_PCIE_AUX		6
+#define TMPV770X_RESET_PIINTC		7
+#define TMPV770X_RESET_PIETHER_BUS	8
+#define TMPV770X_RESET_PISPI0		9
+#define TMPV770X_RESET_PISPI1		10
+#define TMPV770X_RESET_PISPI2		11
+#define TMPV770X_RESET_PISPI3		12
+#define TMPV770X_RESET_PISPI4		13
+#define TMPV770X_RESET_PISPI5		14
+#define TMPV770X_RESET_PISPI6		15
+#define TMPV770X_RESET_PIUART0		16
+#define TMPV770X_RESET_PIUART1		17
+#define TMPV770X_RESET_PIUART2		18
+#define TMPV770X_RESET_PIUART3		19
+#define TMPV770X_RESET_PII2C0		20
+#define TMPV770X_RESET_PII2C1		21
+#define TMPV770X_RESET_PII2C2		22
+#define TMPV770X_RESET_PII2C3		23
+#define TMPV770X_RESET_PII2C4		24
+#define TMPV770X_RESET_PII2C5		25
+#define TMPV770X_RESET_PII2C6		26
+#define TMPV770X_RESET_PII2C7		27
+#define TMPV770X_RESET_PII2C8		28
+#define TMPV770X_RESET_PIPCMIF		29
+#define TMPV770X_RESET_PICKMON		30
+#define TMPV770X_RESET_SBUSCLK		31
+#define TMPV770X_NR_RESET		32
+
+#endif /*_DT_BINDINGS_CLOCK_TOSHIBA_TMPV770X_H_ */
diff --git a/include/dt-bindings/reset/toshiba,tmpv770x.h b/include/dt-bindings/reset/toshiba,tmpv770x.h
new file mode 100644
index 000000000000..c1007acb1941
--- /dev/null
+++ b/include/dt-bindings/reset/toshiba,tmpv770x.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
+#define _DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_
+
+/* Reset */
+#define TMPV770X_RESET_PIETHER_2P5M	0
+#define TMPV770X_RESET_PIETHER_25M	1
+#define TMPV770X_RESET_PIETHER_50M	2
+#define TMPV770X_RESET_PIETHER_125M	3
+#define TMPV770X_RESET_HOX		4
+#define TMPV770X_RESET_PCIE_MSTR	5
+#define TMPV770X_RESET_PCIE_AUX		6
+#define TMPV770X_RESET_PIINTC		7
+#define TMPV770X_RESET_PIETHER_BUS	8
+#define TMPV770X_RESET_PISPI0		9
+#define TMPV770X_RESET_PISPI1		10
+#define TMPV770X_RESET_PISPI2		11
+#define TMPV770X_RESET_PISPI3		12
+#define TMPV770X_RESET_PISPI4		13
+#define TMPV770X_RESET_PISPI5		14
+#define TMPV770X_RESET_PISPI6		15
+#define TMPV770X_RESET_PIUART0		16
+#define TMPV770X_RESET_PIUART1		17
+#define TMPV770X_RESET_PIUART2		18
+#define TMPV770X_RESET_PIUART3		19
+#define TMPV770X_RESET_PII2C0		20
+#define TMPV770X_RESET_PII2C1		21
+#define TMPV770X_RESET_PII2C2		22
+#define TMPV770X_RESET_PII2C3		23
+#define TMPV770X_RESET_PII2C4		24
+#define TMPV770X_RESET_PII2C5		25
+#define TMPV770X_RESET_PII2C6		26
+#define TMPV770X_RESET_PII2C7		27
+#define TMPV770X_RESET_PII2C8		28
+#define TMPV770X_RESET_PIPCMIF		29
+#define TMPV770X_RESET_PICKMON		30
+#define TMPV770X_RESET_SBUSCLK		31
+#define TMPV770X_NR_RESET		32
+
+#endif /*_DT_BINDINGS_RESET_TOSHIBA_TMPV770X_H_ */
-- 
2.33.0


