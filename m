Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAC418D21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhIZXpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIZXpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CBC06176A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e7so16087921pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkEF0/Q6rbx9FExzFJEmcylCwn+F9BK/PAVlqDzqCuk=;
        b=Tl1nreO8ZaENYCUeyUvf3Ic0WiU+vCsHdK5O+hJJHl8u6WsUXxobXZpORdPtNvK6IA
         OE4Z2YMCMbdDachKu+3TxvHTbmJ4TDa9/EJuI3xLg3OLfVr6zVbUnYGjeqamKB5RIbLg
         FY/Z9APV3f3FlThudedelEZZuncC1xDPPXY+OEQXv3mbJr+znGld+b3GBdN3/i2Q1Sr2
         evxIstLnH3dhVtpZ9ZbgJtPWjKvRY8PuwgPjfJeY0/u9bNRVV4CmEAeN5JJDyJ8oA6ih
         Az6cRRcfm9DW2Y+zpxhJe+opXPtCE0zrp1S+JE+tc+nc9T7otIW5cdjkbtom1v3EoRSk
         TI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkEF0/Q6rbx9FExzFJEmcylCwn+F9BK/PAVlqDzqCuk=;
        b=pDf1hf5GQaEwLmsboljqVNU58Otl2lz243sAPfckfhywn5DAlbUHUsfVW0/QzcxNds
         FfckuvIaSzokIdD623r/9qm9v5GrqNcZ38y4IRLFOsxlPq70cgt22poQaMTpyrHUU1Ca
         iEltfgKnnilYZDYi5v8zL+nJqEzbgEc3tIXeIZhD7sZ1577/+WXeNJP527HTD9lP/fkz
         ukbDjaZd3Xb/9Awr5qy5ooWqGPntDcYsBlXF0mW1+f5RGop9D8F07ldbleCgzCTI4w+o
         hCrVxT7A9tRdwR2si8xoo567O8/kzaJXoALDs1rDkO45argtRph6dlc4EoJ+CJync7wL
         UTVg==
X-Gm-Message-State: AOAM531JcIC+JsH08zDyrJRMmZYTmb1LJAqoEQfmU+P6yYu6ZKxUg5nF
        4JT7w4iV/OR3V1S5wtp6XZ8=
X-Google-Smtp-Source: ABdhPJyhOgaxFKSJHYAE0/nHMseXbjf23Cg7H2wwtSb134c4XmaFXwSEjSXcFhZgWJ81w8SLx9TtUA==
X-Received: by 2002:a63:4606:: with SMTP id t6mr13935096pga.388.1632699842239;
        Sun, 26 Sep 2021 16:44:02 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:44:01 -0700 (PDT)
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
Subject: [RFC PATCH 6/8] mm/madvise: more aggressive TLB batching
Date:   Sun, 26 Sep 2021 09:12:57 -0700
Message-Id: <20210926161259.238054-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

process_madvise(MADV_COLD) and future variants lose the opportunity to
perform TLB batching across IO vectors. As a result, a TLB flush (and
potentially a shootdown) is performed for each IO vector, instead of one
for the whole operation.

Batch TLB operations across IO-vectors. Open code zap_page_range() to do
so. A future patch will eliminate redundancies between
madvise_free_single_vma() and madvise_dontneed_single_vma().

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/internal.h |   5 +++
 mm/madvise.c  | 104 +++++++++++++++++++++++++++++---------------------
 mm/memory.c   |   2 +-
 3 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 18256e32a14c..2313a6739ce7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -59,6 +59,11 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
+void unmap_single_vma(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long start_addr,
+		unsigned long end_addr,
+		struct zap_details *details);
+
 void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
 		unsigned long lookahead_size);
 void force_page_cache_ra(struct readahead_control *, unsigned long nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index 84b86ae85671..e679cfa94655 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -51,6 +51,7 @@ struct madvise_info {
 	 * to only take it for reading.
 	 */
 	u8 need_mmap_read_only: 1;
+	u8 tlb_batching: 1;
 };
 
 static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
@@ -81,20 +82,24 @@ static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
 	[MADV_DONTNEED] = {
 		.behavior_valid = 1,
 		.need_mmap_read_only = 1,
+		.tlb_batching = 1,
 	},
 	[MADV_FREE] = {
 		.behavior_valid = 1,
 		.need_mmap_read_only = 1,
+		.tlb_batching = 1,
 	},
 	[MADV_COLD] = {
 		.behavior_valid = 1,
 		.process_behavior_valid = 1,
 		.need_mmap_read_only = 1,
+		.tlb_batching = 1,
 	},
 	[MADV_PAGEOUT] = {
 		.behavior_valid = 1,
 		.process_behavior_valid = 1,
 		.need_mmap_read_only = 1,
+		.tlb_batching = 1,
 	},
 #ifdef CONFIG_KSM
 	[MADV_MERGEABLE] = {
@@ -578,21 +583,16 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static long madvise_cold(struct vm_area_struct *vma,
-			struct vm_area_struct **prev,
-			unsigned long start_addr, unsigned long end_addr)
+static long madvise_cold(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			struct vm_area_struct **prev, unsigned long start_addr,
+			unsigned long end_addr)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	struct mmu_gather tlb;
-
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb);
+	madvise_cold_page_range(tlb, vma, start_addr, end_addr);
 
 	return 0;
 }
@@ -628,13 +628,10 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
-static long madvise_pageout(struct vm_area_struct *vma,
+static long madvise_pageout(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	struct mmu_gather tlb;
-
 	*prev = vma;
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
@@ -643,9 +640,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 		return 0;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb);
+	madvise_pageout_page_range(tlb, vma, start_addr, end_addr);
 
 	return 0;
 }
@@ -787,12 +782,12 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
 	.pmd_entry		= madvise_free_pte_range,
 };
 
-static int madvise_free_single_vma(struct vm_area_struct *vma,
+static int madvise_free_single_vma(struct mmu_gather *tlb,
+			struct vm_area_struct *vma,
 			unsigned long start_addr, unsigned long end_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
-	struct mmu_gather tlb;
 
 	/* MADV_FREE works for only anon vma at the moment */
 	if (!vma_is_anonymous(vma))
@@ -802,16 +797,14 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 				start_addr, end_addr);
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
 	tlb_start_vma(&tlb, vma);
 	walk_page_range(vma->vm_mm, range.start, range.end,
-			&madvise_free_walk_ops, &tlb);
-	tlb_end_vma(&tlb, vma);
+			&madvise_free_walk_ops, tlb);
+	tlb_end_vma(tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -820,7 +813,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
  * Application no longer needs these pages.  If the pages are dirty,
  * it's OK to just throw them away.  The app will be more careful about
  * data it wants to keep.  Be sure to free swap resources too.  The
- * zap_page_range call sets things up for shrink_active_list to actually free
+ * unmap_single_vma call sets things up for shrink_active_list to actually free
  * these pages later if no one else has touched them in the meantime,
  * although we could add these pages to a global reuse list for
  * shrink_active_list to pick up before reclaiming other pages.
@@ -835,14 +828,28 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
  * An interface that causes the system to free clean pages and flush
  * dirty pages is already available as msync(MS_INVALIDATE).
  */
-static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
+static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
+					struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	zap_page_range(vma, start, end - start);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, start,
+				end);
+
+	lru_add_drain();
+	update_hiwater_rss(mm);
+
+	mmu_notifier_invalidate_range_start(&range);
+	unmap_single_vma(tlb, vma, start, end, NULL);
+	mmu_notifier_invalidate_range_end(&range);
+
 	return 0;
 }
 
-static long madvise_dontneed_free(struct vm_area_struct *vma,
+static long madvise_dontneed_free(struct mmu_gather *tlb,
+				  struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long *pend,
 				  int behavior)
@@ -895,9 +902,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	}
 
 	if (behavior == MADV_DONTNEED)
-		return madvise_dontneed_single_vma(vma, start, end);
+		return madvise_dontneed_single_vma(tlb, vma, start, end);
 	else /* behavior == MADV_FREE */
-		return madvise_free_single_vma(vma, start, end);
+		return madvise_free_single_vma(tlb, vma, start, end);
 }
 
 static long madvise_populate(struct vm_area_struct *vma,
@@ -1055,8 +1062,9 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		unsigned long start, unsigned long *pend, int behavior)
+madvise_vma(struct mmu_gather *tlb, struct vm_area_struct *vma,
+	    struct vm_area_struct **prev, unsigned long start,
+	    unsigned long *pend, int behavior)
 {
 	unsigned long end = *pend;
 
@@ -1066,12 +1074,13 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_WILLNEED:
 		return madvise_willneed(vma, prev, start, end);
 	case MADV_COLD:
-		return madvise_cold(vma, prev, start, end);
+		return madvise_cold(tlb, vma, prev, start, end);
 	case MADV_PAGEOUT:
-		return madvise_pageout(vma, prev, start, end);
+		return madvise_pageout(tlb, vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
-		return madvise_dontneed_free(vma, prev, start, pend, behavior);
+		return madvise_dontneed_free(tlb, vma, prev, start, pend,
+					     behavior);
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 		return madvise_populate(vma, prev, start, end, behavior);
@@ -1151,7 +1160,7 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
 int madvise_one_range(struct mm_struct *mm, unsigned long start, size_t len_in,
-		      int behavior)
+		      int behavior, struct mmu_gather *tlb)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1211,7 +1220,7 @@ int madvise_one_range(struct mm_struct *mm, unsigned long start, size_t len_in,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, &tmp, behavior);
+		error = madvise_vma(tlb, vma, &prev, start, &tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
@@ -1225,6 +1234,7 @@ int madvise_one_range(struct mm_struct *mm, unsigned long start, size_t len_in,
 		else	/* madvise_remove dropped mmap_lock */
 			vma = find_vma(mm, start);
 	}
+
 out:
 
 	return error;
@@ -1232,7 +1242,7 @@ int madvise_one_range(struct mm_struct *mm, unsigned long start, size_t len_in,
 
 static int
 madvise_start(struct mm_struct *mm, struct madvise_info behavior_info,
-	      struct blk_plug *plug)
+	      struct mmu_gather *tlb, struct blk_plug *plug)
 {
 	if (!behavior_info.no_mmap_lock) {
 		if (behavior_info.need_mmap_read_only)
@@ -1241,16 +1251,22 @@ madvise_start(struct mm_struct *mm, struct madvise_info behavior_info,
 			return -EINTR;
 	}
 
+	if (behavior_info.tlb_batching)
+		tlb_gather_mmu(tlb, mm);
+
 	blk_start_plug(plug);
 	return 0;
 }
 
 static void
 madvise_finish(struct mm_struct *mm, struct madvise_info behavior_info,
-	       struct blk_plug *plug)
+	       struct mmu_gather *tlb, struct blk_plug *plug)
 {
 	blk_finish_plug(plug);
 
+	if (behavior_info.tlb_batching)
+		tlb_finish_mmu(tlb);
+
 	if (!behavior_info.no_mmap_lock) {
 		if (behavior_info.need_mmap_read_only)
 			mmap_read_unlock(mm);
@@ -1274,6 +1290,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
 	       int behavior)
 {
 	struct madvise_info behavior_info;
+	struct mmu_gather tlb;
 	struct blk_plug plug;
 	int ret = -EINVAL;
 
@@ -1282,13 +1299,13 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
 	if (!behavior_info.behavior_valid)
 		return ret;
 
-	ret = madvise_start(mm, behavior_info, &plug);
+	ret = madvise_start(mm, behavior_info, &tlb, &plug);
 	if (ret != 0)
 		return ret;
 
-	ret = madvise_one_range(mm, start, len_in, behavior);
+	ret = madvise_one_range(mm, start, len_in, behavior, &tlb);
 
-	madvise_finish(mm, behavior_info, &plug);
+	madvise_finish(mm, behavior_info, &tlb, &plug);
 	return ret;
 }
 
@@ -1310,6 +1327,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	size_t total_len;
 	unsigned int f_flags;
 	struct madvise_info behavior_info;
+	struct mmu_gather tlb;
 	struct blk_plug plug;
 
 	if (flags != 0) {
@@ -1358,20 +1376,20 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	total_len = iov_iter_count(&iter);
 
-	ret = madvise_start(mm, behavior_info, &plug);
+	ret = madvise_start(mm, behavior_info, &tlb, &plug);
 	if (ret != 0)
 		goto release_mm;
 
 	while (iov_iter_count(&iter)) {
 		iovec = iov_iter_iovec(&iter);
 		ret = madvise_one_range(mm, (unsigned long)iovec.iov_base,
-				iovec.iov_len, behavior);
+				iovec.iov_len, behavior, &tlb);
 		if (ret < 0)
 			break;
 		iov_iter_advance(&iter, iovec.iov_len);
 	}
 
-	madvise_finish(mm, behavior_info, &plug);
+	madvise_finish(mm, behavior_info, &tlb, &plug);
 
 	if (ret == 0)
 		ret = total_len - iov_iter_count(&iter);
diff --git a/mm/memory.c b/mm/memory.c
index 12a7b2094434..a00fb705a77f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1541,7 +1541,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 }
 
 
-static void unmap_single_vma(struct mmu_gather *tlb,
+void unmap_single_vma(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr,
 		struct zap_details *details)
-- 
2.25.1

