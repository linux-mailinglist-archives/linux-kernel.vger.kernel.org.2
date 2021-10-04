Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E5421254
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhJDPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhJDPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:10:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C6C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 08:08:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08d80044cec3b734c8017c.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:d800:44ce:c3b7:34c8:17c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B807E1EC03D5;
        Mon,  4 Oct 2021 17:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633360125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ggal+4qNmiBMoIpJ/kVznwCxxMAmbQKX5Lqka/nSR5Q=;
        b=Y8g6T+ftcyQ8lEts04ildOYPWTdFSbgR0dA6bLBRlZmNNrIjEnPtjqj5PwZ9qjyNRMNY/J
        MA/YjbtKXXRPS8yF7JVStR4lqs585WZFAT8bLC0z5ULeItsow4SSFSGLARBdjFHOw1FHbW
        /wn0ULoBWU+hag4xkoZSJqL+Ks4ZJx4=
Date:   Mon, 4 Oct 2021 17:08:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] x86/sev: Make the #VC exception stacks part of the default
 stacks storage
Message-ID: <YVsY95SXNN4uTCCl@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
 <YVcGdpVuSsieFL8W@suse.de>
 <YVcSuVqmTPiw4YLk@zn.tnic>
 <YVdx/SRNkeRFnIuX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVdx/SRNkeRFnIuX@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 1 Oct 2021 21:41:20 +0200

The size of the exception stacks was increased by the commit in Fixes,
resulting in stack sizes greater than a page in size. The #VC exception
handling was only mapping the first (bottom) page, resulting in an
SEV-ES guest failing to boot.

Make the #VC exception stacks part of the default exception stacks
storage and allocate them with a CONFIG_AMD_MEM_ENCRYPT=y .config. Map
them only when a SEV-ES guest has been detected.

Rip out the custom VC stacks mapping and storage code.

 [ bp: Steal and adapt Tom's commit message. ]

Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpu_entry_area.h | 16 +++++++++-----
 arch/x86/kernel/sev.c                 | 32 ---------------------------
 arch/x86/mm/cpu_entry_area.c          |  7 ++++++
 3 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 3d52b094850a..2512e1f5ac02 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -10,8 +10,14 @@
 
 #ifdef CONFIG_X86_64
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define VC_EXCEPTION_STKSZ	EXCEPTION_STKSZ
+#else
+#define VC_EXCEPTION_STKSZ	0
+#endif
+
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
+#define ESTACKS_MEMBERS(guardsize)				\
 	char	DF_stack_guard[guardsize];			\
 	char	DF_stack[EXCEPTION_STKSZ];			\
 	char	NMI_stack_guard[guardsize];			\
@@ -21,19 +27,19 @@
 	char	MCE_stack_guard[guardsize];			\
 	char	MCE_stack[EXCEPTION_STKSZ];			\
 	char	VC_stack_guard[guardsize];			\
-	char	VC_stack[optional_stack_size];			\
+	char	VC_stack[VC_EXCEPTION_STKSZ];			\
 	char	VC2_stack_guard[guardsize];			\
-	char	VC2_stack[optional_stack_size];			\
+	char	VC2_stack[VC_EXCEPTION_STKSZ];			\
 	char	IST_top_guard[guardsize];			\
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 
 /*
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
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
