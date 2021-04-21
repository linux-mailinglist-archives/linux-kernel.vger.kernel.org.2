Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB136633C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhDUA60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhDUA6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e2so16353902plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVzrlAG5S4c5i21A2xQbfzsii/cvRpawzHB8MLnK5hw=;
        b=WaRpcDHov1beFYCT2p6RMBCG8Y8ImRcIA3gF3lzt8NuXHteo9YydUpVX3Suy1+E0Nf
         Doi+2kM++82zEk6ikHT7iHrD+DrSbTU4z7CH9qrYRfL2MBXIwSXTXikrYYAF6So/2Ku8
         JBG3smlDOgOxUUXxEOUBGElexpdkLqLVbXVLabGyD1TI6tJlGzmT99diIuYPD53ZYbb1
         q0qLC2tIOzhxuE2qL0ZnqiclVb3H18XhF/tn2Fc1IcXpsZCjVmUuw4yMZNuKLFw1F9XK
         bLjUwrNtUDwe9mcqNhuqVxsoJW7sRVR72WzsunIf9e436AwJCjU07GrQEyKUn4rWvzGj
         394w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVzrlAG5S4c5i21A2xQbfzsii/cvRpawzHB8MLnK5hw=;
        b=piAmz7WM+90tAIl7gKLkS5vRDLXbtRcOpnlpvnUaiRsSW0DJ7R3P5uwaoAgafCMzDx
         Af3roACB8bjD3+nZswpZTkQ63EmuBcoj2izYc6MpyBr+ZrGmXqxZI0Dgx8AeMzVQFAhT
         wfudV4xqMvuMx/kPtztHFXjgPOkIIP/IpJrSr7sprHqc/luNjxrlFBRARNVA/ujrD10B
         M5Sgi5WUHiR5nNJwK0G5NWOZZ30KNHfCLOPVsTgTa8DCiVxAb9pv1kvdSUreRiq/Y0E9
         W+piJCLwygsV8bqNoA+nnOuNigMg+OFJ4Kj6whSJKmuvrjC7vKbeOrd98LFiCk8iy216
         /ScA==
X-Gm-Message-State: AOAM532DDqPl6zLCSOAcrh2uWPoVyyL5NhC4UvbA2ZGrXE+8C3MNJITd
        p/KBoZp5EQXTjAqhTqGleg==
X-Google-Smtp-Source: ABdhPJyDF63dp3mPKSPMKWzeP4+nvo6GjM1DF03V/LB7qEKFmHlWODOrF2fXRAg0xkzIHmEvJL8FEQ==
X-Received: by 2002:a17:902:8487:b029:e9:a884:7450 with SMTP id c7-20020a1709028487b02900e9a8847450mr31666657plo.49.1618966667722;
        Tue, 20 Apr 2021 17:57:47 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id e13sm178278pfi.199.2021.04.20.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:57:47 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find error virtual address
Date:   Wed, 21 Apr 2021 09:57:28 +0900
Message-Id: <20210421005728.1994268-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
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
Tested-by: Aili Yao <yaoaili@kingsoft.com>
---
change log v1 -> v2:
- initialize local variables in check_hwpoisoned_entry() and
  hwpoison_pte_range()
- fix and improve logic to calculate error address offset.
---
 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 143 ++++++++++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 3 deletions(-)

diff --git v5.12-rc8/arch/x86/kernel/cpu/mce/core.c v5.12-rc8_patched/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..3ce23445a48c 100644
--- v5.12-rc8/arch/x86/kernel/cpu/mce/core.c
+++ v5.12-rc8_patched/arch/x86/kernel/cpu/mce/core.c
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
diff --git v5.12-rc8/include/linux/swapops.h v5.12-rc8_patched/include/linux/swapops.h
index d9b7c9132c2f..98ea67fcf360 100644
--- v5.12-rc8/include/linux/swapops.h
+++ v5.12-rc8_patched/include/linux/swapops.h
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
diff --git v5.12-rc8/mm/memory-failure.c v5.12-rc8_patched/mm/memory-failure.c
index 39d0ff0339b9..7cc563e1770a 100644
--- v5.12-rc8/mm/memory-failure.c
+++ v5.12-rc8_patched/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/pagewalk.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -554,6 +555,141 @@ static void collect_procs(struct page *page, struct list_head *tokill,
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
+	spinlock_t *ptl;
+
+	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
+	if (ptl) {
+		pmd_t pmd = *pmdp;
+
+		if (pmd_present(pmd)) {
+			unsigned long pfn = pmd_pfn(pmd);
+
+			if (pfn <= hwp->pfn && hwp->pfn < pfn + HPAGE_PMD_NR) {
+				unsigned long hwpoison_vaddr = addr +
+					((hwp->pfn - pfn) << PAGE_SHIFT);
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
@@ -1228,7 +1364,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
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
@@ -1438,6 +1577,8 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		res = -EHWPOISON;
+		if (flags & MF_ACTION_REQUIRED)
+			res = kill_accessing_process(current, pfn, flags);
 		goto unlock_mutex;
 	}
 
-- 
2.25.1

