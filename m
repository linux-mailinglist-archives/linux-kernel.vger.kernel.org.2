Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334A3146D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBIDLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230319AbhBIDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45ThGTqfFb6/yx2k3kPs+btJTG2mPFONj9RwvqJLKYY=;
        b=YmQvyWglwdGDW9gCwu1JYKnToi3mRk47T5XlX14vSxtZD9SowS/gIknuRQMZwRREQL58S/
        NBcGirqz+i3aYg9U8YJmNS9CGh4r2QMiD/ptJdTehN/OQKRiClB/b8xh6LxAZ3C7zih80e
        BOnihOYJFokLwHdTVIqDGVlBR0VJZqU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-yHTgvT19M7OYgn1xoVKp2A-1; Mon, 08 Feb 2021 22:02:40 -0500
X-MC-Unique: yHTgvT19M7OYgn1xoVKp2A-1
Received: by mail-qt1-f197.google.com with SMTP id w3so11145378qti.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45ThGTqfFb6/yx2k3kPs+btJTG2mPFONj9RwvqJLKYY=;
        b=dDXdUtSZLs7ZqLDtMQAG+WPygh/jlV/z1if7N/CJkXvO28LfiEm3WNEQB2L202fqkl
         YYG18bU+e+uhLWRGGYuylRS5fuB5r5URTBylQiWA2Fmnq/uzpmv7BtL6+6Kd4wec8VwY
         zD754GNj04SiKcba6dypu8dYaPlDCyfw+sQm+ekKITz+InPkF8pCdln+fC0JEnU6N/HT
         NTlznrXjDvVZOhZDq3oCWBl+IRxaREuysrycAjKHCMbMjYuYFLxDSf7HMl8DSsim4QXr
         ps54usFl8XT59T29IXtevItnrwHiEQRwrAHSnFBW7AuB1ze6MyeoxKrFUr3r5ToTaF6M
         KlnA==
X-Gm-Message-State: AOAM533VL7//mOs2VEb9lzvs5XxYzdBbkHo4nW5bAA1KoeZGUhCygUSt
        9VxXonoPrem85LWgHBMsNq1r6BCFK8dVYStjGuPkDysUw6C3o5SSldGW1WP5t4v9suoE2Wa1nfg
        ML5V6tZjMWr1sHXZ1jkD35gkm
X-Received: by 2002:ac8:1403:: with SMTP id k3mr18504417qtj.266.1612839759909;
        Mon, 08 Feb 2021 19:02:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2c1gqjFwl2EgCFV1jzhiFbIEsvjBLharoixnAKXp/pgq/v39CQuAjuR9IcJNqX5BFJAMTYA==
X-Received: by 2002:ac8:1403:: with SMTP id k3mr18504382qtj.266.1612839759707;
        Mon, 08 Feb 2021 19:02:39 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:39 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v4 4/5] mm: Use is_cow_mapping() across tree where proper
Date:   Mon,  8 Feb 2021 22:02:28 -0500
Message-Id: <20210209030229.84991-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209030229.84991-1-peterx@redhat.com>
References: <20210209030229.84991-1-peterx@redhat.com>
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
index 71ccec5c3817..620700f05ff4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3733,15 +3733,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
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

