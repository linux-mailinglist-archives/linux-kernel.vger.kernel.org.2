Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8467E41DA69
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351245AbhI3NAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351222AbhI3NAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4CF7613A7;
        Thu, 30 Sep 2021 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006750;
        bh=0KHPWDxkQ4cP449XYvVB8lbUfbyz2Z5Mvb7G0++ZC7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z510BOF7LmUGqruh2US8aVPJVbXag8CagBSYq4S67SmOVDUJNlxQ8zeC/1B4I54bm
         2cx57dOoWrNjpwHJ4dtVRUD3KV1ensvGMoYpDaxXn+mVFTAi/pu6vbd22uc5SqrMwi
         cnxlpC8omWDI4exG5KsymU4IRRQDpgEYYKn04+80LCrmlgksyEIOGHvuh4xztdQRpr
         4fPmkj/fCJzE8mSfCD9XEVazrk6EcMO5a/Mbr6BmwXbqsatEHJqDdZdnJeHidUZVnj
         AmkAcuULTqERXLnArffn/i/UaYwe5yvwseTRJMjMRNdJyL3LSfwW2uhTYv2myUh+M8
         PxdgRKMWiwTFg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 5/7] sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
Date:   Thu, 30 Sep 2021 14:58:11 +0200
Message-Id: <20210930125813.197418-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THREAD_INFO_IN_TASK moved the CPU field out of thread_info, but this
causes some issues on architectures that define raw_smp_processor_id()
in terms of this field, due to the fact that #include'ing linux/sched.h
to get at struct task_struct is problematic in terms of circular
dependencies.

Given that thread_info and task_struct are the same data structure
anyway when THREAD_INFO_IN_TASK=y, let's move it back so that having
access to the type definition of struct thread_info is sufficient to
reference the CPU number of the current task.

Note that this requires THREAD_INFO_IN_TASK's definition of the
task_thread_info() helper to be updated, as task_cpu() takes a
pointer-to-const, whereas task_thread_info() (which is used to generate
lvalues as well), needs a non-const pointer. So make it a macro instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/arm64/kernel/asm-offsets.c   |  1 -
 arch/arm64/kernel/head.S          |  2 +-
 arch/powerpc/kernel/asm-offsets.c |  2 +-
 arch/powerpc/kernel/smp.c         |  2 +-
 include/linux/sched.h             | 13 +------------
 kernel/sched/sched.h              |  4 ----
 6 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index cee9f3e9f906..0bfc048221af 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -27,7 +27,6 @@
 int main(void)
 {
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
-  DEFINE(TSK_CPU,		offsetof(struct task_struct, cpu));
   BLANK();
   DEFINE(TSK_TI_CPU,		offsetof(struct task_struct, thread_info.cpu));
   DEFINE(TSK_TI_FLAGS,		offsetof(struct task_struct, thread_info.flags));
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 17962452e31d..6a98f1a38c29 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -412,7 +412,7 @@ SYM_FUNC_END(__create_page_tables)
 	scs_load \tsk
 
 	adr_l	\tmp1, __per_cpu_offset
-	ldr	w\tmp2, [\tsk, #TSK_CPU]
+	ldr	w\tmp2, [\tsk, #TSK_TI_CPU]
 	ldr	\tmp1, [\tmp1, \tmp2, lsl #3]
 	set_this_cpu_offset \tmp1
 	.endm
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e563d3222d69..e37e4546034e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -93,7 +93,7 @@ int main(void)
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
 #ifdef CONFIG_SMP
-	OFFSET(TASK_CPU, task_struct, cpu);
+	OFFSET(TASK_CPU, task_struct, thread_info.cpu);
 #endif
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9cc7d3dbf439..512d875b45e0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1223,7 +1223,7 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
 				 THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
-	idle->cpu = cpu;
+	task_thread_info(idle)->cpu = cpu;
 	secondary_current = current_set[cpu] = idle;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..8699594e3f99 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -750,10 +750,6 @@ struct task_struct {
 #ifdef CONFIG_SMP
 	int				on_cpu;
 	struct __call_single_node	wake_entry;
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	/* Current CPU: */
-	unsigned int			cpu;
-#endif
 	unsigned int			wakee_flips;
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
@@ -1886,10 +1882,7 @@ extern struct thread_info init_thread_info;
 extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-static inline struct thread_info *task_thread_info(struct task_struct *task)
-{
-	return &task->thread_info;
-}
+# define task_thread_info(task)	(&(task)->thread_info)
 #elif !defined(__HAVE_THREAD_FUNCTIONS)
 # define task_thread_info(task)	((struct thread_info *)(task)->stack)
 #endif
@@ -2114,11 +2107,7 @@ static __always_inline bool need_resched(void)
 
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	return READ_ONCE(p->cpu);
-#else
 	return READ_ONCE(task_thread_info(p)->cpu);
-#endif
 }
 
 extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e117..79fcbad11450 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1926,11 +1926,7 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 * per-task data have been completed by this moment.
 	 */
 	smp_wmb();
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-	WRITE_ONCE(p->cpu, cpu);
-#else
 	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
-#endif
 	p->wake_cpu = cpu;
 #endif
 }
-- 
2.30.2

