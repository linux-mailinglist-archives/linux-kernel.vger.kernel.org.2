Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52223767A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhEGPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237831AbhEGPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620399968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdcz1iiMJ5gfAfI4nfvenmAExZGLAkLPxmpCCshgl2M=;
        b=T9uAItbr9xEEXp4h2lKEgvgWBIIOVBMsMJlpOJCBH8xnxoct25pwaV290M/Hbyi3G5IeFz
        FDe2MjTxZglLcyloXQB0JiSRYcvdoYxqZeo6F42suEIN/wRlC9XjGwREFr9nuBjfNYNi5s
        NUCu8NA5NzfnoFw8q2JzNZs16fvuU3w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Jx_0KIgBPJOQb5ULldRqkg-1; Fri, 07 May 2021 11:06:06 -0400
X-MC-Unique: Jx_0KIgBPJOQb5ULldRqkg-1
Received: by mail-qv1-f72.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso6782838qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdcz1iiMJ5gfAfI4nfvenmAExZGLAkLPxmpCCshgl2M=;
        b=CfMk8ll2Na0j5kPBVUIKPaN7r+tDXLewOzc/IahlXuekCgIt/0v6bZq9P/tuIqbEZH
         psNVuDWfsr52HdMmYVna9kTt0srcXzaq0eP0eo0J88u6b9Jdfasl4cp1IgasCR1HW57Y
         UytIeODfsBtbDrqhvo7m468H9dB+LvWsj8yW3lqlyrCK0jUCMxB4dEBEXiqI+sHKYanT
         RWeMbQLmq9EixJVCCHZ839WYT/FxZppncxPb/41LRNn76HpoNdBIfeDS9bHPnMX2DHFr
         v6lR2fBNIQ0Wfc+j5M9TZfUSrKNQQjazNLiH/KMmmoMd4yEkrhMO7JA8CSJGvgGOoY6S
         QHmA==
X-Gm-Message-State: AOAM530SnYrTXWjgbGbkO5VnNtj87/606+ktUWP4e7d6DPWsSS1jySzN
        b1NXh1E8uBZZAPsXzYD357nBDT+/EouI+fVAKKERuTNVXxHsNhbnorwbTCx2dDD/IUmqjooa5P7
        lYbgMDdzklGRUhyQ2W06EPmCt
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr9923950qkj.354.1620399964171;
        Fri, 07 May 2021 08:06:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmMkOVQJS6gjZ491s2ZTwn1A0qXX91bKFd/CY+lfU6/IeIUokPpEPo9SfwpZ8hf+ONImU0pg==
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr9923906qkj.354.1620399963820;
        Fri, 07 May 2021 08:06:03 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c141sm950456qke.12.2021.05.07.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 08:06:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
Date:   Fri,  7 May 2021 11:05:53 -0400
Message-Id: <20210507150553.208763-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507150553.208763-1-peterx@redhat.com>
References: <20210507150553.208763-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

has_pinned 32bit can be packed in the MMF_HAS_PINNED bit as a noop
cleanup.

Any atomic_inc/dec to the mm cacheline shared by all threads in
pin-fast would reintroduce a loss of SMP scalability to pin-fast, so
there's no future potential usefulness to keep an atomic in the mm for
this.

set_bit(MMF_HAS_PINNED) will be theoretically a bit slower than
WRITE_ONCE (atomic_set is equivalent to WRITE_ONCE), but the set_bit
(just like atomic_set after this commit) has to be still issued only
once per "mm", so the difference between the two will be lost in the
noise.

will-it-scale "mmap2" shows no change in performance with enterprise
config as expected.

will-it-scale "pin_fast" retains the > 4000% SMP scalability
performance improvement against upstream as expected.

This is a noop as far as overall performance and SMP scalability are
concerned.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: Fix build for task_mmu.c, introduce mm_set_has_pinned_flag, fix
 comment here and there]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c             |  2 +-
 include/linux/mm.h             |  2 +-
 include/linux/mm_types.h       | 10 ----------
 include/linux/sched/coredump.h |  8 ++++++++
 kernel/fork.c                  |  1 -
 mm/gup.c                       | 19 +++++++++++++++----
 6 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4c95cc57a66a8..6144571942db9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1049,7 +1049,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 		return false;
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
-	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
+	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
 		return false;
 	page = vm_normal_page(vma, addr, pte);
 	if (!page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d6790ab0cf575..94dc84f6d8658 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1331,7 +1331,7 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
 
-	if (!atomic_read(&vma->vm_mm->has_pinned))
+	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
 		return false;
 
 	return page_maybe_dma_pinned(page);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a88946..15d79858fadbd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -435,16 +435,6 @@ struct mm_struct {
 		 */
 		atomic_t mm_count;
 
-		/**
-		 * @has_pinned: Whether this mm has pinned any pages.  This can
-		 * be either replaced in the future by @pinned_vm when it
-		 * becomes stable, or grow into a counter on its own. We're
-		 * aggresive on this bit now - even if the pinned pages were
-		 * unpinned later on, we'll still keep this bit set for the
-		 * lifecycle of this mm just for simplicity.
-		 */
-		atomic_t has_pinned;
-
 		/**
 		 * @write_protect_seq: Locked when any thread is write
 		 * protecting pages mapped by this mm to enforce a later COW,
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index dfd82eab29025..4d9e3a6568758 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -73,6 +73,14 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
 #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
+/*
+ * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
+ * replaced in the future by mm.pinned_vm when it becomes stable, or grow into
+ * a counter on its own. We're aggresive on this bit for now: even if the
+ * pinned pages were unpinned later on, we'll still keep this bit set for the
+ * lifecycle of this mm, just for simplicity.
+ */
+#define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
diff --git a/kernel/fork.c b/kernel/fork.c
index 502dc046fbc62..a71e73707ef59 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1026,7 +1026,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
-	atomic_set(&mm->has_pinned, 0);
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/gup.c b/mm/gup.c
index 9933bc5c2eff2..bb130723a6717 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1270,6 +1270,17 @@ int fixup_user_fault(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
 
+/*
+ * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
+ * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
+ * cache bouncing on large SMP machines for concurrent pinned gups.
+ */
+static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
+{
+       if (!test_bit(MMF_HAS_PINNED, mm_flags))
+               set_bit(MMF_HAS_PINNED, mm_flags);
+}
+
 /*
  * Please note that this function, unlike __get_user_pages will not
  * return 0 for nr_pages > 0 without FOLL_NOWAIT
@@ -1292,8 +1303,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
-	if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))
-		atomic_set(&mm->has_pinned, 1);
+	if (flags & FOLL_PIN)
+		mm_set_has_pinned_flag(&mm->flags);
 
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
@@ -2617,8 +2628,8 @@ static int internal_get_user_pages_fast(unsigned long start,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
-	if ((gup_flags & FOLL_PIN) && !atomic_read(&current->mm->has_pinned))
-		atomic_set(&current->mm->has_pinned, 1);
+	if (gup_flags & FOLL_PIN)
+		mm_set_has_pinned_flag(&current->mm->flags);
 
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
-- 
2.31.1

