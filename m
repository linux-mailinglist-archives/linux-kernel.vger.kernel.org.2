Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65036B89A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDZSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:51109 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhDZSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:37 -0400
IronPort-SDR: CYJ1pl1JvseSgS+8b0s+pdARu9s2ZbXdMD2GzyB+S/aFeC584C6uGHFzP6XBwwSObx/QvQ9lAm
 /VHoF7E3J/YA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196440430"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196440430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:54 -0700
IronPort-SDR: /d8RFcZ9QatFRQrElpSTNu71bWHEzpbuVEHaBrjvs18AWw2naHZarkJYheSvXCpZr87O0Oynp3
 IB35osaCJvKw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353431"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:54 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 24/32] x86/topology: Disable CPU online/offline control for TDX guest
Date:   Mon, 26 Apr 2021 11:01:51 -0700
Message-Id: <8c859476363d43b0e5c3fd6ea3f7c250068b24d5.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 294dda5bf3f6..ab1efa4d10e9 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -316,6 +316,17 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return insn.length;
 }
 
+static int tdg_cpu_offline_prepare(unsigned int cpu)
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
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -410,5 +421,8 @@ void __init tdx_early_init(void)
 	pv_ops.irq.safe_halt = tdg_safe_halt;
 	pv_ops.irq.halt = tdg_halt;
 
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
+			  NULL, tdg_cpu_offline_prepare);
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

