Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E328A427451
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbhJHXnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:43:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:35994 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243982AbhJHXm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:42:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213752107"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213752107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="590706809"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:36 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: [PATCH v9 10/11] x86/tdx: Don't write CSTAR MSR on Intel
Date:   Fri,  8 Oct 2021 16:40:08 -0700
Message-Id: <20211008234009.1211215-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v8:
 * None

Changes since v7:
 * None.

Changes since v6:
 * None.

Changes since v5:
 * Fixed commit log as per review comments.

 arch/x86/kernel/cpu/common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f8885949e8c..fd10f1044157 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1758,7 +1758,13 @@ void syscall_init(void)
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
@@ -1770,7 +1776,8 @@ void syscall_init(void)
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

