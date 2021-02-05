Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1903118CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBFCpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:45:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:27740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhBFCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:33:39 -0500
IronPort-SDR: BNg1PrJWelZBQKO9oQ6Xz5vp3ZFc21iWYGF2+dLxSY3SB7cieaq4X4+oJkUoLtKkRnC5vMmmS3
 tLF8eZ6J3Prw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650748"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650748"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:14 -0800
IronPort-SDR: jSNiuBxmrqn/RsltXINj8h4E65VM46er/XBtMzwXRdZVUhP2XZOqcO34WjM21o+DSoT+NQQLXL
 funX/DpyRPdQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183958"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:13 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 18/26] x86/topology: Disable CPU hotplug support for TDX platforms.
Date:   Fri,  5 Feb 2021 15:38:35 -0800
Message-Id: <1004f13441b0a1e5ce9547a547e32d05bc7b9f80.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Intel TDX Virtual Firmware Design Guide, sec 4.3.5 and
sec 9.4, all unused CPUs are put in spinning state by
TDVF until OS requests for CPU bring-up via mailbox address passed
by ACPI MADT table. Since by default all unused CPUs are always in
spinning state, there is no point in supporting dynamic CPU
online/offline feature. So current generation of TDVF does not
support CPU hotplug feature. It may be supported in next generation.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/tdx.c      | 14 ++++++++++++++
 arch/x86/kernel/topology.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 8d1d7555fb56..a36b6ae14942 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -387,6 +387,17 @@ static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return insn.length;
 }
 
+static int tdx_cpu_offline_prepare(unsigned int cpu)
+{
+	/*
+	 * Per Intel TDX Virtual Firmware Design Guide,
+	 * sec 4.3.5 and sec 9.4, Hotplug is not supported
+	 * in TDX platforms. So don't support CPU
+	 * offline feature once its turned on.
+	 */
+	return -EOPNOTSUPP;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -399,6 +410,9 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdx_safe_halt;
 	pv_ops.irq.halt = tdx_halt;
 
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
+			  NULL, tdx_cpu_offline_prepare);
+
 	pr_info("TDX guest is initialized\n");
 }
 
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index f5477eab5692..d879ea96d79c 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -34,6 +34,7 @@
 #include <linux/irq.h>
 #include <asm/io_apic.h>
 #include <asm/cpu.h>
+#include <asm/tdx.h>
 
 static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
 
@@ -130,7 +131,7 @@ int arch_register_cpu(int num)
 			}
 		}
 	}
-	if (num || cpu0_hotpluggable)
+	if ((num || cpu0_hotpluggable) && !is_tdx_guest())
 		per_cpu(cpu_devices, num).cpu.hotpluggable = 1;
 
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
-- 
2.25.1

