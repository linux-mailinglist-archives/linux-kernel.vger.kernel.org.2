Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480AC36C95B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbhD0QZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237616AbhD0QQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWfJd/H/T26cGeSLT9ABJVI8Det1WDmJfdLZOnVj/9Y=;
        b=a0MQeVXLDiGDtYcgsX7KztydjB3AoF3pcgpI5pyJUvjzuPTNNWab0rY1TN3+InZNxoAbkL
        1+ZiohvD3mYvIYmtLtyM8V4HeOFVWrDHG2340Nv/LEn5P2MnGR5BfSjzfR1l9lL9cSC4i2
        LR3JoZRgOwKKnaU6nqTlQMX8KUMBlwc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-SoESH5CHPJixDKf-7AeHpQ-1; Tue, 27 Apr 2021 12:14:01 -0400
X-MC-Unique: SoESH5CHPJixDKf-7AeHpQ-1
Received: by mail-qv1-f72.google.com with SMTP id c5-20020a0ca9c50000b02901aede9b5061so14110684qvb.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWfJd/H/T26cGeSLT9ABJVI8Det1WDmJfdLZOnVj/9Y=;
        b=jWMEHibDsJdo4P+x4IMBIe/Gpre0fC1Olh5PIyGI2eHLWjQDVu1NqqpWMx5sCvUzUV
         hVAAr46ksS6Kc/TZvbyIciPsFC6ztEOm+UOzm29Ccg/krT5H88TsgbR831ZG9LEh1jCe
         dOC/SSE9A0mPHG2GyDwXTBRO1K071Lr6EuRN7dpz6OTawIdvLCxOsYvOZHLVkV3xEQMB
         5Vwg+M4pLLIYEXsWczLdkcS2tRLe0J1JsN/jSYM1+U61vbXdZQ3hZjeqErCJAh47bjKR
         aIzS2MBa8c90PFcwJM5Qhd5dM9JoCXtMd29LVbaO1OSJlKfoKsilJOTjAWjEQFr0dl7k
         eWhQ==
X-Gm-Message-State: AOAM531UFhedf0HBBaP2JSMVmDVkxfdicZ21v/eI9JwxSHF8S4ChH+tD
        UOFero/flHZYWAJg2S4g1VDjNIlhkg9FWnSnFw8Ubk84J4AnG1C0ggQa73zmHGbJnF+o+pxri6s
        Y23Etmz0sSZmY7/g6b2eQI0qO
X-Received: by 2002:a05:620a:40c6:: with SMTP id g6mr7712180qko.226.1619540040546;
        Tue, 27 Apr 2021 09:14:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaSB+v4nhW1pF8jFSUzXD1x5f/DDzv4u7/+Bwb8/4kHfWIDByTz/eIHQ9VVD180ealMkxeXQ==
X-Received: by 2002:a05:620a:40c6:: with SMTP id g6mr7712153qko.226.1619540040220;
        Tue, 27 Apr 2021 09:14:00 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 23/24] mm/userfaultfd: Enable write protection for shmem & hugetlbfs
Date:   Tue, 27 Apr 2021 12:13:16 -0400
Message-Id: <20210427161317.50682-24-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've had all the necessary changes ready for both shmem and hugetlbfs.  Turn
on all the shmem/hugetlbfs switches for userfaultfd-wp.

Now we can remove the flags parameter for vma_can_userfault() since not used
any more.  Meanwhile, we can expand UFFD_API_RANGE_IOCTLS_BASIC with
_UFFDIO_WRITEPROTECT too because all existing types now support write
protection mode.

Since vma_can_userfault() will be used elsewhere, move into userfaultfd_k.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                 | 19 -------------------
 include/linux/userfaultfd_k.h    | 15 +++++++++++++++
 include/uapi/linux/userfaultfd.h |  7 +++++--
 mm/userfaultfd.c                 | 10 +++-------
 4 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a41e0631af512..a436a1feb10db 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1275,25 +1275,6 @@ static __always_inline int validate_range(struct mm_struct *mm,
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
-		/* FIXME: Add minor fault interception for shmem. */
-		if (!is_vm_hugetlb_page(vma))
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
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fefebe6e96560..95afd4814ab29 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -132,6 +133,20 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma,
+				     unsigned long vm_flags)
+{
+	if (vm_flags & VM_UFFD_MINOR) {
+		/* FIXME: Add minor fault interception for shmem. */
+		if (!is_vm_hugetlb_page(vma))
+			return false;
+	}
+
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
+}
+
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a26245..298fbd4e2d1d3 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -31,7 +31,8 @@
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
-			   UFFD_FEATURE_MINOR_HUGETLBFS)
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -45,7 +46,8 @@
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
-	 (__u64)1 << _UFFDIO_CONTINUE)
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -196,6 +198,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<10)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 2cd6ad5c3d8f8..3930e56aaefd8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -445,7 +445,6 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		VM_WARN_ON_ONCE(wp_copy);
 		if (!zeropage)
 			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
 						     dst_vma, dst_addr,
@@ -682,15 +681,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
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
2.26.2

