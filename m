Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C49453BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhKPWAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:00:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943C2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:57:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id y18-20020a634952000000b002ecc060ccc8so193363pgk.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ds7CkJIXOL2mYL105KfyaplaQRNJT0sgaXWilVjc75w=;
        b=a4UUleXv4Vh0+4iNT2NyvFFpMROT9+yq0O/b+cpkv7VQa6AYLh4gfJfXpvxTfZbEH5
         OPQn3NsKK79KyNEWT2Wyz0IRL/kOkJRIKvprEB5pu8jdfHXz5d4Ba01tNMMqIyuSUTFZ
         xMQ1rqK2GQX0Kfqv7ATKT7TGPs3AkOcHPbNOPAthwrZFdqKRyCEohjAgfvyYXOPgnnGg
         YWwhwcvY2C4XBGMJvrDfZlq1ILMglQO+sB6sDRhWjDM3gOQNbZNPteXwHqo4/CaHHPnY
         xjsMVcjn79zbjBbMC32Qakfoof0Dwlv7rchpJzMujCNyk8bq3ZXweo/rWiKDwWg44E1R
         BzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ds7CkJIXOL2mYL105KfyaplaQRNJT0sgaXWilVjc75w=;
        b=fIAx5BNmmEYCeCQ9mQut9Qi1TebxTlsNGgx3ad/Lql0QI9TmMtfLpz+iHGNors0hLb
         tEFYlWaJ4izE9FvZakAOEX00W3CNEZa3K6wDPyUk/cg37yjXjvclYB7FpLCJJ5FnZJAD
         BnTpKJl+wn84gwPC9uJ/B8rdUtE0YnuxQzVccZmYHoRrPwFOHphJ7SKXX6EFDqd0REgb
         SsMnP32FkrCw8xe8dxux+KCPfOHWj1bJk5yf4ufvXFSbYe2H9J9Op0AS5BImBUQskXtt
         PjQNbH3hLJaLaoNfn0JN2nr7we+QuSYddu/U/oEo2g2skeExqQTCgPvdobee9myi1tae
         4XQA==
X-Gm-Message-State: AOAM532pXRLIN9KNRkBeR2wo9vJPp9664gv/5oo1FMcOEN1qJ9r7njfH
        w5ew2Bz4a3Ddsr1vclekWVSAkiREyU8=
X-Google-Smtp-Source: ABdhPJye+XfttuNAxgGm4XDnZjHBwsdwvyOlKQAeoGZWLGAuc/JE6AaUFQlJvGYlhrKfh4nhYdVuXmyX5pE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:91d1:d198:1088:5801])
 (user=surenb job=sendgmr) by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id
 d24-20020a170902b71800b0014372b7409emr48831424pls.28.1637099839672; Tue, 16
 Nov 2021 13:57:19 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:57:14 -0800
Message-Id: <20211116215715.645231-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock in exit_mmap
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
 mm/mmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bfb0ea164a90..69b3036c6dee 100644
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
@@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
+	mmap_write_unlock(mm);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
-- 
2.34.0.rc1.387.gb447b232ab-goog

