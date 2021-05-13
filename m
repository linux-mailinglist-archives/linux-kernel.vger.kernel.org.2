Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B374037FFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhEMVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 17:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 17:24:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:23:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso256447pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zKjERDKMyhua0PjhqCNVM2rE/Zi4pz1d2TcF1K6coiw=;
        b=vcxAw4es3ae/p0vfEkPw30Wii9+5l8PzPxy1wKHBtSRJW/eMJ4Qzl5Dgp/r1vIpKSc
         YkPqk09yCEs5j2TwF5MT2QsxblvxARCT799z0pbhJZ6Ry1CsuZoRCZ150z1uOp3FXXg6
         WEpmVlXKWbppkCJKn+DlwO7y4n8zFn71kRd/nNE2N5oW0tHB9/w2UvIAfOXIIUA/MdxI
         YglYroORejTaOQnAv269G7WoimW9L11myTKMZiBMxxw9udK53hQoPWMTikj0/0biq7Ak
         N53FMd/90Ug8R5PpMwNYSI8nlJZiP7LVIOVs0AppF596MGxevq/ecWRnqM5e0XDu5kFU
         YIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zKjERDKMyhua0PjhqCNVM2rE/Zi4pz1d2TcF1K6coiw=;
        b=W7wRryIPQZY1mS7cA4LE6gjdc25j7gc9AF/SEmLiV5uQ0LbrXhLN7l88XYH85Q50pw
         M/+CpFCHSZZ6njKQrTrsq3FgteDAtWbP4b2AAkQfTfWi3ZiNz1k4hxPeAO5Y82BxyMKO
         JTa40nssoZTVuMo30TGj1nsXl7KN1HpZ2EOgH+6ggLV0aFI+h/1F0H89HLjWkr+3DOCz
         96Td2wLH+QGUxcruCAAG2L+H84LW52ENA3opQ0PRUfraP9uXFvI6hH5mNsHMhec4ZFWq
         0/E4Xl59InTXKapLlYbQogOcI/Xq+kJ1PL3ak2Djq5wJQmEZvkMn8nurjbEL+rIf6RZp
         vezA==
X-Gm-Message-State: AOAM531Xmzz1aCGhDdiMfwCYUAP4W7ysYmli6HeaVnBJSpQ2CRd4ehGE
        jePqWaWqxBRT8PhPr0ODjYE=
X-Google-Smtp-Source: ABdhPJwFOU23ftSv4xH5XJzisA/8ym0azHja6b7g155adVUUvy2ifygY9HcMcOGq0R+JMRCgLQVEYg==
X-Received: by 2002:a17:902:b104:b029:ee:beb3:ef0a with SMTP id q4-20020a170902b104b02900eebeb3ef0amr42241191plr.80.1620941017397;
        Thu, 13 May 2021 14:23:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id b9sm145926pfo.107.2021.05.13.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:23:36 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        wangyugui@e16-tech.com, hughd@google.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Thu, 13 May 2021 14:23:34 -0700
Message-Id: <20210513212334.217424-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
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

Use total_mapcount() instead of page_mapcount() for try_to_unmap() and
do so for the VM_BUG_ON_PAGE in split_huge_page_to_list as well.

This changed the semantic of try_to_unmap(), but I don't see there is
any usecase that expects try_to_unmap() just unmap one subpage of a huge
page.  So using page_mapcount() seems like a bug.

[1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v2: Removed dead code and updated the comment of try_to_unmap() per Zi
    Yan.

 mm/huge_memory.c | 11 +----------
 mm/rmap.c        | 10 ++++++----
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..3b08b9ba1578 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2348,7 +2348,6 @@ static void unmap_page(struct page *page)
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
 	unmap_success = try_to_unmap(page, ttu_flags);
-	VM_BUG_ON_PAGE(!unmap_success, page);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
@@ -2718,7 +2717,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
+	VM_BUG_ON_PAGE(total_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -2758,14 +2757,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
diff --git a/mm/rmap.c b/mm/rmap.c
index 693a610e181d..f52825b1330d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1742,12 +1742,14 @@ static int page_not_mapped(struct page *page)
 }
 
 /**
- * try_to_unmap - try to remove all page table mappings to a page
- * @page: the page to get unmapped
+ * try_to_unmap - try to remove all page table mappings to a page and the
+ *                compound page it belongs to
+ * @page: the page or the subpages of compound page to get unmapped
  * @flags: action and flags
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold the page lock.
+ * page and the compound page it belongs to, used in the pageout path.
+ * Caller must hold the page lock.
  *
  * If unmap is successful, return true. Otherwise, false.
  */
@@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
 	else
 		rmap_walk(page, &rwc);
 
-	return !page_mapcount(page) ? true : false;
+	return !total_mapcount(page) ? true : false;
 }
 
 /**
-- 
2.26.2

