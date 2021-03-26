Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE51349D26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZAC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:02:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:15382 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhCZACp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:02:45 -0400
IronPort-SDR: bsHj8nPzRsXIGf0B7VO1XAhtr0rvDfqhVKCtuEVsBUjy1ZIDxg5nqSmXJ2jcWjeNTby1AMjj3r
 YmxFVPYMHHbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187748034"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="187748034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
IronPort-SDR: 6M0k84g+CKYIoUlN3FSrybSxkhZDcKiZliPuopz+OPLLsK/nBPB6BnJGO/1bIf3CYOarYuVJEk
 r1lQxPJkzKXA==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="416265843"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=20=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>
Subject: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user hits poison
Date:   Thu, 25 Mar 2021 17:02:34 -0700
Message-Id: <20210326000235.370514-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210326000235.370514-1-tony.luck@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski pointed out that sending SIGBUS to tasks that
hit poison in the kernel copying syscall parameters from user
address space is not the right semantic.

So stop doing that. Add a new kill_me_never() call back that
simply unmaps and offlines the poison page.

current-mce_vaddr is no longer used, so drop this field

---

Needs to be combined with other patches for bisectability
---
 arch/x86/kernel/cpu/mce/core.c     | 35 ++++++++++++++++--------------
 arch/x86/kernel/cpu/mce/severity.c |  2 --
 include/linux/sched.h              |  1 -
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..1570310cadab 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1263,32 +1263,32 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
-	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
 
-	if (p->mce_vaddr != (void __user *)-1l) {
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
-	} else {
-		pr_err("Memory error not recovered");
-		kill_me_now(cb);
-	}
+	pr_err("Memory error not recovered");
+	kill_me_now(cb);
 }
 
-static void queue_task_work(struct mce *m, int kill_current_task)
+static void kill_me_never(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+
+	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+}
+
+static void queue_task_work(struct mce *m, void (*func)(struct callback_head *))
 {
 	current->mce_addr = m->addr;
 	current->mce_kflags = m->kflags;
 	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 	current->mce_whole_page = whole_page(m);
-
-	if (kill_current_task)
-		current->mce_kill_me.func = kill_me_now;
-	else
-		current->mce_kill_me.func = kill_me_maybe;
+	current->mce_kill_me.func = func;
 
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
@@ -1426,7 +1426,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		if (kill_current_task)
+			queue_task_work(&m, kill_me_now);
+		else
+			queue_task_work(&m, kill_me_maybe);
 
 	} else {
 		/*
@@ -1444,7 +1447,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, kill_me_never);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991314c5..47810d12f040 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -251,8 +251,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	if (fault_in_kernel_space(addr))
 		return false;
 
-	current->mce_vaddr = (void __user *)addr;
-
 	return true;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164c..2d213b52730c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1358,7 +1358,6 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_X86_MCE
-	void __user			*mce_vaddr;
 	__u64				mce_kflags;
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
-- 
2.29.2

