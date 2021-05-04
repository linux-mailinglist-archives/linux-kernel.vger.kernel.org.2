Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A834A372EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEDRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:19:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhEDRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:18:47 -0400
Received: from zn.tnic (p200300ec2f0c8400434730836ea897d2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:4347:3083:6ea8:97d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A37791EC0598;
        Tue,  4 May 2021 19:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620148670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=faOl1enp2RXY/vCNHMiZNrvMY4eODQWN39NdXIdQhhM=;
        b=PP6gw/4/Je0ez7PryntJth4RB4SQFcNS/2yFVyuFCg3aSRcH5PB3ahn5drriYwZATkgaKd
        DlUzzo5CtlYNJdcj74N98RYvFvBkMVM1yUl3km0495GwyQAkWAIHEniu+JeWNcqygDjhYK
        AIP2Tn1oRACoAfeN3YsY7cx9R5S0LvA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: Init exception handling from cpu_init()
Date:   Tue,  4 May 2021 19:17:45 +0200
Message-Id: <20210504171745.2249-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

SEV-ES guests require properly setup task register with which the TSS
descriptor in the GDT can be located so that the IST-type #VC exception
handler which they need to function properly, can be executed.

This setup needs to happen before attempting to load microcode in
ucode_cpu_init() which can cause such #VC exceptions.

Simplify the machinery by running that exception setup from cpu_init()
directly.

There should be no functional changes resulting from this patch.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/kernel/cpu/common.c     | 14 +++-----------
 arch/x86/kernel/smpboot.c        |  1 -
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 154321d29050..50059c988167 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -663,7 +663,6 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
-extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
 static inline unsigned long get_debugctlmsr(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6bdb69a9a7dc..1aa20b5e4e66 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1917,7 +1917,7 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
  * Setup everything needed to handle exceptions from the IDT, including the IST
  * exceptions which use paranoid_entry().
  */
-void cpu_init_exception_handling(void)
+static void init_exception_handling(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	int cpu = raw_smp_processor_id();
@@ -1944,10 +1944,11 @@ void cpu_init_exception_handling(void)
  */
 void cpu_init(void)
 {
-	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
+	init_exception_handling();
+
 	wait_for_master_cpu(cpu);
 
 	ucode_cpu_init(cpu);
@@ -1957,8 +1958,6 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
-	setup_getcpu(cpu);
-
 	pr_debug("Initializing CPU#%d\n", cpu);
 
 	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
@@ -1970,7 +1969,6 @@ void cpu_init(void)
 	 * and set up the GDT descriptor:
 	 */
 	switch_to_new_gdt(cpu);
-	load_current_idt();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
@@ -1990,12 +1988,6 @@ void cpu_init(void)
 	initialize_tlbstate_and_flush();
 	enter_lazy_tlb(&init_mm, cur);
 
-	/* Initialize the TSS. */
-	tss_setup_ist(tss);
-	tss_setup_io_bitmap(tss);
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
-
-	load_TR_desc();
 	/*
 	 * sp0 points to the entry trampoline stack regardless of what task
 	 * is running.
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7ffb0cf3f997..5e5899d046e4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -232,7 +232,6 @@ static void notrace start_secondary(void *unused)
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
-	cpu_init_exception_handling();
 	cpu_init();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
-- 
2.29.2

