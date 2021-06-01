Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A71397B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhFAVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:09:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE34C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:07:57 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u13so199926qvt.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zbc201h4vA/zTsuSBg7jG5PuehkrxrykYzZRAEADCP8=;
        b=fyn3XV5Gn8AMOt/w9jFZQcTUUD+FCmCO4tT29BnKyp4u/dx5EwwqvgdPLw2XdqMp8s
         eQvzzPzAxwskLgzsdeECw1/GhJjq5o65hZ4LnxfMZpSsOz5y8V6jzgu7Qd/7ztxLcS5Q
         KlzagkjhvEAMUb/bCJllVGq8UV/61Ldtc/bXQnOHEfHJkxGFXayF8OJdqzEPdj/ePIUZ
         oa2iHZrsNZxGpwGMBAN9JpUQhv/ab7neSsILqOhh1WZP856AihV1pApvpJZctHhbsmTf
         5sNvu43VsavBmYEXH0nKkKaZoizLvz3paYHgGjrm9VM5//rbUt36/sVtBInZsNpK728z
         WGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zbc201h4vA/zTsuSBg7jG5PuehkrxrykYzZRAEADCP8=;
        b=oe+eBtqjMvVhupnCMR85pm3Sp9Cc4K1hJHDBdmV/LX/iWi181pt5AX1y2lxCYOmZ9Y
         lO9PbrUdkX6FgTK+KJAEydkSlafkdp/NnjINVBRGJu/NOxM6HRr7DmK+0GoUBj0zdJj8
         ENP+w0mlBWk+ik+hBenZwa+h6xGY4Z3YIp54VWHtHtfIifZfMyroF7xprtjdBC+xiqVQ
         VeoAOa67jqv1wohnBCb0zD8kwxVoGYrZON6uSXL9Cp4cJo5rPyKhJWdIW1FQHL41jchD
         d1fz1IRHxWBGRywVdLBQqnrYcmN6Ef2VYM8JVFfFA0qnujs1z+iEXNXzvExJN1b/vsgS
         bMcA==
X-Gm-Message-State: AOAM530ZLAECbsB1YPhknl+hVIWn03GPXPN1QcArxGiPvPSm835TG+R0
        /d4vwvBDfgYIeJw1I5emOyOtOw==
X-Google-Smtp-Source: ABdhPJwN4ufBQATeY8YBGM4IN8Yt39DV+3kywLCuUoK/7J52iUNL46bXGV7bnwtx+mw+CfH9flwLlw==
X-Received: by 2002:ad4:5bef:: with SMTP id k15mr23795389qvc.22.1622581676150;
        Tue, 01 Jun 2021 14:07:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w3sm300195qkb.13.2021.06.01.14.07.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:07:55 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:07:53 -0700 (PDT)
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
Subject: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM
 splitting
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
to the options, and passing that from unmap_page() when CONFIG_DEBUG_VM=y.
It could be passed in the non-debug case too, but that would sometimes add
a little overhead, whereas it's rare for this race to result in failure.

mm/memory-failure.c:hwpoison_user_mappings() should probably use the new
TTU_SYNC option too, just in case this race coincides with its attempts to
unmap a failing page (THP or not); but this commit does not add that.

Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with generic rmap walkers")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/rmap.h |  3 ++-
 mm/huge_memory.c     |  4 ++++
 mm/page_vma_mapped.c |  8 ++++++++
 mm/rmap.c            | 17 ++++++++++++++++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index def5c62c93b3..891599a4cb8d 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -97,7 +97,8 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
-	TTU_SPLIT_FREEZE	= 0x100,		/* freeze pte under splitting thp */
+	TTU_SPLIT_FREEZE	= 0x100, /* freeze pte under splitting thp */
+	TTU_SYNC		= 0x200, /* avoid racy checks with PVMW_SYNC */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9fb7b47da87e..305f709a7aca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2357,6 +2357,10 @@ static void unmap_page(struct page *page)
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
+	/* Make sure that the BUGs will not bite */
+	if (IS_ENABLED(CONFIG_DEBUG_VM))
+		ttu_flags |= TTU_SYNC;
+
 	unmap_success = try_to_unmap(page, ttu_flags);
 	VM_BUG_ON_PAGE(!unmap_success, page);
 }
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2cf01d933f13..b45d22738b45 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			pvmw->ptl = NULL;
 		}
 	} else if (!pmd_present(pmde)) {
+		/*
+		 * If PVMW_SYNC, take and drop THP pmd lock so that we
+		 * cannot return prematurely, while zap_huge_pmd() has
+		 * cleared *pmd but not decremented compound_mapcount().
+		 */
+		if ((pvmw->flags & PVMW_SYNC) &&
+		    PageTransCompound(pvmw->page))
+			spin_unlock(pmd_lock(mm, pvmw->pmd));
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
2.32.0.rc0.204.g9fa02ecfa5-goog

