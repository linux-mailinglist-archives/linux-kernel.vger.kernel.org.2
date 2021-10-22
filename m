Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77643719A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVGQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:16:58 -0400
Received: from [113.204.237.245] ([113.204.237.245]:45566 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231616AbhJVGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:16:56 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(10964:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 22 Oct 2021 14:11:33 +0800 (CST)
From:   qinjian <qinjian@cqplus1.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qinjian <qinjian@cqplus1.com>
Subject: [PATCH 3/4] dt-bindings: clock: Add bindings for SP7021 clock driver
Date:   Fri, 22 Oct 2021 14:11:05 +0800
Message-Id: <20211022061105.281807-1-qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 clock driver bindings.

Signed-off-by: qinjian <qinjian@cqplus1.com>
---
 .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 ++++++
 MAINTAINERS                                   |   2 +
 include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 create mode 100644 include/dt-bindings/clock/sp-sp7021.h

diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
new file mode 100644
index 000000000..5b3c0881b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 SoC Clock Controller Binding
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-clkc
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    clkc: clkc@9c000000 {
+      compatible = "sunplus,sp7021-clkc";
+      #clock-cells = <1>;
+      reg = <0x9c000000 0x80>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 065da0846..474544db2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2660,7 +2660,9 @@ M:	Qin Jian <qinjian@cqplus1.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
+F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
 
 ARM/Synaptics SoC support
diff --git a/include/dt-bindings/clock/sp-sp7021.h b/include/dt-bindings/clock/sp-sp7021.h
new file mode 100644
index 000000000..98c3feba1
--- /dev/null
+++ b/include/dt-bindings/clock/sp-sp7021.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
+
+#define XTAL        27000000
+
+/* plls */
+#define PLL_A		0
+#define PLL_E		1
+#define PLL_E_2P5	2
+#define PLL_E_25	3
+#define PLL_E_112P5	4
+#define PLL_F		5
+#define PLL_TV		6
+#define PLL_TV_A	7
+#define PLL_SYS		8
+
+/* gates: mo_clken0 ~ mo_clken9 */
+#define SYSTEM		0x10
+#define RTC			0x12
+#define IOCTL		0x13
+#define IOP			0x14
+#define OTPRX		0x15
+#define NOC			0x16
+#define BR			0x17
+#define RBUS_L00	0x18
+#define SPIFL		0x19
+#define SDCTRL0		0x1a
+#define PERI0		0x1b
+#define A926		0x1d
+#define UMCTL2		0x1e
+#define PERI1		0x1f
+
+#define DDR_PHY0	0x20
+#define ACHIP		0x22
+#define STC0		0x24
+#define STC_AV0		0x25
+#define STC_AV1		0x26
+#define STC_AV2		0x27
+#define UA0			0x28
+#define UA1			0x29
+#define UA2			0x2a
+#define UA3			0x2b
+#define UA4			0x2c
+#define HWUA		0x2d
+#define DDC0		0x2e
+#define UADMA		0x2f
+
+#define CBDMA0		0x30
+#define CBDMA1		0x31
+#define SPI_COMBO_0	0x32
+#define SPI_COMBO_1	0x33
+#define SPI_COMBO_2	0x34
+#define SPI_COMBO_3	0x35
+#define AUD			0x36
+#define USBC0		0x3a
+#define USBC1		0x3b
+#define UPHY0		0x3d
+#define UPHY1		0x3e
+
+#define I2CM0		0x40
+#define I2CM1		0x41
+#define I2CM2		0x42
+#define I2CM3		0x43
+#define PMC			0x4d
+#define CARD_CTL0	0x4e
+#define CARD_CTL1	0x4f
+
+#define CARD_CTL4	0x52
+#define BCH			0x54
+#define DDFCH		0x5b
+#define CSIIW0		0x5c
+#define CSIIW1		0x5d
+#define MIPICSI0	0x5e
+#define MIPICSI1	0x5f
+
+#define HDMI_TX		0x60
+#define VPOST		0x65
+
+#define TGEN		0x70
+#define DMIX		0x71
+#define TCON		0x7a
+#define INTERRUPT	0x7f
+
+#define RGST		0x80
+#define GPIO		0x83
+#define RBUS_TOP	0x84
+
+#define MAILBOX		0x96
+#define SPIND		0x9a
+#define I2C2CBUS	0x9b
+#define SEC			0x9d
+#define DVE			0x9e
+#define GPOST0		0x9f
+
+#define OSD0		0xa0
+#define DISP_PWM	0xa2
+#define UADBG		0xa3
+#define DUMMY_MASTER	0xa4
+#define FIO_CTL		0xa5
+#define FPGA		0xa6
+#define L2SW		0xa7
+#define ICM			0xa8
+#define AXI_GLOBAL	0xa9
+
+#define CLK_MAX		0xb0
+
+#endif
-- 
2.33.1

