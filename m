Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91C418D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhIZXpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIZXpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B757C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so13969085pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u81btMS2EcfvD4xOl+t93Wlb5o4OTa3kZuiyGFUFTF8=;
        b=qlSgKJdiolKmSwykOFnZi1/XJzd8aFrG+DROd106Q+ECW3QKD8Nq+JIZs8Kg3z48Mr
         IbhFU/F89Xivj9Bx6lJAEbcB3aT43JnnsQ77qFheBfb327hb/4+YfPwwoLkE9k6uO6Yy
         MPmRD7YGyItvx1v3mFfgOwrhqpQZz29UX8QzsgwyXn4LjLMd09NaIqZMjpvqIjxI2PWJ
         ggPv9KW7lLO5emIWBrnA72c3UMPZI8FfSgv0wnfj9/Es0Eq2YXSyx6jHHYacjXMc4W9m
         IdNYXLqyHdM/EVBPqxKwJA7VKxShkNFbjn2WegVHGy43UoLkXNjzxjX4aYt3wMBTIlgu
         jO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u81btMS2EcfvD4xOl+t93Wlb5o4OTa3kZuiyGFUFTF8=;
        b=v+998DQm3u2wyTsR2m6deyKqO2zkt1/NAA/YqK5WDEJSK7o9dOWlNQeRiRA7xsoH3F
         9nQAUSD4m+ICCoBNATfFhOSAzag8FWExLQ+Bl7QIGE7NRRYEUhiUl/CbSExYSsQF3kDR
         PID6Fk6STSi6R75MiVdIYWurUuSv6Ko1gqVzvc4qI0uUt7Rp+lztZjhuuvZoeB/GFT8y
         Q4XKhvWFg583dFMdPGmdgPt1LQb+8w5jsxIuyNLapYbfy/yFqeCg1XBPPr/cN/j68ujT
         JnT5WLM7/BemLlT6/F+OxrHVdWgUGmwat2Ucc6dXIiNsKQHUhqWT9aGBxuxg5yH81FXg
         IYwA==
X-Gm-Message-State: AOAM530wuw9TeLM1TlT0lcUoRoduYwfOYkkLzfvQrb6nxhDw/w7MP86D
        3jlFAOviLuJZe2CZMjJXIKqa9aZjs3I=
X-Google-Smtp-Source: ABdhPJzKPnFqZTi36uFRL2WPagr7zdZSK/rhjNj1N5ymsyTwLG9xuGKRrMH+uCQAJVk6eUR4M5SOEA==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr16397472pjy.137.1632699835568;
        Sun, 26 Sep 2021 16:43:55 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:43:55 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
Date:   Sun, 26 Sep 2021 09:12:52 -0700
Message-Id: <20210926161259.238054-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The comment in madvise_dontneed_free() says that vma splits that occur
while the mmap-lock is dropped, during userfaultfd_remove(), should be
handled correctly, but nothing in the code indicates that it is so: prev
is invalidated, and do_madvise() will therefore continue to update VMAs
from the "obsolete" end (i.e., the one before the split).

Propagate the changes to end from madvise_dontneed_free() back to
do_madvise() and continue the updates from the new end accordingly.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Fixes: 70ccb92fdd90 ("userfaultfd: non-cooperative: userfaultfd_remove revalidate vma in MADV_DONTNEED")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..a2b05352ebfe 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -768,10 +768,11 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
-				  unsigned long start, unsigned long end,
+				  unsigned long start, unsigned long *pend,
 				  int behavior)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long end = *pend;
 
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
@@ -811,6 +812,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 * end-vma->vm_end range, but the manager can
 			 * handle a repetition fine.
 			 */
+			*pend = end;
 			end = vma->vm_end;
 		}
 		VM_WARN_ON(start >= end);
@@ -980,8 +982,10 @@ static int madvise_inject_error(int behavior,
 
 static long
 madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		unsigned long start, unsigned long end, int behavior)
+		unsigned long start, unsigned long *pend, int behavior)
 {
+	unsigned long end = *pend;
+
 	switch (behavior) {
 	case MADV_REMOVE:
 		return madvise_remove(vma, prev, start, end);
@@ -993,7 +997,7 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		return madvise_pageout(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
-		return madvise_dontneed_free(vma, prev, start, end, behavior);
+		return madvise_dontneed_free(vma, prev, start, pend, behavior);
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 		return madvise_populate(vma, prev, start, end, behavior);
@@ -1199,7 +1203,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(vma, &prev, start, &tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
-- 
2.25.1

