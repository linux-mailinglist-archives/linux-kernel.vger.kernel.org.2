Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53A3CF3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhGTEnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:43:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:5625 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237117AbhGTEm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:42:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211237210"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211237210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="496035649"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2021 22:23:02 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH V2 3/3] arm64: dts: add initial device tree for Thunder Bay SoC
Date:   Tue, 20 Jul 2021 10:52:49 +0530
Message-Id: <1626758569-27176-4-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
References: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>

Add initial device tree for Intel Movidius SoC code-named Thunder Bay.

This initial DT includes nodes for 4 CPU clusters with 4 Cortex-A53
cores per cluster, UARTs, GIC, ARM Timer and PSCI.

thunderbay-soc.dtsi   - Thunder Bay SoC dtsi file
hddl_hybrid_4s.dts    - Thunder Bay full configuration board dts
			with 4 VPU processors
hddl_hybrid_2s_02.dts - Thunder Bay prime configuration board dts with
			2 VPU processors (slice 0 and slice 2 enabled)
hddl_hybrid_2s_03.dts - Thunder Bay prime configuration board dts with
			2 VPU processors (slice 0 and slice 3 enabled)
hddl_hybrid_2s_12.dts - Thunder Bay prime configuration board dts with
			2 VPU processors (slice 1 and slice 2 enabled)
hddl_hybrid_2s_13.dts - Thunder Bay prime configuration board dts with
			2 VPU processors (slice 1 and slice 3 enabled)

Signed-off-by: Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
---
 MAINTAINERS                                     |   2 +
 arch/arm64/boot/dts/intel/Makefile              |   6 +
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts |  43 +++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts |  43 +++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts |  43 +++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts |  43 +++++
 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts    |  54 ++++++
 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi   | 243 ++++++++++++++++++++++++
 8 files changed, 477 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
 create mode 100644 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 041f9a0..68317f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1996,6 +1996,8 @@ ARM/INTEL THUNDERBAY ARCHITECTURE
 M:	Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
+F:	arch/arm64/boot/dts/intel/hddl*
+F:	arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
 
 ARM/INTEL XSC3 (MANZANO) ARM CORE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 0b54774..767b74b 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,3 +3,9 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
+
+dtb-$(CONFIG_ARCH_THUNDERBAY) += hddl_hybrid_4s.dtb \
+				 hddl_hybrid_2s_02.dtb \
+				 hddl_hybrid_2s_03.dtb \
+				 hddl_hybrid_2s_12.dtb \
+				 hddl_hybrid_2s_13.dtb
diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
new file mode 100644
index 0000000..f907ddd
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Intel Thunder Bay Hybrid HDDL Prime configuration
+ * board.
+ *
+ * DDR 8GB + 4GB with vpu slice 0 and vpu slice 2
+ */
+
+/dts-v1/;
+
+#include "thunderbay-soc.dtsi"
+
+/ {
+	model = "Intel Thunder Bay Hybrid HDDL Prime Board";
+	compatible = "intel,thunderbay";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@100A000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x10 0x0A000000 0x2 0x0>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x12 0x0 0x1 0x0>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
new file mode 100644
index 0000000..01a3d4c
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Intel Thunder Bay Hybrid HDDL Prime configuration
+ * board
+ *
+ * DDR 8GB + 4GB with vpu slice 0 and vpu slice 3
+ */
+
+/dts-v1/;
+
+#include "thunderbay-soc.dtsi"
+
+/ {
+	model = "Intel Thunder Bay Hybrid HDDL Prime Board";
+	compatible = "intel,thunderbay";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@100A000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x10 0x0A000000 0x2 0x0>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x12 0x0 0x1 0x0>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
new file mode 100644
index 0000000..e31db16
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Intel Thunder Bay Hybrid HDDL Prime configuration
+ * board
+ *
+ * DDR 8GB + 4GB with vpu slice 1 and vpu slice 2
+ */
+
+/dts-v1/;
+
+#include "thunderbay-soc.dtsi"
+
+/ {
+	model = "Intel Thunder Bay Hybrid HDDL Prime Board";
+	compatible = "intel,thunderbay";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@100A000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x10 0x0A000000 0x2 0x0>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x12 0x0 0x1 0x0>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
new file mode 100644
index 0000000..6529664
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Intel Thunder Bay Hybrid HDDL Prime configuration
+ * board
+ *
+ * DDR 8GB + 4GB with vpu slice 1 and vpu slice 3
+ */
+
+/dts-v1/;
+
+#include "thunderbay-soc.dtsi"
+
+/ {
+	model = "Intel Thunder Bay Hybrid HDDL Prime Board";
+	compatible = "intel,thunderbay";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@100A000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x10 0x0A000000 0x2 0x0>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x12 0x0 0x1 0x0>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts b/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
new file mode 100644
index 0000000..561ecea
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Intel Thunder Bay Hybrid HDDL Full configuration
+ * board
+ *
+ * DDR 8GB + 8GB + 4GB + 4GB with four vpu slices
+ */
+
+/dts-v1/;
+
+#include "thunderbay-soc.dtsi"
+
+/ {
+	model = "Intel Thunder Bay Hybrid HDDL Full Board";
+	compatible = "intel,thunderbay";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@100A000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x10 0x0A000000 0x2 0x0>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		/* 8GB of DDR memory */
+		reg = <0x12 0x0 0x2 0x0>;
+	};
+
+	memory@1400000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x14 0x0 0x1 0x0>;
+	};
+
+	memory@1500000000 {
+		device_type = "memory";
+		/* 4GB of DDR memory */
+		reg = <0x15 0x0 0x1 0x0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi b/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
new file mode 100644
index 0000000..834200d
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021 Intel Corporation.
+ *
+ * Device tree describing Thunder Bay SoC
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+
+	compatible = "intel,thunderbay";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+				core1 {
+					cpu = <&CPU5>;
+				};
+				core2 {
+					cpu = <&CPU6>;
+				};
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&CPU8>;
+				};
+				core1 {
+					cpu = <&CPU9>;
+				};
+				core2 {
+					cpu = <&CPU10>;
+				};
+				core3 {
+					cpu = <&CPU11>;
+				};
+			};
+			cluster3 {
+				core0 {
+					cpu = <&CPU12>;
+				};
+				core1 {
+					cpu = <&CPU13>;
+				};
+				core2 {
+					cpu = <&CPU14>;
+				};
+				core3 {
+					cpu = <&CPU15>;
+				};
+			};
+		};
+
+		CPU0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		CPU1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		CPU2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		CPU3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+
+		CPU4: cpu@100 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		CPU5: cpu@101 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+
+		CPU6: cpu@102 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+
+		CPU7: cpu@103 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+
+		CPU8: cpu@200 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		CPU9: cpu@201 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x201>;
+			enable-method = "psci";
+		};
+
+		CPU10: cpu@202 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x202>;
+			enable-method = "psci";
+		};
+
+		CPU11: cpu@203 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x203>;
+			enable-method = "psci";
+		};
+
+		CPU12: cpu@300 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
+
+		CPU13: cpu@301 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x301>;
+			enable-method = "psci";
+		};
+
+		CPU14: cpu@302 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x302>;
+			enable-method = "psci";
+		};
+
+		CPU15: cpu@303 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x303>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller@88400000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x0 0x88400000 0x0 0x200000>,	/* GICD */
+		      <0x0 0x88600000 0x0 0x200000>;	/* GICR */
+		/* VGIC maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		/* Secure, non-secure, virtual, and hypervisor */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges;
+
+		uart0: serial@80460000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x80460000 0x0 0x100>;
+			interrupts = <GIC_SPI 725 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <50000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart1: serial@80470000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x80470000 0x0 0x100>;
+			interrupts = <GIC_SPI 724 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <50000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4

