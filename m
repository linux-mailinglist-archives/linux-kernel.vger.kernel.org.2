Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658C839AEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCXim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:38:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD11C061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 16:36:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y15so6103216pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QZP/2zPNWkHUV5d1g3n6GdeLfOnqJ4ULZ1taVr6o9I=;
        b=KrycwZLVn+kAjG83eM/L4ROh/Va5YK4B46NIa7USCRnrh4BUcLgYnRB8zirUQSan1x
         6csfxI4qne5CbZFVb4MJchVk1GsgOZhiVENCy1NFEHnFDwLjWFW1cJWH+GE/RXInDTPZ
         QI0mSaXixJCWz+MkdWYulVIvPigSduxNCcqUPAlDGLAwPNi8zsTbXr2C+uZ++ZwmKIeE
         FsdL1f28PbD35wUSGzqr2/C4JG5SS+iR4DGns/dbRpAmKVyk3LTCKCqvvlvk4/38BVEq
         JadJff5qJE3RrPZH/aD9KDyU7F7jAqrMEe3PAR9VkM/QgI7LsT7sKQJOCwgnQjGVFwx/
         YM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QZP/2zPNWkHUV5d1g3n6GdeLfOnqJ4ULZ1taVr6o9I=;
        b=Ia10Y4rbOPG1S7jgX1Yy3ePuUHF2bDQTy7tWrIctWHib90wbrZgNzDbclp1tydMtDc
         WhpazlKqCXcKBDl2z18KsGzAdhdmTLHrFx4nC07U6A+xxWujCqV55gCIKoWweUOxgPQp
         s+um2Jv4ll8rqanexWN/vF6hP+5SXsM5XeQf9LnZPPD6q/i7A04pSncGe1MB4B+ypAN5
         1+VHy1BpHmoZK428U8S7fGo4PdPLjn/BdXJtp3ycPhwru54l8sYcXpyinyjRraz7BrPv
         1d33kXHYlCmM64MCUSecoLNWxNFzHc/w+eXTfyfvjr+rS0qsILYcfYAD+1IAZph2bjJu
         7/yQ==
X-Gm-Message-State: AOAM5310yhQ3SxrIAjKgSnTBZ1J5menlmsbGT+u98xWxxCxirgHrqEkK
        Z35ymnoW2hKl7o+toOpvAw==
X-Google-Smtp-Source: ABdhPJx09r/EWdCNBtiolI2VCU/oNAT+q3xo0UVQ1Kbrvu0hzfmhwbMsQImXmQCQoa90xHQIKWewXA==
X-Received: by 2002:aa7:9ab0:0:b029:2ea:1d0:f326 with SMTP id x16-20020aa79ab00000b02902ea01d0f326mr1748313pfi.1.1622763406327;
        Thu, 03 Jun 2021 16:36:46 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id gg22sm3009818pjb.17.2021.06.03.16.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:36:46 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] mm,hwpoison: make get_hwpoison_page() call get_any_page()
Date:   Fri,  4 Jun 2021 08:36:32 +0900
Message-Id: <20210603233632.2964832-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

__get_hwpoison_page() could fail to grab refcount by some race
condition, so it's helpful if we can handle it by retrying.  We already
have retry logic, so make get_hwpoison_page() call get_any_page() when
called from memory_failure().

As a result, get_hwpoison_page() can return negative values (i.e. error
code), so some callers are also changed to handle error cases.
soft_offline_page() does nothing for -EBUSY because that's enough and
users in userspace can easily handle it.  unpoison_memory() is also
unchanged because it's broken and need thorough fixes (will be done
later).

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v6:
- some callers of get_hwpoison_page() have code for negative return values.
---
 mm/hugetlb.c        |   2 +
 mm/memory-failure.c | 194 +++++++++++++++++++++++++-------------------
 2 files changed, 111 insertions(+), 85 deletions(-)

diff --git v5.13-rc2/mm/hugetlb.c v5.13-rc2_patched/mm/hugetlb.c
index 0c1d87b1e303..5480cdcf62cd 100644
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
index 0caedbeeed77..359ca13b3cad 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -1103,13 +1103,6 @@ static inline bool HWPoisonHandlable(struct page *page)
 	return PageLRU(page) || __PageMovable(page);
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
@@ -1154,15 +1147,6 @@ static int __get_hwpoison_page(struct page *page)
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
@@ -1172,50 +1156,77 @@ static int get_any_page(struct page *p, unsigned long flags)
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
+			goto out;
 		}
+	}
+
+	if (PageHuge(p) || HWPoisonHandlable(p)) {
+		ret = 1;
 	} else {
-		if (PageHuge(p) || HWPoisonHandlable(p)) {
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
@@ -1404,27 +1415,33 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
-		/*
-		 * Check "filter hit" and "race with other subpage."
-		 */
-		lock_page(head);
-		if (PageHWPoison(head)) {
-			if ((hwpoison_filter(p) && TestClearPageHWPoison(p))
-			    || (p != head && TestSetPageHWPoison(head))) {
-				num_poisoned_pages_dec();
-				unlock_page(head);
-				return 0;
+	if (!(flags & MF_COUNT_INCREASED)) {
+		res = get_hwpoison_page(p, flags);
+		if (!res) {
+			/*
+			 * Check "filter hit" and "race with other subpage."
+			 */
+			lock_page(head);
+			if (PageHWPoison(head)) {
+				if ((hwpoison_filter(p) && TestClearPageHWPoison(p))
+				    || (p != head && TestSetPageHWPoison(head))) {
+					num_poisoned_pages_dec();
+					unlock_page(head);
+					return 0;
+				}
 			}
+			unlock_page(head);
+			res = MF_FAILED;
+			if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
+				page_ref_inc(p);
+				res = MF_RECOVERED;
+			}
+			action_result(pfn, MF_MSG_FREE_HUGE, res);
+			return res == MF_RECOVERED ? 0 : -EBUSY;
+		} else if (res < 0) {
+			action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+			return -EBUSY;
 		}
-		unlock_page(head);
-		res = MF_FAILED;
-		if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
-			page_ref_inc(p);
-			res = MF_RECOVERED;
-		}
-		action_result(pfn, MF_MSG_FREE_HUGE, res);
-		return res == MF_RECOVERED ? 0 : -EBUSY;
 	}
 
 	lock_page(head);
@@ -1627,28 +1644,35 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
-		if (is_free_buddy_page(p)) {
-			if (take_page_off_buddy(p)) {
-				page_ref_inc(p);
-				res = MF_RECOVERED;
-			} else {
-				/* We lost the race, try again */
-				if (retry) {
-					ClearPageHWPoison(p);
-					num_poisoned_pages_dec();
-					retry = false;
-					goto try_again;
+	if (!(flags & MF_COUNT_INCREASED)) {
+		res = get_hwpoison_page(p, flags);
+		if (!res) {
+			if (is_free_buddy_page(p)) {
+				if (take_page_off_buddy(p)) {
+					page_ref_inc(p);
+					res = MF_RECOVERED;
+				} else {
+					/* We lost the race, try again */
+					if (retry) {
+						ClearPageHWPoison(p);
+						num_poisoned_pages_dec();
+						retry = false;
+						goto try_again;
+					}
+					res = MF_FAILED;
 				}
-				res = MF_FAILED;
+				action_result(pfn, MF_MSG_BUDDY, res);
+				res = res == MF_RECOVERED ? 0 : -EBUSY;
+			} else {
+				action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+				res = -EBUSY;
 			}
-			action_result(pfn, MF_MSG_BUDDY, res);
-			res = res == MF_RECOVERED ? 0 : -EBUSY;
-		} else {
-			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+			goto unlock_mutex;
+		} else if (res < 0) {
+			action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 			res = -EBUSY;
+			goto unlock_mutex;
 		}
-		goto unlock_mutex;
 	}
 
 	if (PageTransHuge(hpage)) {
@@ -1919,7 +1943,7 @@ int unpoison_memory(unsigned long pfn)
 		return 0;
 	}
 
-	if (!get_hwpoison_page(p, flags, 0)) {
+	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
@@ -2135,7 +2159,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags, MF_SOFT_OFFLINE);
+	ret = get_hwpoison_page(page, flags);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.25.1

