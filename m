Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6A3A0B01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFIEOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhFIEO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:14:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:12:23 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso22609202otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version;
        bh=dH5ufk7Y6j9/GuAEqgcW6GomD5lTAsfQgKNtMZXGAZw=;
        b=suDqTOtYhw65igVyFflM5NWu6cE9W/9pkIJIuRfBvtmcdE+kQ2E4LW6yecy0YeIDoC
         A1vQrJPBticUu4bYvfKxFd1QFTfDMue5JVBfh7OcvH6b451eNbR4Pa8MzRkqPGh20skr
         UXgA/BY6on6HUK1ggRI2FIq9vaUEgYu8CIUczXccrb4RmQXlanSbqpfEkriV4xpSMZce
         2P5dygh3yYd9psOWHRZbwWu/1B/zYKILV6XmCjh5yxmerxiTTJ8pehEDNx3URfODt1GX
         gU98yCW2jGZXP1tcmOapS4+1RFiuKj3cTUjcDkjQp3vHKIcVHcw2YMcfg+meFfkfcEPg
         As4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version;
        bh=dH5ufk7Y6j9/GuAEqgcW6GomD5lTAsfQgKNtMZXGAZw=;
        b=qwXob+0LtsaxcsxlpZqv/nXr+lFdgrx/Do7ma13pW4eFtYuFJq04KzZeXak4SingaL
         R+AA6cjXUkuHDKUjwOtLXffwGHqIHwPhw++ohCDlCMa6cB+MLh22PXt73+J63VXT2vBA
         NssONx/7Vl8TBYLfjXnv4wvNXvPMYpwMzsWmMLJtMkdud/CKmGedofMHLH7Ry1RmxhKM
         dHKi5StvjjzxqQG5GKDhZRjXxEKeDTReN+h/ZDO8x5iNeW2PHXACf0JvbfLtrl92SwQy
         +JlozejMl+bOvKLO1NoNmmlqHMI0LNd5SqE40VK7oTCCTl2yssMHrrtSaPqtDahARrmp
         aF6Q==
X-Gm-Message-State: AOAM533SkKBu0aFwVpyoKged11k7z5wTXQV7w2IXyeJylnPv0x9QanU3
        E8S0IVGWaHOtYQPArG5d20Yg4w==
X-Google-Smtp-Source: ABdhPJy8EA3JngAx0gGz5Jhhe/FOExFaGsYyva3Po5f2ayBipGfyZuuW56kwCv6M1oUi0fsxDF/P+A==
X-Received: by 2002:a9d:3e5:: with SMTP id f92mr20891152otf.181.1623211942541;
        Tue, 08 Jun 2021 21:12:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l18sm201747otr.50.2021.06.08.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:12:22 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:12:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe
 splitting (fwd)
Message-ID: <6b2b6683-d9a7-b7d0-a3e5-425b96338d63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Tue, 8 Jun 2021 21:10:19 -0700 (PDT)
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
Subject: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe splitting

Stressing huge tmpfs often crashed on unmap_page()'s VM_BUG_ON_PAGE
(!unmap_success): with dump_page() showing mapcount:1, but then its
raw struct page output showing _mapcount ffffffff i.e. mapcount 0.

And even if that particular VM_BUG_ON_PAGE(!unmap_success) is removed,
it is immediately followed by a VM_BUG_ON_PAGE(compound_mapcount(head)),
and further down an IS_ENABLED(CONFIG_DEBUG_VM) total_mapcount BUG():
all indicative of some mapcount difficulty in development here perhaps.
But the !CONFIG_DEBUG_VM path handles the failures correctly and silently.

I believe the problem is that once a racing unmap has cleared pte or pmd,
try_to_unmap_one() may skip taking the page table lock, and emerge from
try_to_unmap() before the racing task has reached decrementing mapcount.

Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
to the options, and passing that from unmap_page().

When CONFIG_DEBUG_VM, or for non-debug too?  Consensus is to do the same
for both: the slight overhead added should rarely matter, except perhaps
if splitting sparsely-populated multiply-mapped shmem.  Once confident
that bugs are fixed, TTU_SYNC here can be removed, and the race tolerated.

Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with generic rmap walkers")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
v2: moved TTU_SYNC definition up, to avoid conflict with other patchset
    use TTU_SYNC even when non-debug, per Peter Xu and Yang Shi
    expanded PVMW_SYNC's spin_unlock(pmd_lock()), per Kirill and Peter

 include/linux/rmap.h |  1 +
 mm/huge_memory.c     |  2 +-
 mm/page_vma_mapped.c | 11 +++++++++++
 mm/rmap.c            | 17 ++++++++++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index def5c62c93b3..8d04e7deedc6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -91,6 +91,7 @@ enum ttu_flags {
 
 	TTU_SPLIT_HUGE_PMD	= 0x4,	/* split huge PMD if any */
 	TTU_IGNORE_MLOCK	= 0x8,	/* ignore mlock */
+	TTU_SYNC		= 0x10,	/* avoid racy checks with PVMW_SYNC */
 	TTU_IGNORE_HWPOISON	= 0x20,	/* corrupted page is recoverable */
 	TTU_BATCH_FLUSH		= 0x40,	/* Batch TLB flushes where possible
 					 * and caller guarantees they will
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5885c5f5836f..84ab735139dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2350,7 +2350,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 static void unmap_page(struct page *page)
 {
-	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
+	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_SYNC |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
 	bool unmap_success;
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2cf01d933f13..5b559967410e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -212,6 +212,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			pvmw->ptl = NULL;
 		}
 	} else if (!pmd_present(pmde)) {
+		/*
+		 * If PVMW_SYNC, take and drop THP pmd lock so that we
+		 * cannot return prematurely, while zap_huge_pmd() has
+		 * cleared *pmd but not decremented compound_mapcount().
+		 */
+		if ((pvmw->flags & PVMW_SYNC) &&
+		    PageTransCompound(pvmw->page)) {
+			spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
+
+			spin_unlock(ptl);
+		}
 		return false;
 	}
 	if (!map_pte(pvmw))
diff --git a/mm/rmap.c b/mm/rmap.c
index 693a610e181d..07811b4ae793 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1405,6 +1405,15 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
+	/*
+	 * When racing against e.g. zap_pte_range() on another cpu,
+	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * try_to_unmap() may return false when it is about to become true,
+	 * if page table locking is skipped: use TTU_SYNC to wait for that.
+	 */
+	if (flags & TTU_SYNC)
+		pvmw.flags = PVMW_SYNC;
+
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
 		return true;
@@ -1777,7 +1786,13 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
 	else
 		rmap_walk(page, &rwc);
 
-	return !page_mapcount(page) ? true : false;
+	/*
+	 * When racing against e.g. zap_pte_range() on another cpu,
+	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * try_to_unmap() may return false when it is about to become true,
+	 * if page table locking is skipped: use TTU_SYNC to wait for that.
+	 */
+	return !page_mapcount(page);
 }
 
 /**
-- 
2.26.2

