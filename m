Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368AF3E08D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhHDT2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:28:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:42526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhHDT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:28:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235953239"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="235953239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="585563757"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:48 -0700
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
Subject: [PATCH v4 3/5] x86/topology: Disable CPU online/offline control for TDX guest
Date:   Wed,  4 Aug 2021 12:27:26 -0700
Message-Id: <20210804192729.2902472-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804192729.2902472-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210804192729.2902472-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v3:
 * Rebased on top of Tom Lendacky's protected guest change.

Changes since v1:
 * Replaced is_tdx_guest() check with prot_guest_has(PR_GUEST_TDX).

 arch/x86/kernel/tdx.c      | 15 +++++++++++++++
 arch/x86/kernel/topology.c |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 4080f7546e62..1b6ed482c6b6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "x86/tdx: " fmt
 
 #include <linux/protected_guest.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -303,6 +304,17 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -443,5 +455,8 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdg_safe_halt;
 	pv_ops.irq.halt = tdg_halt;
 
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
+			  NULL, tdg_cpu_offline_prepare);
+
 	pr_info("Guest initialized\n");
 }
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index bd83748e2bde..c637f49d029a 100644
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
+	if ((num || cpu0_hotpluggable) && !prot_guest_has(PATTR_GUEST_TDX))
 		per_cpu(cpu_devices, num).cpu.hotpluggable = 1;
 
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
-- 
2.25.1

