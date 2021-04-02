Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D916935244E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhDBARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:22890 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236360AbhDBARk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:40 -0400
IronPort-SDR: jalE5anH/Q5oP/XpSDCh1fgGAiVH+hrFpsrGU7OpLg6pX77Js1xhkl+8t6HoSTd1uxN/qCkjlN
 1hjKkaXCnGnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191837677"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="191837677"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:40 -0700
IronPort-SDR: w7p+cxuJXDD9PehZpT7+yd1mwKXedsWJuHv7Hz3n83VJgNmD+O7RVQierQqvLujsf4toclgUW5
 xs5b2OEnukiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399251"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:36 -0700
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
Subject: [PATCH V4 02/25] x86/cpu: Add helper function to get the type of the current hybrid CPU
Date:   Thu,  1 Apr 2021 17:10:29 -0700
Message-Id: <1617322252-154215-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

On processors with Intel Hybrid Technology (i.e., one having more than
one type of CPU in the same package), all CPUs support the same
instruction set and enumerate the same features on CPUID. Thus, all
software can run on any CPU without restrictions. However, there may be
model-specific differences among types of CPUs. For instance, each type
of CPU may support a different number of performance counters. Also,
machine check error banks may be wired differently. Even though most
software will not care about these differences, kernel subsystems
dealing with these differences must know.

Add and expose a new helper function get_this_hybrid_cpu_type() to query
the type of the current hybrid CPU. The function will be used later in
the perf subsystem.

The Intel Software Developer's Manual defines the CPU type as 8-bit
identifier.

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
Changes since v3 (as part of patchset for perf change for Alderlake)
 * None

Changes since v2 (as part of patchset for perf change for Alderlake)
 * Use get_this_hybrid_cpu_type() to replace get_hybrid_cpu_type() to
   avoid the trouble of IPIs. The new function retrieves the type of the
   current hybrid CPU. It's good enough for perf. (Dave)
 * Remove definitions for Atom and Core CPU types. Perf will define a
   enum for the hybrid CPU type in the perf_event.h (Peter)
 * Remove X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK. Not used in the patch
   set. (Kan)
 * Update the description accordingly. (Boris)

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
 arch/x86/include/asm/cpu.h       |  6 ++++++
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/intel.c      | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..610905d7e541 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -45,6 +45,7 @@ extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+u8 get_this_hybrid_cpu_type(void);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -57,6 +58,11 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline u8 get_this_hybrid_cpu_type(void)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149bf851..746512a68b30 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -166,6 +166,8 @@ enum cpuid_regs_idx {
 
 #define X86_VENDOR_UNKNOWN	0xff
 
+#define X86_HYBRID_CPU_TYPE_ID_SHIFT		24
+
 /*
  * capabilities of CPUs
  */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a544835..189fcbe16590 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1195,3 +1195,17 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	cpu_model_supports_sld = true;
 	split_lock_setup();
 }
+
+/**
+ * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
+ *
+ * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
+ * a hybrid processor. If the processor is not hybrid, returns 0.
+ */
+u8 get_this_hybrid_cpu_type(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return 0;
+
+	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
+}
-- 
2.17.1

