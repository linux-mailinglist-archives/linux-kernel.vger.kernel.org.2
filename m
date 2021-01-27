Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A329A306853
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhA0Xyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhA0Xyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:54:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A0B364DD4;
        Wed, 27 Jan 2021 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611791648;
        bh=jmM4gVRGgilnA81ZMlj6tXbIsH9e4Kl+pn5Cw5j3RJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaRQ4V3KQ4lw1arqtiyzsTsE0CP5+RywkTTNZe0WPosVGZfZ0/cEkeBgtr1UpK29v
         qg0jydqu3jnaKy5PgKPgvhgUfncloK74x1uQ/o11xaRUqNqH5ITw15vlbKvx7qbGxs
         aAx43nvq6S8M/BMNsdZa8asIm8l2U0RkV6WriyiymeZ4IiYsIiNVK02CFksG8U25Bp
         TFao6SLyDNw2xyg6xbdA8GQVRbuYLtetkGI08lDQwM9zFsfb3ixnjPnI13SoLb67NN
         4FhlrVv87lvhJs/hsZX6kEtvarip626Mkn1ue2N1y9XKpiggZDueUNiRVkbh1MEbYH
         YiNExzz+oKxoQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 1/6] mm: proc: Invalidate TLB after clearing soft-dirty page state
Date:   Wed, 27 Jan 2021 23:53:42 +0000
Message-Id: <20210127235347.1402-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210127235347.1402-1-will@kernel.org>
References: <20210127235347.1402-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double
flush"), TLB invalidation is elided in tlb_finish_mmu() if no entries
were batched via the tlb_remove_*() functions. Consequently, the
page-table modifications performed by clear_refs_write() in response to
a write to /proc/<pid>/clear_refs do not perform TLB invalidation.
Although this is fine when simply aging the ptes, in the case of
clearing the "soft-dirty" state we can end up with entries where
pte_write() is false, yet a writable mapping remains in the TLB.

Fix this by avoiding the mmu_gather API altogether: managing both the
'tlb_flush_pending' flag on the 'mm_struct' and explicit TLB
invalidation for the sort-dirty path, much like mprotect() does already.

Fixes: 0758cd830494 ("asm-generic/tlb: avoid potential double flush”)
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/proc/task_mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 602e3a52884d..3cec6fbef725 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1210,7 +1210,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
-	struct mmu_gather tlb;
 	int itype;
 	int rv;
 
@@ -1249,7 +1248,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			goto out_unlock;
 		}
 
-		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1258,15 +1256,18 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				vma_set_page_prot(vma);
 			}
 
+			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
 		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
 				&cp);
-		if (type == CLEAR_REFS_SOFT_DIRTY)
+		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-		tlb_finish_mmu(&tlb, 0, -1);
+			flush_tlb_mm(mm);
+			dec_tlb_flush_pending(mm);
+		}
 out_unlock:
 		mmap_write_unlock(mm);
 out_mm:
-- 
2.30.0.365.g02bc693789-goog

