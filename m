Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F303B4F03
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFZOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:35:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:16420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhFZOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:35:14 -0400
IronPort-SDR: /1Fyw8v4Oxoc+wXJIZ1Bz2DSRF6TFe8KnY+E8z3Vn6ig5IrEmhUq3NdNc9pcREDvFyJXqQH9nN
 VsFVKXoWVk4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="188174863"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="188174863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:32:52 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="475134349"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:32:51 -0700
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v1 1/4] x86/tdx: Add #VE tracepoint
Date:   Sat, 26 Jun 2021 07:32:41 -0700
Message-Id: <a910a084415521e8b98441f32b0d0dd239e0f25c.1624717684.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624717684.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624717684.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add tracepoint for tracing TDX guest #VE exceptions. It will dump
RIP, exit reason, exit qual, GPA, instruction length and instruction
info for each #VE exception occurred.

Also, make trace points RCU idle safe to avoid warnings when RCU
debugging is enabled.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/trace/tdx.h | 51 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c            |  6 ++++
 2 files changed, 57 insertions(+)
 create mode 100644 arch/x86/include/asm/trace/tdx.h

diff --git a/arch/x86/include/asm/trace/tdx.h b/arch/x86/include/asm/trace/tdx.h
new file mode 100644
index 000000000000..e045e276009e
--- /dev/null
+++ b/arch/x86/include/asm/trace/tdx.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_TRACE_TDX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TDX_H
+
+#include <linux/tracepoint.h>
+
+#include <uapi/asm/vmx.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tdx
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+TRACE_EVENT(tdg_virtualization_exception,
+	    TP_PROTO(u64 rip, u32 exit_reason, u64 exit_qual,
+		     u64 gpa, u32 instr_len, u32 instr_info),
+	    TP_ARGS(rip, exit_reason, exit_qual, gpa, instr_len,
+		    instr_info),
+	    TP_STRUCT__entry(
+			     __field(u64, rip)
+			     __field(u64, exit_qual)
+			     __field(u64, gpa)
+			     __field(u32, exit_reason)
+			     __field(u32, instr_len)
+			     __field(u32, instr_info)
+			     ),
+	    TP_fast_assign(
+			   __entry->rip = rip;
+			   __entry->exit_qual = exit_qual;
+			   __entry->gpa = gpa;
+			   __entry->exit_reason = exit_reason;
+			   __entry->instr_len = instr_len;
+			   __entry->instr_info = instr_info;
+			   ),
+	    TP_printk("reason %s rip 0x%016llx len %u info 0x%08x qual 0x%016llx gpa 0x%016llx",
+		      __print_symbolic(__entry->exit_reason, VMX_EXIT_REASONS),
+		      __entry->rip, __entry->instr_len, __entry->instr_info,
+		      __entry->exit_qual, __entry->gpa
+		      )
+	    );
+
+#endif // CONFIG_INTEL_TDX_GUEST
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH asm/trace/
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE tdx
+#endif /* _TRACE_TDX_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 4639206d99f3..67687cf3e631 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -16,6 +16,9 @@
 #include <linux/sched/signal.h> /* force_sig_fault() */
 #include <linux/swiotlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/trace/tdx.h>
+
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
 #define TDGETVEINFO			3
@@ -407,6 +410,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	unsigned long val;
 	int ret = 0;
 
+	trace_tdg_virtualization_exception_rcuidle(regs->ip, ve->exit_reason,
+		ve->exit_qual, ve->gpa, ve->instr_len, ve->instr_info);
+
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		tdg_halt();
-- 
2.25.1

