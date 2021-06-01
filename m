Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D1397B88
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhFAVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:07:30 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E602C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:05:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so552381otc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aOIG7tu+/2aICcc9Ly2ISwpTg6tce60fLXoVvD1JTzM=;
        b=LVCZanx/eYTvSx8lbWpO+ZdK2aPRERFXGZTx1Mhgep8Q8QkzGUo7bbB3g+i5u8rpSp
         Soqb3fcuYDDDvt0nFd0wlpFXBxgnZe3ZIIZ7mgooDnnJ1XxzdUCk17V1ihl4yakJt5Mm
         1B502MVUExrwyRSZ5YiNucIo3AkPrclnGMUGraAbZYC/olCSlLINFvP4uLCoGa5uogeU
         Ma3csqVApJ7WJY1t2WesG1pEfBnC89flXSRo4Ty2ljjJH9Jak59UnDl7KUieNY01cwYU
         5NROwk8GWWXUJNYIeP5ruto/jmw+GN/3HS1HRrl79yZcILHFQXlNGh80ws3w+LBwSdOV
         Ffnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aOIG7tu+/2aICcc9Ly2ISwpTg6tce60fLXoVvD1JTzM=;
        b=UCx8naNhyLSYD0C7AbieSe6cjklVTwamn6ioD8VS4JwX9uOz+XEmGojuKyuL9ln4Xm
         HcorHae4Zdat4dYqBOifd18qkjHpv3ooj7O2I3GacFRZxW3NGL9Du+/D9mPBoAqgoJ8r
         52VSFrzij+QTloo3MS7byZARduSBQmEDihoSu7WZzFT/47EMqLq60z2uMR9d6bnT6Yg+
         G/bAzi0PLtEayDK6WeGGrFAdkTnw8fHSP5ztSkVaZ5cUqMODQGxgMu0xfydzwO1d4Ts0
         OsiMai79tcEzExoTzLkGVBgPhWSVY+2CYRpsMDCdxdnk2neaN2WyZICjnJXpbXbnzYbm
         d8mA==
X-Gm-Message-State: AOAM531orKOEuqVce+5DUuZ3jekRSbe4iz3wrkva72V2Ka289nem8dKC
        /Zk02vMtVg4zakcNwG1U7h3WDg==
X-Google-Smtp-Source: ABdhPJzV5gldYPZB2iLgdrqcizeQk2B+APGM0bHru2ERnaVvQl2M5X3Gk3ejGz5izjqbmQcVBiRC7g==
X-Received: by 2002:a05:6830:18dc:: with SMTP id v28mr8776572ote.326.1622581548311;
        Tue, 01 Jun 2021 14:05:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t14sm3641081ooh.39.2021.06.01.14.05.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:05:47 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:05:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem migration
 entry
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011403540.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stressing huge tmpfs page migration racing hole punch often crashed on the
VM_BUG_ON(!pmd_present) in pmdp_huge_clear_flush(), with DEBUG_VM=y kernel;
or shortly afterwards, on a bad dereference in __split_huge_pmd_locked()
when DEBUG_VM=n.  They forgot to allow for pmd migration entries in the
non-anonymous case.

Full disclosure: those particular experiments were on a kernel with more
relaxed mmap_lock and i_mmap_rwsem locking, and were not repeated on the
vanilla kernel: it is conceivable that stricter locking happens to avoid
those cases, or makes them less likely; but __split_huge_pmd_locked()
already allowed for pmd migration entries when handling anonymous THPs,
so this commit brings the shmem and file THP handling into line.

Are there more places that need to be careful about pmd migration entries?
None hit in practice, but several of those is_huge_zero_pmd() tests were
done without checking pmd_present() first: I believe a pmd migration entry
could end up satisfying that test.  Ah, the inversion of swap offset, to
protect against L1TF, makes that impossible on x86; but other arches need
the pmd_present() check, and even x86 ought not to apply pmd_page() to a
swap-like pmd.  Fix those instances; __split_huge_pmd_locked() was not
wrong to be checking with pmd_trans_huge() instead, but I think it's
clearer to use pmd_present() in each instance.

And while there: make it clearer to the eye that the !vma_is_anonymous()
and is_huge_zero_pmd() blocks make early returns (and don't return void).

Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/huge_memory.c     | 38 ++++++++++++++++++++++++--------------
 mm/pgtable-generic.c |  5 ++---
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..9fb7b47da87e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1587,9 +1587,6 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out_unlocked;
 
 	orig_pmd = *pmd;
-	if (is_huge_zero_pmd(orig_pmd))
-		goto out;
-
 	if (unlikely(!pmd_present(orig_pmd))) {
 		VM_BUG_ON(thp_migration_supported() &&
 				  !is_pmd_migration_entry(orig_pmd));
@@ -1597,6 +1594,9 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 
 	page = pmd_page(orig_pmd);
+	if (is_huge_zero_page(page))
+		goto out;
+
 	/*
 	 * If other processes are mapping this page, we couldn't discard
 	 * the page unless they all do MADV_FREE so let's skip the page.
@@ -1676,7 +1676,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
-	} else if (is_huge_zero_pmd(orig_pmd)) {
+	} else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
@@ -2044,7 +2044,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	count_vm_event(THP_SPLIT_PMD);
 
 	if (!vma_is_anonymous(vma)) {
-		_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
+		old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
 		/*
 		 * We are going to unmap this huge page. So
 		 * just go ahead and zap it
@@ -2053,16 +2053,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			zap_deposited_table(mm, pmd);
 		if (vma_is_special_huge(vma))
 			return;
-		page = pmd_page(_pmd);
-		if (!PageDirty(page) && pmd_dirty(_pmd))
-			set_page_dirty(page);
-		if (!PageReferenced(page) && pmd_young(_pmd))
-			SetPageReferenced(page);
-		page_remove_rmap(page, true);
-		put_page(page);
+		if (unlikely(is_pmd_migration_entry(old_pmd))) {
+			swp_entry_t entry;
+
+			entry = pmd_to_swp_entry(old_pmd);
+			page = migration_entry_to_page(entry);
+		} else {
+			page = pmd_page(old_pmd);
+			if (!PageDirty(page) && pmd_dirty(old_pmd))
+				set_page_dirty(page);
+			if (!PageReferenced(page) && pmd_young(old_pmd))
+				SetPageReferenced(page);
+			page_remove_rmap(page, true);
+			put_page(page);
+		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-	} else if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
+	}
+
+	if (pmd_present(*pmd) && is_huge_zero_pmd(*pmd)) {
 		/*
 		 * FIXME: Do we want to invalidate secondary mmu by calling
 		 * mmu_notifier_invalidate_range() see comments below inside
@@ -2072,7 +2081,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 * small page also write protected so it does not seems useful
 		 * to invalidate secondary mmu at this time.
 		 */
-		return __split_huge_zero_page_pmd(vma, haddr, pmd);
+		__split_huge_zero_page_pmd(vma, haddr, pmd);
+		return;
 	}
 
 	/*
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c2210e1cdb51..4e640baf9794 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -135,9 +135,8 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(!pmd_present(*pmdp));
-	/* Below assumes pmd_present() is true */
-	VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
+			   !pmd_devmap(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

