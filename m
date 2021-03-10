Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD9334357
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhCJQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhCJQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:43:46 -0500
IronPort-SDR: v4kCMG+y3lrGAjN4lIKU9dQVPyeeOGomfu0JiROhVWxieAs1yawUwT/OpsrhMVvAnztPRjeVk3
 rQtYvsaqJo7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546418"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:43:46 -0800
IronPort-SDR: hPkZ1gyFlKSHVo6ZyA66KePnUwZrk7AU4QSjcjtDLl/1DR/JxmUrpd+DaBOl+CPPeZaVMIlA3R
 rcfrb3Xq8FHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729049"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:43:45 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH V2 2/25] x86/cpu: Add helper functions to get parameters of hybrid CPUs
Date:   Wed, 10 Mar 2021 08:37:38 -0800
Message-Id: <1615394281-68214-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

On processors with Intel Hybrid Technology (i.e., one having more than one
type of CPU in the same package), all CPUs support the same instruction
set and enumerate the same features on CPUID. Thus, all software can run
on any CPU without restrictions. However, there may be model-specific
differences among types of CPUs. For instance, each type of CPU may support
a different number of performance counters. Also, machine check error banks
may be wired differently. Even though most software will not care about
these differences, kernel subsystems dealing with these differences must
know. Add a new member to cpuinfo_x86 that subsystems can query to know
the type of CPU.

Hybrid processors also have a native model ID to uniquely identify the
micro-architecture of each CPU. Please note that the native model ID is not
related with the existing x86_model_id read from CPUID leaf 0x1.

Add helper functions and definitions to get both the CPU type and the
combined CPU type and native model ID. Only expose get_hybrid_cpu_type().
The sole known use case (i.e., perf for hybrid processors) only wants to
know the type but not the model ID. get_hybrid_params() can be exposed in
the future if new use cases arise.

The Intel Software Developer's Manual defines the CPU type and the CPU
native model ID as 8-bit and 24-bit identifiers, respectively.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1 (as part of patchset for perf change for Alderlake)
 * Removed cpuinfo_x86.x86_cpu_type. It can be added later if needed.
   Instead, implement helper functions that subsystems can use.(Boris)
 * Add definitions for Atom and Core CPU types. (Kan)

Changes since v1 (in a separate posting)
 * Simplify code by using cpuid_eax(). (Boris)
 * Reworded the commit message to clarify the concept of Intel Hybrid
   Technology. Stress that all CPUs can run the same instruction set
   and support the same features.
---
 arch/x86/include/asm/cpu.h          |  6 ++++
 arch/x86/include/asm/intel-family.h |  4 +++
 arch/x86/include/asm/processor.h    |  3 ++
 arch/x86/kernel/cpu/intel.c         | 44 +++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..845c478dfcd4 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -45,6 +45,7 @@ extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+u8 get_hybrid_cpu_type(int cpu);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -57,6 +58,11 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline u8 get_hybrid_cpu_type(int cpu)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9abe842dbd84..b5fb475bdf10 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -134,4 +134,8 @@
 /* Family 5 */
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 
+/* Types of CPUs in hybrid parts. */
+#define INTEL_HYBRID_TYPE_ATOM		0x20
+#define INTEL_HYBRID_TYPE_CORE		0x40
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149bf851..d43d7a11afba 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -166,6 +166,9 @@ enum cpuid_regs_idx {
 
 #define X86_VENDOR_UNKNOWN	0xff
 
+#define X86_HYBRID_CPU_TYPE_ID_SHIFT		24
+#define X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK	0xffffff
+
 /*
  * capabilities of CPUs
  */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a544835..aa0dac287c1f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1195,3 +1195,47 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	cpu_model_supports_sld = true;
 	split_lock_setup();
 }
+
+static void read_hybrid_params(void *data)
+{
+	u32 *eax = data;
+
+	*eax = cpuid_eax(0x0000001a);
+}
+
+/**
+ * get_hybrid_params() - Get type and model ID of a hybrid CPU
+ * @cpu:	CPU of which hybrid parameters are queried.
+ *
+ * Returns the combined CPU type [31:24] and the native model ID [23:0] of a
+ * CPU in a hybrid processor. It must be called with preemption disabled.
+ * If @cpu is invalid or the processor is not hybrid, returns 0;
+ */
+static u32 get_hybrid_params(int cpu)
+{
+	u32 param;
+
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return 0;
+
+	if (cpu == smp_processor_id())
+		return cpuid_eax(0x0000001a);
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return 0;
+
+	smp_call_function_single(cpu, read_hybrid_params, &param, true);
+
+	return param;
+}
+
+/**
+ * get_hybrid_cpu_type() - Get the type of a hybrid CPU
+ *
+ * Returns the type (i.e., Atom or Core) of a CPU in a hybrid processor. It
+ * must be called with preemption disabled.
+ */
+u8 get_hybrid_cpu_type(int cpu)
+{
+	return get_hybrid_params(cpu) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
+}
-- 
2.17.1

