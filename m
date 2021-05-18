Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C203882FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhERXOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhERXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:14:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D059C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t30so8082160pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8gYobotjJnYcWazwmcjL6gNSrMr8DTQsu5NhinMU0o=;
        b=mcGWc5PFd28LQZqgh8Plri2bQg3kdpog81TtpMeohBvHBLkjfpDDTqn7rHf9DVAjgr
         mo1qkCENe2SaNwT29/LSZj5tEkUk9GpP4014qsZFWBT02VbC3CVvBgJ5MNfxPWMOIpvI
         0BVkZrrPslf5uSvkR3pz13wS/2eMxNRNYIC5bMet1kg+2hdtjhRBmkq1bC2Tip4exVPq
         aHk38hrTst119rnNXb6cqat/lWs8604I2zZOAWiAK4qq3G1KCNlM5vSLtQ2RyfmHa7C+
         1GtDZHy09xTi07MIgvzMdbPAU1GSBq2UFFIJdf6HpNdakvIr4XYmTASil6FA9jamBqva
         iXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8gYobotjJnYcWazwmcjL6gNSrMr8DTQsu5NhinMU0o=;
        b=D1WDbF/tfTdWd3uVBSSlkVptGxqUYeb3VmuuybmLD2b3aEnYs6I50hQ7/32XWgynUI
         ShtYY+njmXh58FVzOl4NdYjFE/xpdRaUcMHaUSkz9KhT2J3Tv5ioJcDDuwhQxWSIv/Vs
         HYqPKqMfbtFn+GI8sTI1PnH8SBCVLMSvVUaCQdGAQKjNTpckuy/hejaejrp9ssLY7W34
         usRRZLCRcKkKajsXy5qCag+6yQ40H9vwa2AotA3Ky3Ski8OXn+ZtGcGy/aL44mj6Gwyj
         DB1BF/tm/Lv3KYc+6WPPPQWupo6e6FhOgOiKAwEOBZXrxdGU+vRVm+wzYHHO0VDa2Wln
         2lzQ==
X-Gm-Message-State: AOAM5331z54F3ON8iDgBS9TyKfQeaD2dYSbbps5P7oRxKOUuarTZ1Gfr
        D3eOq60l8h9CGcNi1wZQM4D6j5ffHqNN
X-Google-Smtp-Source: ABdhPJyx2Ke2GbkrZBT/HoODdXS2D1DtzVLCewk4ReyfcGe1FZ58keYAlVK7FZzutBSss0Ul0G12lw==
X-Received: by 2002:a63:d245:: with SMTP id t5mr7428670pgi.172.1621379594812;
        Tue, 18 May 2021 16:13:14 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id f14sm14437473pjq.50.2021.05.18.16.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:13:14 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mm,hwpoison: make get_hwpoison_page call get_any_page()
Date:   Wed, 19 May 2021 08:12:59 +0900
Message-Id: <20210518231259.2553203-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

__get_hwpoison_page() could fail to grab refcount by some race
condition, so it's helpful if we can handle it by retrying.
We already have retry logic, so make get_hwpoison_page() call
get_any_page() when called from memory_failure().

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/hugetlb.c        |   2 +
 mm/memory-failure.c | 110 ++++++++++++++++++++++++--------------------
 2 files changed, 62 insertions(+), 50 deletions(-)

diff --git v5.13-rc2/mm/hugetlb.c v5.13-rc2_patched/mm/hugetlb.c
index f138bae3e302..6aef717cd8df 100644
--- v5.13-rc2/mm/hugetlb.c
+++ v5.13-rc2_patched/mm/hugetlb.c
@@ -5857,6 +5857,8 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 		*hugetlb = true;
 		if (HPageFreed(page) || HPageMigratable(page))
 			ret = get_page_unless_zero(page);
+		else
+			ret = -EBUSY;
 	}
 	spin_unlock_irq(&hugetlb_lock);
 	return ret;
diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 353c6177e489..5e7d9c21f01b 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -949,13 +949,6 @@ static int page_action(struct page_state *ps, struct page *p,
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
 }
 
-/**
- * __get_hwpoison_page() - Get refcount for memory error handling:
- * @page:	raw error page (hit by memory error)
- *
- * Return: return 0 if failed to grab the refcount, otherwise true (some
- * non-zero value.)
- */
 static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
@@ -992,15 +985,6 @@ static int __get_hwpoison_page(struct page *page)
 	return 0;
 }
 
-/*
- * Safely get reference count of an arbitrary page.
- *
- * Returns 0 for a free page, 1 for an in-use page,
- * -EIO for a page-type we cannot handle and -EBUSY if we raced with an
- * allocation.
- * We only incremented refcount in case the page was already in-use and it
- * is a known type we can handle.
- */
 static int get_any_page(struct page *p, unsigned long flags)
 {
 	int ret = 0, pass = 0;
@@ -1010,50 +994,76 @@ static int get_any_page(struct page *p, unsigned long flags)
 		count_increased = true;
 
 try_again:
-	if (!count_increased && !__get_hwpoison_page(p)) {
-		if (page_count(p)) {
-			/* We raced with an allocation, retry. */
-			if (pass++ < 3)
-				goto try_again;
-			ret = -EBUSY;
-		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
-			/* We raced with put_page, retry. */
+	if (!count_increased) {
+		ret = __get_hwpoison_page(p);
+		if (!ret) {
+			if (page_count(p)) {
+				/* We raced with an allocation, retry. */
+				if (pass++ < 3)
+					goto try_again;
+				ret = -EBUSY;
+			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
+				/* We raced with put_page, retry. */
+				if (pass++ < 3)
+					goto try_again;
+				ret = -EIO;
+			}
+			goto out;
+		} else if (ret == -EBUSY) {
+			/* We raced with freeing huge page to buddy, retry. */
 			if (pass++ < 3)
 				goto try_again;
-			ret = -EIO;
 		}
+	}
+
+	if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
+		ret = 1;
 	} else {
-		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
-			ret = 1;
-		} else {
-			/*
-			 * A page we cannot handle. Check whether we can turn
-			 * it into something we can handle.
-			 */
-			if (pass++ < 3) {
-				put_page(p);
-				shake_page(p, 1);
-				count_increased = false;
-				goto try_again;
-			}
+		/*
+		 * A page we cannot handle. Check whether we can turn
+		 * it into something we can handle.
+		 */
+		if (pass++ < 3) {
 			put_page(p);
-			ret = -EIO;
+			shake_page(p, 1);
+			count_increased = false;
+			goto try_again;
 		}
+		put_page(p);
+		ret = -EIO;
 	}
-
+out:
 	return ret;
 }
 
-static int get_hwpoison_page(struct page *p, unsigned long flags,
-			     enum mf_flags ctxt)
+/**
+ * get_hwpoison_page() - Get refcount for memory error handling
+ * @p:		Raw error page (hit by memory error)
+ * @flags:	Flags controlling behavior of error handling
+ *
+ * get_hwpoison_page() takes a page refcount of an error page to handle memory
+ * error on it, after checking that the error page is in a well-defined state
+ * (defined as a page-type we can successfully handle the memor error on it,
+ * such as LRU page and hugetlb page).
+ *
+ * Memory error handling could be triggered at any time on any type of page,
+ * so it's prone to race with typical memory management lifecycle (like
+ * allocation and free).  So to avoid such races, get_hwpoison_page() takes
+ * extra care for the error page's state (as done in __get_hwpoison_page()),
+ * and has some retry logic in get_any_page().
+ *
+ * Return: 0 on failure,
+ *         1 on success for in-use pages in a well-defined state,
+ *         -EIO for pages on which we can not handle memory errors,
+ *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
+ *         operations like allocation and free.
+ */
+static int get_hwpoison_page(struct page *p, unsigned long flags)
 {
 	int ret;
 
 	zone_pcp_disable(page_zone(p));
-	if (ctxt == MF_SOFT_OFFLINE)
-		ret = get_any_page(p, flags);
-	else
-		ret = __get_hwpoison_page(p);
+	ret = get_any_page(p, flags);
 	zone_pcp_enable(page_zone(p));
 
 	return ret;
@@ -1239,7 +1249,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1453,7 +1463,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -1741,7 +1751,7 @@ int unpoison_memory(unsigned long pfn)
 		return 0;
 	}
 
-	if (!get_hwpoison_page(p, flags, 0)) {
+	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
@@ -1957,7 +1967,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags, MF_SOFT_OFFLINE);
+	ret = get_hwpoison_page(page, flags);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.25.1

