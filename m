Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB0418D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhIZXpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIZXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f129so16086419pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IgX6dL5NOEQt+/OKQBPTYq3DM8yqU22ikiRTuWFEQs=;
        b=iCi1KOKi0WklCCvp2FWY4GYlC2rLLIejsnGEbQv645XvjEvRLC03v/zhGtg9n7XhI5
         B7SDPa7KX8ZnvOjkUBe0CCIoVYh6gTmIbz3aOJUartJx+s2v8diqqYBRmDpD9sv8nrbf
         2YajJ6pOYEjoSYxPtatkIp0SsNnV5CUJlljPKsQyaMLQmnrh1OZfp3saxNV9wGOGBbb4
         dkeHjdYZk8bjL3Q1v88Q7+WNv2SCd8BuohBIQP14f4TeMZc1Rek2pse0wAsz3XH+FZjZ
         RvGNfN2EEGMdoANBp+ep4zUR9Il8wWpwBvyFfyFk1K502jardGs8i2c2SXldKHtFjhLP
         FTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IgX6dL5NOEQt+/OKQBPTYq3DM8yqU22ikiRTuWFEQs=;
        b=f6JMVm7EbdEa7Oo5ZvppTcaz3Gk0AqutnyYKDcMJKWnfLyEw8cfsLIALKW0KyUT01J
         Qxx2SPjMO1gdlLh3X/oo35eE8F2PKgafmBw9yV6MCaxM0PiAKXaZ7Z1kNaiiigeeiMO0
         VEh79ExCcFjrm7B4MuIoJParQWEuCR9Tsh7lY6YccVFQ/X5MIybCQsdixapJ0V3fufCP
         foXYlfrikULOorKq/Yly7Wgn8Y+Lyuv765DXB8IiLnURoumR1urVo2hTWPta4fVFkABl
         9rOix34zfXSaTeu/dljAItm7L0HFCJWM9AAzLk2lEB/PL7OuPBobY5wBNsPc+yJDKqFT
         Wf9A==
X-Gm-Message-State: AOAM530ljhWCF6HF3Tj3lBaoE6ToGNYwXcHGBi68nzeN0F5N9SHQfpUg
        IJKuZiwHIu//hj/6+P5DC/0=
X-Google-Smtp-Source: ABdhPJx0ScK7+0SaPr9aLkqxWDiNKDgH66MEuAVqy1Czm2rGkTHqNSM7usqARFL9qBBrsg6IAd+PBQ==
X-Received: by 2002:a63:8543:: with SMTP id u64mr13991077pgd.220.1632699839511;
        Sun, 26 Sep 2021 16:43:59 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:43:59 -0700 (PDT)
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
Subject: [RFC PATCH 4/8] mm/madvise: define madvise behavior in a struct
Date:   Sun, 26 Sep 2021 09:12:55 -0700
Message-Id: <20210926161259.238054-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The different behaviors of madvise are different in several ways, which
are distributed across several functions. Use the design pattern from
iouring in order to define the actions that are required for each
behavior.

The next patches will get rid of old helper functions that are modified
in this patch and the redundant use of array_index_nospec(). The next
patches will add more actions for each leaf into the new struct.

No functional change is intended.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 168 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 109 insertions(+), 59 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 17e39c70704b..127507c71ba9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/nospec.h>
 
 #include <asm/tlb.h>
 
@@ -39,6 +40,101 @@ struct madvise_walk_private {
 	bool pageout;
 };
 
+struct madvise_info {
+	u8 behavior_valid: 1;
+	u8 process_behavior_valid: 1;
+	u8 need_mmap_read_only: 1;
+};
+
+static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
+	[MADV_DOFORK] = {
+		.behavior_valid = 1,
+	},
+	[MADV_DONTFORK] = {
+		.behavior_valid = 1,
+	},
+	[MADV_NORMAL] = {
+		.behavior_valid = 1,
+	},
+	[MADV_SEQUENTIAL] = {
+		.behavior_valid = 1,
+	},
+	[MADV_RANDOM] = {
+		.behavior_valid = 1,
+	},
+	[MADV_REMOVE] = {
+		.behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_WILLNEED] = {
+		.behavior_valid = 1,
+		.process_behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_DONTNEED] = {
+		.behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_FREE] = {
+		.behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_COLD] = {
+		.behavior_valid = 1,
+		.process_behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_PAGEOUT] = {
+		.behavior_valid = 1,
+		.process_behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+#ifdef CONFIG_KSM
+	[MADV_MERGEABLE] = {
+		.behavior_valid = 1,
+	},
+	[MADV_UNMERGEABLE] = {
+		.behavior_valid = 1,
+	},
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	[MADV_HUGEPAGE] = {
+		.behavior_valid = 1,
+	},
+	[MADV_NOHUGEPAGE] = {
+		.behavior_valid = 1,
+	},
+#endif
+	[MADV_DONTDUMP] = {
+		.behavior_valid = 1,
+	},
+	[MADV_DODUMP] = {
+		.behavior_valid = 1,
+	},
+	[MADV_WIPEONFORK] = {
+		.behavior_valid = 1,
+	},
+	[MADV_KEEPONFORK] = {
+		.behavior_valid = 1,
+	},
+#ifdef CONFIG_MEMORY_FAILURE
+	[MADV_HWPOISON] = {
+		.behavior_valid = 1,
+	},
+	[MADV_SOFT_OFFLINE] = {
+		.behavior_valid = 1,
+	},
+#endif
+	[MADV_POPULATE_READ] = {
+		.behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+	[MADV_POPULATE_WRITE] = {
+		.behavior_valid = 1,
+		.need_mmap_read_only = 1,
+	},
+};
+
 /*
  * Any behaviour which results in changes to the vma->vm_flags needs to
  * take mmap_lock for writing. Others, which simply traverse vmas, need
@@ -46,20 +142,7 @@ struct madvise_walk_private {
  */
 static int madvise_need_mmap_write(int behavior)
 {
-	switch (behavior) {
-	case MADV_REMOVE:
-	case MADV_WILLNEED:
-	case MADV_DONTNEED:
-	case MADV_COLD:
-	case MADV_PAGEOUT:
-	case MADV_FREE:
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
-		return 0;
-	default:
-		/* be safe, default to 1. list exceptions explicitly */
-		return 1;
-	}
+	return !madvise_info[behavior].need_mmap_read_only;
 }
 
 /*
@@ -999,56 +1082,23 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 }
 
 static bool
-madvise_behavior_valid(int behavior)
+madvise_behavior_valid(int *behavior)
 {
-	switch (behavior) {
-	case MADV_DOFORK:
-	case MADV_DONTFORK:
-	case MADV_NORMAL:
-	case MADV_SEQUENTIAL:
-	case MADV_RANDOM:
-	case MADV_REMOVE:
-	case MADV_WILLNEED:
-	case MADV_DONTNEED:
-	case MADV_FREE:
-	case MADV_COLD:
-	case MADV_PAGEOUT:
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
-#ifdef CONFIG_KSM
-	case MADV_MERGEABLE:
-	case MADV_UNMERGEABLE:
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	case MADV_HUGEPAGE:
-	case MADV_NOHUGEPAGE:
-#endif
-	case MADV_DONTDUMP:
-	case MADV_DODUMP:
-	case MADV_WIPEONFORK:
-	case MADV_KEEPONFORK:
-#ifdef CONFIG_MEMORY_FAILURE
-	case MADV_SOFT_OFFLINE:
-	case MADV_HWPOISON:
-#endif
-		return true;
-
-	default:
+	if (*behavior >= ARRAY_SIZE(madvise_info))
 		return false;
-	}
+
+	*behavior = array_index_nospec(*behavior, ARRAY_SIZE(madvise_info));
+	return madvise_info[*behavior].behavior_valid;
 }
 
 static bool
-process_madvise_behavior_valid(int behavior)
+process_madvise_behavior_valid(int *behavior)
 {
-	switch (behavior) {
-	case MADV_COLD:
-	case MADV_PAGEOUT:
-	case MADV_WILLNEED:
-		return true;
-	default:
+	if (*behavior >= ARRAY_SIZE(madvise_info))
 		return false;
-	}
+
+	*behavior = array_index_nospec(*behavior, ARRAY_SIZE(madvise_info));
+	return madvise_info[*behavior].process_behavior_valid;
 }
 
 /*
@@ -1133,7 +1183,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 
 	start = untagged_addr(start);
 
-	if (!madvise_behavior_valid(behavior))
+	if (!madvise_behavior_valid(&behavior))
 		return error;
 
 	if (!PAGE_ALIGNED(start))
@@ -1258,7 +1308,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto put_pid;
 	}
 
-	if (!process_madvise_behavior_valid(behavior)) {
+	if (!process_madvise_behavior_valid(&behavior)) {
 		ret = -EINVAL;
 		goto release_task;
 	}
-- 
2.25.1

