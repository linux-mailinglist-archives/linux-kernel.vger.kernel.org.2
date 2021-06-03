Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9539ADF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFCW2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCW2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:28:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C7C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 15:27:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so3647031plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s5yPesF7sEWozm6wfz/tvzm6wYfI1FnnfGsX6uavdk0=;
        b=dddkEQ10ucFDB7ZZfF1p0ObMg4oGDxNtuqWzTKCZIIACiVojmFMGA6oEOmnvRIoBoz
         JtSfACXMYK1p9dtfs7o1U7JoeD5VVwf3PDNlOr+p2qYinR11eXQAVlHIB8/SYdle3JzC
         SUBIJdu67+swFWKvSoBNkCDgtpTW+XS8+GbAGEEI1oo7BXk2X/lRMZK61oD48/UWxNgn
         khY1TNPFItlMeizHaRIr/OsVf2COCOKaZQiVTV8aFHEKkAr1IByCboNbSL21tXMgUGrI
         uFZBo52ok4mwBMZsqcyPddZg2yoLn8alfwL+6aot1VnXVpKDdkVCjYug1e05USGmrxji
         1sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s5yPesF7sEWozm6wfz/tvzm6wYfI1FnnfGsX6uavdk0=;
        b=Z9bs3JJDUvvtZ98cxuTudCO7aUtLZvmmeKrXmxS0ThA2k1+w/6+FBeWKujr1kmuvdG
         n+Y+gQyCR3GS9NTPDjh1KOHwiJ2WPxx3GIomfTJpUzC25Gd3gTbAz9BDWuY37M1GwW+S
         CI5uJL+eRciFV38kESCHR7u641fXZsjcP6c7kUX4Gs93+U/j1yIZLDsc6mtkiVrHajdE
         CNn56SrgwcCDzwmA0DqUiuL8IleXV8Bxe33k872lOVs4JJjxFoxa6lzeLD7Nqu3rIuHZ
         tADpZ3ZY6Oj1YcK5dHhqkOe+blr5GcGsFzEMhks841IQirV/GRY8DAmRhA40tzz3SEd/
         GVOA==
X-Gm-Message-State: AOAM531DFd3Vd6EmKqAMkV+eZhIXt+vy93K/UJtu4hiCMySad7dbn5Jr
        tQBjdKrZA5xhy9UF8Gv9VRrNRA==
X-Google-Smtp-Source: ABdhPJzQYnppn92XbOXwHSN2nMLzPzyYW4Gc6+3gA+f7iIVTLQReK3q6DaTA91XMC2xklVJ4kL6KVw==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr13626649pjw.19.1622759221524;
        Thu, 03 Jun 2021 15:27:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q191sm75708pfq.108.2021.06.03.15.26.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 15:27:00 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:26:58 -0700 (PDT)
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
Subject: [PATCH 6.1/7] mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap
 fails for split
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106031521480.11704@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
v5: Rediffed by Hugh to fit after 6/7 in his mm/thp series; Cc stable.
v4: Updated the subject and commit log per Hugh.
    Reordered the patches per Hugh.
v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
    since there is no fundamental change against v2.
v2: Removed dead code and updated the comment of try_to_unmap() per Zi
    Yan.

 mm/huge_memory.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2350,19 +2350,19 @@ static void unmap_page(struct page *page
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
-	bool unmap_success;
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
-	/* Make sure that the BUGs will not bite */
+	/* If warning below, prevent a race in the mapped accounting */
 	if (IS_ENABLED(CONFIG_DEBUG_VM))
 		ttu_flags |= TTU_SYNC;
 
-	unmap_success = try_to_unmap(page, ttu_flags);
-	VM_BUG_ON_PAGE(!unmap_success, page);
+	try_to_unmap(page, ttu_flags);
+
+	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
@@ -2673,7 +2673,7 @@ int split_huge_page_to_list(struct page
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	int count, mapcount, extra_pins, ret;
+	int extra_pins, ret;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2732,7 +2732,6 @@ int split_huge_page_to_list(struct page
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -2750,9 +2749,7 @@ int split_huge_page_to_list(struct page
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
-	count = page_count(head);
-	mapcount = total_mapcount(head);
-	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
+	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
@@ -2772,16 +2769,9 @@ int split_huge_page_to_list(struct page
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
