Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6E3560FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347937AbhDGBwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:16 -0400
Received: from server.lespinasse.org ([63.205.204.226]:54091 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347823AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=4ziyv/pIXZ+c0Q5G5PWzYQBRlES+IZwjStJKbTMM+os=;
 b=1zfU2U/hZRjQOfQbf+ngGzUxUD0CAmdlCfE75iKwCJji3T80V31VCIjGrlAz4Vg2/qnUR
 cLMt72B2etEV5ErCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=4ziyv/pIXZ+c0Q5G5PWzYQBRlES+IZwjStJKbTMM+os=;
 b=Zk4enQyEEfaPQoXqLFfW8qu8XPvJ29ctA8eQmIOu5f7cy23VXpXwFyszzj7f/B4A5c+I/
 T7XEBxP5iCS4irHJX9swHIlVK9DWYUe+gnQn6KljNjZOzg5yZ16CPVI3wqpxLm4Ugn/w4VE
 vw38o6Ovajp+16OwAsnx9pl7eoq3wSkeokZSFYFNjcOStaJd005IjYgCf5yzpOcVgY6+kPn
 qzJKLnN2RLPyB7Q2I2eroqhgkEI0TZpRrB+Y74rRmtcb/E6ldd2NZIY6004/l9BS8lp5Spb
 vUVer8Bak0nHBymTqRtUxDOEqcnxKHoYW0EZOExcseVtnKJW9tXHTh6KJywQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 10E05160369;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0272C19F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 23/37] mm: rcu safe vma->vm_file freeing
Date:   Tue,  6 Apr 2021 18:44:48 -0700
Message-Id: <20210407014502.24091-24-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer freeing of vma->vm_file when freeing vmas.
This is to allow speculative page faults in the mapped file case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 fs/exec.c     |  1 +
 kernel/fork.c | 17 +++++++++++++++--
 mm/mmap.c     | 11 +++++++----
 mm/nommu.c    |  6 ++----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..c9da73eb0f53 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -286,6 +286,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	mmap_write_unlock(mm);
 err_free:
 	bprm->vma = NULL;
+	VM_BUG_ON(vma->vm_file);
 	vm_area_free(vma);
 	return err;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index b6078e546114..2f20a5c5fed8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -369,19 +369,31 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
+static inline void ____vm_area_free(struct vm_area_struct *vma)
+{
+	if (vma->vm_file)
+		fput(vma->vm_file);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 static void __vm_area_free(struct rcu_head *head)
 {
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
-	kmem_cache_free(vm_area_cachep, vma);
+	____vm_area_free(vma);
 }
 
+#endif
+
 void vm_area_free(struct vm_area_struct *vma)
 {
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 	call_rcu(&vma->vm_rcu, __vm_area_free);
+#else
+	____vm_area_free(vma);
+#endif
 }
-#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
@@ -621,6 +633,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
+	tmp->vm_file = NULL;	/* prevents fput within vm_area_free() */
 	vm_area_free(tmp);
 fail_nomem:
 	retval = -ENOMEM;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..cc2323e243bb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -178,9 +178,8 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
-	if (vma->vm_file)
-		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
+	/* fput(vma->vm_file) happens in vm_area_free after an RCU delay. */
 	vm_area_free(vma);
 	return next;
 }
@@ -949,7 +948,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (remove_next) {
 		if (file) {
 			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
+			/* fput(file) happens whthin vm_area_free(next) */
+			VM_BUG_ON(file != next->vm_file);
 		}
 		if (next->anon_vma)
 			anon_vma_merge(vma, next);
@@ -1828,7 +1828,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
-				fput(vma->vm_file);
+				/* fput happens within vm_area_free */
 				vm_area_free(vma);
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
@@ -1907,6 +1907,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
 free_vma:
+	VM_BUG_ON(vma->vm_file);
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
@@ -2779,6 +2780,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
  out_free_mpol:
 	mpol_put(vma_policy(new));
  out_free_vma:
+	new->vm_file = NULL;	/* prevents fput within vm_area_free() */
 	vm_area_free(new);
 	return err;
 }
@@ -3343,6 +3345,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_mempol:
 	mpol_put(vma_policy(new_vma));
 out_free_vma:
+	new_vma->vm_file = NULL;	/* Prevent fput within vm_area_free */
 	vm_area_free(new_vma);
 out:
 	return NULL;
diff --git a/mm/nommu.c b/mm/nommu.c
index 5c9ab799c0e6..06a0dc0b913b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -664,9 +664,8 @@ static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
-	if (vma->vm_file)
-		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
+	/* fput(vma->vm_file) happens within vm_area_free() */
 	vm_area_free(vma);
 }
 
@@ -1267,8 +1266,7 @@ unsigned long do_mmap(struct file *file,
 	if (region->vm_file)
 		fput(region->vm_file);
 	kmem_cache_free(vm_region_jar, region);
-	if (vma->vm_file)
-		fput(vma->vm_file);
+	/* fput(vma->vm_file) happens within vm_area_free() */
 	vm_area_free(vma);
 	return ret;
 
-- 
2.20.1

