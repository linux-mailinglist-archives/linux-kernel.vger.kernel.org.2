Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB253EE846
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhHQISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHQISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:18:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:17:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id az7so22160843qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ijowZ4jcrG0Ehbu0X7RLv2m890u4vuBU8RzGN0n7bL0=;
        b=hkL/t1N59snMllnmFaWkLsl2GgYb22030wlHiEeGop1btUrASwwzsFxbAV5LMYGE7q
         ozjKkck4uIJ4l1yp4GbhPSoqRVn8uj5D5eatF3Z9fVPNX22tkXoXqc2N+x1RNEw8XK+Y
         GS6Y74GADMaDC9HV+cat0PaBPrmtm9u64hTjHxzKGPZeEFb95d72hs6yQGUjYxhWnmhM
         LZ5cGAOGrIQNAeddwbzrpmiwIVtS/7Eg67KQ15w6ZNtFK9UZ7gUiFvDLYtXzmo9UjvuI
         PA9PwX/hWqQngtiDQwZygVZ85HzrBgyRHoJv+9zymjFDvvfF8iqcoQ492w0mOGbUv1Ds
         k1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ijowZ4jcrG0Ehbu0X7RLv2m890u4vuBU8RzGN0n7bL0=;
        b=k5qNHffVuO0HnPrmK02zb0PTsOoH1KU6N2V9ddjNvXbbxYw2aJoNgTWE/EMUaDVWnh
         zXhKqkugjsMlmbpCirZPefThUeJM/nkptBTLXXC3eHoY3qDEZuDCsyhZ3TxPIVm0KfXu
         NEcHNDDkhd5mB94MtkgI+lQAnxf2pNWuMESyKnN9i6b3vHWecne8cRwLCkToc8ryNHCp
         LkrGehyY2ayXo0LbxAruRjW4o06Ny6y8RrTe447YciQzz2ODtellUoG1f2/ZQi/WFWxt
         Yct/UsOtyajgh1DNwL9A1fUyZkqTRMpSk8MWcAXm6FKgiXjwDHgVQ6beS9vJQPyqohQV
         7XMA==
X-Gm-Message-State: AOAM5306At0tdJBwV1GllgM9sl5YHzlFspbtbn5M2BOc91043qjYJPm5
        gXEHOpc6fxak59LYY3SBuHWTHA==
X-Google-Smtp-Source: ABdhPJyDjNDrAfBVAAvGPzIj04mSmcEsVajGGsFy6FFaXWF2QwGM7GhbPjNQfw/JroHWC0p7JHupbg==
X-Received: by 2002:a05:620a:1222:: with SMTP id v2mr2636380qkj.1.1629188264267;
        Tue, 17 Aug 2021 01:17:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h140sm921535qke.112.2021.08.17.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:17:43 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:17:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 6/9] huge tmpfs: SGP_NOALLOC to stop collapse_file() on
 race
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <1355343b-acf-4653-ef79-6aee40214ac5@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

khugepaged's collapse_file() currently uses SGP_NOHUGE to tell
shmem_getpage() not to try allocating a huge page, in the very unlikely
event that a racing hole-punch removes the swapped or fallocated page as
soon as i_pages lock is dropped.

We want to consolidate shmem's huge decisions, removing SGP_HUGE and
SGP_NOHUGE; but cannot quite persuade ourselves that it's okay to regress
the protection in this case - Yang Shi points out that the huge page
would remain indefinitely, charged to root instead of the intended memcg.

collapse_file() should not even allocate a small page in this case: why
proceed if someone is punching a hole?  SGP_READ is almost the right flag
here, except that it optimizes away from a fallocated page, with NULL to
tell caller to fill with zeroes (like a hole); whereas collapse_file()'s
sequence relies on using a cache page.  Add SGP_NOALLOC just for this.

There are too many consecutive "if (page"s there in shmem_getpage_gfp():
group it better; and fix the outdated "bring it back from swap" comment.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/shmem_fs.h |  1 +
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 29 +++++++++++++++++------------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9b7f7ac52351..7d97b15a2f7a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -94,6 +94,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 /* Flag allocation requirements to shmem_getpage */
 enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
+	SGP_NOALLOC,	/* similar, but fail on hole or use fallocated page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_NOHUGE,	/* like SGP_CACHE, but no huge pages */
 	SGP_HUGE,	/* like SGP_CACHE, huge pages preferred */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..045cc579f724 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,7 +1721,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_getpage(mapping->host, index, &page,
-						  SGP_NOHUGE)) {
+						  SGP_NOALLOC)) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index 740d48ef1eb5..226ac3a911e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1871,26 +1871,31 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return error;
 	}
 
-	if (page)
+	if (page) {
 		hindex = page->index;
-	if (page && sgp == SGP_WRITE)
-		mark_page_accessed(page);
-
-	/* fallocated page? */
-	if (page && !PageUptodate(page)) {
+		if (sgp == SGP_WRITE)
+			mark_page_accessed(page);
+		if (PageUptodate(page))
+			goto out;
+		/* fallocated page */
 		if (sgp != SGP_READ)
 			goto clear;
 		unlock_page(page);
 		put_page(page);
-		page = NULL;
-		hindex = index;
 	}
-	if (page || sgp == SGP_READ)
-		goto out;
 
 	/*
-	 * Fast cache lookup did not find it:
-	 * bring it back from swap or allocate.
+	 * SGP_READ: succeed on hole, with NULL page, letting caller zero.
+	 * SGP_NOALLOC: fail on hole, with NULL page, letting caller fail.
+	 */
+	*pagep = NULL;
+	if (sgp == SGP_READ)
+		return 0;
+	if (sgp == SGP_NOALLOC)
+		return -ENOENT;
+
+	/*
+	 * Fast cache lookup and swap lookup did not find it: allocate.
 	 */
 
 	if (vma && userfaultfd_missing(vma)) {
-- 
2.26.2

