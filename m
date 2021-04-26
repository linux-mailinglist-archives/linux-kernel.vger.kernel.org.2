Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D136B88D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDZSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:31744 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234274AbhDZSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:29 -0400
IronPort-SDR: sxx8pUkxq1B0dGwp1x/LkjVoglALx0hJoD4cHI1BtdIF6+RT0OGaplSjo2Gu9BahKpErK2hxPb
 bWX97YBdh+/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934039"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934039"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:47 -0700
IronPort-SDR: Dj/XabYGD3+8a4SEaRD3ilnatyaYCbNIGkY5EtmIY8ZrZPfs+F5+U3mXr/u9ceytqrGmMqAdTm
 vp46lhGUCbcw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353355"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:43 -0700
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
Subject: [RFC v2 07/32] =?UTF-8?q?x86/traps:=20Add=C2=A0do=5Fgeneral=5Fpro?= =?UTF-8?q?tection()=20helper=20function?=
Date:   Mon, 26 Apr 2021 11:01:34 -0700
Message-Id: <00eeea950502dbaa5f6d48509307c806e08c6e4d.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX guest #VE exception handler treats unsupported exceptions
as #GP. So to handle the #GP, move the protection fault handler
code to out of exc_general_protection() and create new helper
function for it.

Also since exception handler is responsible to decide when to
turn on/off IRQ, move cond_local_irq_{enable/disable)() calls
out of do_general_protection().

This is a preparatory patch for adding #VE exception handler
support for TDX guests.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/traps.c | 51 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 651e3e508959..213d4aa8e337 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -527,44 +527,28 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
-DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
+static void do_general_protection(struct pt_regs *regs, long error_code)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
-	struct task_struct *tsk;
+	struct task_struct *tsk = current;
 	unsigned long gp_addr;
 	int ret;
 
-	cond_local_irq_enable(regs);
-
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
-	if (v8086_mode(regs)) {
-		local_irq_enable();
-		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-		local_irq_disable();
-		return;
-	}
-
-	tsk = current;
-
 	if (user_mode(regs)) {
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
-			goto exit;
+			return;
 
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
-		goto exit;
+		return;
 	}
 
 	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		goto exit;
+		return;
 
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
@@ -576,11 +560,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	if (!preemptible() &&
 	    kprobe_running() &&
 	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		goto exit;
+		return;
 
 	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
 	if (ret == NOTIFY_STOP)
-		goto exit;
+		return;
 
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
@@ -601,8 +585,27 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		gp_addr = 0;
 
 	die_addr(desc, regs, error_code, gp_addr);
+}
 
-exit:
+DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
+{
+	cond_local_irq_enable(regs);
+
+	if (static_cpu_has(X86_FEATURE_UMIP)) {
+		if (user_mode(regs) && fixup_umip_exception(regs)) {
+			cond_local_irq_disable(regs);
+			return;
+		}
+	}
+
+	if (v8086_mode(regs)) {
+		local_irq_enable();
+		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+		local_irq_disable();
+		return;
+	}
+
+	do_general_protection(regs, error_code);
 	cond_local_irq_disable(regs);
 }
 
-- 
2.25.1

