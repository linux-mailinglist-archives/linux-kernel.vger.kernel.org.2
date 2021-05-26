Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1FC39214B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhEZUOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhEZUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:14:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:12:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l70so1913902pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R308Tm4caxn19xHGz7pM0TIdOHBZX3XBvF5WMLnOo9U=;
        b=su8nF9w7LG7RnLnxTJbBNyaATWpFMrKEJCHE7SdSa00HBUrStRUCnNfpgq4JHx4C0f
         X9w12/DuTnwdaRq2aAs3UDFwr3igZ94bOa1idnj1yDWuIQvT0eVkNYZS3gX/TrdOG7Lr
         yq6o94mQmUsErNU5drbsLi2mJDbq1NY1CiDUXh+zYs83gVujRCvwQWOwxUaR3LRVf6rh
         WGJmhrsL5Rzd5Q6dL0QfedErmMAyF5Uz/YQgf3Y8GDBcvElwCtS2k6fACnZ3TicqS663
         wqigc54lktNjc0+BSoaNcVvCeLPzdgiSuzhAk3OatQaRoMDYpsaZ/36mA+3J8kcDIm3g
         3a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R308Tm4caxn19xHGz7pM0TIdOHBZX3XBvF5WMLnOo9U=;
        b=rDqp25n02MqiDJa5cugQxbS5TdvKZ3M0G9xxX67gdwfgpRD4HZOoknpo2Ykfv+Ts4V
         7+zI3FIb2JQZgvly+3MU8iqIuw4eVj4Q3y4tUTnq9eYshS49U8uUynLCI7Du3Bb7oBif
         NQ8gdm5dqwn+iQncSSVhwa+btV/pdStLGfxFcmW1Gtnr6SOEPnO5+jVFfCYlAZJFdB51
         uQC0Teptg/iJf0X6bMoVVanD3OPevYu4YuKeb+xgdOHLhn9a6Jy8XtTHalwdrEs5yioG
         I4YHRE6km7Ci3PdSG9ktuBA1pXsuQRMdInDVrgjkS8DNm5mZst5sAbggkZ2PQM5ZkRnp
         FKjQ==
X-Gm-Message-State: AOAM532u9IBUTgnALlvGI8XqNc7t1hKLh4lWHhd64S+OxQaEizUdfG4z
        OWzt9+aCjvXwG5brxG2SX8w=
X-Google-Smtp-Source: ABdhPJzhf/IYwO7BYcCY5iHQZhKv6DVWDkg/OqHSWo7V1NWvN26I0L9N6h/f2AGybqiyzbUXZPF3lg==
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id m1-20020aa790010000b02902d494089998mr166302pfo.9.1622059962522;
        Wed, 26 May 2021 13:12:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id m14sm76733pff.17.2021.05.26.13.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 13:12:41 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        minchan@kernel.org, naoya.horiguchi@nec.com,
        wangyugui@e16-tech.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 1/2] mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap fails for split
Date:   Wed, 26 May 2021 13:12:38 -0700
Message-Id: <20210526201239.3351-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
fail, but the first VM_BUG_ON_PAGE() just checks page_mapcount() however
it may miss the failure when head page is unmapped but other subpage is
mapped.  Then the second DEBUG_VM BUG() that check total mapcount would
catch it.  This may incur some confusion.  And this is not a fatal issue,
so consolidate the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE().

[1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v4: Updated the subject and commit log per Hugh.
    Reordered the patches per Hugh.
v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
    since there is no fundamental change against v2.
v2: Removed dead code and updated the comment of try_to_unmap() per Zi
    Yan.

 mm/huge_memory.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 19195fca1aee..8827f82c5302 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2336,15 +2336,15 @@ static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
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
@@ -2655,7 +2655,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	int count, mapcount, extra_pins, ret;
+	int extra_pins, ret;
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
@@ -2714,7 +2714,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -2732,9 +2731,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
-	count = page_count(head);
-	mapcount = total_mapcount(head);
-	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
+	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
@@ -2754,16 +2751,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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

