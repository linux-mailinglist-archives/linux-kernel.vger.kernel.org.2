Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5483A0B16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFIEYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhFIEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:24:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A65BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:22:43 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id g12so12121589qvx.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=WFC+/0lyPxFIAiwGMHjjGfnZCl9oEPVKPge+xDeOiLA=;
        b=NlAloZezTsaqGXm+Vce+9CIJS/kpxlmYkrmUXX5sEBZ4dSjx8mTxMFcdYrY7TITW7r
         duwK3CxTdlKxNCDni5i1bQiVrvGYOsT+AnoFFG5OjBVx/R8Ma33peq9vQvgwsuvrpkTT
         2vwo0T+HyrtIjo3Sw68tZwFksUOXHsRTZxKgyGl06LJ4UynqNlV2Z1dMKvNScr8aqFe3
         L9GBA1v0FNQ5988p/PgZB06yKzd7U2R+Hxcxbh0TUnbwfe3mS2Tt2frSUmyDOJS1MG36
         p1MIOIfNB+TnRUFWhr8oOTg+PHljTndvKZVf3bCKgx5rj3BnHD20IKxOClS1gEyb3aoY
         MJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WFC+/0lyPxFIAiwGMHjjGfnZCl9oEPVKPge+xDeOiLA=;
        b=KUqgaUUHXbfSVWTb7rYejhrssYGsX8Z/fj32cuxik4t/Ebs8WaTxqmeEmnkWGmIWwg
         EUJ+3QaPKIUTe+CzB4N/1dyiR64H9wIr3SDzM6PoOR8x0sNuriiOzd+Ff7eQG1zd7UiS
         GoJjNJiigXab4ni2y5kOOZEgPgq2joWoM3p2atGElPkf/RvlxbADnIssYVpYypgrVGnF
         GhvaXckx6ytc7cLU10tXoZ3O8+kzi9HDjjP1DYZqQ16DykgMdswOezPD/TWkuzhO8Xjo
         Cr8H9erukpgSE/hGNi+k50zbDwHUnQAdOpSpwf0YiXCObyOe99Yx4Uw9pmBv+jmbAlIQ
         qKag==
X-Gm-Message-State: AOAM531DO6Cqj+d6xpreZlU5C3ANAj1RI9crkocZpHWR4DOPDX6Dd37r
        f/ki7AvMMFaTHlPh8d26GVUejg==
X-Google-Smtp-Source: ABdhPJxvoInT8fNvF++/wNvSN3dYnlbQ5nVu6siJRdbWpnTpcsvOa0lmTjktIbCw37L5J1yT/UrCrw==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr4056084qvv.9.1623212561911;
        Tue, 08 Jun 2021 21:22:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f13sm3722869qtv.83.2021.06.08.21.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:22:41 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:22:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
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
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] mm: thp: replace DEBUG_VM BUG with VM_WARN when
 unmap fails for split
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <d0f0db68-98b8-ebfb-16dc-f29df24cf012@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <shy828301@gmail.com>

When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
fail, but the first VM_BUG_ON_PAGE() just checks page_mapcount() however
it may miss the failure when head page is unmapped but other subpage is
mapped.  Then the second DEBUG_VM BUG() that check total mapcount would
catch it.  This may incur some confusion.  And this is not a fatal issue,
so consolidate the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE().

[1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Signed-off-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
Patch inserted since the v1 series was posted.
v5: Rediffed by Hugh to fit after 6/7 in his mm/thp series; Cc stable.
v4: Updated the subject and commit log per Hugh.
    Reordered the patches per Hugh.
v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
    since there is no fundamental change against v2.
v2: Removed dead code and updated the comment of try_to_unmap() per Zi
    Yan.

 mm/huge_memory.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 84ab735139dc..6d2a0119fc58 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2352,15 +2352,15 @@ static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_SYNC |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
-	bool unmap_success;
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
-	unmap_success = try_to_unmap(page, ttu_flags);
-	VM_BUG_ON_PAGE(!unmap_success, page);
+	try_to_unmap(page, ttu_flags);
+
+	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
@@ -2671,7 +2671,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	int count, mapcount, extra_pins, ret;
+	int extra_pins, ret;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2730,7 +2730,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -2748,9 +2747,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
-	count = page_count(head);
-	mapcount = total_mapcount(head);
-	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
+	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
@@ -2770,16 +2767,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
-		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
-			pr_alert("total_mapcount: %u, page_count(): %u\n",
-					mapcount, count);
-			if (PageTail(page))
-				dump_page(head, NULL);
-			dump_page(page, "total_mapcount(head) > 0");
-			BUG();
-		}
 		spin_unlock(&ds_queue->split_queue_lock);
-fail:		if (mapping)
+fail:
+		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		local_irq_enable();
 		remap_page(head, thp_nr_pages(head));
-- 
2.26.2

