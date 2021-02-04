Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5130FE25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhBDUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240044AbhBDUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612470059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RUhZ+EXApqGSb7+Tmq9sGFuKWAYlgVlaiJ/4jTiTkk=;
        b=FNVzSmzDqn6Tf8pYUtOCmhbTipwWgF1uNTpBR5BWujukcSfCi2/a+N5oc5tc/1Tq47yyco
        rRhjVtT8mmOGlfcVWivOfmOYS29wUUpJL2iiTD0/EdvqjhC/B7O/zZzYvqfKVq6ZC8k/Z3
        3CG0/WuGI2v4/A6YQvlSrL4yIaK1uSo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-wHCm88ATO3WRmZ4-YyOrQA-1; Thu, 04 Feb 2021 15:20:58 -0500
X-MC-Unique: wHCm88ATO3WRmZ4-YyOrQA-1
Received: by mail-qt1-f199.google.com with SMTP id 22so3519730qty.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RUhZ+EXApqGSb7+Tmq9sGFuKWAYlgVlaiJ/4jTiTkk=;
        b=tVU+68N6grJRsGCv3LeL2ElsXw2PgL5NrWFOKeaSaPlaTTP/0jdO82m0CEoL3BdDTI
         rse9l5ieRTM3grJDbUu7MrCoGvRN1MYk2/8/w8TpfQwYmNgaghXgFGDS7zd5f1WyQgtg
         cTUu7wW7X4/WacS7t23W22CLMq2VHGW0uafooryuxyTOsjzXrb4UMW0DITVl9eTYYFsD
         Be+m9D2RrGVDDBPZvcIJ0SwJxN4xrycYXX1k1D9j/075v0y1/FNoaLbBAYnTBK/ME9ac
         Kgqtv/sIgxS/SQ6zhvp/vJUBiMyW4QG7/qEZsTR8Ieq40ZwlrveQ5c7Dy1PLX4bG7jlz
         7VaQ==
X-Gm-Message-State: AOAM532dkEopupJ6a63jnRMWKCJVFgO8mIRMnNX276P4NVKhTOjVJ3Z+
        qjuZK/SN1I4REmCjLXpc80Wlpwl4xer50CPk0zKml4+cJdcORs3cN3OrGg9okBPnLNtfCzphY/8
        mNeSQ6LXVzHRSNIYaAZB0IiZV
X-Received: by 2002:ae9:ef55:: with SMTP id d82mr991082qkg.243.1612470058081;
        Thu, 04 Feb 2021 12:20:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMrOpedoRrsIqyFMCtBNBcL9gayR8imVmM/6UmrovjTLeTt3NSZKJNQgK1fpK21QJITN0cvA==
X-Received: by 2002:ae9:ef55:: with SMTP id d82mr991055qkg.243.1612470057866;
        Thu, 04 Feb 2021 12:20:57 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p18sm5990601qkj.130.2021.02.04.12.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:20:57 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, Jan Kara <jack@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Wei Zhang <wzam@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Kirill Shutemov <kirill@shutemov.name>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v2 5/4] mm: Use is_cow_mapping() across tree where proper
Date:   Thu,  4 Feb 2021 15:20:55 -0500
Message-Id: <20210204202055.192260-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204145033.136755-1-peterx@redhat.com>
References: <20210204145033.136755-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 4 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   | 2 +-
 fs/proc/task_mmu.c                         | 2 --
 mm/hugetlb.c                               | 4 +---
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 0b76b3d17d4c..22c4a0e9d250 100644
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
index 602e3a52884d..96c1682025f9 100644
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
index 5793936e00ef..684d91b68b60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3756,15 +3756,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage, *prealloc = NULL;
 	unsigned long addr;
-	int cow;
+	int cow = is_cow_mapping(vma->vm_flags);
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

