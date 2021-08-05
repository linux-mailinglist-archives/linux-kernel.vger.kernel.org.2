Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0322D3E1F62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbhHEXb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:31:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:6542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236895AbhHEXbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:31:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="201448367"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201448367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 16:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="481043888"
Received: from rmgular-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 16:31:07 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>
Subject: [PATCH v3 1/5] x86/tdx: Add #VE tracepoint
Date:   Thu,  5 Aug 2021 16:30:32 -0700
Message-Id: <20210805233036.2949674-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805233036.2949674-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210805233036.2949674-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v2:
 * Modified tdg_virtualization_exception() to dump cx,ax,dx
   register contents.

 arch/x86/include/asm/trace/tdx.h | 59 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c            |  7 ++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/x86/include/asm/trace/tdx.h

diff --git a/arch/x86/include/asm/trace/tdx.h b/arch/x86/include/asm/trace/tdx.h
new file mode 100644
index 000000000000..46bae44e12e5
--- /dev/null
+++ b/arch/x86/include/asm/trace/tdx.h
@@ -0,0 +1,59 @@
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
+		     u64 gpa, u32 instr_len, u32 instr_info,
+		     u64 cx, u64 ax, u64 dx),
+	    TP_ARGS(rip, exit_reason, exit_qual, gpa, instr_len,
+		    instr_info, cx, ax, dx),
+	    TP_STRUCT__entry(
+			     __field(u64, rip)
+			     __field(u64, exit_qual)
+			     __field(u64, gpa)
+			     __field(u32, exit_reason)
+			     __field(u32, instr_len)
+			     __field(u32, instr_info)
+			     __field(u64, cx)
+			     __field(u64, ax)
+			     __field(u64, dx)
+			     ),
+	    TP_fast_assign(
+			   __entry->rip = rip;
+			   __entry->exit_qual = exit_qual;
+			   __entry->gpa = gpa;
+			   __entry->exit_reason = exit_reason;
+			   __entry->instr_len = instr_len;
+			   __entry->instr_info = instr_info;
+			   __entry->cx = cx;
+			   __entry->ax = ax;
+			   __entry->dx = dx;
+			   ),
+	    TP_printk("reason %s rip 0x%016llx len %u info 0x%08x qual 0x%016llx gpa 0x%016llx cx %llx ax %llx dx %llx",
+		      __print_symbolic(__entry->exit_reason, VMX_EXIT_REASONS),
+		      __entry->rip, __entry->instr_len, __entry->instr_info,
+		      __entry->exit_qual, __entry->gpa,
+		      __entry->cx, __entry->ax, __entry->dx
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
index 1cf2443edb90..4b41baa56958 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -15,6 +15,9 @@
 #include <linux/sched/signal.h> /* force_sig_fault() */
 #include <linux/swiotlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/trace/tdx.h>
+
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
 #define TDGETVEINFO			3
@@ -407,6 +410,10 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	unsigned long val;
 	int ret = 0;
 
+	trace_tdg_virtualization_exception_rcuidle(regs->ip, ve->exit_reason,
+		ve->exit_qual, ve->gpa, ve->instr_len, ve->instr_info,
+		regs->cx, regs->ax, regs->dx);
+
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		tdg_halt();
-- 
2.25.1

