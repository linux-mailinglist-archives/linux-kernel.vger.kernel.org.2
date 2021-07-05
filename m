Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32803BB711
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 08:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhGEGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 02:11:56 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8928 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhGEGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 02:11:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16565EuQ006018;
        Sun, 4 Jul 2021 23:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=33eQwvG8bLKJ0tnKhOhm2VEEq98utnW5E4rVKJCM+p0=;
 b=M4MuDIeXZlR/96wjyFFYRBUU/PT0t67izcmHPeT2/q/Qu0DD8sPUufmVckuRvlwNUC1y
 nBphYhNEZVI8NQ0wSYyhc32YblWN4eUEDPlF/lnqsUfLoncz4k9gKnrwFeM5fuvKVafa
 iBKeDOSG69FJU978bo/RYP9ScC4PCL3leSuTVUJ7wvVIrRhPXCBszXr73Gi5Pf9n/Xwi
 fIC9c1OFzbMcSPpva/r+5C4H9pqh48NopfwxpCcYUlTDjUxF3w9XlrnqBJF0ppzuDooL
 8u4tWtdCU8MEACKqdAgdKIrJSkQfVqs8wRl4YWcM5Cmz1MW8tyJfpPVIb6huEUTzTxUo jg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 39kt2m8e0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 23:08:56 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 4 Jul
 2021 23:08:54 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 4 Jul 2021 23:08:50 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <daniel.lezcano@linaro.org>, <mark.rutland@arm.com>,
        <maz@kernel.org>, <konrad.dybcio@somainline.org>,
        <saiprakash.ranjan@codeaurora.org>, <robh@kernel.org>,
        <marcan@marcan.st>, <suzuki.poulose@arm.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH] clocksource: Add Marvell Errata-38627 workaround
Date:   Mon, 5 Jul 2021 11:38:43 +0530
Message-ID: <20210705060843.3150-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t8f2rBwS1Ya8t-FOmmK4gt7YWaopi8_X
X-Proofpoint-GUID: t8f2rBwS1Ya8t-FOmmK4gt7YWaopi8_X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_03:2021-07-02,2021-07-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU pipeline have unpredicted behavior when timer
interrupt appears and then disappears prior to the
exception happening. Time interrupt appears on timer
expiry and disappears when timer programming or timer
disable. This typically can happen when a load
instruction misses in the cache,  which can take
few hundreds of cycles, and an interrupt appears
after the load instruction starts executing but
disappears before the load instruction completes.

Workaround of this is to ensure maximum 2us of time
gap between timer interrupt and timer programming
which can de-assert timer interrupt.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 arch/arm64/include/asm/cputype.h     | 13 +++++++
 arch/arm64/kernel/cpu_errata.c       | 24 +++++++++++++
 arch/arm64/tools/cpucaps             |  1 +
 drivers/clocksource/Kconfig          | 13 +++++++
 drivers/clocksource/arm_arch_timer.c | 54 ++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 6231e1f0abe7..e9a76935ee0f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,6 +81,13 @@
 #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
 #define CAVIUM_CPU_PART_THUNDERX2	0x0AF
 
+#define MRVL_CPU_PART_OCTEONTX2_98XX    0x0B1
+#define MRVL_CPU_PART_OCTEONTX2_96XX    0x0B2
+#define MRVL_CPU_PART_OCTEONTX2_95XX    0x0B3
+#define MRVL_CPU_PART_OCTEONTX2_LOKI    0x0B4
+#define MRVL_CPU_PART_OCTEONTX2_95MM    0x0B5
+#define MRVL_CPU_PART_OCTEONTX2_95O     0x0B6
+
 #define BRCM_CPU_PART_BRAHMA_B53	0x100
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -117,6 +124,12 @@
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_MRVL_OCTEONTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_98XX)
+#define MIDR_MRVL_OCTEONTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_96XX)
+#define MIDR_MRVL_OCTEONTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95XX)
+#define MIDR_MRVL_OCTEONTX2_LOKI MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_LOKI)
+#define MIDR_MRVL_OCTEONTX2_95MM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95MM)
+#define MIDR_MRVL_OCTEONTX2_95O MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, MRVL_CPU_PART_OCTEONTX2_95O)
 #define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
 #define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e2c20c036442..363f83adb333 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -339,6 +339,23 @@ static const struct midr_range erratum_1463225[] = {
 	{},
 };
 #endif
+#ifdef CONFIG_MARVELL_ERRATUM_38627
+static const struct midr_range marvell_erratum_38627_cpus[] = {
+	/* Marvell OcteonTX 2, 95xx all passes */
+	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95XX),
+	/* Marvell OcteonTX 2, 95MM all passes */
+	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_95MM),
+	/* Marvell OcteonTX 2, LOKI all passes */
+	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_LOKI),
+	/* Marvell OcteonTX 2, 96xx all passes */
+	MIDR_ALL_VERSIONS(MIDR_MRVL_OCTEONTX2_96XX),
+	/* Marvell OcteonTX 2, 98xx pass 1.0 */
+	MIDR_REV(MIDR_MRVL_OCTEONTX2_98XX, 0, 0),
+	/* Marvell OcteonTX 2, 95O pass 1.0 */
+	MIDR_REV(MIDR_MRVL_OCTEONTX2_95O, 0, 0),
+	{},
+};
+#endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
@@ -439,6 +456,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_858921,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	},
+#endif
+#ifdef CONFIG_MARVELL_ERRATUM_38627
+	{
+		.desc = "MARVELL erratum 38627",
+		.capability = ARM64_WORKAROUND_MRVL_38627,
+		ERRATA_MIDR_RANGE_LIST(marvell_erratum_38627_cpus),
+	},
 #endif
 	{
 		.desc = "Spectre-v2",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 49305c2e6dfd..99dbe80445ef 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -60,6 +60,7 @@ WORKAROUND_CAVIUM_TX2_219_PRFM
 WORKAROUND_CAVIUM_TX2_219_TVM
 WORKAROUND_CLEAN_CACHE
 WORKAROUND_DEVICE_LOAD_ACQUIRE
+WORKAROUND_MRVL_38627
 WORKAROUND_NVIDIA_CARMEL_CNP
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eb661b539a3e..83feb502cf02 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -309,6 +309,19 @@ config ARM_ARCH_TIMER_EVTSTREAM
 config ARM_ARCH_TIMER_OOL_WORKAROUND
 	bool
 
+config MARVELL_ERRATUM_38627
+	bool "Workaround for Marvell Erratum 38627"
+	default y
+	depends on ARM_ARCH_TIMER && ARM64
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	help
+	  This option enables a workaround for Marvell Erratum
+	  38627. According to this errata CPU pipeline have
+	  unpredicted behavior when timer interrupt appears and
+	  then disappears prior to the exception happening.
+	  This Errata workaround is applicable only to some Marvell
+	  OcteonTX2 series of processors.
+
 config FSL_ERRATUM_A008585
 	bool "Workaround for Freescale/NXP Erratum A-008585"
 	default y
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index be6d741d404c..d1c5e2aa2e7c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -27,6 +27,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <linux/delay.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -88,6 +89,8 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
+static __always_inline void set_next_event(const int access, unsigned long evt,
+					   struct clock_event_device *clk);
 
 static int __init early_evtstrm_cfg(char *buf)
 {
@@ -432,6 +435,48 @@ static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
 	return 0;
 }
 
+#ifdef CONFIG_MARVELL_ERRATUM_38627
+/* Workaround is to ensure maximum 2us of time gap between timer expiry
+ * and timer programming which can de-assert timer interrupt.
+ * Time calculation below is based on 100MHz as timer frequency is fixed
+ * to 100MHz on all affected parts.
+ */
+static __always_inline
+void erratum_38627_set_next_event(const int access, unsigned long evt,
+				  struct clock_event_device *clk)
+{
+	int32_t tval;
+
+	tval = arch_timer_reg_read(access, ARCH_TIMER_REG_TVAL, clk);
+
+	/* Timer already expired, wait for (2 - expired time)us */
+	if ((tval > -200) && (tval < 0))
+		udelay(2 + tval/100);
+
+	/* Timer is about to expire, wait for 2us + time to expire */
+	if (tval >= 0 && tval < 200)
+		udelay(3 + tval/100);
+
+	set_next_event(access, evt, clk);
+}
+
+static __maybe_unused
+int erratum_38627_set_next_event_tval_virt(unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	erratum_38627_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	return 0;
+}
+
+static __maybe_unused
+int erratum_38627_set_next_event_tval_phys(unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	erratum_38627_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	return 0;
+}
+#endif
+
 static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 #ifdef CONFIG_FSL_ERRATUM_A008585
 	{
@@ -479,6 +524,15 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
 	},
 #endif
+#ifdef CONFIG_MARVELL_ERRATUM_38627
+	{
+		.match_type = ate_match_local_cap_id,
+		.id = (void *)ARM64_WORKAROUND_MRVL_38627,
+		.desc = "Marvell erratum 38627",
+		.set_next_event_phys = erratum_38627_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_38627_set_next_event_tval_virt,
+	},
+#endif
 #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
 	{
 		.match_type = ate_match_dt,
-- 
2.17.1

