Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE245EA05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353647AbhKZJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:15:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31909 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKZJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:13:00 -0500
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J0ppr6SXyzcbNF;
        Fri, 26 Nov 2021 17:09:40 +0800 (CST)
Received: from localhost (10.175.101.6) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 17:09:43 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
        <chenweilong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH] cache: Workaround HiSilicon Taishan DC CVAU
Date:   Fri, 26 Nov 2021 17:11:39 +0800
Message-ID: <20211126091139.358114-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.31.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taishan's L1/L2 cache is inclusive, and the data is consistent.
Any change of L1 does not require DC operation to brush CL in L1 to L2.
It's safe that don't clean data cache by address to point of unification.

Without IDC featrue, kernel needs to flush icache as well as dcache,
causes performance degradation.

The flaw refers to V110/V200 variant 1.

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 11 +++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 32 ++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 5 files changed, 48 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 5342e895fb60..5fe577eed65f 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -158,6 +158,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | TSV{110,200}    | #1980005        | HISILICON_ERRATUM_1980005   |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 517d26c8002d..8943a62ed643 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -913,6 +913,17 @@ config QCOM_QDF2400_ERRATUM_0065
 
 	  If unsure, say Y.
 
+config HISILICON_ERRATUM_1980005
+	bool "Hisilicon erratum IDC support"
+	default y
+	help
+	  The HiSilicon TSV100/200 SoC support idc but report wrong value to
+	  kernel. Any change of L1 does not require DC operation to brush CL in
+	  L1 to L2. It's safe that don't clean data cache by address to point of
+	  unification.
+
+	  If unsure, say Y.
+
 config QCOM_FALKOR_ERRATUM_E1041
 	bool "Falkor E1041: Speculative instruction fetches might cause errant memory access"
 	default y
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 19b8441aa8f2..86888a6381e0 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -101,6 +101,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_TSV200		0xD02
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -135,6 +136,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_TSV200 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV200)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9e1c1aef9ebd..b7daea3c14e9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -55,6 +55,29 @@ is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 	return model == entry->midr_range.model;
 }
 
+#ifdef CONFIG_HISILICON_ERRATUM_1980005
+static bool
+hisilicon_1980005_match(const struct arm64_cpu_capabilities *entry,
+		int scope)
+{
+	static const struct midr_range idc_support_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
+		MIDR_REV(MIDR_HISI_TSV200, 1, 0),
+		{ /* sentinel */ }
+	};
+
+	return  is_midr_in_range_list(read_cpuid_id(), idc_support_list);
+}
+
+static void
+hisilicon_1980005_enable(const struct arm64_cpu_capabilities *__unused)
+{
+	cpus_set_cap(ARM64_HAS_CACHE_IDC);
+	arm64_ftr_reg_ctrel0.sys_val |= BIT(CTR_IDC_SHIFT);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
+}
+#endif
+
 static bool
 has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 			  int scope)
@@ -450,6 +473,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.cpu_enable = cpu_enable_trap_ctr_access,
 	},
+#ifdef CONFIG_HISILICON_ERRATUM_1980005
+	{
+		.desc = "Taishan IDC coherence workaround",
+		.capability = ARM64_WORKAROUND_HISILICON_1980005,
+		.matches = hisilicon_1980005_match,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.cpu_enable = hisilicon_1980005_enable,
+	},
+#endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
 	{
 		.desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 870c39537dd0..d47f4904d589 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -69,3 +69,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
+WORKAROUND_HISILICON_1980005
-- 
2.31.GIT

