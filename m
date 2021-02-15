Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5270531C28B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBOTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhBOTlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:41:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D8C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:40:23 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613418021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q6oirop6UG0OkFOtgPWEORLLdcELTBjAI0SRQGM8XSA=;
        b=4naTeeN8Z9/Av4lGobDEwdezHkx+wMNRtxq9q4g+8lxACr/eApao+CS9X2JpYbwdXFjg5S
        NoJsa3nIcIPsZp2RUnLRgBD+IOZGdLeVLg6P0Ha+hkxtU07y+DFclgAS4Ifyi/6rz7qrEa
        z34uzW9Y6AsNDIsEfcYyyxz3dQZYlAjTMBQEWhlE21Stnqjqh17OqLj/S6iBYh5HKrv7hI
        O5rzlqB3svoc/E1zM90mGRytojwR9DNQplRaw/fpqtkIA7Zt5UTzSaPkuuVs0ShlsDT1yy
        TgVimjxVjlWWwR/sjn+DoNJXuYmduNY4vXmVIp+zRCv3jp8NvWU2jByGE9ZmsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613418021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q6oirop6UG0OkFOtgPWEORLLdcELTBjAI0SRQGM8XSA=;
        b=Cf3ltPG0H2BvMVbcJtGx6VrVpyQAE3B539vFH59tcEibURkHmu65G9RnrIPrFk2T7j30VW
        v8nWOFn8gBUHHjAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 5.12
Message-ID: <161341798844.14643.10479841258453089369.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-02-15

up to:  0b6d70e571a1: Merge tag 'irqchip-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Updates for the irq subsystem:

  - The usual new irq chip driver (Realtek RTL83xx)
  - Removal of sirfsoc and tango irq chip drivers
  - Conversion of the sun6i chip support to hierarchical irq domains
  - The usual fixes, improvements and cleanups all over the place

Thanks,

	tglx

------------------>
Arnd Bergmann (2):
      irqchip: Remove sigma tango driver
      irqchip: Remove sirfsoc driver

Bert Vermeulen (2):
      dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
      irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller

Biwen Li (1):
      irqchip/ls-extirq: add IRQCHIP_SKIP_SET_WAKE to the irqchip flags

Emil Renner Berthing (1):
      genirq: Use new tasklet API for resend_tasklet

Geert Uytterhoeven (1):
      irqchip/imx: IMX_INTMUX should not default to y, unconditionally

Guo Ren (1):
      irqchip/csky-mpintc: Prevent selection on unsupported platforms

Huacai Chen (1):
      irqchip/loongson-pch-msi: Use bitmap_zalloc() to allocate bitmap

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Fix typos in PMR/RPR SCR_EL3.FIQ handling explanation

Samuel Holland (4):
      dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
      dt-bindings: irq: sun6i-r: Add a compatible for the H3
      irqchip/sun6i-r: Use a stacked irqchip driver
      irqchip/sun6i-r: Add wakeup support

Vinod Koul (2):
      dt-bindings: qcom,pdc: Add compatible for SM8250
      dt-bindings: qcom,pdc: Add compatible for SM8350


 .../allwinner,sun6i-a31-r-intc.yaml                |  67 ++++
 .../allwinner,sun7i-a20-sc-nmi.yaml                |  10 -
 .../bindings/interrupt-controller/qcom,pdc.txt     |   2 +
 .../interrupt-controller/realtek,rtl-intc.yaml     |  57 ++++
 .../interrupt-controller/sigma,smp8642-intc.txt    |  48 ---
 arch/arm/mach-sunxi/Kconfig                        |   2 +
 arch/arm64/Kconfig.platforms                       |   2 +
 drivers/irqchip/Kconfig                            |  10 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |   2 +-
 drivers/irqchip/irq-ls-extirq.c                    |   2 +-
 drivers/irqchip/irq-realtek-rtl.c                  | 180 ++++++++++
 drivers/irqchip/irq-sirfsoc.c                      | 134 --------
 drivers/irqchip/irq-sun6i-r.c                      | 379 +++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c                    |  26 +-
 drivers/irqchip/irq-tango.c                        | 227 ------------
 kernel/irq/resend.c                                |   4 +-
 18 files changed, 703 insertions(+), 457 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
 create mode 100644 drivers/irqchip/irq-realtek-rtl.c
 delete mode 100644 drivers/irqchip/irq-sirfsoc.c
 create mode 100644 drivers/irqchip/irq-sun6i-r.c
 delete mode 100644 drivers/irqchip/irq-tango.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
new file mode 100644
index 000000000000..4db24b8a9ffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 NMI/Wakeup Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 3
+    description:
+      The first cell is GIC_SPI (0), the second cell is the IRQ number, and
+      the third cell is the trigger type as defined in interrupt.txt in this
+      directory.
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun6i-a31-r-intc
+      - items:
+          - enum:
+              - allwinner,sun8i-a83t-r-intc
+              - allwinner,sun8i-h3-r-intc
+              - allwinner,sun50i-a64-r-intc
+          - const: allwinner,sun6i-a31-r-intc
+      - const: allwinner,sun50i-h6-r-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      The GIC interrupt labeled as "External NMI".
+
+  interrupt-controller: true
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    r_intc: interrupt-controller@1f00c00 {
+            compatible = "allwinner,sun50i-a64-r-intc",
+                         "allwinner,sun6i-a31-r-intc";
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            reg = <0x01f00c00 0x400>;
+            interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 8acca0ae3129..f34ecc8c7093 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -22,23 +22,13 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun6i-a31-sc-nmi
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
-      - items:
-          - const: allwinner,sun8i-a83t-r-intc
-          - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun9i-a80-nmi
-      - items:
-          - const: allwinner,sun50i-a64-r-intc
-          - const: allwinner,sun6i-a31-r-intc
       - items:
           - const: allwinner,sun50i-a100-nmi
           - const: allwinner,sun9i-a80-nmi
-      - items:
-          - const: allwinner,sun50i-h6-r-intc
-          - const: allwinner,sun6i-a31-r-intc
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 1df293953327..e9afb48182c7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -20,6 +20,8 @@ Properties:
 	Definition: Should contain "qcom,<soc>-pdc" and "qcom,pdc"
 		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sdm845-pdc": For SDM845
+		    - "qcom,sdm8250-pdc": For SM8250
+		    - "qcom,sdm8350-pdc": For SM8350
 
 - reg:
 	Usage: required
diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
new file mode 100644
index 000000000000..9e76fff20323
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtl-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL SoC interrupt controller devicetree bindings
+
+maintainers:
+  - Birger Koblitz <mail@birger-koblitz.de>
+  - Bert Vermeulen <bert@biot.com>
+  - John Crispin <john@phrozen.org>
+
+properties:
+  compatible:
+    const: realtek,rtl-intc
+
+  "#interrupt-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells":
+    const: 0
+
+  interrupt-map:
+    description: Describes mapping from SoC interrupts to CPU interrupts
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - "#address-cells"
+  - interrupt-map
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@3000 {
+      compatible = "realtek,rtl-intc";
+      #interrupt-cells = <1>;
+      interrupt-controller;
+      reg = <0x3000 0x20>;
+      #address-cells = <0>;
+      interrupt-map =
+              <31 &cpuintc 2>,
+              <30 &cpuintc 1>,
+              <29 &cpuintc 5>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
deleted file mode 100644
index 355c18a3a4d3..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Sigma Designs SMP86xx/SMP87xx secondary interrupt controller
-
-Required properties:
-- compatible: should be "sigma,smp8642-intc"
-- reg: physical address of MMIO region
-- ranges: address space mapping of child nodes
-- interrupt-controller: boolean
-- #address-cells: should be <1>
-- #size-cells: should be <1>
-
-One child node per control block with properties:
-- reg: address of registers for this control block
-- interrupt-controller: boolean
-- #interrupt-cells: should be <2>, interrupt index and flags per interrupts.txt
-- interrupts: interrupt spec of primary interrupt controller
-
-Example:
-
-interrupt-controller@6e000 {
-	compatible = "sigma,smp8642-intc";
-	reg = <0x6e000 0x400>;
-	ranges = <0x0 0x6e000 0x400>;
-	interrupt-parent = <&gic>;
-	interrupt-controller;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	irq0: interrupt-controller@0 {
-		reg = <0x000 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	irq1: interrupt-controller@100 {
-		reg = <0x100 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	irq2: interrupt-controller@300 {
-		reg = <0x300 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..e5c2fce281cd 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,8 @@ menuconfig ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..f2aa1518c6f4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -17,6 +17,8 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
 	help
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b147f22a78f4..e74fa206240a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -260,11 +260,6 @@ config ST_IRQCHIP
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
 
-config TANGO_IRQ
-	bool
-	select IRQ_DOMAIN
-	select GENERIC_IRQ_CHIP
-
 config TB10X_IRQC
 	bool
 	select IRQ_DOMAIN
@@ -432,7 +427,7 @@ config QCOM_PDC
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
 config CSKY_MPINTC
-	bool "C-SKY Multi Processor Interrupt Controller"
+	bool
 	depends on CSKY
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
@@ -457,7 +452,8 @@ config IMX_IRQSTEER
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
-	def_bool y if ARCH_MXC || COMPILE_TEST
+	bool "i.MX INTMUX support" if COMPILE_TEST
+	default y if ARCH_MXC
 	select IRQ_DOMAIN
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..c59b95a0532c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
+obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun6i-r.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
@@ -45,7 +46,6 @@ obj-$(CONFIG_I8259)			+= irq-i8259.o
 obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
 obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_IXP4XX_IRQ)		+= irq-ixp4xx.o
-obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
 obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
 obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
@@ -55,7 +55,6 @@ obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
 obj-$(CONFIG_ST_IRQCHIP)		+= irq-st.o
-obj-$(CONFIG_TANGO_IRQ)			+= irq-tango.o
 obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
@@ -113,3 +112,4 @@ obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
+obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3fc65375cbe0..eb0ee356a629 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -75,10 +75,10 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  * are presented to the GIC CPUIF as follow:
  *     (GIC_(R)DIST_PRI[irq] >> 1) | 0x80;
  *
- * If SCR_EL3.FIQ == 1, the values writen to/read from PMR and RPR at non-secure
+ * If SCR_EL3.FIQ == 1, the values written to/read from PMR and RPR at non-secure
  * EL1 are subject to a similar operation thus matching the priorities presented
  * from the (re)distributor when security is enabled. When SCR_EL3.FIQ == 0,
- * these values are unchanched by the GIC.
+ * these values are unchanged by the GIC.
  *
  * see GICv3/GICv4 Architecture Specification (IHI0069D):
  * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 12aeeab43289..32562b7e681b 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -225,7 +225,7 @@ static int pch_msi_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	priv->msi_map = bitmap_alloc(priv->num_irqs, GFP_KERNEL);
+	priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret = -ENOMEM;
 		goto err_priv;
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index f94f974a8764..853b3972dbe7 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -64,7 +64,7 @@ static struct irq_chip ls_extirq_chip = {
 	.irq_set_type		= ls_extirq_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
new file mode 100644
index 000000000000..b57c67dfab5b
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Birger Koblitz <mail@birger-koblitz.de>
+ * Copyright (C) 2020 Bert Vermeulen <bert@biot.com>
+ * Copyright (C) 2020 John Crispin <john@phrozen.org>
+ */
+
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/spinlock.h>
+#include <linux/of_address.h>
+#include <linux/irqchip/chained_irq.h>
+
+/* Global Interrupt Mask Register */
+#define RTL_ICTL_GIMR		0x00
+/* Global Interrupt Status Register */
+#define RTL_ICTL_GISR		0x04
+/* Interrupt Routing Registers */
+#define RTL_ICTL_IRR0		0x08
+#define RTL_ICTL_IRR1		0x0c
+#define RTL_ICTL_IRR2		0x10
+#define RTL_ICTL_IRR3		0x14
+
+#define REG(x)		(realtek_ictl_base + x)
+
+static DEFINE_RAW_SPINLOCK(irq_lock);
+static void __iomem *realtek_ictl_base;
+
+static void realtek_ictl_unmask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value |= BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static void realtek_ictl_mask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value &= ~BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static struct irq_chip realtek_ictl_irq = {
+	.name = "realtek-rtl-intc",
+	.irq_mask = realtek_ictl_mask_irq,
+	.irq_unmask = realtek_ictl_unmask_irq,
+};
+
+static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(hw, &realtek_ictl_irq, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.map = intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void realtek_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain;
+	unsigned int pending;
+
+	chained_irq_enter(chip, desc);
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+	if (unlikely(!pending)) {
+		spurious_interrupt();
+		goto out;
+	}
+	domain = irq_desc_get_handler_data(desc);
+	generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+/*
+ * SoC interrupts are cascaded to MIPS CPU interrupts according to the
+ * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
+ * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
+ * thus go into 4 IRRs.
+ */
+static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
+{
+	struct device_node *cpu_ictl;
+	const __be32 *imap;
+	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
+	int ret, i, irr_regs[] = {
+		RTL_ICTL_IRR3,
+		RTL_ICTL_IRR2,
+		RTL_ICTL_IRR1,
+		RTL_ICTL_IRR0,
+	};
+	u8 mips_irqs_set;
+
+	ret = of_property_read_u32(node, "#address-cells", &tmp);
+	if (ret || tmp)
+		return -EINVAL;
+
+	imap = of_get_property(node, "interrupt-map", &imaplen);
+	if (!imap || imaplen % 3)
+		return -EINVAL;
+
+	mips_irqs_set = 0;
+	memset(regs, 0, sizeof(regs));
+	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
+		soc_int = be32_to_cpup(imap);
+		if (soc_int > 31)
+			return -EINVAL;
+
+		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
+		if (!cpu_ictl)
+			return -EINVAL;
+		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		if (ret || tmp != 1)
+			return -EINVAL;
+		of_node_put(cpu_ictl);
+
+		cpu_int = be32_to_cpup(imap + 2);
+		if (cpu_int > 7)
+			return -EINVAL;
+
+		if (!(mips_irqs_set & BIT(cpu_int))) {
+			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
+							 domain);
+			mips_irqs_set |= BIT(cpu_int);
+		}
+
+		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		imap += 3;
+	}
+
+	for (i = 0; i < 4; i++)
+		writel(regs[i], REG(irr_regs[i]));
+
+	return 0;
+}
+
+static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	int ret;
+
+	realtek_ictl_base = of_iomap(node, 0);
+	if (!realtek_ictl_base)
+		return -ENXIO;
+
+	/* Disable all cascaded interrupts */
+	writel(0, REG(RTL_ICTL_GIMR));
+
+	domain = irq_domain_add_simple(node, 32, 0,
+				       &irq_domain_ops, NULL);
+
+	ret = map_interrupts(node, domain);
+	if (ret) {
+		pr_err("invalid interrupt map\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(realtek_rtl_intc, "realtek,rtl-intc", realtek_rtl_of_init);
diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
deleted file mode 100644
index c86faaa35ca4..000000000000
--- a/drivers/irqchip/irq-sirfsoc.c
+++ /dev/null
@@ -1,134 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * interrupt controller support for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/irqchip.h>
-#include <linux/irqdomain.h>
-#include <linux/syscore_ops.h>
-#include <asm/mach/irq.h>
-#include <asm/exception.h>
-
-#define SIRFSOC_INT_RISC_MASK0		0x0018
-#define SIRFSOC_INT_RISC_MASK1		0x001C
-#define SIRFSOC_INT_RISC_LEVEL0		0x0020
-#define SIRFSOC_INT_RISC_LEVEL1		0x0024
-#define SIRFSOC_INIT_IRQ_ID		0x0038
-#define SIRFSOC_INT_BASE_OFFSET		0x0004
-
-#define SIRFSOC_NUM_IRQS		64
-#define SIRFSOC_NUM_BANKS		(SIRFSOC_NUM_IRQS / 32)
-
-static struct irq_domain *sirfsoc_irqdomain;
-
-static void __iomem *sirfsoc_irq_get_regbase(void)
-{
-	return (void __iomem __force *)sirfsoc_irqdomain->host_data;
-}
-
-static __init void sirfsoc_alloc_gc(void __iomem *base)
-{
-	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	unsigned int set = IRQ_LEVEL;
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-	int i;
-
-	irq_alloc_domain_generic_chips(sirfsoc_irqdomain, 32, 1, "irq_sirfsoc",
-				       handle_level_irq, clr, set,
-				       IRQ_GC_INIT_MASK_CACHE);
-
-	for (i = 0; i < SIRFSOC_NUM_BANKS; i++) {
-		gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, i * 32);
-		gc->reg_base = base + i * SIRFSOC_INT_BASE_OFFSET;
-		ct = gc->chip_types;
-		ct->chip.irq_mask = irq_gc_mask_clr_bit;
-		ct->chip.irq_unmask = irq_gc_mask_set_bit;
-		ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
-	}
-}
-
-static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
-{
-	void __iomem *base = sirfsoc_irq_get_regbase();
-	u32 irqstat;
-
-	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
-	handle_domain_irq(sirfsoc_irqdomain, irqstat & 0xff, regs);
-}
-
-static int __init sirfsoc_irq_init(struct device_node *np,
-	struct device_node *parent)
-{
-	void __iomem *base = of_iomap(np, 0);
-	if (!base)
-		panic("unable to map intc cpu registers\n");
-
-	sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
-						  &irq_generic_chip_ops, base);
-	sirfsoc_alloc_gc(base);
-
-	writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL0);
-	writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL1);
-
-	writel_relaxed(0, base + SIRFSOC_INT_RISC_MASK0);
-	writel_relaxed(0, base + SIRFSOC_INT_RISC_MASK1);
-
-	set_handle_irq(sirfsoc_handle_irq);
-
-	return 0;
-}
-IRQCHIP_DECLARE(sirfsoc_intc, "sirf,prima2-intc", sirfsoc_irq_init);
-
-struct sirfsoc_irq_status {
-	u32 mask0;
-	u32 mask1;
-	u32 level0;
-	u32 level1;
-};
-
-static struct sirfsoc_irq_status sirfsoc_irq_st;
-
-static int sirfsoc_irq_suspend(void)
-{
-	void __iomem *base = sirfsoc_irq_get_regbase();
-
-	sirfsoc_irq_st.mask0 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK0);
-	sirfsoc_irq_st.mask1 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK1);
-	sirfsoc_irq_st.level0 = readl_relaxed(base + SIRFSOC_INT_RISC_LEVEL0);
-	sirfsoc_irq_st.level1 = readl_relaxed(base + SIRFSOC_INT_RISC_LEVEL1);
-
-	return 0;
-}
-
-static void sirfsoc_irq_resume(void)
-{
-	void __iomem *base = sirfsoc_irq_get_regbase();
-
-	writel_relaxed(sirfsoc_irq_st.mask0, base + SIRFSOC_INT_RISC_MASK0);
-	writel_relaxed(sirfsoc_irq_st.mask1, base + SIRFSOC_INT_RISC_MASK1);
-	writel_relaxed(sirfsoc_irq_st.level0, base + SIRFSOC_INT_RISC_LEVEL0);
-	writel_relaxed(sirfsoc_irq_st.level1, base + SIRFSOC_INT_RISC_LEVEL1);
-}
-
-static struct syscore_ops sirfsoc_irq_syscore_ops = {
-	.suspend	= sirfsoc_irq_suspend,
-	.resume		= sirfsoc_irq_resume,
-};
-
-static int __init sirfsoc_irq_pm_init(void)
-{
-	if (!sirfsoc_irqdomain)
-		return 0;
-
-	register_syscore_ops(&sirfsoc_irq_syscore_ops);
-	return 0;
-}
-device_initcall(sirfsoc_irq_pm_init);
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
new file mode 100644
index 000000000000..4cd3e533740b
--- /dev/null
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The R_INTC in Allwinner A31 and newer SoCs manages several types of
+ * interrupts, as shown below:
+ *
+ *             NMI IRQ                DIRECT IRQs           MUXED IRQs
+ *              bit 0                  bits 1-15^           bits 19-31
+ *
+ *   +---------+                      +---------+    +---------+  +---------+
+ *   | NMI Pad |                      |  IRQ d  |    |  IRQ m  |  | IRQ m+7 |
+ *   +---------+                      +---------+    +---------+  +---------+
+ *        |                             |     |         |    |      |    |
+ *        |                             |     |         |    |......|    |
+ * +------V------+ +------------+       |     |         | +--V------V--+ |
+ * |   Invert/   | | Write 1 to |       |     |         | |  AND with  | |
+ * | Edge Detect | | PENDING[0] |       |     |         | |  MUX[m/8]  | |
+ * +-------------+ +------------+       |     |         | +------------+ |
+ *            |       |                 |     |         |       |        |
+ *         +--V-------V--+           +--V--+  |      +--V--+    |     +--V--+
+ *         | Set    Reset|           | GIC |  |      | GIC |    |     | GIC |
+ *         |    Latch    |           | SPI |  |      | SPI |... |  ...| SPI |
+ *         +-------------+           | N+d |  |      |  m  |    |     | m+7 |
+ *             |     |               +-----+  |      +-----+    |     +-----+
+ *             |     |                        |                 |
+ *     +-------V-+ +-V----------+   +---------V--+     +--------V--------+
+ *     | GIC SPI | |  AND with  |   |  AND with  |     |    AND with     |
+ *     | N (=32) | |  ENABLE[0] |   |  ENABLE[d] |     |  ENABLE[19+m/8] |
+ *     +---------+ +------------+   +------------+     +-----------------+
+ *                        |                |                    |
+ *                 +------V-----+   +------V-----+     +--------V--------+
+ *                 |    Read    |   |    Read    |     |     Read        |
+ *                 | PENDING[0] |   | PENDING[d] |     | PENDING[19+m/8] |
+ *                 +------------+   +------------+     +-----------------+
+ *
+ * ^ bits 16-18 are direct IRQs for peripherals with banked interrupts, such as
+ *   the MSGBOX. These IRQs do not map to any GIC SPI.
+ *
+ * The H6 variant adds two more (banked) direct IRQs and implements the full
+ * set of 128 mux bits. This requires a second set of top-level registers.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define SUN6I_NMI_CTRL			(0x0c)
+#define SUN6I_IRQ_PENDING(n)		(0x10 + 4 * (n))
+#define SUN6I_IRQ_ENABLE(n)		(0x40 + 4 * (n))
+#define SUN6I_MUX_ENABLE(n)		(0xc0 + 4 * (n))
+
+#define SUN6I_NMI_SRC_TYPE_LEVEL_LOW	0
+#define SUN6I_NMI_SRC_TYPE_EDGE_FALLING	1
+#define SUN6I_NMI_SRC_TYPE_LEVEL_HIGH	2
+#define SUN6I_NMI_SRC_TYPE_EDGE_RISING	3
+
+#define SUN6I_NMI_BIT			BIT(0)
+
+#define SUN6I_NMI_NEEDS_ACK		((void *)1)
+
+#define SUN6I_NR_TOP_LEVEL_IRQS		64
+#define SUN6I_NR_DIRECT_IRQS		16
+#define SUN6I_NR_MUX_BITS		128
+
+struct sun6i_r_intc_variant {
+	u32		first_mux_irq;
+	u32		nr_mux_irqs;
+	u32		mux_valid[BITS_TO_U32(SUN6I_NR_MUX_BITS)];
+};
+
+static void __iomem *base;
+static irq_hw_number_t nmi_hwirq;
+static DECLARE_BITMAP(wake_irq_enabled, SUN6I_NR_TOP_LEVEL_IRQS);
+static DECLARE_BITMAP(wake_mux_enabled, SUN6I_NR_MUX_BITS);
+static DECLARE_BITMAP(wake_mux_valid, SUN6I_NR_MUX_BITS);
+
+static void sun6i_r_intc_ack_nmi(void)
+{
+	writel_relaxed(SUN6I_NMI_BIT, base + SUN6I_IRQ_PENDING(0));
+}
+
+static void sun6i_r_intc_nmi_ack(struct irq_data *data)
+{
+	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
+		sun6i_r_intc_ack_nmi();
+	else
+		data->chip_data = SUN6I_NMI_NEEDS_ACK;
+}
+
+static void sun6i_r_intc_nmi_eoi(struct irq_data *data)
+{
+	/* For oneshot IRQs, delay the ack until the IRQ is unmasked. */
+	if (data->chip_data == SUN6I_NMI_NEEDS_ACK && !irqd_irq_masked(data)) {
+		data->chip_data = NULL;
+		sun6i_r_intc_ack_nmi();
+	}
+
+	irq_chip_eoi_parent(data);
+}
+
+static void sun6i_r_intc_nmi_unmask(struct irq_data *data)
+{
+	if (data->chip_data == SUN6I_NMI_NEEDS_ACK) {
+		data->chip_data = NULL;
+		sun6i_r_intc_ack_nmi();
+	}
+
+	irq_chip_unmask_parent(data);
+}
+
+static int sun6i_r_intc_nmi_set_type(struct irq_data *data, unsigned int type)
+{
+	u32 nmi_src_type;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_LEVEL_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(nmi_src_type, base + SUN6I_NMI_CTRL);
+
+	/*
+	 * The "External NMI" GIC input connects to a latch inside R_INTC, not
+	 * directly to the pin. So the GIC trigger type does not depend on the
+	 * NMI pin trigger type.
+	 */
+	return irq_chip_set_type_parent(data, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static int sun6i_r_intc_nmi_set_irqchip_state(struct irq_data *data,
+					      enum irqchip_irq_state which,
+					      bool state)
+{
+	if (which == IRQCHIP_STATE_PENDING && !state)
+		sun6i_r_intc_ack_nmi();
+
+	return irq_chip_set_parent_state(data, which, state);
+}
+
+static int sun6i_r_intc_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	unsigned long offset_from_nmi = data->hwirq - nmi_hwirq;
+
+	if (offset_from_nmi < SUN6I_NR_DIRECT_IRQS)
+		assign_bit(offset_from_nmi, wake_irq_enabled, on);
+	else if (test_bit(data->hwirq, wake_mux_valid))
+		assign_bit(data->hwirq, wake_mux_enabled, on);
+	else
+		/* Not wakeup capable. */
+		return -EPERM;
+
+	return 0;
+}
+
+static struct irq_chip sun6i_r_intc_nmi_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_ack		= sun6i_r_intc_nmi_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= sun6i_r_intc_nmi_unmask,
+	.irq_eoi		= sun6i_r_intc_nmi_eoi,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_nmi_set_type,
+	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip sun6i_r_intc_wakeup_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
+					 struct irq_fwspec *fwspec,
+					 unsigned long *hwirq,
+					 unsigned int *type)
+{
+	/* Accept the old two-cell binding for the NMI only. */
+	if (fwspec->param_count == 2 && fwspec->param[0] == 0) {
+		*hwirq = nmi_hwirq;
+		*type  = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	/* Otherwise this binding should match the GIC SPI binding. */
+	if (fwspec->param_count < 3)
+		return -EINVAL;
+	if (fwspec->param[0] != GIC_SPI)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[1];
+	*type  = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec;
+	unsigned long hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+	if (hwirq + nr_irqs > SUN6I_NR_MUX_BITS)
+		return -EINVAL;
+
+	/* Construct a GIC-compatible fwspec from this fwspec. */
+	gic_fwspec = (struct irq_fwspec) {
+		.fwnode      = domain->parent->fwnode,
+		.param_count = 3,
+		.param       = { GIC_SPI, hwirq, type },
+	};
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
+		if (hwirq == nmi_hwirq) {
+			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+						      &sun6i_r_intc_nmi_chip, 0);
+			irq_set_handler(virq, handle_fasteoi_ack_irq);
+		} else {
+			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+						      &sun6i_r_intc_wakeup_chip, 0);
+		}
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
+	.translate	= sun6i_r_intc_domain_translate,
+	.alloc		= sun6i_r_intc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int sun6i_r_intc_suspend(void)
+{
+	u32 buf[BITS_TO_U32(max(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
+	int i;
+
+	/* Wake IRQs are enabled during system sleep and shutdown. */
+	bitmap_to_arr32(buf, wake_irq_enabled, SUN6I_NR_TOP_LEVEL_IRQS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_TOP_LEVEL_IRQS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_IRQ_ENABLE(i));
+	bitmap_to_arr32(buf, wake_mux_enabled, SUN6I_NR_MUX_BITS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_MUX_BITS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_MUX_ENABLE(i));
+
+	return 0;
+}
+
+static void sun6i_r_intc_resume(void)
+{
+	int i;
+
+	/* Only the NMI is relevant during normal operation. */
+	writel_relaxed(SUN6I_NMI_BIT, base + SUN6I_IRQ_ENABLE(0));
+	for (i = 1; i < BITS_TO_U32(SUN6I_NR_TOP_LEVEL_IRQS); ++i)
+		writel_relaxed(0, base + SUN6I_IRQ_ENABLE(i));
+}
+
+static void sun6i_r_intc_shutdown(void)
+{
+	sun6i_r_intc_suspend();
+}
+
+static struct syscore_ops sun6i_r_intc_syscore_ops = {
+	.suspend	= sun6i_r_intc_suspend,
+	.resume		= sun6i_r_intc_resume,
+	.shutdown	= sun6i_r_intc_shutdown,
+};
+
+static int __init sun6i_r_intc_init(struct device_node *node,
+				    struct device_node *parent,
+				    const struct sun6i_r_intc_variant *v)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct of_phandle_args nmi_parent;
+	int ret;
+
+	/* Extract the NMI hwirq number from the OF node. */
+	ret = of_irq_parse_one(node, 0, &nmi_parent);
+	if (ret)
+		return ret;
+	if (nmi_parent.args_count < 3 ||
+	    nmi_parent.args[0] != GIC_SPI ||
+	    nmi_parent.args[2] != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+	nmi_hwirq = nmi_parent.args[1];
+
+	bitmap_set(wake_irq_enabled, v->first_mux_irq, v->nr_mux_irqs);
+	bitmap_from_arr32(wake_mux_valid, v->mux_valid, SUN6I_NR_MUX_BITS);
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: Failed to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	base = of_io_request_and_map(node, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("%pOF: Failed to map MMIO region\n", node);
+		return PTR_ERR(base);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, node,
+					  &sun6i_r_intc_domain_ops, NULL);
+	if (!domain) {
+		pr_err("%pOF: Failed to allocate domain\n", node);
+		iounmap(base);
+		return -ENOMEM;
+	}
+
+	register_syscore_ops(&sun6i_r_intc_syscore_ops);
+
+	sun6i_r_intc_ack_nmi();
+	sun6i_r_intc_resume();
+
+	return 0;
+}
+
+static const struct sun6i_r_intc_variant sun6i_a31_r_intc_variant __initconst = {
+	.first_mux_irq	= 19,
+	.nr_mux_irqs	= 13,
+	.mux_valid	= { 0xffffffff, 0xfff80000, 0xffffffff, 0x0000000f },
+};
+
+static int __init sun6i_a31_r_intc_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return sun6i_r_intc_init(node, parent, &sun6i_a31_r_intc_variant);
+}
+IRQCHIP_DECLARE(sun6i_a31_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_a31_r_intc_init);
+
+static const struct sun6i_r_intc_variant sun50i_h6_r_intc_variant __initconst = {
+	.first_mux_irq	= 21,
+	.nr_mux_irqs	= 16,
+	.mux_valid	= { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff },
+};
+
+static int __init sun50i_h6_r_intc_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return sun6i_r_intc_init(node, parent, &sun50i_h6_r_intc_variant);
+}
+IRQCHIP_DECLARE(sun50i_h6_r_intc, "allwinner,sun50i-h6-r-intc", sun50i_h6_r_intc_init);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index a412b5d5d0fa..9f2bd0c5d289 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -27,18 +27,12 @@
 
 #define SUNXI_NMI_IRQ_BIT	BIT(0)
 
-#define SUN6I_R_INTC_CTRL	0x0c
-#define SUN6I_R_INTC_PENDING	0x10
-#define SUN6I_R_INTC_ENABLE	0x40
-
 /*
  * For deprecated sun6i-a31-sc-nmi compatible.
- * Registers are offset by 0x0c.
  */
-#define SUN6I_R_INTC_NMI_OFFSET	0x0c
-#define SUN6I_NMI_CTRL		(SUN6I_R_INTC_CTRL - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_PENDING	(SUN6I_R_INTC_PENDING - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_ENABLE	(SUN6I_R_INTC_ENABLE - SUN6I_R_INTC_NMI_OFFSET)
+#define SUN6I_NMI_CTRL		0x00
+#define SUN6I_NMI_PENDING	0x04
+#define SUN6I_NMI_ENABLE	0x34
 
 #define SUN7I_NMI_CTRL		0x00
 #define SUN7I_NMI_PENDING	0x04
@@ -61,12 +55,6 @@ struct sunxi_sc_nmi_reg_offs {
 	u32 enable;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_r_intc_reg_offs __initconst = {
-	.ctrl	= SUN6I_R_INTC_CTRL,
-	.pend	= SUN6I_R_INTC_PENDING,
-	.enable	= SUN6I_R_INTC_ENABLE,
-};
-
 static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
@@ -232,14 +220,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	return ret;
 }
 
-static int __init sun6i_r_intc_irq_init(struct device_node *node,
-					struct device_node *parent)
-{
-	return sunxi_sc_nmi_irq_init(node, &sun6i_r_intc_reg_offs);
-}
-IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc",
-		sun6i_r_intc_irq_init);
-
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
deleted file mode 100644
index 34290f09b853..000000000000
--- a/drivers/irqchip/irq-tango.c
+++ /dev/null
@@ -1,227 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2014 Mans Rullgard <mans@mansr.com>
- */
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/slab.h>
-
-#define IRQ0_CTL_BASE		0x0000
-#define IRQ1_CTL_BASE		0x0100
-#define EDGE_CTL_BASE		0x0200
-#define IRQ2_CTL_BASE		0x0300
-
-#define IRQ_CTL_HI		0x18
-#define EDGE_CTL_HI		0x20
-
-#define IRQ_STATUS		0x00
-#define IRQ_RAWSTAT		0x04
-#define IRQ_EN_SET		0x08
-#define IRQ_EN_CLR		0x0c
-#define IRQ_SOFT_SET		0x10
-#define IRQ_SOFT_CLR		0x14
-
-#define EDGE_STATUS		0x00
-#define EDGE_RAWSTAT		0x04
-#define EDGE_CFG_RISE		0x08
-#define EDGE_CFG_FALL		0x0c
-#define EDGE_CFG_RISE_SET	0x10
-#define EDGE_CFG_RISE_CLR	0x14
-#define EDGE_CFG_FALL_SET	0x18
-#define EDGE_CFG_FALL_CLR	0x1c
-
-struct tangox_irq_chip {
-	void __iomem *base;
-	unsigned long ctl;
-};
-
-static inline u32 intc_readl(struct tangox_irq_chip *chip, int reg)
-{
-	return readl_relaxed(chip->base + reg);
-}
-
-static inline void intc_writel(struct tangox_irq_chip *chip, int reg, u32 val)
-{
-	writel_relaxed(val, chip->base + reg);
-}
-
-static void tangox_dispatch_irqs(struct irq_domain *dom, unsigned int status,
-				 int base)
-{
-	unsigned int hwirq;
-	unsigned int virq;
-
-	while (status) {
-		hwirq = __ffs(status);
-		virq = irq_find_mapping(dom, base + hwirq);
-		if (virq)
-			generic_handle_irq(virq);
-		status &= ~BIT(hwirq);
-	}
-}
-
-static void tangox_irq_handler(struct irq_desc *desc)
-{
-	struct irq_domain *dom = irq_desc_get_handler_data(desc);
-	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	struct tangox_irq_chip *chip = dom->host_data;
-	unsigned int status_lo, status_hi;
-
-	chained_irq_enter(host_chip, desc);
-
-	status_lo = intc_readl(chip, chip->ctl + IRQ_STATUS);
-	status_hi = intc_readl(chip, chip->ctl + IRQ_CTL_HI + IRQ_STATUS);
-
-	tangox_dispatch_irqs(dom, status_lo, 0);
-	tangox_dispatch_irqs(dom, status_hi, 32);
-
-	chained_irq_exit(host_chip, desc);
-}
-
-static int tangox_irq_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct tangox_irq_chip *chip = gc->domain->host_data;
-	struct irq_chip_regs *regs = &gc->chip_types[0].regs;
-
-	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
-	case IRQ_TYPE_EDGE_RISING:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_SET, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_CLR, d->mask);
-		break;
-
-	case IRQ_TYPE_EDGE_FALLING:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_CLR, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_SET, d->mask);
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_CLR, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_CLR, d->mask);
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_SET, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_SET, d->mask);
-		break;
-
-	default:
-		pr_err("Invalid trigger mode %x for IRQ %d\n",
-		       flow_type, d->irq);
-		return -EINVAL;
-	}
-
-	return irq_setup_alt_chip(d, flow_type);
-}
-
-static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
-					unsigned long ctl_offs,
-					unsigned long edge_offs)
-{
-	struct tangox_irq_chip *chip = gc->domain->host_data;
-	struct irq_chip_type *ct = gc->chip_types;
-	unsigned long ctl_base = chip->ctl + ctl_offs;
-	unsigned long edge_base = EDGE_CTL_BASE + edge_offs;
-	int i;
-
-	gc->reg_base = chip->base;
-	gc->unused = 0;
-
-	for (i = 0; i < 2; i++) {
-		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
-		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
-		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
-		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
-		ct[i].chip.irq_set_type = tangox_irq_set_type;
-		ct[i].chip.name = gc->domain->name;
-
-		ct[i].regs.enable = ctl_base + IRQ_EN_SET;
-		ct[i].regs.disable = ctl_base + IRQ_EN_CLR;
-		ct[i].regs.ack = edge_base + EDGE_RAWSTAT;
-		ct[i].regs.type = edge_base;
-	}
-
-	ct[0].type = IRQ_TYPE_LEVEL_MASK;
-	ct[0].handler = handle_level_irq;
-
-	ct[1].type = IRQ_TYPE_EDGE_BOTH;
-	ct[1].handler = handle_edge_irq;
-
-	intc_writel(chip, ct->regs.disable, 0xffffffff);
-	intc_writel(chip, ct->regs.ack, 0xffffffff);
-}
-
-static void __init tangox_irq_domain_init(struct irq_domain *dom)
-{
-	struct irq_chip_generic *gc;
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		gc = irq_get_domain_generic_chip(dom, i * 32);
-		tangox_irq_init_chip(gc, i * IRQ_CTL_HI, i * EDGE_CTL_HI);
-	}
-}
-
-static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
-				  struct device_node *node)
-{
-	struct tangox_irq_chip *chip;
-	struct irq_domain *dom;
-	struct resource res;
-	int irq;
-	int err;
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq)
-		panic("%pOFn: failed to get IRQ", node);
-
-	err = of_address_to_resource(node, 0, &res);
-	if (err)
-		panic("%pOFn: failed to get address", node);
-
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	chip->ctl = res.start - baseres->start;
-	chip->base = base;
-
-	dom = irq_domain_add_linear(node, 64, &irq_generic_chip_ops, chip);
-	if (!dom)
-		panic("%pOFn: failed to create irqdomain", node);
-
-	err = irq_alloc_domain_generic_chips(dom, 32, 2, node->name,
-					     handle_level_irq, 0, 0, 0);
-	if (err)
-		panic("%pOFn: failed to allocate irqchip", node);
-
-	tangox_irq_domain_init(dom);
-
-	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
-
-	return 0;
-}
-
-static int __init tangox_of_irq_init(struct device_node *node,
-				     struct device_node *parent)
-{
-	struct device_node *c;
-	struct resource res;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base)
-		panic("%pOFn: of_iomap failed", node);
-
-	of_address_to_resource(node, 0, &res);
-
-	for_each_child_of_node(node, c)
-		tangox_irq_init(base, &res, c);
-
-	return 0;
-}
-IRQCHIP_DECLARE(tangox_intc, "sigma,smp8642-intc", tangox_of_irq_init);
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 8ccd32a0cc80..bd1d85c610aa 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -27,7 +27,7 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 /*
  * Run software resends of IRQ's
  */
-static void resend_irqs(unsigned long arg)
+static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
 	int irq;
@@ -45,7 +45,7 @@ static void resend_irqs(unsigned long arg)
 }
 
 /* Tasklet to handle resend: */
-static DECLARE_TASKLET_OLD(resend_tasklet, resend_irqs);
+static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {

