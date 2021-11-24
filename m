Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419345D176
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbhKYACW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbhKYACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:02:21 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2AFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:59:11 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v32-20020a05622a18a000b002b04d0d410dso3941526qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gkTIFHzn7lWgA+OKJcWBkA+tgUB9Kv7MlnOSivNnZuA=;
        b=XZom6cLEXCTPPg13cihmjgx6jWLpE3yE6iuM/1xq7DRR8mxgE5ul9FDawNKWZp34V6
         6QX4exQioKgzqwnbZ0RQ1BN1+kX+fygi+9BTQPyFQMYvOqLH6qg/352p4Tq+6VCOf2j7
         Bz+S9nuwfpMre1gMME6RfyuQFS5rqfyB44luHdfqiVVMYMhcYi/WjdkyzQApNr4TJB/S
         /k1JCx3aKgUVTuJYSQhFnqJX05+yUyHrYy0m2M4C1sealksJQCec7ivd6C0eBxWfnCKT
         CjVMHKLvn5KEaLJ9p5fZXwIgCtGAzUGGoFDBXnXor72VgMagnD2HupmJhaGIvJIpESQP
         358Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gkTIFHzn7lWgA+OKJcWBkA+tgUB9Kv7MlnOSivNnZuA=;
        b=shHdJJ61Jwdsa8vkYqxnbzuSHQePwqm7/eOMzMV+0pWMwurnSim4DUSVyYdmWahj8i
         UHjZtEPvIqs8FftuZ+ztMnCAElkjtvjq6kQyxqSAdh+a0RYSlmjOd5qeKl9eqmDqX9nP
         yj6aLAHnKAoKpin8EkqR1PcY2zEnWJl4pjIfWkHpjXvet8dJCTH9Qhf2Ipx6zjFeoUq1
         2/KQisK98tg6F3o1KAFYuEteHYWlgea9VbWG4OsdhA7wUBYOv+PflKePGQis5at93bIg
         IZ8lqYTeKiqgJRQbgEbM2jvzRSQbrgEfUZF1mxPild3sw/1OZ8CiGv6sh0cgmMn+9g7o
         zLHw==
X-Gm-Message-State: AOAM532C6ii7mWI7dhPC1yBUQaIxtAp39/ddexKa3EJh6+MI80DkRvdw
        3mFKOa13XYRnpOwoYBFZC7xAAV+FUyc=
X-Google-Smtp-Source: ABdhPJyCFoO8iT7UKnJAGhIvllYLx1WxReppQlKxurAYcQqseTCbk016W9Tt2SXNW0ZaJC2hr6A+WzzKMS8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e6ae:ce8f:3b61:8f18])
 (user=surenb job=sendgmr) by 2002:ac8:4e51:: with SMTP id e17mr12207103qtw.129.1637798349867;
 Wed, 24 Nov 2021 15:59:09 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:59:05 -0800
Message-Id: <20211124235906.14437-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write lock in exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oom-reaper and process_mrelease system call should protect against
races with exit_mmap which can destroy page tables while they
walk the VMA tree. oom-reaper protects from that race by setting
MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
before taking and releasing mmap_write_lock. process_mrelease has
to elevate mm->mm_users to prevent such race. Both oom-reaper and
process_mrelease hold mmap_read_lock when walking the VMA tree.
The locking rules and mechanisms could be simpler if exit_mmap takes
mmap_write_lock while executing destructive operations such as
free_pgtables.
Change exit_mmap to hold the mmap_write_lock when calling
free_pgtables. Operations like unmap_vmas() and unlock_range() are not
destructive and could run under mmap_read_lock but for simplicity we
take one mmap_write_lock during almost the entire operation. Note
also that because oom-reaper checks VM_LOCKED flag, unlock_range()
should not be allowed to race with it.
In most cases this lock should be uncontended. Previously, Kirill
reported ~4% regression caused by a similar change [1]. We reran the
same test and although the individual results are quite noisy, the
percentiles show lower regression with 1.6% being the worst case [2].
The change allows oom-reaper and process_mrelease to execute safely
under mmap_read_lock without worries that exit_mmap might destroy page
tables from under them.

[1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
[2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v2
- Moved mmap_write_unlock to cover remove_vma loop as well, per Matthew Wilcox

 mm/mmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bfb0ea164a90..f4e09d390a07 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
 		 *
-		 * This needs to be done before calling munlock_vma_pages_all(),
+		 * This needs to be done before calling unlock_range(),
 		 * which clears VM_LOCKED, otherwise the oom reaper cannot
 		 * reliably test it.
 		 */
 		(void)__oom_reap_task_mm(mm);
 
 		set_bit(MMF_OOM_SKIP, &mm->flags);
-		mmap_write_lock(mm);
-		mmap_write_unlock(mm);
 	}
 
+	mmap_write_lock(mm);
 	if (mm->locked_vm)
 		unlock_range(mm->mmap, ULONG_MAX);
 
 	arch_exit_mmap(mm);
 
 	vma = mm->mmap;
-	if (!vma)	/* Can happen if dup_mmap() received an OOM */
+	if (!vma) {
+		/* Can happen if dup_mmap() received an OOM */
+		mmap_write_unlock(mm);
 		return;
+	}
 
 	lru_add_drain();
 	flush_cache_mm(mm);
@@ -3171,16 +3173,14 @@ void exit_mmap(struct mm_struct *mm)
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
-	/*
-	 * Walk the list again, actually closing and freeing it,
-	 * with preemption enabled, without holding any MM locks.
-	 */
+	/* Walk the list again, actually closing and freeing it. */
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

