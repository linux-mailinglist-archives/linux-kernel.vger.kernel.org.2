Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D76393720
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhE0U0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhE0UZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngMPi0v8szsDymkLXEE1yzQNi7Qk4LQoecvqvdNIG9I=;
        b=UqHY+JjTRIYDVwA6SbsIPIR+yzmzgShcKFnYc3yQgV7fzZejpykV5zfPIB+aZDIs753v6d
        0G7NE/K2fTuysFzgxBZR+/BhkxfCEKpO0q2amoe4yhh3wG/vW538qJCQvWFpTWr/2kxXu5
        HxUhMZEljfb+8CHr9vdmj42FfW9IEJ0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-UrkgGFvkN-Cdx7KgZsHkOA-1; Thu, 27 May 2021 16:23:49 -0400
X-MC-Unique: UrkgGFvkN-Cdx7KgZsHkOA-1
Received: by mail-qk1-f197.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so1357625qkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngMPi0v8szsDymkLXEE1yzQNi7Qk4LQoecvqvdNIG9I=;
        b=sEQfBRRDsU0gqJxR5S66kCZ05eJ3nSZW/R62LuCfqeozHKkLITSxWhbn05iA3d+Tvk
         tp39+MfHmwt3Dk+ou8GSCmMYulrhrLeBJ7NeNjQWOs4d56fKB7TDkQdssbugic8hu/LP
         snxR0LofLd9mX/GGp7BdSpbJ9qPQOMfZzEMwtkidKlHgJ+HeZGKR1IJUSE7gohVa2V2t
         +sL62JK72NWXSLsP3Q7et5KentZbOuxlascJ44w4qDq7oTgT+ELjJFGqynDWxq5qu7hY
         ujZhmtDKwQvxqwgKsilUxq/DYnOY0EMdxpS0kcqkn73/ziRGW8bvDkoDsUlEHbFJ5rhZ
         Qo7A==
X-Gm-Message-State: AOAM530Gv9eV/dOVPzyfi/yE0ZJFxSEFdj+45BvorVd/R6OU1HXQxQFG
        EuiLYXQk008zKcATKDBDY2YZbZzyVNZF5QMJhmSKEcFenN1Vg/KacHcICLIJWBPwHAtFl9rAuq7
        0Q7GRdvPZ5fhCzYOCk/Gf2E55ZnNhm5UZYZLlLSbR1ojVsZw+MF3ZG9m5q1JgrhnYUufLdU7J2A
        ==
X-Received: by 2002:ad4:4e91:: with SMTP id dy17mr330680qvb.55.1622147028642;
        Thu, 27 May 2021 13:23:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxERXmrLVdBH2ktYPjs4f1N04FyCnVjMWl8pzE8ly931umyxfVaq9veVsqvYipuRhEbaHuyA==
X-Received: by 2002:ad4:4e91:: with SMTP id dy17mr330647qvb.55.1622147028362;
        Thu, 27 May 2021 13:23:48 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q7sm2094142qki.17.2021.05.27.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 26/27] mm/userfaultfd: Enable write protection for shmem & hugetlbfs
Date:   Thu, 27 May 2021 16:23:45 -0400
Message-Id: <20210527202345.32356-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
 fs/userfaultfd.c                 | 18 ------------------
 include/linux/userfaultfd_k.h    | 12 ++++++++++++
 include/uapi/linux/userfaultfd.h | 10 ++++++++--
 mm/userfaultfd.c                 |  9 +++------
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6ef7b56760bf..140bab07935e 100644
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
index ca3f794d07e9..489fb375e66c 100644
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
index 159a74e9564f..09b7ec69c97d 100644
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
index af79f3d3a001..7ff9176149e0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -772,15 +772,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
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

