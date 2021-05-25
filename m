Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E1390688
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhEYQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhEYQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:23:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:21:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t193so23148474pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmbfHX6D035LsGn/+TcBmTVxPxWKc+RU4GxB9gPvNc0=;
        b=IgD5NSBRENJweCx2RLe1CXOfi7EWjfiRlHMOcLL++sy/kQIz927Jj8uzD77JqyRk/X
         wl62ZGgBLGWDquk3BC9ihn3gqeROxDwRp+ZcAQBG4OBrZHWXd03Af64wKenlWn1SkHeU
         7a2yKbWoI2HLl2szycw5511ry5UQFsjAsEkgS9Em0owXtRomOsLrXG3dkMRklI2OTbCT
         vtu/YMFmK2zDW/x3aw9TPvvRl4ay3ucK9/zI9mOK8fPG3Wmy3nVc/etpib3MTJhIxbnq
         XqaINJd4BoUcCQ3n8xs6Uy9w2B1oIYhgYmmsq2tyy3Pc1sYzIGS7CvKxltKrdZaG3M1x
         OcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmbfHX6D035LsGn/+TcBmTVxPxWKc+RU4GxB9gPvNc0=;
        b=FkPS2SPpN5F7ZSn/bX8JGZ2uRhkR8fFvditnpkR7ioZPHgM46GNIdrrIYqHajXOEcR
         40nxAARdlLweGjbzRDWbzyKJouLblHt6h9pMnnw0NraM0OrSAz3XAmr0FIf+xyF4qJig
         wOx9FFHZuCMrApEJhXLQi2AM1yGghkATLxyEwurJrEPPnsTjjqoqHDMeJeph8MN4hkAn
         7BmXyjGzllyMylvulx/3QtRsrNlGnCIFNW/mWm07yxS3GAF3JRkltVOkXW5MXXRIP+Uw
         6DDemmS/0soxNtk3cOktNA4X71V/5jshnD3P0CP3UDSIVBXM1kRuJjdvXVZaC+aiqLC6
         Y6MA==
X-Gm-Message-State: AOAM530fkyJsnSbChQVdM+fdbWYbGcbxJbgO6x4uot9Op/WiB957HJVQ
        Al1R2smMujyspwkQ7owLcGk=
X-Google-Smtp-Source: ABdhPJy88yigkedUoFzoMFNJUDnuErEK45jOVUAaZulsIcyoFD5pW9mFqhZnTE0rj8HURvbS/a7tDA==
X-Received: by 2002:a63:5a01:: with SMTP id o1mr19485648pgb.313.1621959709715;
        Tue, 25 May 2021 09:21:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id e22sm7493087pfl.188.2021.05.25.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:21:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, wangyugui@e16-tech.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/2] mm: thp: check page_mapped instead of page_mapcount for split
Date:   Tue, 25 May 2021 09:21:45 -0700
Message-Id: <20210525162145.3510-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525162145.3510-1-shy828301@gmail.com>
References: <20210525162145.3510-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
return false positive for PTE-mapped THP since page_mapcount() is used
to check if the THP is unmapped, but it just checks compound mapount and
head page's mapcount.  If the THP is PTE-mapped and head page is not
mapped, it may return false positive.

The try_to_unmap() has been changed to void function, so check
page_mapped() after it.  And changed BUG_ON to WARN_ON since it is not a
fatal issue.

[1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
    since there is no fundamental change against v2.
v2: Removed dead code and updated the comment of try_to_unmap() per Zi
    Yan.
 mm/huge_memory.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 80fe642d742d..72d81d8e01b1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2343,6 +2343,8 @@ static void unmap_page(struct page *page)
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
 	try_to_unmap(page, ttu_flags);
+
+	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
@@ -2653,7 +2655,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	int count, mapcount, extra_pins, ret;
+	int mapcount, extra_pins, ret;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2712,7 +2714,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -2730,7 +2731,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
-	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
@@ -2752,16 +2752,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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

