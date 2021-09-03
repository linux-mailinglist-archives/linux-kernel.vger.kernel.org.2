Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD9400424
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350325AbhICR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:29:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:33543 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350264AbhICR3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:29:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241760105"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="241760105"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="534222286"
Received: from dlinsen-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.56.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:31 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/11] x86/tdx: Don't write CSTAR MSR on Intel
Date:   Fri,  3 Sep 2021 10:28:11 -0700
Message-Id: <20210903172812.1097643-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

On Intel CPUs writing the CSTAR MSR is not really needed. Syscalls
from 32bit work using SYSENTER and 32bit SYSCALL is an illegal opcode.
But the kernel did write it anyways even though it was ignored by
the CPU. Inside a TDX guest this actually leads to a #VE which in
turn will trigger ve_raise_fault() due to failed MSR write. Inside
ve_raise_fault() before it recovers from this error, it prints an
ugly message at boot. Since such warning message is pointless for
CSTAR MSR write failure, add exception to skip CSTAR msr write on
Intel CPUs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---

Changes since v5:
 * Fixed commit log as per review comments.

 arch/x86/kernel/cpu/common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 64b805bd6a54..d936f0e4ec51 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1752,7 +1752,13 @@ void syscall_init(void)
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 #ifdef CONFIG_IA32_EMULATION
-	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
+	/*
+	 * CSTAR is not needed on Intel because it doesn't support
+	 * 32bit SYSCALL, but only SYSENTER. On a TDX guest
+	 * it leads to a #GP.
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
 	/*
 	 * This only works on Intel CPUs.
 	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
@@ -1764,7 +1770,8 @@ void syscall_init(void)
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
-	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
-- 
2.25.1

