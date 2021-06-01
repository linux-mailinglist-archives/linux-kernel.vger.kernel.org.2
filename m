Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0A397CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhFAXYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhFAXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69192613BC;
        Tue,  1 Jun 2021 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622589755;
        bh=d6j6EDGkhnc+GxiEmiU29Lm/NCKNEqKbXTPVfNJiuuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftu0zJj3/weUgRsC8CSXzsmqeuhN2FdlfFbM5ew8+E1xgWmbSx50aC2TeDff/fo3r
         rXK/4YMRtWDpxZ50xfhXMJM3yljE5igxQ6kcRa58MomH/F5L3TNhL/t884dtSmTIo+
         09ytxS7PJVtcn5dj3yw4PyjcYw2tGvkIVW8OQ6ZWZD48lgYqOpLsFdXQDLWjTH9P85
         7oHZbbIgqE5qoxr3gzF+FM4CckTHXQRscojVBqXI2wgPvH8I2utWPqJdlz5LQ+N7pT
         TM+e02mUxQEZMPM0EBBBYG3z5XlVgjf55p6Q/I8nuq6tynxWktFEIPZ5FcbLpVVNog
         E77bBQpTQwZTw==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ming Lin <mlin@kernel.org>
Subject: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
Date:   Tue,  1 Jun 2021 16:22:33 -0700
Message-Id: <1622589753-9206-3-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622589753-9206-1-git-send-email-mlin@kernel.org>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
"don't SIGBUS on read beyond i_size". This flag is only allowed
for read only shmem mapping.

If you use MAP_NOSIGBUS, and you access pages that don't have a backing
store, you will get zero pages, and they will NOT BE SYNCHRONIZED with
the backing store possibly later being updated.

Any user that uses MAP_NOSIGBUS had better just accept that it's not
compatible with expanding the shmem backing store later.

Signed-off-by: Ming Lin <mlin@kernel.org>
---
 include/linux/mm.h                     |  2 ++
 include/linux/mman.h                   |  1 +
 include/uapi/asm-generic/mman-common.h |  1 +
 mm/mmap.c                              |  3 +++
 mm/shmem.c                             | 17 ++++++++++++++++-
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e9d67bc..5d0e0dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -373,6 +373,8 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 
+#define VM_NOSIGBUS		VM_FLAGS_BIT(38)	/* Do not SIGBUS on out-of-band shmem read */
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
 
diff --git a/include/linux/mman.h b/include/linux/mman.h
index b2cbae9..c966b08 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -154,6 +154,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_NOSIGBUS,   VM_NOSIGBUS  ) |
 	       arch_calc_vm_flag_bits(flags);
 }
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d..55f4be0 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on out-of-band shmem read */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/mm/mmap.c b/mm/mmap.c
index 096bba4..69cd856 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1419,6 +1419,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (!len)
 		return -EINVAL;
 
+	if ((flags & MAP_NOSIGBUS) && ((prot & PROT_WRITE) || !shmem_file(file)))
+		return -EINVAL;
+
 	/*
 	 * Does the application expect PROT_READ to imply PROT_EXEC?
 	 *
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d46611..5d15b08 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1812,7 +1812,22 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 repeat:
 	if (sgp <= SGP_CACHE &&
 	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
-		return -EINVAL;
+		if (!vma || !(vma->vm_flags & VM_NOSIGBUS))
+			return -EINVAL;
+
+		vma->vm_flags |= VM_MIXEDMAP;
+		/*
+		 * Get zero page for MAP_NOSIGBUS mapping, which isn't
+                 * coherent wrt shmem contents that are expanded and
+		 * filled in later.
+		 */
+		error = vm_insert_page(vma, (unsigned long)vmf->address,
+					ZERO_PAGE(0));
+		if (error)
+			return error;
+
+		*fault_type = VM_FAULT_NOPAGE;
+		return 0;
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-- 
1.8.3.1

