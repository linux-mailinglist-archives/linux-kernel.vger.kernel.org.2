Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19638BCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhEUDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbhEUDDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:03:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so5218145pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MH94uIHMeoDjk3zXobqNy3iErBgo2MMguCnQ5paX5D4=;
        b=C0Szw1wFaLt4RsgPq1+m2fKIvOSDWr8xoUgr3cDf1tIsu9MRuDdE+bXUp9t14OM+Vg
         CNsHJpOWc8BNDdBHFo08XSYRl3jCpzK2e71kFFio/Fpcvd1ZfGXq4QNvGQzdynCjV5A1
         6e+XFxZLR5FAYxTU2wx7kLPmz8VzUkT4Dv/JrwO9gd7ZtJlAvahun7wdTCKQjNpApyOl
         76yXZ0eveC3XW98MCRt5QHi+ivqgYkPb7s84NEfRsqqamEZwBtCh9t5rIQXXzT4vJqTP
         0F41PzWfmaE7us3HDdsWMoIvSGZlwtawApFbeJXsHrIXI8nBaE2ei4tmFO9mKaYokT9B
         /+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MH94uIHMeoDjk3zXobqNy3iErBgo2MMguCnQ5paX5D4=;
        b=dvwBKHEY7TMd8t9znLeNj7Qz2iVB1eCr+6zobLiIvt/l0e7HMk9GPXLorTg88qj46I
         Tfdv260FYi5ln60OgWd20pkfXc2SX2W5I3MHpPOoW4tefgknRUJL9ChCPrnEaz/1ysML
         gg8OADui9QZsR1nd/vZTwwD/+8OAh8twtf4dfLNNkHBsAc0ptCzZq8Mc8DJq5XrwYwv6
         BuDSY0r8bhX2tlhSjjU+saGTPWTzXPjlrL622jxbjfgRm0dZAeHHISg9SLrg0uZSTw9K
         BvVwETshXyYyo8bYzAB1t1OsG4QOYm9BOeTh0v5fP9zXM/AQzoW5MVc44pfS7UIyM7Cd
         wMUg==
X-Gm-Message-State: AOAM5315UBdm2NEJB+urcIERrG3vs6t1Z9nuZIMYScEQB4YdB1mg0u7t
        apPbOgD1t1t2ZySe6VJ+nw==
X-Google-Smtp-Source: ABdhPJybg9fSkjtWKRuss5+gcKVA5fpqZNUNWUejwaSKi+iUWFMSdo97tXrKmGz1mCQW6/cxvEwgRg==
X-Received: by 2002:a17:90b:e02:: with SMTP id ge2mr8361420pjb.196.1621566132714;
        Thu, 20 May 2021 20:02:12 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id 191sm2959677pfx.121.2021.05.20.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:02:12 -0700 (PDT)
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
Subject: [PATCH v5 3/3] mm,hwpoison: Send SIGBUS with error virutal address
Date:   Fri, 21 May 2021 12:01:56 +0900
Message-Id: <20210521030156.2612074-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now an action required MCE in already hwpoisoned address surely sends a
SIGBUS to current process, but the SIGBUS doesn't convey error virtual
address.  That's not optimal for hwpoison-aware applications.

To fix the issue, make memory_failure() call kill_accessing_process(),
that does pagetable walk to find the error virtual address.  It could
find multiple virtual addresses for the same error page, and it seems
hard to tell which virtual address is correct one.  But that's rare
and sending incorrect virtual address could be better than no address.
So let's report the first found virtual address for now.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
change log v4 -> v5:
- switched to first found approach,
- introduced check_hwpoisoned_pmd_entry() to fix build failure on arch
  without thp support.

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
 mm/memory-failure.c            | 150 ++++++++++++++++++++++++++++++++-
 3 files changed, 165 insertions(+), 3 deletions(-)

diff --git v5.13-rc2/arch/x86/kernel/cpu/mce/core.c v5.13-rc2_patched/arch/x86/kernel/cpu/mce/core.c
index bf7fe87a7e88..22791aadc085 100644
--- v5.13-rc2/arch/x86/kernel/cpu/mce/core.c
+++ v5.13-rc2_patched/arch/x86/kernel/cpu/mce/core.c
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
+	 * send SIGBUS here again.
+	 */
+	if (ret == -EHWPOISON)
+		return;
+
 	if (p->mce_vaddr != (void __user *)-1l) {
 		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
 	} else {
diff --git v5.13-rc2/include/linux/swapops.h v5.13-rc2_patched/include/linux/swapops.h
index d9b7c9132c2f..98ea67fcf360 100644
--- v5.13-rc2/include/linux/swapops.h
+++ v5.13-rc2_patched/include/linux/swapops.h
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
diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 8add7cafad5e..137cd0f61af3 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/pagewalk.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -554,6 +555,148 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 		collect_procs_file(page, tokill, force_early);
 }
 
+struct hwp_walk {
+	struct to_kill tk;
+	unsigned long pfn;
+	int flags;
+};
+
+static void set_to_kill(struct to_kill *tk, unsigned long addr, short shift)
+{
+	tk->addr = addr;
+	tk->size_shift = shift;
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
+	set_to_kill(tk, addr, shift);
+	return 1;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
+				      struct hwp_walk *hwp)
+{
+	pmd_t pmd = *pmdp;
+	unsigned long pfn;
+	unsigned long hwpoison_vaddr;
+
+	if (!pmd_present(pmd))
+		return 0;
+	pfn = pmd_pfn(pmd);
+	if (pfn <= hwp->pfn && hwp->pfn < pfn + HPAGE_PMD_NR) {
+		hwpoison_vaddr = addr + ((hwp->pfn - pfn) << PAGE_SHIFT);
+		set_to_kill(&hwp->tk, hwpoison_vaddr, PAGE_SHIFT);
+		return 1;
+	}
+	return 0;
+}
+#else
+static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
+				      struct hwp_walk *hwp)
+{
+	return 0;
+}
+#endif
+
+static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
+{
+	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
+	int ret = 0;
+	pte_t *ptep;
+	spinlock_t *ptl;
+
+	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
+	if (ptl) {
+		ret = check_hwpoisoned_pmd_entry(pmdp, addr, hwp);
+		spin_unlock(ptl);
+		goto out;
+	}
+
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
+ * Sends SIGBUS to the current process with error info.
+ *
+ * This function is intended to handle "Action Required" MCEs on already
+ * hardware poisoned pages. They could happen, for example, when
+ * memory_failure() failed to unmap the error page at the first call, or
+ * when multiple local machine checks happened on different CPUs.
+ *
+ * MCE handler currently has no easy access to the error virtual address,
+ * so this function walks page table to find it. The returned virtual address
+ * is proper in most cases, but it could be wrong when the application
+ * process has multiple entries mapping the error page.
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
+	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
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
@@ -1247,7 +1390,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return -EHWPOISON;
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, page_to_pfn(head), flags);
+		return res;
 	}
 
 	num_poisoned_pages_inc();
@@ -1457,6 +1603,8 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		goto unlock_mutex;
 	}
 
-- 
2.25.1

