Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D632C34543E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhCWAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231694AbhCWAvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMz4zykUsRqLQsQnpjugwWFonlMak/AsLri3yN76IU8=;
        b=dD12kLNO+igxA10TNEQmG8OMgT/sYt51o5Oi+enqVRBmZuOyixn07L7hoEcj8ptTiQKvxB
        tZCiZTcjqaKZrvh9vecZ1HPN0EkLZ/Y6vyc9NB5YO+oIL9vNG38PNXA6zbimpMCsA+MkDY
        qKobfZyKkI96E+zokmIsR44iIzSPqIs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-21BHm0cgMY-6qBJ-_Ir9tg-1; Mon, 22 Mar 2021 20:51:00 -0400
X-MC-Unique: 21BHm0cgMY-6qBJ-_Ir9tg-1
Received: by mail-qv1-f69.google.com with SMTP id k92so542362qva.20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMz4zykUsRqLQsQnpjugwWFonlMak/AsLri3yN76IU8=;
        b=n34tD2KIVtBUZOQq+5daefoGW4eXKo1+u+aoSo5sstjc7p3/SA6lpiqx3exJgzEJI1
         vLIW07InfzDcEoJu9di0CoAZY738TfXWxsUotob0SKl14gb3nPHRfepqW0N5RZ0yjUXi
         cPDeH+SWLUV7gcuXINKq2JakoZiWK0enxsOtWvsoNW+8/C8veBVenVI+Ede7fhn/ceM9
         mK62WFeTLP9Y588tVIenyun5grkl0d1GMls/dNEMXZE7064XU9KetYs3bqdYJ7SH2Xi3
         mtUjjoUbbQ1nBmwZSCXOP9JmUgmbq2C8wJzi6QG5/VcZNDsk72Il5AbQGqynNMy8XEpb
         i7OA==
X-Gm-Message-State: AOAM532hHHbNq2gd6W7CJr2FFlSs6iJyRgyMMfOXb3QuiJNGfam226Rm
        ZRwjE5A8YWubX/2xd9lPTrEGHQfXhwR/YncEJKzxQ/q8OfuAzSsnkpWi2r8e5QxohqkUYu32GYK
        UQu2PX3hA7tDcwSOtMJ/QKTVj
X-Received: by 2002:a37:6848:: with SMTP id d69mr2970010qkc.159.1616460659702;
        Mon, 22 Mar 2021 17:50:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3wt9SmWeNMBwi1yvJ4wgntypuHoNSgIQv+r28OKmzDrhpIEGPoRQZMlpRSyZw5Ld0JfAMuA==
X-Received: by 2002:a37:6848:: with SMTP id d69mr2969993qkc.159.1616460659449;
        Mon, 22 Mar 2021 17:50:59 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id c27sm12337483qko.71.2021.03.22.17.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:50:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 22/23] mm/userfaultfd: Enable write protection for shmem & hugetlbfs
Date:   Mon, 22 Mar 2021 20:50:57 -0400
Message-Id: <20210323005057.36027-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
 fs/userfaultfd.c                 | 18 ------------------
 include/linux/userfaultfd_k.h    | 14 ++++++++++++++
 include/uapi/linux/userfaultfd.h |  7 +++++--
 mm/userfaultfd.c                 | 10 +++-------
 4 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f6fa34f58c37..b4f30fe84aa3 100644
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
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fefebe6e9656..413323fc81ca 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -132,6 +133,19 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma,
+				     unsigned long vm_flags)
+{
+	if (vm_flags & VM_UFFD_MINOR) {
+		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
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
index 47d9790d863d..000cc4cfc787 100644
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
@@ -198,6 +200,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
+#define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<11)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a2b0dcc80a19..e6c6095878bb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -452,7 +452,6 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 			break;
 		}
 	} else {
-		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 					     src_addr, mode, page, wp_copy);
 	}
@@ -683,15 +682,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
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

