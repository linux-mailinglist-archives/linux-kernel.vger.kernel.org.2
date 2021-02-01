Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE88B30ABD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBAPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBAPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:39:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6502C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:38:37 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 19so16608566qkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g2firNhV/7kB7YU7cH9BNSgXaQWIxvW5HlS98FNnYEs=;
        b=cQ7U9FQRpR9JGNNrg7Wiu9qDQUW+pR4nvGFdzAwg72lQTYccPZx1dsnRYuei2XGHR2
         nAlpPdY8DvOXXmWhxdO2LVpkkk/LE3TWy1gnwdN9NGZ27+5o4ziEIQHINofLGI6f/ljN
         xUImvXDI5GxWSaIoGrqJ9WAUFPoBXi7P8YlKOIrlNG9bSr0jV22PcDOKtLdrgcVa/eSO
         npZal8wKnZ01rdB2fiGFC5d7sGwMqK/gqvcw9nRH7m7NG7fVylYebScPZJ8QRLAfJrjp
         31zojxu9KuEQTeGfWRsA44sPb9srl/ktRriq5tGaxbxyU+o/nPqqMqtR4G4Ch4hpcFXK
         bCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2firNhV/7kB7YU7cH9BNSgXaQWIxvW5HlS98FNnYEs=;
        b=LPfenmx5YdzYHe7UQ+Q84JMI26jTDfUTzJMOGgqLU8Gb6SaWr/rqtM7+wOmgtZD7IJ
         mQQ3xjRwwJ5oxUxq7mP7nGWo/2B71oes1Pxngf9wezGdETJd1roWXMbZqCjBXquMYYy+
         iaQjP7xrMdI8czriJAj5fk8zOpXRPCOOPhsYQVGVh+klWEVmEtgd8C9LonUcD2V/+/u9
         3XbfVKn2ABkEVAKtk2o9fzEaY7D5MFq1AB5rbOIb8F/5YHG+DGitZhUv55CjBem3EmAc
         44Qp/hSgjNXvYoAPfv8T90aWY90JIUFlWk9+Srhp9pLqkFbgFqdqC5DdFso/yDQKS6Mu
         zMlw==
X-Gm-Message-State: AOAM531QyJFuDbntN6Z9X2kwrkEOzvU5WPgDdDNRx27yK0kdl+o/1pVt
        Zvu1MiDkOpRLA60LMhHYmmOAFQ==
X-Google-Smtp-Source: ABdhPJz3cHryVBgm+sMaWB1E3xhYlRhY35s+BzBXgbN2R53/Sw/rzB5M+lv25DSTo/3rnxq17/J76A==
X-Received: by 2002:a37:4d12:: with SMTP id a18mr16245768qkb.371.1612193916967;
        Mon, 01 Feb 2021 07:38:36 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 22sm14853307qke.123.2021.02.01.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:38:36 -0800 (PST)
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
Subject: [PATCH v9 04/14] mm/gup: check for isolation errors
Date:   Mon,  1 Feb 2021 10:38:17 -0500
Message-Id: <20210201153827.444374-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201153827.444374-1-pasha.tatashin@soleen.com>
References: <20210201153827.444374-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is still possible that we pin movable CMA pages if there are isolation
errors and cma_page_list stays empty when we check again.

Check for isolation errors, and return success only when there are no
isolation errors, and cma_page_list is empty after checking.

Because isolation errors are transient, we retry indefinitely.

Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 60 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 88ce41f41543..7ecca2d66dff 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1555,8 +1555,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					struct vm_area_struct **vmas,
 					unsigned int gup_flags)
 {
-	unsigned long i;
-	bool drain_allow = true;
+	unsigned long i, isolation_error_count;
+	bool drain_allow;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1567,6 +1567,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
 check_again:
 	prev_head = NULL;
+	isolation_error_count = 0;
+	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1578,25 +1580,35 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		 * of the CMA zone if possible.
 		 */
 		if (is_migrate_cma_page(head)) {
-			if (PageHuge(head))
-				isolate_huge_page(head, &cma_page_list);
-			else {
+			if (PageHuge(head)) {
+				if (!isolate_huge_page(head, &cma_page_list))
+					isolation_error_count++;
+			} else {
 				if (!PageLRU(head) && drain_allow) {
 					lru_add_drain_all();
 					drain_allow = false;
 				}
 
-				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
-					mod_node_page_state(page_pgdat(head),
-							    NR_ISOLATED_ANON +
-							    page_is_file_lru(head),
-							    thp_nr_pages(head));
+				if (isolate_lru_page(head)) {
+					isolation_error_count++;
+					continue;
 				}
+				list_add_tail(&head->lru, &cma_page_list);
+				mod_node_page_state(page_pgdat(head),
+						    NR_ISOLATED_ANON +
+						    page_is_file_lru(head),
+						    thp_nr_pages(head));
 			}
 		}
 	}
 
+	/*
+	 * If list is empty, and no isolation errors, means that all pages are
+	 * in the correct zone.
+	 */
+	if (list_empty(&cma_page_list) && !isolation_error_count)
+		return ret;
+
 	if (!list_empty(&cma_page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
@@ -1616,23 +1628,19 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			return ret > 0 ? -ENOMEM : ret;
 		}
 
-		/*
-		 * We did migrate all the pages, Try to get the page references
-		 * again migrating any new CMA pages which we failed to isolate
-		 * earlier.
-		 */
-		ret = __get_user_pages_locked(mm, start, nr_pages,
-						   pages, vmas, NULL,
-						   gup_flags);
-
-		if (ret > 0) {
-			nr_pages = ret;
-			drain_allow = true;
-			goto check_again;
-		}
+		/* We unpinned pages before migration, pin them again */
+		ret = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					      NULL, gup_flags);
+		if (ret <= 0)
+			return ret;
+		nr_pages = ret;
 	}
 
-	return ret;
+	/*
+	 * check again because pages were unpinned, and we also might have
+	 * had isolation errors and need more pages to migrate.
+	 */
+	goto check_again;
 }
 #else
 static long check_and_migrate_cma_pages(struct mm_struct *mm,
-- 
2.25.1

