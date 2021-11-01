Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F174412A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 05:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhKAEFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 00:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAEE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 00:04:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D1C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:02:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x5so6276008pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtiwVFtHI+j8Vy2Q3Iq1fgzUP2WmAtec5CugDxM8ax4=;
        b=K339gEZeyd4SCXcLT5h29aVmD43lvtCRsdu5ts8/9Ek7IPmLEXspkNJkgmvLJOS0MU
         s+2sG+mzwKDEtNQOGK1eCGQugN4a1QxJ1PPl2DX9+IZ7PXha5/MM9pMUUtYtQZHFiq/4
         d/wZCNOiOaTg4WoPCGanv5lLkLhmkkYLwXc4KlzbB6JFgp09oesv5tUNcKTNby5sqnMg
         LwiCdVbGLpnU3AaBGGtaLFYIu5ktClnJwzdyEOvC8pTnN8G4N2z1gCKh+qPdBCl4/8QQ
         zr2w+CZMiV3btsHlWFNIpE4mNBEZK+QvhzWQDhEPLaMFCVnPa1fw+NVTxUqmWCiw467j
         QoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtiwVFtHI+j8Vy2Q3Iq1fgzUP2WmAtec5CugDxM8ax4=;
        b=ba0E7l6mhCV6n3Ly3qm1/r+DvDJB85Tps/mgEe4OXxg9JlkbeSrdKYjQDmzjwHv7gS
         oZQgxiqZLsQtTs7AGTl2cSFmXZ5eJLM4g2aPb+GUEKQAfTi9zcRqTDdSUTWPmSDmxh9E
         JmRdqG1CZdAwQeiVtLyWfyBr4OJG0AYm98NyiXV9mCPLlSZrQ8bnkvxd1IuVRdVoD96T
         MfZU5cp31XjQW8N9HsTxW7U7u3na8Ah3yivckKJK6wpV1wGqbjDqc4DDIReVpymizET4
         KXbgl9fHFoWyfJFQltEj3/FuqRsJx99Q98Gk6wwTuxEHF47rFmFIHc3fkmNRzhJ8JVFP
         r/2w==
X-Gm-Message-State: AOAM530HF1lQHgpQtduqlg5M5xqL0bsOi6xjiEfG6HSHHIZux5lt37nM
        ++TA0hZ8L7oczyOD3/LT+mw=
X-Google-Smtp-Source: ABdhPJyFtJcEqUSXpLgZI8e/+6gESa0+IBgtXzewHdbCGqxGOZZOzvMABTfsjepCKIZKZC8xT5VTNA==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr19914014pgv.370.1635739342494;
        Sun, 31 Oct 2021 21:02:22 -0700 (PDT)
Received: from ubuntu.localdomain ([103.121.208.77])
        by smtp.gmail.com with ESMTPSA id z71sm14358252pfc.19.2021.10.31.21.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 21:02:22 -0700 (PDT)
From:   Quanfa Fu <fuqf0919@gmail.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Quanfa Fu <fuqf0919@gmail.com>
Subject: [PATCH] writeback: Fix some comment errors
Date:   Sun, 31 Oct 2021 21:02:08 -0700
Message-Id: <20211101040208.460810-1-fuqf0919@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Quanfa Fu <fuqf0919@gmail.com>
---
 mm/khugepaged.c     | 2 +-
 mm/memory-failure.c | 2 +-
 mm/slab_common.c    | 2 +-
 mm/swap.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8a8b3aa92937..f482a7861141 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1306,7 +1306,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		/*
 		 * Record which node the original page is from and save this
 		 * information to khugepaged_node_load[].
-		 * Khupaged will allocate hugepage from the node has the max
+		 * Khugepaged will allocate hugepage from the node has the max
 		 * hit record.
 		 */
 		node = page_to_nid(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bdbbb32211a5..5908661e5c23 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1227,7 +1227,7 @@ static int get_any_page(struct page *p, unsigned long flags)
  *
  * get_hwpoison_page() takes a page refcount of an error page to handle memory
  * error on it, after checking that the error page is in a well-defined state
- * (defined as a page-type we can successfully handle the memor error on it,
+ * (defined as a page-type we can successfully handle the memory error on it,
  * such as LRU page and hugetlb page).
  *
  * Memory error handling could be triggered at any time on any type of page,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..e845a8286f2c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -832,7 +832,7 @@ void __init setup_kmalloc_cache_index_table(void)
 
 	if (KMALLOC_MIN_SIZE >= 64) {
 		/*
-		 * The 96 byte size cache is not used if the alignment
+		 * The 96 byte sized cache is not used if the alignment
 		 * is 64 byte.
 		 */
 		for (i = 64 + 8; i <= 96; i += 8)
diff --git a/mm/swap.c b/mm/swap.c
index af3cad4e5378..0ab1aa4a79b6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -866,7 +866,7 @@ void lru_cache_disable(void)
 	 * all online CPUs so any calls of lru_cache_disabled wrapped by
 	 * local_lock or preemption disabled would be ordered by that.
 	 * The atomic operation doesn't need to have stronger ordering
-	 * requirements because that is enforeced by the scheduling
+	 * requirements because that is enforced by the scheduling
 	 * guarantees.
 	 */
 	__lru_add_drain_all(true);
-- 
2.25.1

