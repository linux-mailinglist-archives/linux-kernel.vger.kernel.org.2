Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2E44BF31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhKJK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhKJK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4AC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1496609pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzKPEOc5mm0TwBqhdoOl1DzQcSNXKD+dBXA3Ds/gQ/s=;
        b=mEzS5XATpkqsdNV1d5pMNaa7xKmkAkT+cSCulJa0YMKoxdETv0iA2ujFJiRBU/GpxD
         qiCEOhEFYq+kBBYrxfGR4u0rULYIUHAbIFauW9mXYm20ZJd2r8x7e4UKN5vQPOAWzClH
         3edYvbjiyAPquf0l0aKgNQAhHjZ/U4TE4k9AY4YteFLAlZhpL17O7+K+/VzvPi+2/vb8
         Fp0+EEeN/+7cHZBv/1WjkdRlh6ItgfZN4Ck+oSrV9WC2gw6cXlugOIjGwvRSftQUEhCR
         YZS5V5Q81rCXG6MsM6fTQhOwpsPosLA6LB4ebl821L04tpytE4pZdIupEEP7WgAhNk1k
         B3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzKPEOc5mm0TwBqhdoOl1DzQcSNXKD+dBXA3Ds/gQ/s=;
        b=HNed57ZWPpvaL7O/rvyyUiFhHCJ+u+43sMel09HJSMcLj2b5lIPdly5U18Q+Bi+w0U
         Rf5I2RY6+w1dtJYcKEPQzEraPclHE8hsMdOySmY/XORuW103s6Ji4g4UrrxJFQxyrzCH
         /EJ2FRjJiC2mw8dxNlC+etXV4JNVDj3v+oty25oe4G02yuWQPko+lreoCmGAga4SPM7y
         Ck05L8HgcZOt2AS+wZ+GoIdc8gnGFlZdU0JCsDrqkFMKW2nOagXB69OeH+ugEkXxX6xr
         tcIM1ATm+QgBwn81cXsvjQJJZaOEGaoliWUD+c3slN7k9Pg2QGRueQmd+s/GRSPFEsFC
         MMLg==
X-Gm-Message-State: AOAM530PlTk1qe3jJp+v/YOs+xHfTPB7WY9HB68cs7d3Su/aMhA1+T+I
        NDk30ElMLfYD9iL31lKIB5vP2g==
X-Google-Smtp-Source: ABdhPJy+FoE6Pd2qFnrKTUzrIZoCmmPyO4ssefhZxWp4+uu4twU52l9a97OY9avZJGJf8URTBIrhSw==
X-Received: by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id d24-20020a170902b71800b0014372b7409emr10879675pls.28.1636541736145;
        Wed, 10 Nov 2021 02:55:36 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:35 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 10/15] mm/pte_ref: add support for page fault path
Date:   Wed, 10 Nov 2021 18:54:23 +0800
Message-Id: <20211110105428.32458-11-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the page fault path, we need to take a reference of
the PTE page table page if the pmd entry is not none,
which ensures the PTE page table page will not be released
by other threads.

And the mmap_lock may be unlocked in advance in some cases
in handle_pte_fault(), then the pmd entry will no longer
be stable:

	thread A		thread B
	page fault		collapse_huge_page
	==========		==================

	mmap_read_unlock()
				mmap_write_lock()
				pgtable_trans_huge_deposit()
				set_pmd_at()
	/* pmd entry is changed! */
	pte_put()

So we should call pte_put() before dropping the mmap_lock.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/userfaultfd.c |  1 +
 mm/filemap.c     |  2 ++
 mm/internal.h    |  1 +
 mm/khugepaged.c  |  8 +++++++-
 mm/memory.c      | 33 ++++++++++++++++++++++++---------
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22bf14ab2d16..ddbcefa7e0a6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -509,6 +509,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
 						       vmf->address,
 						       vmf->flags, reason);
+	pte_put_vmf(vmf);
 	mmap_read_unlock(mm);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
diff --git a/mm/filemap.c b/mm/filemap.c
index aa47ee11a3d8..4fdc74dc6736 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1708,6 +1708,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
 			return false;
 
+		pte_put_vmf(vmf);
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
@@ -1720,6 +1721,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
+			pte_put_vmf(vmf);
 			mmap_read_unlock(mm);
 			return false;
 		}
diff --git a/mm/internal.h b/mm/internal.h
index 474d6e3443f8..460418828a76 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -488,6 +488,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	if (fault_flag_allow_retry_first(flags) &&
 	    !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
 		fpin = get_file(vmf->vma->vm_file);
+		pte_put_vmf(vmf);
 		mmap_read_unlock(vmf->vma->vm_mm);
 	}
 	return fpin;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1a..92b0494f4a00 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,10 +1019,13 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 			.pmd = pmd,
 		};
 
-		vmf.pte = pte_offset_map(pmd, address);
+		vmf.pte = pte_tryget_map(pmd, address);
+		if (!vmf.pte)
+			continue;
 		vmf.orig_pte = *vmf.pte;
 		if (!is_swap_pte(vmf.orig_pte)) {
 			pte_unmap(vmf.pte);
+			pte_put_vmf(&vmf);
 			continue;
 		}
 		swapped_in++;
@@ -1041,7 +1044,10 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 				return false;
 			}
+		} else {
+			pte_put_vmf(&vmf);
 		}
+
 		if (ret & VM_FAULT_ERROR) {
 			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 			return false;
diff --git a/mm/memory.c b/mm/memory.c
index ea4d651ac8c7..5cc4ce0af665 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4571,8 +4571,10 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
+	vm_fault_t ret;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
+retry:
+	if (unlikely(pmd_none(READ_ONCE(*vmf->pmd)))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
 		 * want to allocate huge page, and if we expose page table
@@ -4595,13 +4597,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd from under us anymore at this point because we hold the
 		 * mmap_lock read mode and khugepaged takes it in write mode.
 		 * So now it's safe to run pte_offset_map().
 		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_tryget_map(vmf->pmd, vmf->address);
+		if (!vmf->pte)
+			goto retry;
 		vmf->orig_pte = *vmf->pte;
 
 		/*
@@ -4616,6 +4621,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		if (pte_none(vmf->orig_pte)) {
 			pte_unmap(vmf->pte);
 			vmf->pte = NULL;
+			pte_put_vmf(vmf);
 		}
 	}
 
@@ -4626,11 +4632,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
-		return do_swap_page(vmf);
+	if (!pte_present(vmf->orig_pte)) {
+		ret = do_swap_page(vmf);
+		goto put;
+	}
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
-		return do_numa_page(vmf);
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		ret = do_numa_page(vmf);
+		goto put;
+	}
 
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
@@ -4640,8 +4650,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		goto unlock;
 	}
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		if (!pte_write(entry))
-			return do_wp_page(vmf);
+		if (!pte_write(entry)) {
+			ret = do_wp_page(vmf);
+			goto put;
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -4663,7 +4675,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return 0;
+	ret = 0;
+put:
+	pte_put_vmf(vmf);
+	return ret;
 }
 
 /*
-- 
2.11.0

