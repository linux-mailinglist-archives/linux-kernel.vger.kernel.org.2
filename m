Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB0418D20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhIZXpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhIZXpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDBC061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so13969172pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uIfgW0DLl5b1zzqh2vZMp9HHNJQ53DebXYGC7KgLB0=;
        b=bt8Pcnk8mKhwMewC+6gJPcZtVLn3LgH+s5vi1JOXVopT5zHaY2DkYK6+b2U8p4bIOX
         lAeHJbgDTLWYj+5YtJH7UfeL9CUM/d7s5NRt2GZ6JzK4POchQrFyrwNidjjpKGtI9kMO
         AcDzmr1YjmuVE0CAERvBrFzrobICaeOS/SqwBmNbHjYvpUBXf6rkBHfBRad1hktUlawA
         QjQtXJj9HGYiFzsUHakUJTydVh1i12SjfLMRtaMLKHRAUgKK4N57dXgOz1XKk7bwTYH4
         DvvQaJ8d/dWE/dV9OV4mhlSR+7qz8ndm69A6LEnHTWvZWtSOpedT5vYw+NDYNZ2TnLaC
         mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uIfgW0DLl5b1zzqh2vZMp9HHNJQ53DebXYGC7KgLB0=;
        b=XdSr6357OgyJXUHNf6McL4LfUnaBTbKEfRsK1iTTBjlNr96q/3bFhRQx4CGgfBw7kN
         fW4XneYqZ4DuoOWioyUUnnWabZ+KbOyZeXrxe8g2WOcBFgWWFIRzdIxMgH53+qEGQqk6
         m6ZN7ZRqYG3d1xxFQMrgSmUsJRJsK5s8bK16WcvHQCKStw0H8YwZmZ/8lO9XNXU5G2HF
         Me6BDAzqtqd+8HMHXdBjy55jskMJ2SFuSuuStOKpJWs3Ou/KR2E+TN+WhVAQwyRi5JDI
         pbf2AFCiVR2MTLh/uDcWHPcHFDdpz8YiVkC1zudrkwKUUlOhjpEQggft8zb40ZXGBer0
         ZXrg==
X-Gm-Message-State: AOAM532J3/bPFfbvMXALOvW3SEyRF7BQmUafb3PRrUreLhaiMsLtA/gP
        H8iOHBxrkZ8b2htxQ2Gsx8M=
X-Google-Smtp-Source: ABdhPJyQ474KOK4qAUHpwiptg0L4FDkBiV23b+5O5tnyftNkmc2gHVMBQqJw+JEulEWae2ZCYAkxWw==
X-Received: by 2002:a17:90b:3b4c:: with SMTP id ot12mr16305275pjb.67.1632699840874;
        Sun, 26 Sep 2021 16:44:00 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:44:00 -0700 (PDT)
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
Subject: [RFC PATCH 5/8] mm/madvise: perform certain operations once on process_madvise()
Date:   Sun, 26 Sep 2021 09:12:56 -0700
Message-Id: <20210926161259.238054-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There are certain operations that can be performed only once on
process_madvise() instead of performing them for each IO vector.
Acquiring the mmap-lock, and initializing blk_plug are specifically such
operations.

Collect the aforementioned operations into madvise_start() and
madvise_finish(). The next patches will add additional operations into
these functions.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 139 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 53 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 127507c71ba9..84b86ae85671 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -43,6 +43,13 @@ struct madvise_walk_private {
 struct madvise_info {
 	u8 behavior_valid: 1;
 	u8 process_behavior_valid: 1;
+	u8 no_mmap_lock: 1;
+
+	/*
+	 * Any behaviour which results in changes to the vma->vm_flags needs to
+	 * take mmap_lock for writing. Others, which simply traverse vmas, need
+	 * to only take it for reading.
+	 */
 	u8 need_mmap_read_only: 1;
 };
 
@@ -120,9 +127,11 @@ static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
 #ifdef CONFIG_MEMORY_FAILURE
 	[MADV_HWPOISON] = {
 		.behavior_valid = 1,
+		.no_mmap_lock = 1,
 	},
 	[MADV_SOFT_OFFLINE] = {
 		.behavior_valid = 1,
+		.no_mmap_lock = 1,
 	},
 #endif
 	[MADV_POPULATE_READ] = {
@@ -135,16 +144,6 @@ static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
 	},
 };
 
-/*
- * Any behaviour which results in changes to the vma->vm_flags needs to
- * take mmap_lock for writing. Others, which simply traverse vmas, need
- * to only take it for reading.
- */
-static int madvise_need_mmap_write(int behavior)
-{
-	return !madvise_info[behavior].need_mmap_read_only;
-}
-
 /*
  * We can potentially split a vm area into separate
  * areas, each area with its own behavior.
@@ -1081,26 +1080,6 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	}
 }
 
-static bool
-madvise_behavior_valid(int *behavior)
-{
-	if (*behavior >= ARRAY_SIZE(madvise_info))
-		return false;
-
-	*behavior = array_index_nospec(*behavior, ARRAY_SIZE(madvise_info));
-	return madvise_info[*behavior].behavior_valid;
-}
-
-static bool
-process_madvise_behavior_valid(int *behavior)
-{
-	if (*behavior >= ARRAY_SIZE(madvise_info))
-		return false;
-
-	*behavior = array_index_nospec(*behavior, ARRAY_SIZE(madvise_info));
-	return madvise_info[*behavior].process_behavior_valid;
-}
-
 /*
  * The madvise(2) system call.
  *
@@ -1171,21 +1150,17 @@ process_madvise_behavior_valid(int *behavior)
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
+int madvise_one_range(struct mm_struct *mm, unsigned long start, size_t len_in,
+		      int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int unmapped_error = 0;
 	int error = -EINVAL;
-	int write;
 	size_t len;
-	struct blk_plug plug;
 
 	start = untagged_addr(start);
 
-	if (!madvise_behavior_valid(&behavior))
-		return error;
-
 	if (!PAGE_ALIGNED(start))
 		return error;
 	len = PAGE_ALIGN(len_in);
@@ -1207,14 +1182,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 		return madvise_inject_error(behavior, start, start + len_in);
 #endif
 
-	write = madvise_need_mmap_write(behavior);
-	if (write) {
-		if (mmap_write_lock_killable(mm))
-			return -EINTR;
-	} else {
-		mmap_read_lock(mm);
-	}
-
 	/*
 	 * If the interval [start,end) covers some unmapped address
 	 * ranges, just ignore them, but return -ENOMEM at the end.
@@ -1224,7 +1191,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
-	blk_start_plug(&plug);
 	for (;;) {
 		/* Still start < end. */
 		error = -ENOMEM;
@@ -1260,15 +1226,72 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 			vma = find_vma(mm, start);
 	}
 out:
-	blk_finish_plug(&plug);
-	if (write)
-		mmap_write_unlock(mm);
-	else
-		mmap_read_unlock(mm);
 
 	return error;
 }
 
+static int
+madvise_start(struct mm_struct *mm, struct madvise_info behavior_info,
+	      struct blk_plug *plug)
+{
+	if (!behavior_info.no_mmap_lock) {
+		if (behavior_info.need_mmap_read_only)
+			mmap_read_lock(mm);
+		else if (mmap_write_lock_killable(mm))
+			return -EINTR;
+	}
+
+	blk_start_plug(plug);
+	return 0;
+}
+
+static void
+madvise_finish(struct mm_struct *mm, struct madvise_info behavior_info,
+	       struct blk_plug *plug)
+{
+	blk_finish_plug(plug);
+
+	if (!behavior_info.no_mmap_lock) {
+		if (behavior_info.need_mmap_read_only)
+			mmap_read_unlock(mm);
+		else
+			mmap_write_unlock(mm);
+	}
+}
+
+static struct madvise_info madvise_behavior_info(int behavior)
+{
+	if (behavior >= ARRAY_SIZE(madvise_info) || behavior < 0) {
+		const struct madvise_info invalid = {0};
+		return invalid;
+	}
+
+	behavior = array_index_nospec(behavior, ARRAY_SIZE(madvise_info));
+	return madvise_info[behavior];
+}
+
+int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
+	       int behavior)
+{
+	struct madvise_info behavior_info;
+	struct blk_plug plug;
+	int ret = -EINVAL;
+
+	behavior_info = madvise_behavior_info(behavior);
+
+	if (!behavior_info.behavior_valid)
+		return ret;
+
+	ret = madvise_start(mm, behavior_info, &plug);
+	if (ret != 0)
+		return ret;
+
+	ret = madvise_one_range(mm, start, len_in, behavior);
+
+	madvise_finish(mm, behavior_info, &plug);
+	return ret;
+}
+
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return do_madvise(current->mm, start, len_in, behavior);
@@ -1286,6 +1309,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct mm_struct *mm;
 	size_t total_len;
 	unsigned int f_flags;
+	struct madvise_info behavior_info;
+	struct blk_plug plug;
 
 	if (flags != 0) {
 		ret = -EINVAL;
@@ -1308,7 +1333,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto put_pid;
 	}
 
-	if (!process_madvise_behavior_valid(&behavior)) {
+	behavior_info = madvise_behavior_info(behavior);
+
+	if (!behavior_info.process_behavior_valid) {
 		ret = -EINVAL;
 		goto release_task;
 	}
@@ -1331,15 +1358,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	total_len = iov_iter_count(&iter);
 
+	ret = madvise_start(mm, behavior_info, &plug);
+	if (ret != 0)
+		goto release_mm;
+
 	while (iov_iter_count(&iter)) {
 		iovec = iov_iter_iovec(&iter);
-		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
-					iovec.iov_len, behavior);
+		ret = madvise_one_range(mm, (unsigned long)iovec.iov_base,
+				iovec.iov_len, behavior);
 		if (ret < 0)
 			break;
 		iov_iter_advance(&iter, iovec.iov_len);
 	}
 
+	madvise_finish(mm, behavior_info, &plug);
+
 	if (ret == 0)
 		ret = total_len - iov_iter_count(&iter);
 
-- 
2.25.1

