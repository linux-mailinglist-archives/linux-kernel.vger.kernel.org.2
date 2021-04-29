Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCF36E744
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhD2IqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhD2IqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:46:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04470C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:45:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p198-20020a25d8cf0000b02904ededc510d0so13434115ybg.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UwIboEgJUrP9tu19e5ta5ZNsvYvcZVhVmHofP4kq4u4=;
        b=rtZwrnIc1R6copB94LkkXFkOzszKQUrpaP6zPSK1JxAcvOymRwUtbxVcyYur8yxFcj
         3Rlb0DbWcTgPs+sk4dlyQMRWkpk4vaIePOmRKXElhMEz7N4NjVctNIfv0XDir3SPbWvP
         bnkvpGAeRW1b19typiyv5S8N0gglgaeIQelaScbFA6wA95YST1KSP7ln0hyk/jD6VKOl
         VKJtg9Di8nHFNRSqrGo1oKyHZM5M+ijAEgmVwHU3Dr0bO5+HaAove5h9qbi7UjqcQfdN
         CmJ7ln1ERR/QyMJ9f63Cyu9oEzqwNF5GPX4jRYkMrvls6T4rfP3aUCLtF+28/bXxFiy5
         am4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UwIboEgJUrP9tu19e5ta5ZNsvYvcZVhVmHofP4kq4u4=;
        b=ZLwj1DO5Pj8TUKE+DHvAKzg4BQaeg9M+znVU47lva58pShaMe5No5aiFKybljtf5dX
         puV3w7smbLH1Tc0mezYGfqavhd1i+Y0dODrUxG/FV9haHXw38WEJueqHz2/jwwsAQclf
         FWqCW+ymmnT8RE0wD3bicUn0ZsuPAic5Teug3tx4xvFlFQBMSaOXdFj2p00VvOLaXT3F
         HX/Cy34L/O/GwvVbiaBiHIcuO4N85R5YNBNKr9XmUCGr0Zif+2BtJKO/q19DWezZXjKd
         XKder+lWGniiAXM1iaJGfJRj2sFXEvPABF5QHBdHkeHa4ICrtM3wn773nvfYmC4DDB4T
         EQ5w==
X-Gm-Message-State: AOAM5318KmuFxmnPGtSpayOdekQ3ByUTxE0Neq2lCCBaT5H5n0TsEy9n
        RJirSOptEprKGrMPgTCsDCrYirrWAsm2
X-Google-Smtp-Source: ABdhPJzWUNF+S7EL3zADC3WHO1yL8YjyRDIzExmU6yAd/OMsWoVXQIbesPbdkZ3f/XKr7FhTpBSbXM6FTnEf
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:30c1:7a5a:2ec9:29e5])
 (user=amistry job=sendgmr) by 2002:a25:5884:: with SMTP id
 m126mr18116299ybb.328.1619685913111; Thu, 29 Apr 2021 01:45:13 -0700 (PDT)
Date:   Thu, 29 Apr 2021 18:44:09 +1000
In-Reply-To: <20210429084410.783998-1-amistry@google.com>
Message-Id: <20210429184101.RFC.v2.1.Iadd904c1764f3bfe260db30fe41bdb9b8f98533d@changeid>
Mime-Version: 1.0
References: <20210429084410.783998-1-amistry@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 1/2] x86/speculation: Allow per-process control of when
 to issue IBPB
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, bp@alien8.de,
        tglx@linutronix.de, Anand K Mistry <amistry@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jay Lang <jaytlang@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When IB speculation is conditionally disabled for a process (via prctl()
or seccomp), an IBPB is issued whenever that process is switched to/from.
However, this results more IBPBs than necessary. The goal is to protect
a victim process from an attacker poisoning the BTB by issuing IBPB in
the attacker->victim switch. However, the current logic will also issue
IBPB in the victim->attacker switch, because there's no notion of
whether the process with IB speculation disabled is a potential
attacker or victim.

By default, there is no change in behaviour. If IBPB is conditionally
enabled, and a process has IB speculation disabled (either by seccomp or
prctl()), an IBPB will be issued whenever the process is switched to or
from.

But when prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_IBPB_MODE) is used, a
process can be tagged as either "sandboxed" or "protected". This
explicit tagging allows the IBPB to be avoided in one direction,
potentially cutting the number of IBPBs issued in half.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

Changes in v2:
- Make flag per-process using prctl().

 arch/x86/include/asm/thread_info.h |  4 +++
 arch/x86/kernel/cpu/bugs.c         | 56 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          | 10 ++++++
 arch/x86/mm/tlb.c                  | 51 ++++++++++++++++++++++-----
 include/linux/sched.h              | 10 ++++++
 include/uapi/linux/prctl.h         |  5 +++
 6 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index de406d93b515..8139b5d30884 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -97,6 +97,8 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_NO_IBPB_ENTRY	30	/* Prevent IBPB on address space entry */
+#define TIF_NO_IBPB_LEAVE	31	/* Prevent IBPB on address space leave */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -119,6 +121,8 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_NO_IBPB_ENTRY	(1 << TIF_NO_IBPB_ENTRY)
+#define _TIF_NO_IBPB_LEAVE	(1 << TIF_NO_IBPB_LEAVE)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..590a3f465eb6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1316,6 +1316,60 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static int ibpb_mode_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	/* Allow, but this is effectively a no-op. */
+	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE)
+		return 0;
+
+	/*
+	 * Don't allow changing modes if IBPB is always-on. This is logically
+	 * invalid since IBPB is *always* on, and setting the task flag won't do
+	 * anything due to the switch_mm_always_ibpb static branch.
+	 */
+	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT_PREFERRED)
+		return -EPERM;
+
+	/*
+	 * Mode must be set _before_ IB spec is disabled. A process with IB spec
+	 * disabled may not be trusted, so don't allow it to switch modes.
+	 */
+	if (task_spec_ib_disable(task))
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_IBPB_MODE_DEFAULT:
+		task_clear_spec_ibpb_disable_entry(task);
+		task_clear_spec_ibpb_disable_leave(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_IBPB_MODE_SANDBOX:
+		/*
+		 * Here, the process is considered a potential attacker.
+		 * Issue an IBPB when switching away from the process, to
+		 * prevent any BTB poisoning from affecting the next process.
+		 */
+		task_set_spec_ibpb_disable_entry(task);
+		task_clear_spec_ibpb_disable_leave(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_IBPB_MODE_PROTECT:
+		/*
+		 * Here, the process is considered a potential victim.
+		 * Issue the IBPB when switching to the process, to prevent any
+		 * BTB poisoning from affecting this process.
+		 */
+		task_clear_spec_ibpb_disable_entry(task);
+		task_set_spec_ibpb_disable_leave(task);
+		task_update_spec_tif(task);
+		break;
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl)
 {
@@ -1324,6 +1378,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_IBPB_MODE:
+		return ibpb_mode_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 43cbfc84153a..9536083a91b5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -565,6 +565,16 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			set_tsk_thread_flag(tsk, TIF_SPEC_IB);
 		else
 			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
+
+		if (task_spec_ibpb_disable_entry(tsk))
+			set_tsk_thread_flag(tsk, TIF_NO_IBPB_ENTRY);
+		else
+			clear_tsk_thread_flag(tsk, TIF_NO_IBPB_ENTRY);
+
+		if (task_spec_ibpb_disable_leave(tsk))
+			set_tsk_thread_flag(tsk, TIF_NO_IBPB_LEAVE);
+		else
+			clear_tsk_thread_flag(tsk, TIF_NO_IBPB_LEAVE);
 	}
 	/* Return the updated threadinfo flags*/
 	return task_thread_info(tsk)->flags;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 98f269560d40..fd166b641e50 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,14 +316,25 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec_ib_on_leave(
+	struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_disabled =
+		(next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_LEAVE);
+	unsigned long ibpb = spec_disabled & LAST_USER_MM_IBPB;
 
 	return (unsigned long)next->mm | ibpb;
 }
 
+static inline bool ibpb_on_entry(struct task_struct *next)
+{
+	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long spec_disabled =
+		(next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_ENTRY);
+	return spec_disabled & 1;
+}
+
 static void cond_ibpb(struct task_struct *next)
 {
 	if (!next || !next->mm)
@@ -340,10 +351,11 @@ static void cond_ibpb(struct task_struct *next)
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
 		unsigned long prev_mm, next_mm;
+		bool next_entry_ibpb;
 
 		/*
 		 * This is a bit more complex than the always mode because
-		 * it has to handle two cases:
+		 * it has to handle four cases:
 		 *
 		 * 1) Switch from a user space task (potential attacker)
 		 *    which has TIF_SPEC_IB set to a user space task
@@ -353,6 +365,17 @@ static void cond_ibpb(struct task_struct *next)
 		 *    which has TIF_SPEC_IB not set to a user space task
 		 *    (potential victim) which has TIF_SPEC_IB set.
 		 *
+		 * 3) Switch from a user space task (potential victim)
+		 *    which has TIF_SPEC_IB set to a user space task
+		 *    (potential attacker) which has TIF_SPEC_IB not set.
+		 *
+		 * 4) Switch from a user space task (potential victim)
+		 *    which has TIF_SPEC_IB not set to a user space task
+		 *    (potential attacker) which has TIF_SPEC_IB set.
+		 *
+		 * Only the first two cases require issuing an IBPB to prevent
+		 * the victim from being affected by BTB poisoning.
+		 *
 		 * This could be done by unconditionally issuing IBPB when
 		 * a task which has TIF_SPEC_IB set is either scheduled in
 		 * or out. Though that results in two flushes when:
@@ -367,20 +390,30 @@ static void cond_ibpb(struct task_struct *next)
 		 * - a user space task belonging to the same process is
 		 *   scheduled in immediately.
 		 *
+		 * In addition, this also does not distinguish between the cases
+		 * where the switch is attacker->victim (1/2) or
+		 * victim->attacker (3/4). To distinguish between those cases,
+		 * an additional pair of flags, TIF_NO_IBPB_ENTRY and
+		 * TIF_NO_IBPB_LEAVE, control whether the IBPB is to be issued
+		 * on task entry or leave.
+		 *
 		 * Optimize this with reasonably small overhead for the
-		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
-		 * pointer of the incoming task which is stored in
+		 * above cases where the previous task is a potential attacker.
+		 * Mangle the TIF_SPEC_IB bit into the mm pointer of the
+		 * incoming task which is stored in
 		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
 		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
+		next_mm = mm_mangle_tif_spec_ib_on_leave(next);
+		next_entry_ibpb = ibpb_on_entry(next);
 		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
 
 		/*
-		 * Issue IBPB only if the mm's are different and one or
-		 * both have the IBPB bit set.
+		 * Issue IBPB only if the mm's are different and either the task
+		 * being switch to requires an IBPB (potential victim), or the
+		 * previous task requires an IBPB (potential attacker).
 		 */
 		if (next_mm != prev_mm &&
-		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
+		    (next_entry_ibpb || (prev_mm & LAST_USER_MM_IBPB)))
 			indirect_branch_prediction_barrier();
 
 		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f652a8ccad73..d9ffd1794796 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1625,6 +1625,8 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_SPEC_IBPB_DISABLE_ENTRY	8	/* Avoid indirect branch prediction barrier on task entry */
+#define PFA_SPEC_IBPB_DISABLE_LEAVE	9	/* Avoid indirect branch prediction barrier on task leave */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1667,6 +1669,14 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
 TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 
+TASK_PFA_TEST(SPEC_IBPB_DISABLE_ENTRY, spec_ibpb_disable_entry);
+TASK_PFA_SET(SPEC_IBPB_DISABLE_ENTRY, spec_ibpb_disable_entry);
+TASK_PFA_CLEAR(SPEC_IBPB_DISABLE_ENTRY, spec_ibpb_disable_entry);
+
+TASK_PFA_TEST(SPEC_IBPB_DISABLE_LEAVE, spec_ibpb_disable_leave);
+TASK_PFA_SET(SPEC_IBPB_DISABLE_LEAVE, spec_ibpb_disable_leave);
+TASK_PFA_CLEAR(SPEC_IBPB_DISABLE_LEAVE, spec_ibpb_disable_leave);
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 18a9f59dc067..e070e214ddc9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_IBPB_MODE		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
@@ -220,6 +221,10 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 # define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
+/* Indirect branch prediction barrier control */
+# define PR_SPEC_IBPB_MODE_DEFAULT	0
+# define PR_SPEC_IBPB_MODE_SANDBOX	1
+# define PR_SPEC_IBPB_MODE_PROTECT	2
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54
-- 
2.31.1.498.g6c1eba8ee3d-goog

