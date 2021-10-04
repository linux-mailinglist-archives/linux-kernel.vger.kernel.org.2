Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8E42196A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhJDVnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhJDVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:43:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C195C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 14:42:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fe400e5edf893a0ad07a5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e400:e5ed:f893:a0ad:7a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0533B1EC0419;
        Mon,  4 Oct 2021 23:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633383718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fk/mIFHGG6r9xN4kDPLTTqkEH6iycilpM7cKeCCnV+0=;
        b=O5W3t6O/j+i5vl5lZFsxTvhWnQM6R6lN5WpUEC85S4XKQ25vd0uEXh5YCcTC+l+Ry0IhJl
        wk65LLQFV45LiQ3AcQTuzNC9wSYGv1QPS4bBIUVVdyNJE6ZfjCpxN0Lk9i1MnQPiWtoy1H
        WJkCcupTsqWqvujGzGRn8P0NfxGOI88=
Date:   Mon, 4 Oct 2021 23:41:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH -v2] x86/sev: Make the #VC exception stacks part of the
 default stacks storage
Message-ID: <YVt1IMjIs7pIZTRR@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
 <YVcGdpVuSsieFL8W@suse.de>
 <YVcSuVqmTPiw4YLk@zn.tnic>
 <YVdx/SRNkeRFnIuX@zn.tnic>
 <YVsY95SXNN4uTCCl@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVsY95SXNN4uTCCl@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yap,

here's v2, now tested. It seems we do need that optional_stack_size
second arg to ESTACKS_MEMBERS(), thx Tom.

---
From: Borislav Petkov <bp@suse.de>

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
 arch/x86/include/asm/cpu_entry_area.h |  8 ++++++-
 arch/x86/kernel/sev.c                 | 32 ---------------------------
 arch/x86/mm/cpu_entry_area.c          |  7 ++++++
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 3d52b094850a..dd5ea1bdf04c 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -10,6 +10,12 @@
 
 #ifdef CONFIG_X86_64
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define VC_EXCEPTION_STKSZ	EXCEPTION_STKSZ
+#else
+#define VC_EXCEPTION_STKSZ	0
+#endif
+
 /* Macro to enforce the same ordering and stack sizes */
 #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
 	char	DF_stack_guard[guardsize];			\
@@ -28,7 +34,7 @@
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0, VC_EXCEPTION_STKSZ)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 53a6837d354b..4d0d1c2b65e1 100644
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
index f5e1e60c9095..6c2f1b76a0b6 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -110,6 +110,13 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	cea_map_stack(NMI);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
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
