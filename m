Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718DF3CADC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbhGOUU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245663AbhGOUT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MaYhfyg3rdsKTSiNE3E1njhtBDjCspL0vB5Uj2aGpxY=;
        b=hXfW/GfgCoUy3oggnhSRbT8LTaqfx7RgnfaPVmY+O0EDysQEY0ydzboJTf811uT7nu/SNq
        KtBXoFqUIv+bXQBR8sDdxa5FUM1ooWRnS19xg3YGwsjjtnla8B1dnzzNelfWO6KLzWGHGy
        n6apwl/l62NKVK92ZFf+uegz4TDmwy4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-EvrngWvDPNucxc-n9n2wDA-1; Thu, 15 Jul 2021 16:17:01 -0400
X-MC-Unique: EvrngWvDPNucxc-n9n2wDA-1
Received: by mail-qt1-f198.google.com with SMTP id h17-20020ac858510000b0290251fc608f73so4927445qth.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MaYhfyg3rdsKTSiNE3E1njhtBDjCspL0vB5Uj2aGpxY=;
        b=hZh0+aDfVTkSF0CEX9SML5ASwE+oZOhsDQDXNNp7Yg5CPuFGDq0BGbIjGmqFZIT28l
         SAv0LJeX+1kSsIPA7QheUhpZZZtr5l1xGD9kNlwGMEJe89nLzLO3/xaX5fdVJhsgzNw9
         vvVSM++OfdEwoLDTUK5YOYmAEQFD/lP3UYNv7YB9IZcdTb8qq/Fdd8d8V6KWlvH0Ozzq
         gYHLdwpvu22XAbpMLCrq2ozA+dYRquzyH44LzlBTqZiELvVnW+UCyqm5UfFWUSgQM5+R
         MeIpvvweoFY+OEla/CZV+hUXiAz7YuWLPltBVKFbmz79+YQJx5FYGbMuWzvOPZ8S5cpD
         D5YQ==
X-Gm-Message-State: AOAM5302N4EI0hUT5Inqh9mRTcJ/fZh1vgE1AoFVBxbeFth9zw6F/DNJ
        e6f1QwCXVtLbUaoCxCzJu4WabSn6NL6TqWSTHIHdD5c0KXmFwkL/fi0gfdbHc5UiVzPa6UmUdrN
        UvEdBT/p2+TyucsCewPLJR/dt/kwnzMfCP6hjjPu5hhWV+a8ic1E7mBRt/D5NxjNaCMw3uTvI1Q
        ==
X-Received: by 2002:a05:622a:514:: with SMTP id l20mr2187572qtx.215.1626380219342;
        Thu, 15 Jul 2021 13:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGaMVuZvegxB+EpIeGAd6z2m3L4/IrqbWZR8YZVvAN7k/ztEs5ecS1pObFzi2lieDQcRpKxQ==
X-Received: by 2002:a05:622a:514:: with SMTP id l20mr2187534qtx.215.1626380219041;
        Thu, 15 Jul 2021 13:16:59 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id f12sm1587479qtj.10.2021.07.15.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 25/26] mm/userfaultfd: Enable write protection for shmem & hugetlbfs
Date:   Thu, 15 Jul 2021 16:16:55 -0400
Message-Id: <20210715201655.212184-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've had all the necessary changes ready for both shmem and hugetlbfs.  Turn
on all the shmem/hugetlbfs switches for userfaultfd-wp.

We can expand UFFD_API_RANGE_IOCTLS_BASIC with _UFFDIO_WRITEPROTECT too because
all existing types now support write protection mode.

Since vma_can_userfault() will be used elsewhere, move into userfaultfd_k.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                 | 21 ++-------------------
 include/linux/userfaultfd_k.h    | 12 ++++++++++++
 include/uapi/linux/userfaultfd.h | 10 ++++++++--
 mm/userfaultfd.c                 |  9 +++------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 644df737fbb2..980879117110 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1275,24 +1275,6 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
-{
-	/* FIXME: add WP support to hugetlbfs and shmem */
-	if (vm_flags & VM_UFFD_WP) {
-		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
-			return false;
-	}
-
-	if (vm_flags & VM_UFFD_MINOR) {
-		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
-			return false;
-	}
-
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	       vma_is_shmem(vma);
-}
-
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1966,7 +1948,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	uffdio_api.features &=
+	    ~(UFFD_FEATURE_PAGEFAULT_FLAG_WP | UFFD_FEATURE_WP_HUGETLBFS_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 92606d95b005..4382240de7c3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -138,6 +139,17 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma,
+				     unsigned long vm_flags)
+{
+	if (vm_flags & VM_UFFD_MINOR)
+		return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
+
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
+}
+
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 05b31d60acf6..a67b5185a7a9 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -32,7 +32,8 @@
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
-			   UFFD_FEATURE_MINOR_SHMEM)
+			   UFFD_FEATURE_MINOR_SHMEM |		\
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -46,7 +47,8 @@
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
-	 (__u64)1 << _UFFDIO_CONTINUE)
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -189,6 +191,9 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
 	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
+	 *
+	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
+	 * write-protection mode is supported on both shmem and hugetlbfs.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -201,6 +206,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
+#define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<11)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a8038903effd..6587ed787707 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -724,15 +724,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 	err = -ENOENT;
 	dst_vma = find_dst_vma(dst_mm, start, len);
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+
+	if (!dst_vma)
 		goto out_unlock;
 	if (!userfaultfd_wp(dst_vma))
 		goto out_unlock;
-	if (!vma_is_anonymous(dst_vma))
+	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
 		goto out_unlock;
 
 	if (is_vm_hugetlb_page(dst_vma)) {
-- 
2.31.1

