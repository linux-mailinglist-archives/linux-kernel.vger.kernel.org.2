Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F093148AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhBIGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhBIGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:22:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A03C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 22:21:55 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j11so9152597plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 22:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vd+xhAcgBsLbPJd1UskDha5fm3PtDxfa+KAFetZcNso=;
        b=lC+QJpnFvcu1PQ/kXnWXGbYmb9EJpF9dQkoSCvfumVwfLMQjHaH5hvybL17OvbRHAv
         YLfKD5xyj6NMpQqusqOosayNQ8h8G8sJbeM2xyEa7k7k54gjil9e7jj1R2a0OmpAdaXh
         NN0jFKOmMlBdBNAt04PdLeoByhgzRfxh0F/kkwech4UtjlndJh7x+f/yMUh4U9l/RkE5
         iLxuEahMp+t7pHy1QbHNCc9iF3cL2jFy70j0hMHgTNeRfU/ng47wIZd4Dpwg1dJs+Qc5
         VTAfROE2zB4iK9/KyXYjryjPjSdcJ0BB2E+x6gIRccNvCrF5jhwCvZLojikHjt7rpqwn
         +UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vd+xhAcgBsLbPJd1UskDha5fm3PtDxfa+KAFetZcNso=;
        b=jSv7ax2qCyEbMuy1ZzDC/e9RTjaAU/0x4rd/7uPWWeam6ieLmzzMxEXLi4OYqIoUU8
         dEib+mevhyb2w3MoPqooZ3vge6DNxDsmwkbnWcKxM5221bgQlLVz1shZeEup5XYD6c+y
         lG0CMUgi2r/bHJGQCSYuAgDPPxxh17sQDmxcMq51Tn4NF8dtLuvKmKVpzmOowACj11R0
         0trkX0Y09x8Penqo6t8jwpOMeQjV9/jLCKdKHqHlvPnQyKeZaev60+6/8WO0YdM0rJn7
         F4p8onwUTnXbJYwQDgauPhjfS4xMSpkakQuHnnZJQ+LaLKTWBHOAY8L6BNISehKc1xQC
         IyAg==
X-Gm-Message-State: AOAM533SdzTMPCelN3wRWft77qRnSDfLNikaLmzkNr+3ZoGhyRx9CK9N
        Mh+Jq7WzNDILVSiXA4gigQ==
X-Google-Smtp-Source: ABdhPJzVXN9g1S2bv3NJQKxCF8BVat+WlAZomggEOZ4GPOqbopf6tq7zJolHSseP/aDLcJC7bJqxkQ==
X-Received: by 2002:a17:902:309:b029:e1:536b:4ab with SMTP id 9-20020a1709020309b02900e1536b04abmr20067016pld.65.1612851715076;
        Mon, 08 Feb 2021 22:21:55 -0800 (PST)
Received: from localhost.localdomain (h175-177-040-128.catv02.itscom.jp. [175.177.40.128])
        by smtp.gmail.com with ESMTPSA id r15sm21663826pgh.39.2021.02.08.22.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:21:53 -0800 (PST)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Date:   Tue,  9 Feb 2021 15:21:28 +0900
Message-Id: <20210209062128.453814-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently hwpoison code checks PageAnon() for thp and refuses to handle
errors on non-anonymous thps (just for historical reason).  We now
support non-anonymou thp like shmem one, so this patch suggests to enable
to handle shmem thps. Fortunately, we already have can_split_huge_page()
to check if a give thp is splittable, so this patch relies on it.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git v5.11-rc6/mm/memory-failure.c v5.11-rc6_patched/mm/memory-failure.c
index e9481632fcd1..8c1575de0507 100644
--- v5.11-rc6/mm/memory-failure.c
+++ v5.11-rc6_patched/mm/memory-failure.c
@@ -956,20 +956,6 @@ static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
-	if (!PageHuge(head) && PageTransHuge(head)) {
-		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
-		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
-				page_to_pfn(page));
-			return 0;
-		}
-	}
-
 	if (get_page_unless_zero(head)) {
 		if (head == compound_head(page))
 			return 1;
@@ -1197,21 +1183,19 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 
 static int try_to_split_thp_page(struct page *page, const char *msg)
 {
-	lock_page(page);
-	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
-		unsigned long pfn = page_to_pfn(page);
+	struct page *head;
 
+	lock_page(page);
+	head = compound_head(page);
+	if (PageTransHuge(head) && can_split_huge_page(head, NULL) &&
+	    !split_huge_page(page)) {
 		unlock_page(page);
-		if (!PageAnon(page))
-			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
-		else
-			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
-		put_page(page);
-		return -EBUSY;
+		return 0;
 	}
+	pr_info("%s: %#lx: thp split failed\n", msg, page_to_pfn(page));
 	unlock_page(page);
-
-	return 0;
+	put_page(page);
+	return -EBUSY;
 }
 
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
-- 
2.25.1

