Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637AB3C6FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhGMLmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:42:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236072AbhGMLmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED84D6E;
        Tue, 13 Jul 2021 04:39:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 476213F7D8;
        Tue, 13 Jul 2021 04:39:45 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v3 10/10] x86: snapshot thread flags
Date:   Tue, 13 Jul 2021 12:38:42 +0100
Message-Id: <20210713113842.2106-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210713113842.2106-1-mark.rutland@arm.com>
References: <20210713113842.2106-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
---
 arch/x86/kernel/process.c | 8 ++++----
 arch/x86/kernel/process.h | 6 +++---
 arch/x86/mm/tlb.c         | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..0b9a1f2ccfb3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -348,7 +348,7 @@ void arch_setup_new_exec(void)
 		clear_thread_flag(TIF_SSBD);
 		task_clear_spec_ssb_disable(current);
 		task_clear_spec_ssb_noexec(current);
-		speculation_ctrl_update(task_thread_info(current)->flags);
+		speculation_ctrl_update(read_thread_flags());
 	}
 }
 
@@ -600,7 +600,7 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
 	}
 	/* Return the updated threadinfo flags*/
-	return task_thread_info(tsk)->flags;
+	return read_task_thread_flags(tsk);
 }
 
 void speculation_ctrl_update(unsigned long tif)
@@ -636,8 +636,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;
 
-	tifn = READ_ONCE(task_thread_info(next_p)->flags);
-	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+	tifn = read_task_thread_flags(next_p);
+	tifp = read_task_thread_flags(prev_p);
 
 	switch_to_bitmap(tifp);
 
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 1d0797b2338a..0b1be8685b49 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -13,9 +13,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 static inline void switch_to_extra(struct task_struct *prev,
 				   struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long prev_tif = task_thread_info(prev)->flags;
-
+	unsigned long next_tif = read_task_thread_flags(next);
+	unsigned long prev_tif = read_task_thread_flags(prev);
+	
 	if (IS_ENABLED(CONFIG_SMP)) {
 		/*
 		 * Avoid __switch_to_xtra() invocation when conditional
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cfe6b1e85fa6..56917e92991d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -319,7 +319,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long next_tif = read_task_thread_flags(next);
 	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
 
 	return (unsigned long)next->mm | ibpb;
-- 
2.11.0

