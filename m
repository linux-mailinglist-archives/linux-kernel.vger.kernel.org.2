Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF13313C26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhBHSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:03:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:62781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhBHPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:31:49 -0500
IronPort-SDR: HMQ55p8YlWXuTNSym4n2gOoWDiZgqQQdpL7TKhLpeERMZKwlqwzsSADb13ZlMZUX8mQQHkl8N1
 QLVh8S1oxusw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951894"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:29:59 -0800
IronPort-SDR: 47qONyugHmsaVzdgUrUe196BdkvkZSxgd+3uGimPPEPctayFGVUI/8/a90vD3yRJz2TV6ad8Ju
 rPzkTuxnb5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820489"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:29:59 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 02/49] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Date:   Mon,  8 Feb 2021 07:24:59 -0800
Message-Id: <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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

In order to uniquely identify a CPU by type and micro-architecture, combine
the aforementioned identifiers into a single new member, x86_cpu_type.

Define also masks that subsystems can use to obtain the CPU type or native
model separately.

The Intel Software Developer's Manual defines the CPU type and the CPU
native model ID as 8-bit and 24-bit identifiers, respectively.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/processor.h | 13 +++++++++++++
 arch/x86/kernel/cpu/common.c     |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b..1f25ac9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -139,6 +139,16 @@ struct cpuinfo_x86 {
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
+	/*
+	 * In hybrid processors, there is a CPU type and a native model ID. The
+	 * CPU type (x86_cpu_type[31:24]) describes the type of micro-
+	 * architecture families. The native model ID (x86_cpu_type[23:0])
+	 * describes a specific microarchitecture version. Combining both
+	 * allows to uniquely identify a CPU.
+	 *
+	 * Please note that the native model ID is not related to x86_model.
+	 */
+	u32			x86_cpu_type;
 	unsigned		initialized : 1;
 } __randomize_layout;
 
@@ -166,6 +176,9 @@ enum cpuid_regs_idx {
 
 #define X86_VENDOR_UNKNOWN	0xff
 
+#define X86_HYBRID_CPU_TYPE_ID_SHIFT		24
+#define X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK	0xffffff
+
 /*
  * capabilities of CPUs
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad848..a66c1fd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -932,6 +932,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
+	if (cpu_has(c, X86_FEATURE_HYBRID_CPU))
+		c->x86_cpu_type = cpuid_eax(0x0000001a);
+
 	/* AMD-defined flags: level 0x80000001 */
 	eax = cpuid_eax(0x80000000);
 	c->extended_cpuid_level = eax;
-- 
2.7.4

