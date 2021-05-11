Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9B37AA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhEKPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhEKPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:11:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B46C061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l70so1267508pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZ5d92tbMpv53CASAYfzjoqnq/aMVSi1l8lFeEO33kw=;
        b=S47uKjFjUurhXRL03fjk/+x19BNkdGP1H3K3f3doqv7bnP4mRDlTeSY8/SdTK4STys
         yepDTUeK8GJfSiWgPnOvljZCzNmLlBeJU24y5lxHcksIyHOcQnYCeDoEtTrVbqMJmceR
         IbO5FcJ+0B0MD1zJ4Wgmhurf1e8vO0ADOpsVFxks7uWfwBMKb4VP2/iUkHBIQeGZYPJ7
         tBGbUDfI82UM5VZvoMhHfH0jaWCPXI+yyiBht3gfzmryRgt0vFmfByT/xL6ATMAKMlhG
         Qo9pM7oIY39nW7O2ZX8qm23ejpxENY27C/ybw1FpdNyP+MOFdjMR/PC63cut1PZ2QXfi
         gdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ5d92tbMpv53CASAYfzjoqnq/aMVSi1l8lFeEO33kw=;
        b=O665SiMzSMzp3gPs2MFrjtLC0RapUngU+tP/XsyHsYrQs5dw4LIuZHIpyI2e+Rc4hI
         WJG9Y0+2Dwgi8tKSQQQVaNgxbPZzzRzPSLKworH3uQfXUPBDpasAmBR5fvnnmnKW0t41
         lRq3IC1donsN1e7UVCZ/PKajUvrZSEOixM/jKAb1hyDEqPz11o/uppmm6Brenh2MF09a
         sH0IxvotDtLqUZzuyzpcYQfK+e3egHWJF+ajisVMgdunuHREuivWpiJElTlSAwqnq9Au
         A1ldqgQjDDy/w1P4KzgJK36vn5QDzBAfHr/uVWjMTGPvNnlmRdVcDz3XAVnAEumh7d5t
         809w==
X-Gm-Message-State: AOAM531TbY0e1eBaUsl7jxKF3xpv994eaVtn2cVSfDtkHz8IZd6d6xyZ
        iPAJh2vg3zd+APelIZXtSA==
X-Google-Smtp-Source: ABdhPJzx8cS8/SccG8DadKbAZW3b71yMzOkwhASg4Srt6i9+n/n2OG/wTmNaDc5hbLI/JAz7in4ftw==
X-Received: by 2002:a63:5d65:: with SMTP id o37mr30533198pgm.300.1620745836847;
        Tue, 11 May 2021 08:10:36 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id a18sm14376456pgg.51.2021.05.11.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:10:36 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm,hwpoison: make get_hwpoison_page call get_any_page()
Date:   Wed, 12 May 2021 00:10:16 +0900
Message-Id: <20210511151016.2310627-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now __get_hwpoison_page() could return -EBUSY in a race condition,
so it's helpful to handle it by retrying.  We already have retry
logic, so make get_hwpoison_page() call get_any_page() when called
from memory_failure().

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 114 ++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git v5.12/mm/memory-failure.c v5.12_patched/mm/memory-failure.c
index 02668b24e512..d6f470e9ee05 100644
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
@@ -1134,15 +1127,6 @@ static int __get_hwpoison_page(struct page *page)
 	return get_page_unless_zero(page);
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
@@ -1152,50 +1136,76 @@ static int get_any_page(struct page *p, unsigned long flags)
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
-			if (pass++ < 3)
-				goto try_again;
-			ret = -EIO;
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
 		}
+	}
+
+	if (ret == -EBUSY) {
+		/* We raced with freeing huge page to buddy, retry. */
+		if (pass++ < 3)
+			goto try_again;
+	} else if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
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
+ * Return: 0 for buddy free pages,
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
@@ -1384,7 +1394,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1608,7 +1618,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags)) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -1900,7 +1910,7 @@ int unpoison_memory(unsigned long pfn)
 		return 0;
 	}
 
-	if (!get_hwpoison_page(p, flags, 0)) {
+	if (!get_hwpoison_page(p, flags)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
@@ -2116,7 +2126,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags, MF_SOFT_OFFLINE);
+	ret = get_hwpoison_page(page, flags);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.25.1

