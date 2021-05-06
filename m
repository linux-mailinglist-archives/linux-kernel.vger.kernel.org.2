Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C069375D61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 01:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEFX04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 19:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhEFX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 19:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620343549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvDl4+FUwbO0MY99vMQj8Ya/mqNaGR1M/DGULDYnMW4=;
        b=hrwCqAT/bXF6+/zcLY5YLx7Fpg5w6mUYT6Pbni2hL3GCIODqGse0QK/GjQgCHRNKlxgd9L
        N8S6CKxP8W8pBg2soZ3YgB0mstAPF6fKAukkqH31wUFtZt9QjLMhsbBwWMAuNPUV02g65T
        j8SQvGIWgvzznPmBmq6Q45LD3/JIVYE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-rH9LDB5kNIGgq5al7rXUmQ-1; Thu, 06 May 2021 19:25:47 -0400
X-MC-Unique: rH9LDB5kNIGgq5al7rXUmQ-1
Received: by mail-qt1-f197.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so4569031qta.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 16:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvDl4+FUwbO0MY99vMQj8Ya/mqNaGR1M/DGULDYnMW4=;
        b=q+ymdkQ+UwZWXP+MSVQZV13YQubnpJ5ZWQx67QrwYCW0uaOP7qWMd2Xqh1srU4h2u1
         I/tjzQCR0SNg6qAbNMzEOgsdR9sVXcfgeRg3mC9/PUdUBEMRXFRk+tWLtp+G4ST1IuVM
         42UtLuzqJJ8oV/S2iZKlnymITsAQtNlDurY/QKV66MVo+qGhzveJM4YdWVUefvy04G71
         bdRIdbYT0WUKfKqOrzFgbD/oeLrUiMdM2jE0YQ6bcwXJkQ7osFOzFZ7knE3tKJ61lsqw
         4D5gmDwP2Qs7mDbJkBZ8avXMhSqWy+g8Q62zYGNF7G8yr5JPdFsxVW+WAY2v0tu+kQkp
         EiTw==
X-Gm-Message-State: AOAM532SBsSOlyvR3d1OXEOQY+JfbolSvL8/t1VwKl5ompLZ9snMw72D
        14yucMgNRnCY6K02U8dieJUifNcfBbITBNEOMHfFijJta3l9tZoAU9YNZF5zzUPGh9DJ5rYntD1
        s/zI6WXulcyUpClwxI9HljwKR
X-Received: by 2002:a0c:b38b:: with SMTP id t11mr7421841qve.25.1620343545433;
        Thu, 06 May 2021 16:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxZpHe561yR92rMxp1tyWoGD0aKXhful40fuYgTCuul6pIfMwnyAkv8pzsKfXqXsBDgp200g==
X-Received: by 2002:a0c:b38b:: with SMTP id t11mr7421822qve.25.1620343545141;
        Thu, 06 May 2021 16:25:45 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q13sm1605026qkn.10.2021.05.06.16.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 16:25:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
Date:   Thu,  6 May 2021 19:25:37 -0400
Message-Id: <20210506232537.165788-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210506232537.165788-1-peterx@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
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
[peterx: Fix build for task_mmu.c]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c             |  2 +-
 include/linux/mm.h             |  2 +-
 include/linux/mm_types.h       | 10 ----------
 include/linux/sched/coredump.h |  1 +
 kernel/fork.c                  |  1 -
 mm/gup.c                       |  9 +++++----
 6 files changed, 8 insertions(+), 17 deletions(-)

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
index dfd82eab29025..bf45badd63e6d 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -73,6 +73,7 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
 #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
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
index 8b513e1723b45..78416b0909873 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1292,8 +1292,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
-	if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))
-		atomic_set(&mm->has_pinned, 1);
+	if (flags & FOLL_PIN && !test_bit(MMF_HAS_PINNED, &mm->flags))
+		set_bit(MMF_HAS_PINNED, &mm->flags);
 
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
@@ -2617,8 +2617,9 @@ static int internal_get_user_pages_fast(unsigned long start,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
-	if (gup_flags & FOLL_PIN && !atomic_read(&current->mm->has_pinned))
-		atomic_set(&current->mm->has_pinned, 1);
+	if (gup_flags & FOLL_PIN &&
+	    !test_bit(MMF_HAS_PINNED, &current->mm->flags))
+		set_bit(MMF_HAS_PINNED, &current->mm->flags);
 
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
-- 
2.31.1

