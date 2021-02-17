Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8331E317
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBQXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232468AbhBQXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBTLGivaN2/sd96zZsp336IcNgBMJM5xgqwCgvKU+2Q=;
        b=RJfxrWEw66dXX/gRz/gb7/glPZfmvDteSc7Xffww0X24Jz9fp4nx2WXK36vsRru+OT03jo
        j8zWwjKrHbaoc2fFwAPMFK5/Dvqr/G/xLV8isFZ+C61+o9PdEuju0HZmUu4TjbN6xqUBrH
        rjdffOtDqu2QfaCgIb99JigKVUof/Aw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-_KdStlv3ODW7HZGx4ElNTQ-1; Wed, 17 Feb 2021 18:35:57 -0500
X-MC-Unique: _KdStlv3ODW7HZGx4ElNTQ-1
Received: by mail-qt1-f199.google.com with SMTP id i19so92721qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBTLGivaN2/sd96zZsp336IcNgBMJM5xgqwCgvKU+2Q=;
        b=Be5reiQyCrT/P2hnpPa5V5v9ElvQAfR7clPFfUn+XVoMORPenu4YLJyhtYH7tPFtUP
         LRm1y4a+HFKwAQ4DQrCSt7b9FWpS3tEKJrV4kb++yqYtCvzLGAzavYaaOLjnQUymeZpa
         5D4V5SASMaIskl18/xeCotMO/1vcKztskjDO3EOu9nFS/69kxXZZlT8tgcDToXccM9EV
         PQ+c+EUOmNJlDdZzH2BKz7S2bPTPWWj3U8JrYGcUCEGvtnC2j8b1vKpy86jM3Bh78ZP4
         T1Qp1b+s5PMA9S4ng4GzJxum4whToLpQUi5rZSlCqqe83YnUMX2JwO/ApGNABb70SffC
         sVqg==
X-Gm-Message-State: AOAM533nXIwjRXhVA/IyYfl7wHGOVOXK+xurkdLD8o58MIT9oBSWAmAK
        uDaFzPtkCuJXaRe0a4nklK+7DJIZlYF/4+I8mteIjLSWOiosiYESEPjvR2glPDBcoT4OJo1JvU9
        3FHT6WLdJdYDQY58zrI/UaRQ/
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr1751810qtw.223.1613604956659;
        Wed, 17 Feb 2021 15:35:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCH2IIJVdVsOH2LNlUl1Ovh4tC3TAN8kSvtARyw6G8f10CuUr38qe/cCGqM2ng0NiVxAXCwQ==
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr1751793qtw.223.1613604956479;
        Wed, 17 Feb 2021 15:35:56 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:56 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v5 4/5] mm: Use is_cow_mapping() across tree where proper
Date:   Wed, 17 Feb 2021 18:35:46 -0500
Message-Id: <20210217233547.93892-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
References: <20210217233547.93892-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After is_cow_mapping() is exported in mm.h, replace some manual checks
elsewhere throughout the tree but start to use the new helper.

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 4 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   | 2 +-
 fs/proc/task_mmu.c                         | 2 --
 mm/hugetlb.c                               | 4 +---
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 0a900afc66ff..45c9c6a7f1d6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -500,8 +500,6 @@ vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret;
 	pgoff_t fault_page_size;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool is_cow_mapping =
-		(vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	switch (pe_size) {
 	case PE_SIZE_PMD:
@@ -518,7 +516,7 @@ vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
 	}
 
 	/* Always do write dirty-tracking and COW on PTE level. */
-	if (write && (READ_ONCE(vbo->dirty) || is_cow_mapping))
+	if (write && (READ_ONCE(vbo->dirty) || is_cow_mapping(vma->vm_flags)))
 		return VM_FAULT_FALLBACK;
 
 	ret = ttm_bo_vm_reserve(bo, vmf);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
index 3c03b1746661..cb9975889e2f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
@@ -49,7 +49,7 @@ int vmw_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_ops = &vmw_vm_ops;
 
 	/* Use VM_PFNMAP rather than VM_MIXEDMAP if not a COW mapping */
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) != VM_MAYWRITE)
+	if (!is_cow_mapping(vma->vm_flags))
 		vma->vm_flags = (vma->vm_flags & ~VM_MIXEDMAP) | VM_PFNMAP;
 
 	return 0;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cec6fbef725..e862cab69583 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1036,8 +1036,6 @@ struct clear_refs_private {
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 
-#define is_cow_mapping(flags) (((flags) & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE)
-
 static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
 	struct page *page;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2ba4ea4ab46e..8379224e1d43 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3731,15 +3731,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
-	int cow;
+	bool cow = is_cow_mapping(vma->vm_flags);
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
-	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
-
 	if (cow) {
 		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, src,
 					vma->vm_start,
-- 
2.26.2

