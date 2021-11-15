Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4844FFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhKOIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236681AbhKOIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYi6ss6i+qaMQh6aXf6FP47ZJ3XzTF5CNwYJPDp0yLw=;
        b=axqBG3XXlPc+XqEDm2XsoZQ/S0i0ygkoFHHbzXbLeTMxqI4pTu1GAUeEe3NsIUMtcBAw5d
        n0GDCBRizMlltZqlB6g/qj+Lrouin71Kbd5kcg/TkwY88qUs2aMRfiQwwJTGj0LkIzwQtL
        4J7vvyY6rtlslSdKj7cu0xesTj9hMM8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-6dSv2ayvMMW5daPEeSFWwQ-1; Mon, 15 Nov 2021 03:03:54 -0500
X-MC-Unique: 6dSv2ayvMMW5daPEeSFWwQ-1
Received: by mail-pj1-f71.google.com with SMTP id a16-20020a17090aa51000b001a78699acceso8215755pjq.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYi6ss6i+qaMQh6aXf6FP47ZJ3XzTF5CNwYJPDp0yLw=;
        b=ANAkFnrE7Xeak4c29shAJgCBhQATuXc65p1WNLb2eIr2foxmc5B4qft2zWI+M/X3Bz
         vbC6Ht/uJZzFzaKys3079ObUcDXBy3vousTxFEVm+7x323iQUK+g/WuGQgrD6/QRK/CG
         AAicbkl3ixGq31fuK3HO/6QkZaIekxoxqac2D4Q3eQxsWz1T5CC29sdTzqu91uHwPInv
         9tfYpS14eHapJHGEjrbNcVXfyBS2CRORvuTSvYXUdnS+J2WI+e1mEJEN74GIXhpfOeDu
         7pL/XWI0W4k4B4+ZfbdBt09t1rHtbIpW+GYHVyBXSyOR3dbx7NaBPW6jdjr5xE+Er+4C
         B9KA==
X-Gm-Message-State: AOAM531+hHZInAw2IyWyoFYc1j+AJlHBjfUAG2qfBusGz1sAXrVeiO6D
        oPiBz2BQ5FX1RlN8QRgiV7kYUQPKpeh5XLNwyTx18v2QNSMA8LNdUQeUKndSd6SSRCb+erNijwP
        PBdbdXrZ9JQS9TuZ8xmaIppix
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id j5-20020a170902690500b001429e19702emr34025118plk.34.1636963433047;
        Mon, 15 Nov 2021 00:03:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvuw9vrvNG2L7cS/AHgrgJmEaz6hA9Bl56RBh77ZosYjxsN756UigcYazaskbxJjNEt9UMhA==
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id j5-20020a170902690500b001429e19702emr34025099plk.34.1636963432806;
        Mon, 15 Nov 2021 00:03:52 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id i15sm14335793pfu.151.2021.11.15.00.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:03:52 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 21/23] mm/uffd: Enable write protection for shmem & hugetlbfs
Date:   Mon, 15 Nov 2021 16:03:38 +0800
Message-Id: <20211115080338.75264-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
index fa24c72a849e..b74cad206d0a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1253,24 +1253,6 @@ static __always_inline int validate_range(struct mm_struct *mm,
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
@@ -1949,7 +1931,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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
index 05cec02140cb..ef9b70f6447e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -140,6 +141,17 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
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
index 037f82719e64..6d8cd9f6b8a1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -716,15 +716,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
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
2.32.0

