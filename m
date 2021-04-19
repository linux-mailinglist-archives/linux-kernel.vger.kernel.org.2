Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31A236396B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhDSChg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhDSChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:37:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDAC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:37:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u11so13386622pjr.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66+befEu/NZKF7+pilgCUuosT+xXIDnUJyr/H6QMgAY=;
        b=RGRoREXVyFAwxxICqkS3wgutUj08GoQAHU0IomJj974X3FvLf/eimjI35ee0as4hHl
         HoN2qhkKYL01T6xRQ4aGArSzB8PqoG5zMsy1Gigzn9HLu5f+nTdVQxIycCK7XL5QkbED
         ZPtkUm3NWXidzYE2c/mnv9UhjOi0KmhBBbyYuxjD0ShFFMgRjPFDUgMejXwhh09McxxW
         zbJ14PIkrtjTlJmROPKQftqeFRURAAia8Axf0cD435OFFWMdEKWuwbMG+NvxIVTRjBD+
         NqXMvSjb/lNysoyIAq2T0tjKuCreaxKwgeCYVu9v9UlqdDdAZePSqEnoS6/8G3SDyd0Z
         ADlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66+befEu/NZKF7+pilgCUuosT+xXIDnUJyr/H6QMgAY=;
        b=jkQG8p4X5B9Tvg4mqqMVcEnzP9nmrmyU92G0D+PsW/QHZxeZVLOfpFpLBbmamDVQ6S
         i6SwRbbBV9JuYr44QV+WFixx2rNroqOxNVCZjO7upkZOOV55ReZAuKcPuP/m7pXVm5uF
         Qz1KUlX22tvFU7i9g/jPnpUrqGTFURcxCEkh/Kl5ca2hNiCkAmOS/w5qCYrzC3ikXrRz
         tJ9erpzM0eSSiW33JCtSR3/z9PcUaItSbzoAi497ZXApzQNiDU8sesCrkYfdkem362Av
         1UgmQWc4h4VRHWz0MuP9WFOfCbK2e6lKZjUFox7DYs1spZprdcl8RBiRDqT2xIoLx4gk
         dFGQ==
X-Gm-Message-State: AOAM532iwe++TRjOeq/fD8Kdds8SaxBMwVDW5jUjS3kVtkqsqs7w0vpu
        xGgW2KTSclnm0ohKR3Qq4Q==
X-Google-Smtp-Source: ABdhPJyFMeLoVyYr20wAisU2qIo/4hwVVlivdtRaNF2XPDcD6+L/y5NLR4eBX4lts0a/056JVnm69Q==
X-Received: by 2002:a17:902:7d86:b029:eb:4d1c:aa9e with SMTP id a6-20020a1709027d86b02900eb4d1caa9emr21134708plm.51.1618799822847;
        Sun, 18 Apr 2021 19:37:02 -0700 (PDT)
Received: from u2004 (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id v8sm10586717pfm.128.2021.04.18.19.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 19:37:02 -0700 (PDT)
Date:   Mon, 19 Apr 2021 11:36:58 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Subject: [PATCH v2 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Message-ID: <20210419023658.GA1962954@u2004>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
 <20210417134751.0bee9e73@alex-virtual-machine>
 <20210419010955.GA17180@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419010955.GA17180@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. In the function hwpoison_pte_range():
> > if (pfn <= hwp->pfn && hwp->pfn < pfn + PMD_SIZE) this check seem we should use PMD_SIZE/PAGE_SIZE or some macro like this?
> 
> Thanks, that's right.  HPAGE_PMD_NR seems to fit here.
> We also need "#ifdef CONFIG_TRANSPARENT_HUGEPAGE" to use it.

I found that the #ifdef is not necessary because the whole
"if (ptl)" is compiled out.  So I don't add #ifdef.

Here's the v2 of 3/3.

Aili, could you test with it?

Thanks,
Naoya Horiguchi

-----
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Tue, 13 Apr 2021 07:26:25 +0900
Subject: [PATCH v2 3/3] mm,hwpoison: add kill_accessing_process() to find error
 virtual address

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
change log v1 -> v2:
- initialize local variables in check_hwpoisoned_entry() and
  hwpoison_pte_range()
- fix and improve logic to calculate error address offset.
---
 arch/x86/kernel/cpu/mce/core.c |  13 ++-
 include/linux/swapops.h        |   5 ++
 mm/memory-failure.c            | 147 ++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..3ce23445a48c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
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
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d9b7c9132c2f..98ea67fcf360 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
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
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 368ef77e01f9..99dd4caf43cb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
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

