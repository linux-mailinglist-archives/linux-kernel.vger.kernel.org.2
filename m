Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6DC337592
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhCKOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:24:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:47662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhCKOX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:23:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615472606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoI7oHufeO8pieHlsxYeq8uKmilyQjXsUQUWZlzb7OE=;
        b=JTodUFeSkwVptUe+WEDIhCYBsfvIKyFCCawDwjkRTsQA5A58As0giziNTz37dloIRJyjYe
        oCJ/k3Q1vNixFiQa4Pml/1PcmKQf4h36+ffSK+q/GTxDqO8p7BTHv9pSVEIsCsAMB5tyOn
        yRHGRcb50GXCnHIu0T4CEczhIdGWTD8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E305AAE44;
        Thu, 11 Mar 2021 14:23:25 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 11/14] x86/paravirt: switch iret pvops to ALTERNATIVE
Date:   Thu, 11 Mar 2021 15:23:16 +0100
Message-Id: <20210311142319.4723-12-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311142319.4723-1-jgross@suse.com>
References: <20210311142319.4723-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iret paravirt op is rather special as it is using a jmp instead
of a call instruction. Switch it to ALTERNATIVE.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V3:
- use ALTERNATIVE_TERNARY
---
 arch/x86/include/asm/paravirt.h       |  6 +++---
 arch/x86/include/asm/paravirt_types.h |  5 +----
 arch/x86/kernel/asm-offsets.c         |  5 -----
 arch/x86/kernel/paravirt.c            | 26 ++------------------------
 arch/x86/xen/enlighten_pv.c           |  3 +--
 5 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index a780509186bd..913acf7a0ebf 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -747,9 +747,9 @@ extern void default_banner(void);
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
+	ANNOTATE_RETPOLINE_SAFE;					\
+	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
+		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 45bd21647dd8..0afdac83f926 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -151,10 +151,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-	/* Normal iret.  Jump to this with the standard iret stack
-	   frame set up. */
-	void (*iret)(void);
-
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
 #endif
@@ -294,6 +290,7 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
+extern void (*paravirt_iret)(void);
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 736508004b30..ecd3fd6993d1 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -61,11 +61,6 @@ static void __used common(void)
 	OFFSET(IA32_RT_SIGFRAME_sigcontext, rt_sigframe_ia32, uc.uc_mcontext);
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
-	BLANK();
-	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-#endif
-
 #ifdef CONFIG_XEN
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a688edf35e31..9b0f568b0200 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,25 +86,6 @@ u64 notrace _paravirt_ident_64(u64 x)
 {
 	return x;
 }
-
-static unsigned paravirt_patch_jmp(void *insn_buff, const void *target,
-				   unsigned long addr, unsigned len)
-{
-	struct branch *b = insn_buff;
-	unsigned long delta = (unsigned long)target - (addr+5);
-
-	if (len < 5) {
-#ifdef CONFIG_RETPOLINE
-		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
-#endif
-		return len;	/* call too long for patch site */
-	}
-
-	b->opcode = 0xe9;	/* jmp */
-	b->delta = delta;
-
-	return 5;
-}
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
@@ -136,9 +117,6 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
 
-	else if (type == PARAVIRT_PATCH(cpu.iret))
-		/* If operation requires a jmp, then jmp */
-		ret = paravirt_patch_jmp(insn_buff, opfunc, addr, len);
 #endif
 	else
 		/* Otherwise call the function. */
@@ -313,8 +291,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-	.cpu.iret		= native_iret,
-
 #ifdef CONFIG_X86_IOPL_IOPERM
 	.cpu.invalidate_io_bitmap	= native_tss_invalidate_io_bitmap,
 	.cpu.update_io_bitmap		= native_tss_update_io_bitmap,
@@ -419,6 +395,8 @@ struct paravirt_patch_template pv_ops = {
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
+
+void (*paravirt_iret)(void) = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index dc0a337f985b..08dca7bebb30 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1070,8 +1070,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.read_pmc = xen_read_pmc,
 
-	.iret = xen_iret,
-
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
 	.load_gdt = xen_load_gdt,
@@ -1235,6 +1233,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	pv_info = xen_info;
 	pv_ops.init.patch = paravirt_patch_default;
 	pv_ops.cpu = xen_cpu_ops;
+	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
 	/*
-- 
2.26.2

