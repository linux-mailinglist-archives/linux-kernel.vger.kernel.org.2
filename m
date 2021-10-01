Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AC41F666
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355442AbhJAUlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:41:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57916 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355332AbhJAUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:41:15 -0400
Received: from zn.tnic (p200300ec2f0e8e008cd8fcde3ecc481f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:8cd8:fcde:3ecc:481f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E10001EC05DE;
        Fri,  1 Oct 2021 22:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633120769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nx12u0cB1s3RsxRSfxjFtysx8A9z2kvicyKJknGp5i4=;
        b=QXYPwXLiwkYiXk85g0gRv5E0xzRqmPapSW3XPk9wdv7llQVr3hlir2tPQtbMBbunIjJT48
        kxDx+7tBMI/XOsG4OIQkjHhZnQUEyHrwoPpCL7/29FEQ45E+FIHfNJYI40zuhnmfRJmLmi
        tpVpmBfmz9u+lqasle08IumwAedRhvY=
Date:   Fri, 1 Oct 2021 22:39:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVdx/SRNkeRFnIuX@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
 <YVcGdpVuSsieFL8W@suse.de>
 <YVcSuVqmTPiw4YLk@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVcSuVqmTPiw4YLk@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't get any more straight-forward than this.

We can ifdef around the ESTACKS_MEMBERS VC and VC2 arrays so that those
things do get allocated only on a CONFIG_AMD_MEM_ENCRYPT kernel so that
we don't waste 4 pages per CPU on machines which don't do SEV but meh.

Thoughts?

---
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 3d52b094850a..13a3e8510c33 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -21,9 +21,9 @@
 	char	MCE_stack_guard[guardsize];			\
 	char	MCE_stack[EXCEPTION_STKSZ];			\
 	char	VC_stack_guard[guardsize];			\
-	char	VC_stack[optional_stack_size];			\
+	char	VC_stack[EXCEPTION_STKSZ];			\
 	char	VC2_stack_guard[guardsize];			\
-	char	VC2_stack[optional_stack_size];			\
+	char	VC2_stack[EXCEPTION_STKSZ];			\
 	char	IST_top_guard[guardsize];			\
 
 /* The exception stacks' physical storage. No guard pages required */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..88401675dabb 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -46,16 +46,6 @@ static struct ghcb __initdata *boot_ghcb;
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
 
-	/* Physical storage for the per-CPU IST stack of the #VC handler */
-	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
-
-	/*
-	 * Physical storage for the per-CPU fall-back stack of the #VC handler.
-	 * The fall-back stack is used when it is not safe to switch back to the
-	 * interrupted stack in the #VC entry code.
-	 */
-	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
-
 	/*
 	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
 	 * It is needed when an NMI happens while the #VC handler uses the real
@@ -99,27 +89,6 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
-static void __init setup_vc_stacks(int cpu)
-{
-	struct sev_es_runtime_data *data;
-	struct cpu_entry_area *cea;
-	unsigned long vaddr;
-	phys_addr_t pa;
-
-	data = per_cpu(runtime_data, cpu);
-	cea  = get_cpu_entry_area(cpu);
-
-	/* Map #VC IST stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
-	pa    = __pa(data->ist_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-
-	/* Map VC fall-back stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
-	pa    = __pa(data->fallback_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-}
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -787,7 +756,6 @@ void __init sev_es_init_vc_handling(void)
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
 		init_ghcb(cpu);
-		setup_vc_stacks(cpu);
 	}
 
 	sev_es_setup_play_dead();
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index f5e1e60c9095..82d062414f19 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -110,6 +110,13 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	cea_map_stack(NMI);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		if (sev_es_active()) {
+			cea_map_stack(VC);
+			cea_map_stack(VC2);
+		}
+	}
 }
 #else
 static inline void percpu_setup_exception_stacks(unsigned int cpu)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
