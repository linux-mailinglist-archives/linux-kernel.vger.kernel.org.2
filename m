Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB7398172
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFBGze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2946 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhFBGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw06L4mC9z66Y3;
        Wed,  2 Jun 2021 14:50:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:48 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/7] ARM: mm: print out correct page table entries
Date:   Wed, 2 Jun 2021 15:02:43 +0800
Message-ID: <20210602070246.83990-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit 67ce16ec15ce ("arm64: mm: print out correct page table entries")
does, drop the struct mm_struct argument of show_pte(), print the tables
based on the faulting address.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/include/asm/bug.h |  2 +-
 arch/arm/kernel/traps.c    |  2 +-
 arch/arm/mm/fault.c        | 36 ++++++++++++++++++++----------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index ba8d9d7d242b..d618640e34aa 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -86,7 +86,7 @@ extern asmlinkage void c_backtrace(unsigned long fp, int pmode,
 				   const char *loglvl);
 
 struct mm_struct;
-void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr);
+void show_pte(const char *lvl, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 extern void __show_regs_alloc_free(struct pt_regs *regs);
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 64308e3a5d0c..98c904aeee78 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -736,7 +736,7 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 		pr_err("[%d] %s: bad data abort: code %d instr 0x%08lx\n",
 		       task_pid_nr(current), current->comm, code, instr);
 		dump_instr(KERN_ERR, regs);
-		show_pte(KERN_ERR, current->mm, addr);
+		show_pte(KERN_ERR, addr);
 	}
 #endif
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 9a6d74f6ea1d..71a5c29488c2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -27,15 +27,23 @@
 #ifdef CONFIG_MMU
 
 /*
- * This is useful to dump out the page tables associated with
- * 'addr' in mm 'mm'.
+ * Dump out the page tables associated with 'addr' in the currently active mm
  */
-void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
+void show_pte(const char *lvl, unsigned long addr)
 {
 	pgd_t *pgd;
-
-	if (!mm)
+	struct mm_struct *mm;
+
+	if (addr < TASK_SIZE) {
+		mm = current->active_mm;
+		if (mm == &init_mm) {
+			printk("%s[%08lx] user address but active_mm is swapper\n",
+				lvl, addr);
+			return;
+		}
+	} else {
 		mm = &init_mm;
+	}
 
 	printk("%spgd = %p\n", lvl, mm->pgd);
 	pgd = pgd_offset(mm, addr);
@@ -96,7 +104,7 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 	pr_cont("\n");
 }
 #else					/* CONFIG_MMU */
-void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
+void show_pte(const char *lvl, unsigned long addr)
 { }
 #endif					/* CONFIG_MMU */
 
@@ -104,8 +112,7 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
  * Oops.  The kernel tried to access some page that wasn't present.
  */
 static void
-__do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		  struct pt_regs *regs)
+__do_kernel_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	/*
 	 * Are we prepared to handle this kernel fault?
@@ -122,7 +129,7 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
 		 "paging request", addr);
 
-	show_pte(KERN_ALERT, mm, addr);
+	show_pte(KERN_ALERT, addr);
 	die("Oops", regs, fsr);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
@@ -147,7 +154,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 		pr_err("8<--- cut here ---\n");
 		pr_err("%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
 		       tsk->comm, sig, addr, fsr);
-		show_pte(KERN_ERR, tsk->mm, addr);
+		show_pte(KERN_ERR, addr);
 		show_regs(regs);
 	}
 #endif
@@ -166,9 +173,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->active_mm;
-
 	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
@@ -176,7 +180,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (user_mode(regs))
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
-		__do_kernel_fault(mm, addr, fsr, regs);
+		__do_kernel_fault(addr, fsr, regs);
 }
 
 #ifdef CONFIG_MMU
@@ -336,7 +340,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 0;
 
 no_context:
-	__do_kernel_fault(mm, addr, fsr, regs);
+	__do_kernel_fault(addr, fsr, regs);
 	return 0;
 }
 #else					/* CONFIG_MMU */
@@ -503,7 +507,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
-	show_pte(KERN_ALERT, current->mm, addr);
+	show_pte(KERN_ALERT, addr);
 
 	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
 		       fsr, 0);
-- 
2.26.2

