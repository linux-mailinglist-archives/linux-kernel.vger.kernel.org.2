Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB4437195
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhJVGPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:15:44 -0400
Received: from [113.204.237.245] ([113.204.237.245]:45524 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229484AbhJVGPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:15:42 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 02:15:42 EDT
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(10970:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 22 Oct 2021 14:12:44 +0800 (CST)
From:   qinjian <qinjian@cqplus1.com>
To:     p.zabel@pengutronix.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qinjian <qinjian@cqplus1.com>
Subject: [PATCH 4/4] dt-bindings: clock: Add bindings for SP7021 reset driver
Date:   Fri, 22 Oct 2021 14:12:16 +0800
Message-Id: <20211022061216.281903-1-qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 reset driver bindings.

Signed-off-by: qinjian <qinjian@cqplus1.com>
---
 .../bindings/reset/sunplus,reset.yaml         | 40 ++++++++
 MAINTAINERS                                   |  2 +
 include/dt-bindings/reset/sp-sp7021.h         | 99 +++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 create mode 100644 include/dt-bindings/reset/sp-sp7021.h

diff --git a/Documentation/devicetree/bindings/reset/sunplus,reset.yaml b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
new file mode 100644
index 000000000..bf55f4ee2
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/sunplus,reset.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/sunplus,reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC Reset Controller
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-reset # Reset Controller on SP7021 and compatible SoCs
+      - sunplus,q645-reset # Reset Controller on Q645 and compatible SoCs
+
+  "#reset-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#reset-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rstc: reset@9c000054 {
+      compatible = "sunplus,sp7021-reset";
+      #reset-cells = <1>;
+      reg = <0x9c000054 0x28>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 474544db2..123616bb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2662,8 +2662,10 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
+F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
+F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
diff --git a/include/dt-bindings/reset/sp-sp7021.h b/include/dt-bindings/reset/sp-sp7021.h
new file mode 100644
index 000000000..a08fd6231
--- /dev/null
+++ b/include/dt-bindings/reset/sp-sp7021.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#ifndef _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+#define _DT_BINDINGS_RST_SUNPLUS_SP7021_H
+
+/* mo_reset0 ~ mo_reset9 */
+#define RST_SYSTEM		0x00
+#define RST_RTC			0x02
+#define RST_IOCTL		0x03
+#define RST_IOP			0x04
+#define RST_OTPRX		0x05
+#define RST_NOC			0x06
+#define RST_BR			0x07
+#define RST_RBUS_L00	0x08
+#define RST_SPIFL		0x09
+#define RST_SDCTRL0		0x0a
+#define RST_PERI0		0x0b
+#define RST_A926		0x0d
+#define RST_UMCTL2		0x0e
+#define RST_PERI1		0x0f
+
+#define RST_DDR_PHY0	0x10
+#define RST_ACHIP		0x12
+#define RST_STC0		0x14
+#define RST_STC_AV0		0x15
+#define RST_STC_AV1		0x16
+#define RST_STC_AV2		0x17
+#define RST_UA0			0x18
+#define RST_UA1			0x19
+#define RST_UA2			0x1a
+#define RST_UA3			0x1b
+#define RST_UA4			0x1c
+#define RST_HWUA		0x1d
+#define RST_DDC0		0x1e
+#define RST_UADMA		0x1f
+
+#define RST_CBDMA0		0x20
+#define RST_CBDMA1		0x21
+#define RST_SPI_COMBO_0	0x22
+#define RST_SPI_COMBO_1	0x23
+#define RST_SPI_COMBO_2	0x24
+#define RST_SPI_COMBO_3	0x25
+#define RST_AUD			0x26
+#define RST_USBC0		0x2a
+#define RST_USBC1		0x2b
+#define RST_UPHY0		0x2d
+#define RST_UPHY1		0x2e
+
+#define RST_I2CM0		0x30
+#define RST_I2CM1		0x31
+#define RST_I2CM2		0x32
+#define RST_I2CM3		0x33
+#define RST_PMC			0x3d
+#define RST_CARD_CTL0	0x3e
+#define RST_CARD_CTL1	0x3f
+
+#define RST_CARD_CTL4	0x42
+#define RST_BCH			0x44
+#define RST_DDFCH		0x4b
+#define RST_CSIIW0		0x4c
+#define RST_CSIIW1		0x4d
+#define RST_MIPICSI0	0x4e
+#define RST_MIPICSI1	0x4f
+
+#define RST_HDMI_TX		0x50
+#define RST_VPOST		0x55
+
+#define RST_TGEN		0x60
+#define RST_DMIX		0x61
+#define RST_TCON		0x6a
+#define RST_INTERRUPT	0x6f
+
+#define RST_RGST		0x70
+#define RST_GPIO		0x73
+#define RST_RBUS_TOP	0x74
+
+#define RST_MAILBOX		0x86
+#define RST_SPIND		0x8a
+#define RST_I2C2CBUS	0x8b
+#define RST_SEC			0x8d
+#define RST_DVE			0x8e
+#define RST_GPOST0		0x8f
+
+#define RST_OSD0		0x90
+#define RST_DISP_PWM	0x92
+#define RST_UADBG		0x93
+#define RST_DUMMY_MASTER	0x94
+#define RST_FIO_CTL		0x95
+#define RST_FPGA		0x96
+#define RST_L2SW		0x97
+#define RST_ICM			0x98
+#define RST_AXI_GLOBAL	0x99
+
+#define RST_MAX			0xA0
+
+#endif
-- 
2.33.1

