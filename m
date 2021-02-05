Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15532311186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhBESI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:08:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45ThGTqfFb6/yx2k3kPs+btJTG2mPFONj9RwvqJLKYY=;
        b=axX9SZspjMD2bUVLLe+KzTSU+YfGoeQ2dzrwyovm+W4NsuIrGncvRpBV+enusxKX/iD0Ed
        pD7p6yxMca7igJxi6r/f19bN92U4snCK/P7cOiz2UuNaBTlm2QfeMSJXLVjDObadf1g8dB
        66mhjPUl2vNiw04T+mrj13efTunnqnA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-gsSgWaQ7MS2wJOnqOSTylw-1; Fri, 05 Feb 2021 11:53:38 -0500
X-MC-Unique: gsSgWaQ7MS2wJOnqOSTylw-1
Received: by mail-qk1-f198.google.com with SMTP id 70so6355723qkh.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45ThGTqfFb6/yx2k3kPs+btJTG2mPFONj9RwvqJLKYY=;
        b=EgSzW/481+jYkcsDWzsXfJ/EOFqso7FtFaMgNdGjBqXXh0zgrfknLNOZgubYATRe07
         l2kwQ1I8lBLNsqkcSbNbGpSAzFDuh7vI2N0WwWYvdQ1WSNuPrt9k1FL0MlSk0DAfwbAM
         kD7J6AMOzdrjOBCJYN2sis2qHPgzK6A/W5GeEFHfmi71chdkwG1UzVTHnEWLyHLl6tvJ
         bpdHCc6zzrGJJ7aUGkTcxt4aIPylLyCTIykNivKUI1leqaJRJFEAQSMC163/bKp3phjy
         TACHCkjk+f5jxYi1pbjP+qmoO1OtfhSsBPclX1vvqDtLr7fda8QX6RkMzWKNL6MclQx5
         lkgw==
X-Gm-Message-State: AOAM533rqxfS4xie+t5oHVR8L75DDdmX+NFpIHVJZoZPihltYPO00Lqu
        nS4yTGERom2x+x6tpnp/2Y5XHWBpZgjOLlCPZzd0IDbDLaOB73uZNs4ZJUcvddWOu/dG+zbteNR
        2MjWLilya4V/n8pjJQM0YHnNS
X-Received: by 2002:a37:d01:: with SMTP id 1mr5220138qkn.247.1612544018260;
        Fri, 05 Feb 2021 08:53:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxioHYSeFu7FIORv42JUdT5KiGh790cz4iF+AF9w2tOueheZlZAI5UINMF2g+tHX8/8AUMikA==
X-Received: by 2002:a37:d01:: with SMTP id 1mr5220104qkn.247.1612544018061;
        Fri, 05 Feb 2021 08:53:38 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v3 4/5] mm: Use is_cow_mapping() across tree where proper
Date:   Fri,  5 Feb 2021 11:54:05 -0500
Message-Id: <20210205165406.4655-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205165406.4655-1-peterx@redhat.com>
References: <20210205165406.4655-1-peterx@redhat.com>
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

