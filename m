Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449F6343432
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCUSwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:52:40 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:59106 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCUSwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:52:09 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 14:52:08 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 470BD40762;
        Sun, 21 Mar 2021 19:46:12 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="QgstfKZg";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zz_OBa3Q9uRF; Sun, 21 Mar 2021 19:46:10 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C1E1F40391;
        Sun, 21 Mar 2021 19:46:09 +0100 (CET)
Received: from localhost.localdomain (2.70.38.73.mobile.tre.se [2.70.38.73])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 08C20361E92;
        Sun, 21 Mar 2021 19:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616352369; bh=ZnblYh+CL4ivnDI/E6ELj+Eqjfd3BvnVp2d0Kcr13LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgstfKZge72BS3EhP/IMO2NO6UDPjjWw3EOjZQCCAMAZbOhSTAWCUxhA0NuKRdbAb
         O17orFTuvm1/2qUmi4x93pHCMDBI9J8h4+MyhcJS2AMr2K+PHTWIkcqJyU4cmkLUCi
         R2rjarNFky6QOoSe+ndSkv2nZu4fJR5yy1qRp8gY=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
Date:   Sun, 21 Mar 2021 19:45:29 +0100
Message-Id: <20210321184529.59006-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210321184529.59006-1-thomas_os@shipmail.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To block fast gup we need to make sure TTM ptes are always special.
With MIXEDMAP we, on architectures that don't support pte_special,
insert normal ptes, but OTOH on those architectures, fast is not
supported.
At the same time, the function documentation to vm_normal_page() suggests
that ptes pointing to system memory pages of MIXEDMAP vmas are always
normal, but that doesn't seem consistent with what's implemented in
vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
needed.

But to make sure and to avoid also normal (non-fast) gup, make all
TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
anymore so make is_cow_mapping() available and use it to reject
COW mappigs at mmap time.

There was previously a comment in the code that WC mappings together
with x86 PAT + PFNMAP was bad for performance. However from looking at
vmf_insert_mixed() it looks like in the current code PFNMAP and MIXEDMAP
are handled the same for architectures that support pte_special. This
means there should not be a performance difference anymore, but this
needs to be verified.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
 include/linux/mm.h              |  5 +++++
 mm/internal.h                   |  5 -----
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 1c34983480e5..708c6fb9be81 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_mixed_prot() for a discussion.
 		 */
-		if (vma->vm_flags & VM_MIXEDMAP)
-			ret = vmf_insert_mixed_prot(vma, address,
-						    __pfn_to_pfn_t(pfn, PFN_DEV),
-						    prot);
-		else
-			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
@@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_s
 	 * Note: We're transferring the bo reference to
 	 * vma->vm_private_data here.
 	 */
-
 	vma->vm_private_data = bo;
 
 	/*
-	 * We'd like to use VM_PFNMAP on shared mappings, where
-	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
-	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
-	 * bad for performance. Until that has been sorted out, use
-	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
+	 * PFNMAP forces us to block COW mappings in mmap(),
+	 * and with MIXEDMAP we would incorrectly allow fast gup
+	 * on TTM memory on architectures that don't have pte_special.
 	 */
-	vma->vm_flags |= VM_MIXEDMAP;
-	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
 }
 
 int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
@@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
 		return -EINVAL;
 
+	if (unlikely(is_cow_mapping(vma->vm_flags)))
+		return -EINVAL;
+
 	bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
 	if (unlikely(!bo))
 		return -EINVAL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..c6ebf7f9ddbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool is_cow_mapping(vm_flags_t flags)
+{
+	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/internal.h b/mm/internal.h
index 9902648f2206..1432feec62df 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct page *page)
  */
 #define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
 
-static inline bool is_cow_mapping(vm_flags_t flags)
-{
-	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
-}
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
-- 
2.30.2

