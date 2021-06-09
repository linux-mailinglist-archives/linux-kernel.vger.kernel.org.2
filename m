Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89C3A0AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhFIEIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:08:18 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37806 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFIEIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:08:17 -0400
Received: by mail-oi1-f173.google.com with SMTP id h9so23869898oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version;
        bh=GvD7glKDmqy0C8wgTkrBDLR7pK27K361Vqkf6hOXhYA=;
        b=SAi4kOfFlJAobWQC5FfaMehHga/M3Wa0Hmdh+mQcnYGc/JRs6pihYdMMtSS5M/Bk98
         3ALaK8Gue0Us9N3LxFDvt0a9llHAQ9YTg5EhaDN8CsijPeD1+ZGyUm1qvQJu+ix7phVA
         43TJUe9702cUG2c0X6jV4mLwZFPhNX8aUnOE1Y2ME19AQT8qXf3qtZ4W34dBW2K4b/KX
         13gbj7KSeaxJsLFzRDWNwPFNAjnh1AUTTZJdHQiWoVFHAXvlusvOQvqy9w3B9peDqN6w
         cLP+BSiKw0K0Szi5lXIWHaekLUwG9hI1jI0eMG6Hcc06ZiGEO/GjWNnik7/M3Uxvh2Bs
         tBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version;
        bh=GvD7glKDmqy0C8wgTkrBDLR7pK27K361Vqkf6hOXhYA=;
        b=a44fqkpAUh/1w7pFexIuohXCYJgo20oQYK1J96RM1owjd+irOu66DPnOM2B37ZpIPr
         +GeRtMEsjdF9NRMKKgLtigdqNG7ETH9yVXWw2Qls75cBQxAUYBEtkVF2d9TfEdpEnv7t
         p3Ju1arYrbZaGr0J3PPr1X8npLRTgCybk79Cr6ZE6seqnUQQyck4JWWgVLXwFK9ZtS7b
         CyFJ0PJfRacd+dRWt9dci5mynXzGxRrU0rWNBngqRXw+48Jb3I0HXM+aR3hNIUfYasxn
         2aZkOO2ok5fbXzyzrQjsRyoIY8jnekvdMcI6NBHEzXy/yT2bo6Sv8caAu3zDm8/uikTL
         69sw==
X-Gm-Message-State: AOAM532PmQspOp+LhlYOAzA1KoioEL8MXmrg3+OgJToMhwAXNTvMYjG+
        il7IIlKi57+m4jzGzPDv2N5mZxq23zG4+Q==
X-Google-Smtp-Source: ABdhPJz2ZyojP1wY65WXX6sa5VGixFsfCgnnjUYEZuWwujSze0Qk1mzybTYSjorkuWNbORFSP8JjDQ==
X-Received: by 2002:aca:af90:: with SMTP id y138mr5150511oie.92.1623211523605;
        Tue, 08 Jun 2021 21:05:23 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q22sm3416834otl.11.2021.06.08.21.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:05:23 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:05:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry (fwd)
Message-ID: <59d94b4-c0dd-310-894-be99416f3c92@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Tue, 8 Jun 2021 21:00:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>,
    Kirill A. Shutemov <kirill.shutemov@linux.intel.com>,
    Yang Shi <shy828301@gmail.com>, Wang Yugui <wangyugui@e16-tech.com>,
    Matthew Wilcox <willy@infradead.org>,
    Naoya Horiguchi <naoya.horiguchi@nec.com>,
    Alistair Popple <apopple@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
    Zi Yan <ziy@nvidia.com>, Miaohe Lin <linmiaohe@huawei.com>,
    Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
    Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
    Shakeel Butt <shakeelb@google.com>, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
    migration entry

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

And while there: use old_pmd rather than _pmd, as in the following blocks;
and make it clearer to the eye that the !vma_is_anonymous() block is
self-contained, making an early return after accounting for unmapping.

Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
v2: omit is_huge_zero_pmd() mods (done differently in next), per Kirill

 mm/huge_memory.c     | 27 ++++++++++++++++++---------
 mm/pgtable-generic.c |  5 ++---
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..42cfefc6e66e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
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
+	if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
 		/*
 		 * FIXME: Do we want to invalidate secondary mmu by calling
 		 * mmu_notifier_invalidate_range() see comments below inside
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
2.26.2

