Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8116D31C056
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhBORTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhBOQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:16:16 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B9BC0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:13:56 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x14so6838351qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kEb4+EO5FfWEwvtEEV/r+bfuAysDp0uLtQ9Vtb7+Mxs=;
        b=Mjvcn9gFUcCdc22/z/QIMuZAHqj9t0eazT33m6nDiWcsf9dC7b5/Cqunj984C77GCh
         +eDO+f4jZHaYmRkVNyiVvE/AZoCTRqAe6ySBISnRnba2iYwkDWhLwgkZr28MD45Z8sGw
         M+IdB3IPXQBNCXU+B1NJgQpPoEUGoJX07e04vdomEuoHxT0c1nrf30wE5WbEK4Ri2kQc
         VtN/WdklMkVYcoU59sdJbpIYt6mFZ42vKB5YQWdBrt02lFAgo40Rb8TMLf+rPUXDO8Wh
         l4hG1rXQtAGTiPNm3SxKtjXYQ9tx1s3SARXTmDHVP/vcvhonKigVIdiYFwfdvJQ1h1J0
         MRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEb4+EO5FfWEwvtEEV/r+bfuAysDp0uLtQ9Vtb7+Mxs=;
        b=dok3M/ocAYuDT1cCZz01EjsKCBICS4sXFgHQSb168Qd1lX2A7rorlkigdsEQB4e8M6
         eU+la0drT+/4eK8lZ8DOxcyKGlGdU/dVCaOYE0NdVlBOfCn2+Z34FTXiFLDebbZaUoO1
         ebuzLfwRjgURFLtb1S6zE2GhxixBZLNE2taKh5k+ITbPwYzdT7zI1v1rZrz3OiIN6HGc
         5OEQMJFGZ92lWcKxRJwo6zvNu+Y1w8eTQ0VvdlYUaSuSxQUlBxX8D2ri2/Y/ka/UZxtC
         2gA0APQnPCPJ38gBF7btA+bn41PpJx29JPtCbpZE/syWgYjKiGPcwMw4R8oeB0bI6a72
         zweQ==
X-Gm-Message-State: AOAM531gQ0F7N+oiyBO/ncpq+FnnAjW0jOM4Cjc+BIWtt4tDkDnlK1ab
        rbiyTumabLy8xsFXc7ppFiF0ug==
X-Google-Smtp-Source: ABdhPJx1c/toBBYCrfBwQhlcATPk9ySGYdcd3wSTS0lxHztOk2SDxHuOaSIOFMhw+gB/ecl0UXpyHw==
X-Received: by 2002:a37:8306:: with SMTP id f6mr15907605qkd.366.1613405636226;
        Mon, 15 Feb 2021 08:13:56 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:55 -0800 (PST)
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
Subject: [PATCH v11 03/14] mm/gup: return an error on migration failure
Date:   Mon, 15 Feb 2021 11:13:38 -0500
Message-Id: <20210215161349.246722-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migration failure occurs, we still pin pages, which means
that we may pin CMA movable pages which should never be the case.

Instead return an error without pinning pages when migration failure
happens.

No need to retry migrating, because migrate_pages() already retries
10 times.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 11ca49f3f11d..2d0292980b1d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1550,7 +1550,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 {
 	unsigned long i;
 	bool drain_allow = true;
-	bool migrate_allow = true;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct page *prev_head, *head;
@@ -1601,17 +1600,15 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
-			/*
-			 * some of the pages failed migration. Do get_user_pages
-			 * without migration.
-			 */
-			migrate_allow = false;
-
+		ret = migrate_pages(&cma_page_list, alloc_migration_target,
+				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				    MR_CONTIG_RANGE);
+		if (ret) {
 			if (!list_empty(&cma_page_list))
 				putback_movable_pages(&cma_page_list);
+			return ret > 0 ? -ENOMEM : ret;
 		}
+
 		/*
 		 * We did migrate all the pages, Try to get the page references
 		 * again migrating any new CMA pages which we failed to isolate
@@ -1621,7 +1618,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 						   pages, vmas, NULL,
 						   gup_flags);
 
-		if ((ret > 0) && migrate_allow) {
+		if (ret > 0) {
 			nr_pages = ret;
 			drain_allow = true;
 			goto check_again;
-- 
2.25.1

