Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C957382391
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 06:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhEQEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhEQEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 00:55:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31EEC061756
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 27so2517196pgy.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a91cKIOAtNxgkwYYfV45C+J1SqqN2xQcmJEtOXolKqY=;
        b=ije35DqWzzaJoVjfbdhDmWp2z2qlIIyNFRNP5oj8PdcJCfWxrpcMJNVvjIxkE0sVQ+
         Fz37lJni5dGx1XjJFqxWO7BC9BdgIns7kJ6OfvdRc6ivURDLvcnvDsi/fAM2F4ZDCQQU
         7kMZF4Q9vId/lAgeLi4TmwoBxfjNJCqvzaNAT6qxLwlHSa+Tr3G4mRdYpfyhNOk9om37
         QvKWpct5prJH4Db2UOf7IcG1NsaBM201nDc2ruTla201CXY4yaVIHKhJ6UnKsklwyXM8
         RYM5EBbj9A5F6Kk+J2jtZAbvXS5h5BS7UYSzF1MlTNRvVn1gtSKwq1UOqN8CsEftXfJt
         ix4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a91cKIOAtNxgkwYYfV45C+J1SqqN2xQcmJEtOXolKqY=;
        b=j+x1ixdh3WqVY05ISprnW7FXikVrDr60C4KNGweEW2S7keFUn50XW150wt/52VVPgZ
         +lEKA+SEMyZ7X4sGZFqs+be57nV8Ifeigu+S1oekVv6BgRiFp4+tX2LASJ5h5SlK/qYT
         sX7gJEoMz8wr3KlS66FKvKA2yozaCmtzc/aFjQ6nBlJLhzFZDjrUUzfvNux9DOeocM6y
         U2eTnBK9McYUN/F1n1r2EiAA67pev961K8V+Lf4UF5tP4pCn0izi3WcBo87HSTs7gmrL
         v0M9FlfaHhL9ZSsDjBXUmpFYTeKERtQitVxJem0AM8ik4AX7VaEsG+6T2pYjaGwKtQ19
         kcZQ==
X-Gm-Message-State: AOAM530WNtAOhuTUV6v2UP8AI2ms57cWegpteoNheLuWAd2Dq08Byc47
        9xEZHKaLxqj7KpIDFzZ50A==
X-Google-Smtp-Source: ABdhPJwFk4Q8UGF7UMgeYJgHd2I3/KF8Ek+miNEwGrRQqkU820ff0VXZ+o+O1Sc0mspFaXtGh8TG5Q==
X-Received: by 2002:a63:da0a:: with SMTP id c10mr59513361pgh.255.1621227253126;
        Sun, 16 May 2021 21:54:13 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id j29sm9439038pgl.30.2021.05.16.21.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 21:54:12 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm,hwpoison: make get_hwpoison_page call get_any_page()
Date:   Mon, 17 May 2021 13:54:01 +0900
Message-Id: <20210517045401.2506032-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
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
ChangeLog v4:
- __get_hwpoison_page() returns -EBUSY (not in the previous patch),
- moved "if (ret == -EBUSY)" block,
- improved comment.
---
 mm/memory-failure.c | 114 ++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 51 deletions(-)

diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index 761f982b6d7b..85275972cc6f 100644
--- v5.12/mm/memory-failure.c
+++ v5.12_patched/mm/memory-failure.c
@@ -1084,13 +1084,6 @@ static int page_action(struct page_state *ps, struct page *p,
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
@@ -1098,7 +1091,9 @@ static int __get_hwpoison_page(struct page *page)
 
 #ifdef CONFIG_HUGETLB_PAGE
 	spin_lock(&hugetlb_lock);
-	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
+	if (!PageHuge(head))
+		ret = -EBUSY;
+	else if (HPageFreed(head) || HPageMigratable(head))
 		ret = get_page_unless_zero(head);
 	spin_unlock(&hugetlb_lock);
 	if (ret > 0)
@@ -1131,15 +1126,6 @@ static int __get_hwpoison_page(struct page *page)
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
@@ -1149,50 +1135,76 @@ static int get_any_page(struct page *p, unsigned long flags)
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
@@ -1381,7 +1393,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1605,7 +1617,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -1897,7 +1909,7 @@ int unpoison_memory(unsigned long pfn)
 		return 0;
 	}
 
-	if (!get_hwpoison_page(p, flags, 0)) {
+	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
@@ -2113,7 +2125,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags, MF_SOFT_OFFLINE);
+	ret = get_hwpoison_page(page, flags);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.25.1

