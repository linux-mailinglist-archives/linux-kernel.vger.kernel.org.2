Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891D035D355
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhDLWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343807AbhDLWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:43:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24662C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so7150471plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEcfkWjzQjcy5UJ/ItAB81OJjAIgDt8AwI4FNa9iha4=;
        b=JU/b6l8DSFz0zV7qBlusgUefLKuWDkZ14uln/XgG8qdgR3V+PpN3v36OleMrM2NyHI
         /biJAQJldS0fqoIrsOgDss5/LeYzxoMcigzDvWTgCs1JSLsQstvzYVGDOnUU1/UL/l/V
         xP5yyIu9HgUYzhp8mG4hTqlCTUb06EyQJG1A7FHvPqvgItMn7Z/MqxaOTFtrk3J7XI+Y
         6JItWUhWKlbIv1+bvQXvwBooU57N/NrfFZnf1IxKAyU1WuF3S2XNKI5VTMdJANic1jOu
         Ge8y+sM6Y7sjKMx9pPTyevVC9o6KBc+1C9uVrur7ri1pABmYN4LbTtiX81wz2d/6pG6U
         0bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEcfkWjzQjcy5UJ/ItAB81OJjAIgDt8AwI4FNa9iha4=;
        b=IJB2AcahwnXYy3nE5rXvsAqmIaiuMRC1cfN+wuvIf3xII2OrEQbP6iFSoAEjTquzmF
         0RoFTl6pJv8OOHF7ru9NUqvIuSoJY1qUz/bX4LWn1PioE126i6N88LHTUAAUIOhZS9Bo
         qcd1c3i2cJYTuVMeifTm71Ob66njEbrtrIafSBM91w6CeyL3biCY9pkL4nFXo+c6CWvD
         z6Js4MisoDzdEvORLXoH1AEbfulzXn4/8tK5Wa1xWAgLA0LWoS7ysA92FJ1T1OfSOVFj
         BM7POiK+SwIbIUhwKQEdIOESlN01b3qLQCA9g9ozJz2xxXxSQ9HklppUuRE8r7Lh+MUw
         5jMw==
X-Gm-Message-State: AOAM532s1Kqgzz0N7HWZe9WDGweMjchoebyU0DkCIkUlH9tEPFFV+CSn
        sRd/g48VnoLdrIPOM+qNhA==
X-Google-Smtp-Source: ABdhPJz/vrU0iXVN/bE+hDIGcvFZngGKof/HaE1In90UBYxRTyxthWWXv1zVg0HsSK7flMVYag1eKw==
X-Received: by 2002:a17:902:59d4:b029:ea:bbc5:c775 with SMTP id d20-20020a17090259d4b02900eabbc5c775mr14523796plj.11.1618267415716;
        Mon, 12 Apr 2021 15:43:35 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id l25sm13365373pgu.72.2021.04.12.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:43:35 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find error virtual address
Date:   Tue, 13 Apr 2021 07:43:20 +0900
Message-Id: <20210412224320.1747638-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The previous patch solves the infinite MCE loop issue when multiple
MCE events races.  The remaining issue is to make sure that all threads
processing Action Required MCEs send to the current processes the
SIGBUS with the proper virtual address and the error size.

This patch suggests to do page table walk to find the error virtual
address.  If we find multiple virtual addresses in walking, we now can't
determine which one is correct, so we fall back to sending SIGBUS in
kill_me_maybe() without error info as we do now.  This corner case needs
to be solved in the future.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 147 ++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 4 deletions(-)

diff --git v5.12-rc5/arch/x86/kernel/cpu/mce/core.c v5.12-rc5_patched/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..3ce23445a48c 100644
--- v5.12-rc5/arch/x86/kernel/cpu/mce/core.c
+++ v5.12-rc5_patched/arch/x86/kernel/cpu/mce/core.c
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
diff --git v5.12-rc5/include/linux/swapops.h v5.12-rc5_patched/include/linux/swapops.h
index d9b7c9132c2f..98ea67fcf360 100644
--- v5.12-rc5/include/linux/swapops.h
+++ v5.12-rc5_patched/include/linux/swapops.h
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
diff --git v5.12-rc5/mm/memory-failure.c v5.12-rc5_patched/mm/memory-failure.c
index 368ef77e01f9..04e002bd573a 100644
--- v5.12-rc5/mm/memory-failure.c
+++ v5.12-rc5_patched/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/pagewalk.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -554,6 +555,142 @@ static void collect_procs(struct page *page, struct list_head *tokill,
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
+	unsigned long pfn;
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
+	int ret;
+	pte_t *ptep;
+	spinlock_t *ptl;
+
+	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
+	if (ptl) {
+		pmd_t pmd = *pmdp;
+
+		if (pmd_present(pmd)) {
+			unsigned long pfn = pmd_pfn(pmd);
+
+			if (pfn <= hwp->pfn && hwp->pfn < pfn + PMD_SIZE) {
+				unsigned long hwpoison_vaddr = addr +
+					(hwp->pfn << PAGE_SHIFT & ~PMD_MASK);
+
+				ret = set_to_kill(&hwp->tk, hwpoison_vaddr,
+						  PAGE_SHIFT);
+			}
+		}
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
+ * Sends SIGBUS to the current process with the error info.
+ *
+ * This function is intended to handle "Action Required" MCEs on already
+ * hardware poisoned pages. They could happen, for example, when
+ * memory_failure() failed to unmap the error page at the first call, or
+ * when multiple Action Optional MCE events races on different CPUs with
+ * Local MCE enabled.
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
@@ -1228,7 +1365,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
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
@@ -1437,8 +1577,11 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		mutex_unlock(&mf_mutex);
-		return -EHWPOISON;
+		return res;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.25.1

