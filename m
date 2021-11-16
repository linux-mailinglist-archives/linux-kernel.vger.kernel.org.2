Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED0452199
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhKPBFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:05:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:52510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhKPAy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:54:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="232309125"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="232309125"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:51:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454248018"
Received: from asu1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.192])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:51:11 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] x86/tdx: Don't write CSTAR MSR on Intel
Date:   Mon, 15 Nov 2021 16:51:03 -0800
Message-Id: <20211116005103.2929441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Intel CPUs do not support SYSCALL in 32-bit mode, but the kernel
initializes MSR_CSTAR unconditionally. That MSR write is normally
ignored by the CPU, but in a TDX guest it raises a #VE trap.

Exclude Intel CPUs from the MSR_CSTAR initialization.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..8917eb412c4a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1787,6 +1787,18 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
 
+/* Don't write CSTAR MSR on Intel platforms */
+void wrmsrl_cstar(unsigned long val)
+{
+	/*
+	 * Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
+	 * is normally ignored by the CPU, but raises a #VE trap in a TDX
+	 * guest.
+	 */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		wrmsrl(MSR_CSTAR, val);
+}
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
@@ -1794,7 +1806,7 @@ void syscall_init(void)
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 #ifdef CONFIG_IA32_EMULATION
-	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
+	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
 	/*
 	 * This only works on Intel CPUs.
 	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
@@ -1806,7 +1818,7 @@ void syscall_init(void)
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
-	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
+	wrmsrl_cstar((unsigned long)ignore_sysret);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
-- 
2.25.1

