Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635A3EE84C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhHQIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhHQIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:20:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE769C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:19:46 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id jv8so3168517qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BBBG4u4Q/TrT4lAkdPpvB6zA0ayuEUrcQgY7h86EFM4=;
        b=WSl4AhaxuHlksNyDmACm9oGZneBfx4KzHamzDNAmqmY4Pdy9pJfr3HmR9nQuTRoLx8
         HSoE9LCAuaSzFhkeOmK7ROjATd5n+ArQEyGsIuh1/tM7U83Igi+7+FrsWsq+tUedkhCb
         hwsQy7xt2PrE649VqIky0CHBFIuSfG1Mk+0LklM+B+ivs/nhFl+L/8/bM6dZhn0fnb+q
         9AFiWYh/J+AKn5MoFNagQ0H/UWh2LikYFY7kQ6pr+2b2rf7QDaCoPsnL4imkN4f8L13n
         CTHGWJuTvtrSVBGzHXyDqOH1VkYl/qcuJYuCsoymBH14ZNQLfRz8kR1mSCGwzBwNYLcK
         PG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=BBBG4u4Q/TrT4lAkdPpvB6zA0ayuEUrcQgY7h86EFM4=;
        b=ALxyswWX3Z/X//tbr8exo3QVt9l01izMhJD5ZvF0hcNMKDAJ/3B6CJlL2iCygob8wr
         WsK+0UbVLEz2mBCvub85JLnDuP93HQsa3WSTqbs5eL7I//+VFQWIZr/1gpiecS6MiQaI
         b7XGgCXcLahCNk/VkYUl2b0wZa30JnvyQAh74m1NebIydRXWDlGFcVYd05Fk32JCwCpL
         J5tDSxi+bIBM5H8pKeZAo7feaDFU9CKYGEcs6nbD6fJbhJzYqoWs+Ls8wwBDZDU2l5ZL
         OR3kQF+euAyfWFPHa8SasmfFO7xwdETfa1Q0i5axeIbiQ+KMJi+V7BJ0md1cF90bqvN8
         FFkA==
X-Gm-Message-State: AOAM533U6ogu7DPNIxxrxOoXjsLDPpGivTE0Jpr+0PEfzS8Ya6k3qSl+
        WUwg4QHXgDsgG7sFQIa0TWFkpA==
X-Google-Smtp-Source: ABdhPJySkXFUg0KpN6j9gXg6onC7FbzP//iOt3dKX58t3CeRPmZSmCWCpq1/j6mEhtfjUtDKIsgDfg==
X-Received: by 2002:a05:6214:f6c:: with SMTP id iy12mr2072264qvb.10.1629188385741;
        Tue, 17 Aug 2021 01:19:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i10sm881863qkl.51.2021.08.17.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:19:45 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:19:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 7/9] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <23a77889-2ddc-b030-75cd-44ca27fd4d1@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
that a consistent set of checks can be applied, even when the inode is
accessed through read/write syscalls (with NULL vma) instead of mmaps
(the index argument is seldom of interest, but required by mount option
"huge=within_size").  Clean up and rearrange the checks a little.

This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes.

Replace a couple of 0s by explicit SHMEM_HUGE_NEVERs; and replace the
obscure !shmem_mapping() symlink check by explicit S_ISLNK() - nothing
else needs that symlink check, so leave it there in shmem_getpage_gfp().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/shmem_fs.h |  9 +++--
 mm/shmem.c               | 84 ++++++++++++----------------------------
 2 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 7d97b15a2f7a..60c6e4eac275 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -86,7 +86,12 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 extern int shmem_unuse(unsigned int type, bool frontswap,
 		       unsigned long *fs_pages_to_unuse);
 
-extern bool shmem_huge_enabled(struct vm_area_struct *vma);
+extern bool shmem_is_huge(struct vm_area_struct *vma,
+			  struct inode *inode, pgoff_t index);
+static inline bool shmem_huge_enabled(struct vm_area_struct *vma)
+{
+	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff);
+}
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
@@ -96,8 +101,6 @@ enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
 	SGP_NOALLOC,	/* similar, but fail on hole or use fallocated page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
-	SGP_NOHUGE,	/* like SGP_CACHE, but no huge pages */
-	SGP_HUGE,	/* like SGP_CACHE, huge pages preferred */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index 226ac3a911e9..56ee56b1cab6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -474,39 +474,35 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /* ifdef here to avoid bloating shmem.o when not necessary */
 
-static int shmem_huge __read_mostly;
+static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_huge_enabled(struct vm_area_struct *vma)
+bool shmem_is_huge(struct vm_area_struct *vma,
+		   struct inode *inode, pgoff_t index)
 {
-	struct inode *inode = file_inode(vma->vm_file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	loff_t i_size;
-	pgoff_t off;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
-	switch (sbinfo->huge) {
-	case SHMEM_HUGE_NEVER:
+	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return true;
+
+	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
 		return true;
 	case SHMEM_HUGE_WITHIN_SIZE:
-		off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
+		index = round_up(index, HPAGE_PMD_NR);
 		i_size = round_up(i_size_read(inode), PAGE_SIZE);
-		if (i_size >= HPAGE_PMD_SIZE &&
-				i_size >> PAGE_SHIFT >= off)
+		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
 			return true;
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
-		/* TODO: implement fadvise() hints */
-		return (vma->vm_flags & VM_HUGEPAGE);
+		if (vma && (vma->vm_flags & VM_HUGEPAGE))
+			return true;
+		fallthrough;
 	default:
-		VM_BUG_ON(1);
 		return false;
 	}
 }
@@ -680,6 +676,12 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
+bool shmem_is_huge(struct vm_area_struct *vma,
+		   struct inode *inode, pgoff_t index)
+{
+	return false;
+}
+
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_split)
 {
@@ -1829,7 +1831,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct shmem_sb_info *sbinfo;
 	struct mm_struct *charge_mm;
 	struct page *page;
-	enum sgp_type sgp_huge = sgp;
 	pgoff_t hindex = index;
 	gfp_t huge_gfp;
 	int error;
@@ -1838,8 +1839,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
-	if (sgp == SGP_NOHUGE || sgp == SGP_HUGE)
-		sgp = SGP_CACHE;
 repeat:
 	if (sgp <= SGP_CACHE &&
 	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
@@ -1903,36 +1902,12 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	/* shmem_symlink() */
-	if (!shmem_mapping(mapping))
-		goto alloc_nohuge;
-	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
+	/* Never use a huge page for shmem_symlink() */
+	if (S_ISLNK(inode->i_mode))
 		goto alloc_nohuge;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		goto alloc_huge;
-	switch (sbinfo->huge) {
-	case SHMEM_HUGE_NEVER:
+	if (!shmem_is_huge(vma, inode, index))
 		goto alloc_nohuge;
-	case SHMEM_HUGE_WITHIN_SIZE: {
-		loff_t i_size;
-		pgoff_t off;
-
-		off = round_up(index, HPAGE_PMD_NR);
-		i_size = round_up(i_size_read(inode), PAGE_SIZE);
-		if (i_size >= HPAGE_PMD_SIZE &&
-		    i_size >> PAGE_SHIFT >= off)
-			goto alloc_huge;
 
-		fallthrough;
-	}
-	case SHMEM_HUGE_ADVISE:
-		if (sgp_huge == SGP_HUGE)
-			goto alloc_huge;
-		/* TODO: implement fadvise() hints */
-		goto alloc_nohuge;
-	}
-
-alloc_huge:
 	huge_gfp = vma_thp_gfp_mask(vma);
 	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
@@ -2088,7 +2063,6 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
-	enum sgp_type sgp;
 	int err;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
@@ -2151,15 +2125,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		spin_unlock(&inode->i_lock);
 	}
 
-	sgp = SGP_CACHE;
-
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		sgp = SGP_NOHUGE;
-	else if (vma->vm_flags & VM_HUGEPAGE)
-		sgp = SGP_HUGE;
-
-	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
+	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
 				  gfp, vma, vmf, &ret);
 	if (err)
 		return vmf_error(err);
@@ -3966,7 +3932,7 @@ int __init shmem_init(void)
 	if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
 	else
-		shmem_huge = 0; /* just in case it was patched */
+		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
 #endif
 	return 0;
 
-- 
2.26.2

