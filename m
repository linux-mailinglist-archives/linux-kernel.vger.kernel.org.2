Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05793A1F62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFIVxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:53:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:5518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhFIVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:53:04 -0400
IronPort-SDR: ogEnsPx3FFzVBRD08hINRI+SxW7LTbCJ8t83U4RsZnfcaCu7gKfu/oXHu+FovV5EmCBtXwkqli
 /fbsFlDId7zg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="269031384"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="269031384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:51:09 -0700
IronPort-SDR: efHISlK3wSHnBhmGNI9ezEvMwRRx9ymbnkV4P0FP5ILMOpDhEePanl/66heRj39kJ0XoW5VdTD
 OIBIezNE7Ulw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482553402"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:51:08 -0700
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
Subject: [PATCH v1 3/5] x86/topology: Disable CPU online/offline control for TDX guest
Date:   Wed,  9 Jun 2021 14:50:45 -0700
Message-Id: <20210609215047.1955866-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609215047.1955866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609215047.1955866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c      | 14 ++++++++++++++
 arch/x86/kernel/topology.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 18844dae1ddf..153cc143a45a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -326,6 +326,17 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -466,5 +477,8 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdg_safe_halt;
 	pv_ops.irq.halt = tdg_halt;
 
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
+			  NULL, tdg_cpu_offline_prepare);
+
 	pr_info("TDX guest is initialized\n");
 }
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index bd83748e2bde..3b34325e5dcf 100644
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

