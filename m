Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8B3EF3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhHQUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhHQUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:22:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF36C0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:21:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt11so1029775pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ7ZSuuD6tb1hBMUbxFFC7kpnSgGHoGR91mEf8GYgTE=;
        b=avIpKrF9Nji9lsUE6QWvB406A6ea/v4R7yDfqBWiRe2V1XDllMt0tqpxaP28hfYpKx
         ax4Q2ayK1rV36ElRsDUAW6Wp/CE0jRi9XTVRFOau+Gl71r4vim0akJ/WBI+g3jaX7bio
         jGnenDtm1DYm3mV1CBJlWx5FoWYfNaYMQEcyF42nY5UcWNP8h17EIAg2S4xPqE7cHO/j
         rQMK9gk+GDZOQjkXL/Sy3tIOFwXhqml8CR0f489yMrnmxVMvzpfJ2HPJCDLXmA5jYJPG
         BZyygOJfVJECHAF10agd7b3zcvllQATfOJ03MbVmrw0cIxOfJIWW8GqPaDxhXW8p6HUl
         Gx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ7ZSuuD6tb1hBMUbxFFC7kpnSgGHoGR91mEf8GYgTE=;
        b=M6feMVJEVWRs4dKNycFdJezJ2WGubzCKZ2+AR3nv4I0Xx2h9DtIo8LiSTawKHaE7we
         6WbtfZPiD+WzgL5E1uhhlgoHQgWgKetvL4yWfDHcKxsLfbbvbebcG4n6s6oHc+4nDvHw
         Kh1WRbj5PM0sJpsaovPUVyEcyP1kJS/9MW2aN5kaefZqHSRfIZaOTj5kFIvS6tLIrAxB
         Gqtyvihx56CJG0XzqCMvHSIYl8ju3KKqoa5vg2u08CBE4Y6gmNZ6X0MMDUQ2fcVPgn+S
         lqr/B0xn1hLGD2gSKAIaqTkSpNNoNTM9qhcNs9a8njF+2DQ8y885zpB6bv3HkNzSD3rb
         4hQA==
X-Gm-Message-State: AOAM531Rr/Ri1OJbdebx4sKRADko0n4wLEFQDJM0wK02MsTp00Sj3kmU
        FXjJ/ST/ELNDv4ntbfodaFQ=
X-Google-Smtp-Source: ABdhPJzOg0igKRSLy6X8qGilBeVhIpoGqG9rd18JlmvUZCFxi8VBAmS7X0jXGmMXDOdNrW4nbhtLlA==
X-Received: by 2002:a05:6a00:1ad3:b029:3e0:c106:2dea with SMTP id f19-20020a056a001ad3b02903e0c1062deamr5285921pfv.8.1629231708767;
        Tue, 17 Aug 2021 13:21:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id o22sm3408642pfu.87.2021.08.17.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:21:47 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: khugepaged: don't carry huge page to the next loop for !CONFIG_NUMA
Date:   Tue, 17 Aug 2021 13:21:46 -0700
Message-Id: <20210817202146.3218-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The khugepaged has optimization to reduce huge page allocation calls for
!CONFIG_NUMA by carrying the allocated but failed to collapse huge page to
the next loop.  CONFIG_NUMA doesn't do so since the next loop may try to
collapse huge page from a different node, so it doesn't make too much sense
to carry it.

But when NUMA=n, the huge page is allocated by khugepaged_prealloc_page()
before scanning the address space, so it means huge page may be allocated
even though there is no suitable range for collapsing.  Then the page would
be just freed if khugepaged already made enough progress.  This could make
NUMA=n run have 5 times as much thp_collapse_alloc as NUMA=y run.  This
problem actually makes things worse due to the way more pointless THP
allocations and makes the optimization pointless.

This could be fixed by carrying the huge page across scans, but it will
complicate the code further and the huge page may be carried
indefinitely.  But if we take one step back,  the optimization itself seems
not worth keeping nowadays since:
  * Not too many users build NUMA=n kernel nowadays even though the kernel is
    actually running on a non-NUMA machine. Some small devices may run NUMA=n
    kernel, but I don't think they actually use THP.
  * Since commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
    stored on the per-cpu lists"), THP could be cached by pcp.  This actually
    somehow does the job done by the optimization.

Cc: Hugh Dickins <hughd@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 74 ++++---------------------------------------------
 1 file changed, 6 insertions(+), 68 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9c98ddcd09..d6beb10e29e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -855,6 +855,12 @@ static int khugepaged_find_target_node(void)
 	last_khugepaged_target_node = target_node;
 	return target_node;
 }
+#else
+static inline int khugepaged_find_target_node(void)
+{
+	return 0;
+}
+#endif
 
 static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
 {
@@ -889,74 +895,6 @@ khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
 	count_vm_event(THP_COLLAPSE_ALLOC);
 	return *hpage;
 }
-#else
-static int khugepaged_find_target_node(void)
-{
-	return 0;
-}
-
-static inline struct page *alloc_khugepaged_hugepage(void)
-{
-	struct page *page;
-
-	page = alloc_pages(alloc_hugepage_khugepaged_gfpmask(),
-			   HPAGE_PMD_ORDER);
-	if (page)
-		prep_transhuge_page(page);
-	return page;
-}
-
-static struct page *khugepaged_alloc_hugepage(bool *wait)
-{
-	struct page *hpage;
-
-	do {
-		hpage = alloc_khugepaged_hugepage();
-		if (!hpage) {
-			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
-			if (!*wait)
-				return NULL;
-
-			*wait = false;
-			khugepaged_alloc_sleep();
-		} else
-			count_vm_event(THP_COLLAPSE_ALLOC);
-	} while (unlikely(!hpage) && likely(khugepaged_enabled()));
-
-	return hpage;
-}
-
-static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
-{
-	/*
-	 * If the hpage allocated earlier was briefly exposed in page cache
-	 * before collapse_file() failed, it is possible that racing lookups
-	 * have not yet completed, and would then be unpleasantly surprised by
-	 * finding the hpage reused for the same mapping at a different offset.
-	 * Just release the previous allocation if there is any danger of that.
-	 */
-	if (*hpage && page_count(*hpage) > 1) {
-		put_page(*hpage);
-		*hpage = NULL;
-	}
-
-	if (!*hpage)
-		*hpage = khugepaged_alloc_hugepage(wait);
-
-	if (unlikely(!*hpage))
-		return false;
-
-	return true;
-}
-
-static struct page *
-khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
-{
-	VM_BUG_ON(!*hpage);
-
-	return  *hpage;
-}
-#endif
 
 /*
  * If mmap_lock temporarily dropped, revalidate vma
-- 
2.26.2

