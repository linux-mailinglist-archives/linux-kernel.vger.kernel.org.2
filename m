Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95573345DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCWMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:08:27 -0400
Received: from foss.arm.com ([217.140.110.172]:45164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhCWMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:07:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0BA106F;
        Tue, 23 Mar 2021 05:07:30 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF5F33F719;
        Tue, 23 Mar 2021 05:07:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 12/19] coresight: ete: Add support for ETE tracing
Date:   Tue, 23 Mar 2021 12:06:40 +0000
Message-Id: <20210323120647.454211-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210323120647.454211-1-suzuki.poulose@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ETE as one of the supported device types we support
with ETM4x driver. The devices are named following the
existing convention as ete<N>.

ETE mandates that the trace resource status register is programmed
before the tracing is turned on. For the moment simply write to
it indicating TraceActive.

ETE shares most of the registers with ETMv4 except for some and
also adds some new registers. Re-arrange the ETMv4x list
to share the common definitions and add the ETE sysreg support.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4:
 - Make ete sysreg read/write static (kernel test robot)
 - Squashed ETE sysreg support patch to this one.
 - Write 0 to TRCSTATR
---
 drivers/hwtracing/coresight/Kconfig           | 10 +--
 .../coresight/coresight-etm4x-core.c          | 90 ++++++++++++++++---
 .../coresight/coresight-etm4x-sysfs.c         | 19 +++-
 drivers/hwtracing/coresight/coresight-etm4x.h | 66 ++++++++++++--
 4 files changed, 155 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 7b44ba22cbe1..f154ae7e705d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -97,15 +97,15 @@ config CORESIGHT_SOURCE_ETM3X
 	  module will be called coresight-etm3x.
 
 config CORESIGHT_SOURCE_ETM4X
-	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
+	tristate "CoreSight ETMv4.x / ETE driver"
 	depends on ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	select PID_IN_CONTEXTIDR
 	help
-	  This driver provides support for the ETM4.x tracer module, tracing the
-	  instructions that a processor is executing. This is primarily useful
-	  for instruction level tracing. Depending on the implemented version
-	  data tracing may also be available.
+	  This driver provides support for the CoreSight Embedded Trace Macrocell
+	  version 4.x and the Embedded Trace Extensions (ETE). Both are CPU tracer
+	  modules, tracing the instructions that a processor is executing. This is
+	  primarily useful for instruction level tracing.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-etm4x.
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 35802caca32a..efb84ced83dd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -115,6 +115,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 	}
 }
 
+static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
+{
+	u64 res = 0;
+
+	switch (offset) {
+	ETE_READ_CASES(res)
+	default :
+		pr_warn_ratelimited("ete: trying to read unsupported register @%x\n",
+				    offset);
+	}
+
+	if (!_relaxed)
+		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+
+	return res;
+}
+
+static void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
+{
+	if (!_relaxed)
+		__iowmb();	/* Imitate the !relaxed I/O helpers */
+	if (!_64bit)
+		val &= GENMASK(31, 0);
+
+	switch (offset) {
+	ETE_WRITE_CASES(val)
+	default :
+		pr_warn_ratelimited("ete: trying to write to unsupported register @%x\n",
+				    offset);
+	}
+}
+
 static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
 			       struct csdev_access *csa)
 {
@@ -401,6 +433,13 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
 	}
 
+	/*
+	 * ETE mandates that the TRCRSR is written to before
+	 * enabling it.
+	 */
+	if (etm4x_is_ete(drvdata))
+		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
+
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
@@ -862,13 +901,24 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
 	 * ETMs implementing sysreg access must implement TRCDEVARCH.
 	 */
 	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
-	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
+	switch (devarch & ETM_DEVARCH_ID_MASK) {
+	case ETM_DEVARCH_ETMv4x_ARCH:
+		*csa = (struct csdev_access) {
+			.io_mem	= false,
+			.read	= etm4x_sysreg_read,
+			.write	= etm4x_sysreg_write,
+		};
+		break;
+	case ETM_DEVARCH_ETE_ARCH:
+		*csa = (struct csdev_access) {
+			.io_mem	= false,
+			.read	= ete_sysreg_read,
+			.write	= ete_sysreg_write,
+		};
+		break;
+	default:
 		return false;
-	*csa = (struct csdev_access) {
-		.io_mem	= false,
-		.read	= etm4x_sysreg_read,
-		.write	= etm4x_sysreg_write,
-	};
+	}
 
 	drvdata->arch = etm_devarch_to_arch(devarch);
 	return true;
@@ -1809,6 +1859,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	struct etmv4_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
+	u8 major, minor;
+	char *type_name;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1835,10 +1887,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (drvdata->cpu < 0)
 		return drvdata->cpu;
 
-	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
-	if (!desc.name)
-		return -ENOMEM;
-
 	init_arg.drvdata = drvdata;
 	init_arg.csa = &desc.access;
 	init_arg.pid = etm_pid;
@@ -1855,6 +1903,22 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
+	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
+	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
+
+	if (etm4x_is_ete(drvdata)) {
+		type_name = "ete";
+		/* ETE v1 has major version == 0b101. Adjust this for logging.*/
+		major -= 4;
+	} else {
+		type_name = "etm";
+	}
+
+	desc.name = devm_kasprintf(dev, GFP_KERNEL,
+				   "%s%d", type_name, drvdata->cpu);
+	if (!desc.name)
+		return -ENOMEM;
+
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
@@ -1882,9 +1946,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
-		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
-		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
+	dev_info(&drvdata->csdev->dev, "CPU%d: %s v%d.%d initialized\n",
+		 drvdata->cpu, type_name, major, minor);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -2027,6 +2090,7 @@ static struct amba_driver etm4x_amba_driver = {
 
 static const struct of_device_id etm4_sysreg_match[] = {
 	{ .compatible	= "arm,coresight-etm4x-sysreg" },
+	{ .compatible	= "arm,embedded-trace-extension" },
 	{}
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 0995a10790f4..007bad9e7ad8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2374,12 +2374,20 @@ static inline bool
 etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
 {
 	switch (offset) {
-	ETM4x_SYSREG_LIST_CASES
+	ETM_COMMON_SYSREG_LIST_CASES
 		/*
-		 * Registers accessible via system instructions are always
-		 * implemented.
+		 * Common registers to ETE & ETM4x accessible via system
+		 * instructions are always implemented.
 		 */
 		return true;
+
+	ETM4x_ONLY_SYSREG_LIST_CASES
+		/*
+		 * We only support etm4x and ete. So if the device is not
+		 * ETE, it must be ETMv4x.
+		 */
+		return !etm4x_is_ete(drvdata);
+
 	ETM4x_MMAP_LIST_CASES
 		/*
 		 * Registers accessible only via memory-mapped registers
@@ -2389,8 +2397,13 @@ etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
 		 * coresight_register() and the csdev is not initialized
 		 * until that is done. So rely on the drvdata->base to
 		 * detect if we have a memory mapped access.
+		 * Also ETE doesn't implement memory mapped access, thus
+		 * it is sufficient to check that we are using mmio.
 		 */
 		return !!drvdata->base;
+
+	ETE_ONLY_SYSREG_LIST_CASES
+		return etm4x_is_ete(drvdata);
 	}
 
 	return false;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5b961c5b78d1..e5b79bdb9851 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -29,6 +29,7 @@
 #define TRCAUXCTLR			0x018
 #define TRCEVENTCTL0R			0x020
 #define TRCEVENTCTL1R			0x024
+#define TRCRSR				0x028
 #define TRCSTALLCTLR			0x02C
 #define TRCTSCTLR			0x030
 #define TRCSYNCPR			0x034
@@ -49,6 +50,7 @@
 #define TRCSEQRSTEVR			0x118
 #define TRCSEQSTR			0x11C
 #define TRCEXTINSELR			0x120
+#define TRCEXTINSELRn(n)		(0x120 + (n * 4)) /* n = 0-3 */
 #define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
 #define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
 #define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
@@ -126,6 +128,8 @@
 #define TRCCIDR2			0xFF8
 #define TRCCIDR3			0xFFC
 
+#define TRCRSR_TA			BIT(12)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -160,10 +164,22 @@
 #define CASE_NOP(__unused, x)					\
 	case (x):	/* fall through */
 
+#define ETE_ONLY_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCRSR)		\
+	CASE_##op((val), TRCEXTINSELRn(1))	\
+	CASE_##op((val), TRCEXTINSELRn(2))	\
+	CASE_##op((val), TRCEXTINSELRn(3))
+
 /* List of registers accessible via System instructions */
-#define ETM_SYSREG_LIST(op, val)		\
-	CASE_##op((val), TRCPRGCTLR)		\
+#define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCOSLAR)
+
+#define ETM_COMMON_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCPRGCTLR)		\
 	CASE_##op((val), TRCSTATR)		\
 	CASE_##op((val), TRCCONFIGR)		\
 	CASE_##op((val), TRCAUXCTLR)		\
@@ -180,9 +196,6 @@
 	CASE_##op((val), TRCVIIECTLR)		\
 	CASE_##op((val), TRCVISSCTLR)		\
 	CASE_##op((val), TRCVIPCSSCTLR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCSEQEVRn(0))		\
 	CASE_##op((val), TRCSEQEVRn(1))		\
 	CASE_##op((val), TRCSEQEVRn(2))		\
@@ -277,7 +290,6 @@
 	CASE_##op((val), TRCSSPCICRn(5))	\
 	CASE_##op((val), TRCSSPCICRn(6))	\
 	CASE_##op((val), TRCSSPCICRn(7))	\
-	CASE_##op((val), TRCOSLAR)		\
 	CASE_##op((val), TRCOSLSR)		\
 	CASE_##op((val), TRCACVRn(0))		\
 	CASE_##op((val), TRCACVRn(1))		\
@@ -369,12 +381,38 @@
 	CASE_##op((val), TRCPIDR2)		\
 	CASE_##op((val), TRCPIDR3)
 
-#define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
-#define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
+#define ETM4x_READ_SYSREG_CASES(res)		\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETM4x_ONLY_SYSREG_LIST(READ, (res))
+
+#define ETM4x_WRITE_SYSREG_CASES(val)		\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETM4x_ONLY_SYSREG_LIST(WRITE, (val))
+
+#define ETM_COMMON_SYSREG_LIST_CASES		\
+	ETM_COMMON_SYSREG_LIST(NOP, __unused)
+
+#define ETM4x_ONLY_SYSREG_LIST_CASES		\
+	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
+
+#define ETM4x_SYSREG_LIST_CASES			\
+	ETM_COMMON_SYSREG_LIST_CASES		\
+	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
 
-#define ETM4x_SYSREG_LIST_CASES		ETM_SYSREG_LIST(NOP, __unused)
 #define ETM4x_MMAP_LIST_CASES		ETM_MMAP_LIST(NOP, __unused)
 
+/* ETE only supports system register access */
+#define ETE_READ_CASES(res)			\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETE_ONLY_SYSREG_LIST(READ, (res))
+
+#define ETE_WRITE_CASES(val)			\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETE_ONLY_SYSREG_LIST(WRITE, (val))
+
+#define ETE_ONLY_SYSREG_LIST_CASES		\
+	ETE_ONLY_SYSREG_LIST(NOP, __unused)
+
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
 	({									\
 		u64 __val;							\
@@ -555,11 +593,14 @@
 	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
 
 #define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
+#define ETM_DEVARCH_ARCHID_ETE			ETM_DEVARCH_MAKE_ARCHID(0x5)
 
 #define ETM_DEVARCH_ID_MASK						\
 	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
 #define ETM_DEVARCH_ETMv4x_ARCH						\
 	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | ETM_DEVARCH_PRESENT)
+#define ETM_DEVARCH_ETE_ARCH						\
+	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT)
 
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
@@ -649,6 +690,8 @@
 #define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
 
 #define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
+#define ETM_ARCH_ETE	ETM_ARCH_VERSION(5, 0)
+
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
 
@@ -957,4 +1000,9 @@ void etm4_config_trace_mode(struct etmv4_config *config);
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
+
+static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
+{
+	return drvdata->arch >= ETM_ARCH_ETE;
+}
 #endif
-- 
2.24.1

