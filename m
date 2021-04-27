Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA636BF52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhD0Gay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhD0Gaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:30:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g16so13437898plq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SQOGfRhOvmrRAB3OwuASj4ObtEZfSj/KmwjsOnqiSE=;
        b=UvR6wyoZactuHmK0ODzJV0Csj6QMjeR0s+QsW5/uJ7Ju0JqALZzLQLzFGy5EKK+dgP
         S4nIb+tiy5qm1ec6Snjc0O2Y/dL9xpX2NBBat63RBbxRuIJardDNPh/wXO4Xw9ztRoSM
         ABDufnwJa4LE5PAmGUOB0bOSBPoxo4rqnXzcoAswnPOy2nZs0kPp5jfId4586tI++DAK
         GXVS9HoA054B7YinwVMjhDhNoGuYLukwXdP/i0JQbFQ139yglDXVC4VbrUixxuXE1ltP
         jH2QRVAPllNKsaJc+iqSkpXzxePV6Etec5KeFIaYyT4/susfd5JsrKsZ6KGDfCfNTXe7
         niog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SQOGfRhOvmrRAB3OwuASj4ObtEZfSj/KmwjsOnqiSE=;
        b=pZ89y6QnADbnhg074tjd1lUhqaTUNsNrQQyylAK1GMNtx7jPK0R+9mqfr+FKSY9neR
         qoUrHbR3wyOn3ToFn2Ch3NnaBFyjkRSCD8zICF+OBLqATKTKxqsFZJV11HhxNNJKzpUG
         4cRk/3WE0oeEuqlT2r7DHKL7WYifP+sh7099YWWZnaKknoLzEUxKiOVXnDCiSu+PKS+V
         Z4FaUu7g7hPwY+7ci1IX54pqiN0bgkSF3iNwup8SrVNRqU0nJGwfDY8Js0UxvYMQjH3/
         hE3q6xTZLmex8rSSXQ1rbx1Jcu63tpaZkfpU2Q49EGQQNU2QeXw4DLdprD27lnCyaTfy
         0O2g==
X-Gm-Message-State: AOAM531NYZXkgW/ZzoF8Wa8GwFWEg8MEASNMVzTPKXzkZPieZOlVAvGQ
        OSkZKV7Cm0ZvUv1rwmAK5Q==
X-Google-Smtp-Source: ABdhPJzQNpGxdL1CV9nUdLnegqUNZvAmnHzS3LG02PsnEIgOiFZ6GIFvDW+7kU/Le8Z8bqfZm6I1rg==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr3133848pjo.135.1619505009581;
        Mon, 26 Apr 2021 23:30:09 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id t9sm902704pgg.6.2021.04.26.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 23:30:09 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has already been poisoned
Date:   Tue, 27 Apr 2021 15:29:53 +0900
Message-Id: <20210427062953.2080293-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When memory_failure() is called with MF_ACTION_REQUIRED on the
page that has already been hwpoisoned, memory_failure() could fail
to send SIGBUS to the affected process, which results in infinite
loop of MCEs.

Currently memory_failure() returns 0 if it's called for already
hwpoisoned page, then the caller, kill_me_maybe(), could return
without sending SIGBUS to current process.  An action required MCE
is raised when the current process accesses to the broken memory,
so no SIGBUS means that the current process continues to run and
access to the error page again soon, so running into MCE loop.

This issue can arise for example in the following scenarios:

  - Two or more threads access to the poisoned page concurrently.
    If local MCE is enabled, MCE handler independently handles the
    MCE events.  So there's a race among MCE events, and the
    second or latter threads fall into the situation in question.

  - If there was a precedent memory error event and memory_failure()
    for the event failed to unmap the error page for some reason,
    the subsequent memory access to the error page triggers the
    MCE loop situation.

To fix the issue, make memory_failure() return some error code when the
error page has already been hwpoisoned.  This allows memory error
handler to control how it sends signals to userspace.  And make sure
that any process touching a hwpoisoned page should get a SIGBUS (if
possible) with the error virtual address, even in "already hwpoisoned"
path of memory_failure() as is done in page fault path.

kill_accessing_process() does pagetable walk to find the error virtual
address.  If multiple virtual addresses are found in the pagetable walk,
no one knows which address is the correct one, so we fall back to sending
SIGBUS in kill_me_maybe() without error address info as we do now.
This corner case is left to be solved in the future.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
change log v3 -> v4:
- refactored hwpoison_pte_range to save indentation,
- updated patch description

change log v1 -> v2:
- initialize local variables in check_hwpoisoned_entry() and
  hwpoison_pte_range()
- fix and improve logic to calculate error address offset.
---
 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 143 ++++++++++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 3 deletions(-)

diff --git v5.12/arch/x86/kernel/cpu/mce/core.c v5.12_patched/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..3ce23445a48c 100644
--- v5.12/arch/x86/kernel/cpu/mce/core.c
+++ v5.12_patched/arch/x86/kernel/cpu/mce/core.c
@@ -1257,19 +1257,28 @@ static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
+	int ret;
 
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
-	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
+	if (!ret && !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
 
+	/*
+	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
+	 * to the current process with the proper error info, so no need to
+	 * send it here again.
+	 */
+	if (ret == -EHWPOISON)
+		return;
+
 	if (p->mce_vaddr != (void __user *)-1l) {
 		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
 	} else {
diff --git v5.12/include/linux/swapops.h v5.12_patched/include/linux/swapops.h
index d9b7c9132c2f..98ea67fcf360 100644
--- v5.12/include/linux/swapops.h
+++ v5.12_patched/include/linux/swapops.h
@@ -323,6 +323,11 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) == SWP_HWPOISON;
 }
 
+static inline unsigned long hwpoison_entry_to_pfn(swp_entry_t entry)
+{
+	return swp_offset(entry);
+}
+
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index 4087308e4b32..a3659619d293 100644
--- v5.12/mm/memory-failure.c
+++ v5.12_patched/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/pagewalk.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -554,6 +555,140 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 		collect_procs_file(page, tokill, force_early);
 }
 
+struct hwp_walk {
+	struct to_kill tk;
+	unsigned long pfn;
+	int flags;
+};
+
+static int set_to_kill(struct to_kill *tk, unsigned long addr, short shift)
+{
+	/* Abort pagewalk when finding multiple mappings to the error page. */
+	if (tk->addr)
+		return 1;
+	tk->addr = addr;
+	tk->size_shift = shift;
+	return 0;
+}
+
+static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
+				unsigned long poisoned_pfn, struct to_kill *tk)
+{
+	unsigned long pfn = 0;
+
+	if (pte_present(pte)) {
+		pfn = pte_pfn(pte);
+	} else {
+		swp_entry_t swp = pte_to_swp_entry(pte);
+
+		if (is_hwpoison_entry(swp))
+			pfn = hwpoison_entry_to_pfn(swp);
+	}
+
+	if (!pfn || pfn != poisoned_pfn)
+		return 0;
+
+	return set_to_kill(tk, addr, shift);
+}
+
+static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
+{
+	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
+	int ret = 0;
+	pte_t *ptep;
+	pmd_t pmd;
+	spinlock_t *ptl;
+	unsigned long pfn;
+	unsigned long hwpoison_vaddr;
+
+	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
+	if (!ptl)
+		goto pte_loop;
+	pmd = *pmdp;
+	if (!pmd_present(pmd))
+		goto unlock;
+	pfn = pmd_pfn(pmd);
+	if (pfn <= hwp->pfn && hwp->pfn < pfn + HPAGE_PMD_NR) {
+		hwpoison_vaddr = addr + ((hwp->pfn - pfn) << PAGE_SHIFT);
+		ret = set_to_kill(&hwp->tk, hwpoison_vaddr, PAGE_SHIFT);
+	}
+unlock:
+	spin_unlock(ptl);
+	goto out;
+pte_loop:
+	if (pmd_trans_unstable(pmdp))
+		goto out;
+
+	ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp, addr, &ptl);
+	for (; addr != end; ptep++, addr += PAGE_SIZE) {
+		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
+					     hwp->pfn, &hwp->tk);
+		if (ret == 1)
+			break;
+	}
+	pte_unmap_unlock(ptep - 1, ptl);
+out:
+	cond_resched();
+	return ret;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
+			    unsigned long addr, unsigned long end,
+			    struct mm_walk *walk)
+{
+	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
+	pte_t pte = huge_ptep_get(ptep);
+	struct hstate *h = hstate_vma(walk->vma);
+
+	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
+				      hwp->pfn, &hwp->tk);
+}
+#else
+#define hwpoison_hugetlb_range	NULL
+#endif
+
+static struct mm_walk_ops hwp_walk_ops = {
+	.pmd_entry = hwpoison_pte_range,
+	.hugetlb_entry = hwpoison_hugetlb_range,
+};
+
+/*
+ * Sends SIGBUS to the current process with the error info.
+ *
+ * This function is intended to handle "Action Required" MCEs on already
+ * hardware poisoned pages. They could happen, for example, when
+ * memory_failure() failed to unmap the error page at the first call, or
+ * when multiple local machine checks happened on different CPUs.
+ *
+ * MCE handler currently has no easy access to the error virtual address,
+ * so this function walks page table to find it. One challenge on this is
+ * to reliably get the proper virual address of the error to report to
+ * applications via SIGBUS. A process could map a page multiple times to
+ * different virtual addresses, then we now have no way to tell which virtual
+ * address was accessed when the Action Required MCE was generated.
+ * So in such a corner case, we now give up and fall back to sending SIGBUS
+ * with no error info.
+ */
+static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
+				  int flags)
+{
+	int ret;
+	struct hwp_walk priv = {
+		.pfn = pfn,
+	};
+	priv.tk.tsk = p;
+
+	mmap_read_lock(p->mm);
+	ret = walk_page_range(p->mm, 0, TASK_SIZE_MAX, &hwp_walk_ops,
+			      (void *)&priv);
+	if (!ret && priv.tk.addr)
+		kill_proc(&priv.tk, pfn, flags);
+	mmap_read_unlock(p->mm);
+	return ret ? -EFAULT : -EHWPOISON;
+}
+
 static const char *action_name[] = {
 	[MF_IGNORED] = "Ignored",
 	[MF_FAILED] = "Failed",
@@ -1228,7 +1363,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, page_to_pfn(head), flags);
+		return res;
 	}
 
 	num_poisoned_pages_inc();
@@ -1437,6 +1575,9 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		goto unlock_mutex;
 	}
 
-- 
2.25.1

