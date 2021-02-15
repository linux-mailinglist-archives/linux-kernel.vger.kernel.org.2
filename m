Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5631C063
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBORWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhBOQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:18:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303BC061A31
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:14:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h16so5104646qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QmoVsr7V/2HMMUlT3knKDmL5f3XKOtKg0eH1O4Q+2cw=;
        b=VINf+kX7XPpEXKir9xWLfgP23fkqUGexISZo96tV848K8Ct0HPPuxDrytkIdwshB9q
         wST75ooR0nwc6uI66/2ABb+uB7I/4GU35ZaZu7qgAtWWnH1hgUmE8+ylSkxS8cNHswdc
         Pt6bzcK0apK64B+6FmGF9SrnIvlR2tDlmusUOGQsmKk82YmTTJaPm3BnAHtBtD5cmaaQ
         UVWy6FFUba4kzc/hTM1LZdM0kfgvR/kH/xSsoIh/OiqK0C7MH3yV03VJOjyNCEowQQcR
         OujN6fgH+3Yullwus/picqet+hSc+EqPSUzk5hzfIJktRjYRbHLLGWctSscvg418ghgR
         j1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmoVsr7V/2HMMUlT3knKDmL5f3XKOtKg0eH1O4Q+2cw=;
        b=kTuiawC58BYy9H2C+LvrJkz+OhuwEAbw/VI4KBO1e/AAGSHVtElQlprLJFa2OH3HPH
         uoqyud3Tw74PATIrKiXGd/r2oXA1DqlPl2FviIjo+8K/GrP4V+2IPhz9UR0/18lmaCVQ
         fbmlovKj9H1QNnjMd5Duh+yW3r2QlQy5SxqrTuV3zUOXjesP+HEka8R70Kryf7rQl8A6
         GtaEjpNSE8eWNGD3X822SfMuQlEpmGYBVBvlZTzo/+agkHS3KP/olae2GmfAbnBQqqQs
         pTxk8bMH9qeu15D6BWcX3jF1GmQ7MMkVVYlAGuZ1+0GIIP5ZD32gsIprze4ZtyvpaAtC
         pR+A==
X-Gm-Message-State: AOAM533em4xNWC5p5sr2rb9WaMCFKfKW3hX9sq2DB9Bido8J4Cv0Jmht
        z5oET2N3f6qA8qNM2wilJsaAIg==
X-Google-Smtp-Source: ABdhPJzXiJ2mjn2gSGrc+eJpTs9TzmvlyrbhTg4dXgWp/dMT8mWJeCc2GMlBCtxlFza/Y1oyAHMUCQ==
X-Received: by 2002:ac8:538a:: with SMTP id x10mr14123307qtp.166.1613405650445;
        Mon, 15 Feb 2021 08:14:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:14:09 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v11 12/14] mm/gup: longterm pin migration cleanup
Date:   Mon, 15 Feb 2021 11:13:47 -0500
Message-Id: <20210215161349.246722-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages are longterm pinned, we must migrated them out of movable zone.
The function that migrates them has a hidden loop with goto. The loop is
to retry on isolation failures, and after successful migration.

Make this code better by moving this loop to the caller.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 93 ++++++++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index fab20b934030..905d550abb91 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1542,27 +1542,28 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+/*
+ * Check whether all pages are pinnable, if so return number of pages.  If some
+ * pages are not pinnable, migrate them, and unpin all pages. Return zero if
+ * pages were migrated, or if some pages were not successfully isolated.
+ * Return negative error if migration fails.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
-	unsigned long i, isolation_error_count;
-	bool drain_allow;
+	unsigned long i;
+	unsigned long isolation_error_count = 0;
+	bool drain_allow = true;
 	LIST_HEAD(movable_page_list);
-	long ret = nr_pages;
-	struct page *prev_head, *head;
+	long ret = 0;
+	struct page *prev_head = NULL;
+	struct page *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
-check_again:
-	prev_head = NULL;
-	isolation_error_count = 0;
-	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1600,47 +1601,27 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
 	 * in the correct zone.
 	 */
 	if (list_empty(&movable_page_list) && !isolation_error_count)
-		return ret;
+		return nr_pages;
 
+	if (gup_flags & FOLL_PIN) {
+		unpin_user_pages(pages, nr_pages);
+	} else {
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+	}
 	if (!list_empty(&movable_page_list)) {
-		/*
-		 * drop the above get_user_pages reference.
-		 */
-		if (gup_flags & FOLL_PIN)
-			unpin_user_pages(pages, nr_pages);
-		else
-			for (i = 0; i < nr_pages; i++)
-				put_page(pages[i]);
-
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
 				    MR_LONGTERM_PIN);
-		if (ret) {
-			if (!list_empty(&movable_page_list))
-				putback_movable_pages(&movable_page_list);
-			return ret > 0 ? -ENOMEM : ret;
-		}
-
-		/* We unpinned pages before migration, pin them again */
-		ret = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
-					      NULL, gup_flags);
-		if (ret <= 0)
-			return ret;
-		nr_pages = ret;
+		if (ret && !list_empty(&movable_page_list))
+			putback_movable_pages(&movable_page_list);
 	}
 
-	/*
-	 * check again because pages were unpinned, and we also might have
-	 * had isolation errors and need more pages to migrate.
-	 */
-	goto check_again;
+	return ret > 0 ? -ENOMEM : ret;
 }
 #else
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
 	return nr_pages;
@@ -1658,22 +1639,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
 {
-	unsigned long flags = 0;
+	unsigned int flags;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_pin_save();
-
-	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
-				     gup_flags);
+	if (!(gup_flags & FOLL_LONGTERM))
+		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					       NULL, gup_flags);
+	flags = memalloc_pin_save();
+	do {
+		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					     NULL, gup_flags);
+		if (rc <= 0)
+			break;
+		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+	} while (!rc);
+	memalloc_pin_restore(flags);
 
-	if (gup_flags & FOLL_LONGTERM) {
-		if (rc > 0)
-			rc = check_and_migrate_movable_pages(mm, start, rc,
-							     pages, vmas,
-							     gup_flags);
-		memalloc_pin_restore(flags);
-	}
 	return rc;
 }
 
-- 
2.25.1

