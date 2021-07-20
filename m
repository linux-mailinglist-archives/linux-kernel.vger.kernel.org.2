Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C830C3CF304
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGTDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:31:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:58887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243098AbhGTD3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:29:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="210893261"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="210893261"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:10:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="431914080"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:10:09 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] x86/topology: Disable CPU online/offline control for TDX guest
Date:   Mon, 19 Jul 2021 21:08:59 -0700
Message-Id: <20210720040901.2121268-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720040901.2121268-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720040901.2121268-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Changes since v1:
 * Replaced is_tdx_guest() check with prot_guest_has(PR_GUEST_TDX).

 arch/x86/kernel/tdx.c      | 15 +++++++++++++++
 arch/x86/kernel/topology.c |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 92acccbce59c..a110bd5e5e4c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "x86/tdx: " fmt
 
 #include <linux/protected_guest.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -306,6 +307,17 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return insn.length;
 }
 
+static int tdg_cpu_offline_prepare(unsigned int cpu)
+{
+	/*
+	 * Per Intel TDX Virtual Firmware Design Guide,
+	 * sec 4.3.5 and sec 9.4, Hotplug is not supported
+	 * in TDX platforms. So don't support CPU
+	 * offline feature once it is turned on.
+	 */
+	return -EOPNOTSUPP;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -446,5 +458,8 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdg_safe_halt;
 	pv_ops.irq.halt = tdg_halt;
 
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
+			  NULL, tdg_cpu_offline_prepare);
+
 	pr_info("Guest initialized\n");
 }
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index bd83748e2bde..7b5fab69d56e 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
+#include <linux/protected_guest.h>
 #include <asm/io_apic.h>
 #include <asm/cpu.h>
 
@@ -130,7 +131,7 @@ int arch_register_cpu(int num)
 			}
 		}
 	}
-	if (num || cpu0_hotpluggable)
+	if ((num || cpu0_hotpluggable) && !prot_guest_has(PR_GUEST_TDX))
 		per_cpu(cpu_devices, num).cpu.hotpluggable = 1;
 
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
-- 
2.25.1

