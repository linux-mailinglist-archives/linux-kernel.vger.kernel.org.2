Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C939B418D23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhIZXpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhIZXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r7so10552204pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nT513pHzGiMpZgaNWaHuaQRUoarxEdG+vAAtn4ZSI3I=;
        b=VGC5hFjSViPa8UHidrJ+zGmm4I8RPo6B7NhutVuOVsVcLYUwKbN/PoKdD3xiLZf+aJ
         2IOUexZRK1VfbIoDyIRMQgknoPmXlBigfdQqKZlIDe4zqGJhVLh4ZnGIge5Fcqt3qWfE
         G+qfmVSSKT9ury1J76cbONnaDrXRyELY35rDHMDgMpo1/5ImYxUyf6WtF2Egyp824oiG
         5HgNQH3Mi7HDBi4WcV5y8UwFDosNb7948/+VIxJAg9Vt9xZore2YBCJe/tyC2qxM/znX
         VAKeIIgY2ri6qy2XDBtI8D9wIPbEtQMGtia55vazq3FxpZ6D5erBdureiFmy6KdsgN5y
         sOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nT513pHzGiMpZgaNWaHuaQRUoarxEdG+vAAtn4ZSI3I=;
        b=5cHgqE9bXr8Ssq9moZixVwKZjc9QpLgn7bi667n4TuDV61BeX0NE1Y4n7N8jxZfdJk
         fzz393EZCmThWF2vxkhyrLHMfTxUQupASpVQYJtosF1D2gaFHVEDQst97nthIq74q4ox
         HKpMvY8hpBhBqhGXC0ICinYYmguAc14HMjKsLR1XkEobIm3W76SYAvf9rSnnFXVbSNc6
         qD9ilbMquijbz5DH1expwyFVO3UqmZ4ftxemUQk8eTwLm0RzDZ7/5PkKr8L5YDLURpvg
         AJqx3pqIVv0iTjz+Y3fq73OvlGJC4IKsMAmysjYZI1FqqP0V4AZnIvCP0MSYagrcDFXt
         Lhcw==
X-Gm-Message-State: AOAM532s1jL/if6YTHvXpt/DjbhJ5oG8pifCdif3SrPyry6dL19qpnsa
        BxsUQFoe3ljjBOF7yG7NA3Uw1z0/9Q4=
X-Google-Smtp-Source: ABdhPJzAfS8fiN3mGvz5Edu6ZGWMLuREZwgR5MIc7fZhEaI1QNeFZ6PR8DwlKpq2jWtYM1A1vIEMBA==
X-Received: by 2002:a17:90b:33c8:: with SMTP id lk8mr16244064pjb.241.1632699843558;
        Sun, 26 Sep 2021 16:44:03 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:44:03 -0700 (PDT)
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
Subject: [RFC PATCH 7/8] mm/madvise: deduplicate code in madvise_dontneed_free()
Date:   Sun, 26 Sep 2021 09:12:58 -0700
Message-Id: <20210926161259.238054-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Following the previous patches, madvise_dontneed_single_vma() and
madvise_free_single_vma() have redundant code. Consolidate it together
into madvise_dontneed_free().

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index e679cfa94655..9528c38fb6a4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -786,25 +786,14 @@ static int madvise_free_single_vma(struct mmu_gather *tlb,
 			struct vm_area_struct *vma,
 			unsigned long start_addr, unsigned long end_addr)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	struct mmu_notifier_range range;
-
 	/* MADV_FREE works for only anon vma at the moment */
 	if (!vma_is_anonymous(vma))
 		return -EINVAL;
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
-				start_addr, end_addr);
-
-	lru_add_drain();
-	update_hiwater_rss(mm);
-
-	mmu_notifier_invalidate_range_start(&range);
 	tlb_start_vma(&tlb, vma);
-	walk_page_range(vma->vm_mm, range.start, range.end,
+	walk_page_range(vma->vm_mm, start_addr, end_addr,
 			&madvise_free_walk_ops, tlb);
 	tlb_end_vma(tlb, vma);
-	mmu_notifier_invalidate_range_end(&range);
 
 	return 0;
 }
@@ -832,18 +821,7 @@ static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
 					struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	struct mmu_notifier_range range;
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, start,
-				end);
-
-	lru_add_drain();
-	update_hiwater_rss(mm);
-
-	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(tlb, vma, start, end, NULL);
-	mmu_notifier_invalidate_range_end(&range);
 
 	return 0;
 }
@@ -855,7 +833,9 @@ static long madvise_dontneed_free(struct mmu_gather *tlb,
 				  int behavior)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
 	unsigned long end = *pend;
+	long ret;
 
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
@@ -901,10 +881,20 @@ static long madvise_dontneed_free(struct mmu_gather *tlb,
 		VM_WARN_ON(start >= end);
 	}
 
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, start,
+				end);
+
+	lru_add_drain();
+	update_hiwater_rss(mm);
+	mmu_notifier_invalidate_range_start(&range);
+
 	if (behavior == MADV_DONTNEED)
-		return madvise_dontneed_single_vma(tlb, vma, start, end);
+		ret = madvise_dontneed_single_vma(tlb, vma, start, end);
 	else /* behavior == MADV_FREE */
-		return madvise_free_single_vma(tlb, vma, start, end);
+		ret = madvise_free_single_vma(tlb, vma, start, end);
+
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
 }
 
 static long madvise_populate(struct vm_area_struct *vma,
-- 
2.25.1

