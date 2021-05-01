Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A28370797
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEAOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 10:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhEAOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 10:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619880079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWU4dToOlrdXt6xX3Zm8/xsHlBzDG+7XGBVqeUZV/DE=;
        b=JhW98/GjIkPlhztG92I09nIBctERKgYofI8QO7pYeNHsfNAIWv+cCwlUG2+yh6QDagNY32
        EUEKmZHjgsp6LjTZuyNcx+9+4kyDT4WXmwiLtJf338GN/R/Atq7xyNFogd7L+ZUjhw88gz
        Xm5p0WXAVD9tMG/ogZIf47zptK8Bi28=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-8k3xKebGNpS7dZUOhiyNKQ-1; Sat, 01 May 2021 10:41:17 -0400
X-MC-Unique: 8k3xKebGNpS7dZUOhiyNKQ-1
Received: by mail-io1-f70.google.com with SMTP id c24-20020a5d9a980000b029040db7d17e09so573232iom.22
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 07:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWU4dToOlrdXt6xX3Zm8/xsHlBzDG+7XGBVqeUZV/DE=;
        b=OAuLWa6r+NxjtPE7jixrkNATG2Nk4TpUTlkx3mbG62Ho1A56m0fDavr4R7IJkuPBKa
         157LWbvDTbaoMG8wcbn9mhLLUvJBxWSXxtmilgNND7rnfQ4MxMDRWCx1Ils021qVXFfZ
         8Lo9mKdzt0vxtrM3plN3VbRlQt+vB2aDC4UeOscgd9qZoubSzjuL69IBOK3fgfyxzwSK
         EelEgzUhDPDvVUI/VFU1YtwcNc8rqAcMgH7M5yCmK++Dgp048+2taSdidJj9F8z8g0rF
         WV88A7wmjVqrU9V3COa5XtDm7SIQdZqLB5Vtt3FjL5pxSygBS2QhiPyUBejtwzQXAmee
         5FFg==
X-Gm-Message-State: AOAM532um1+/D+/9qhXiTdeLoRJsEKaF0Aj4xKLQTZTz1cBjM2Nh6mDC
        P8E6+cL6mT3a9V8IRwRWWVnRJp+sDNmHo7l/6qgBe1iIlW+q8MEWzAIGNKN7+Qvp01wdK9g/PjR
        /Pul/GYgHfaglr55ChMaYUoEt
X-Received: by 2002:a5e:8a47:: with SMTP id o7mr7511169iom.57.1619880077031;
        Sat, 01 May 2021 07:41:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycsNtoj33R2zB2+M6cM7bHXmSU+NsARgEVbboh0t47qVEaUvyu/N0/3sYR9xMpmJWJ5hCPDQ==
X-Received: by 2002:a5e:8a47:: with SMTP id o7mr7511157iom.57.1619880076788;
        Sat, 01 May 2021 07:41:16 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id k2sm2649343ilq.71.2021.05.01.07.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 07:41:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 1/2] mm/hugetlb: Fix F_SEAL_FUTURE_WRITE
Date:   Sat,  1 May 2021 10:41:09 -0400
Message-Id: <20210501144110.8784-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501144110.8784-1-peterx@redhat.com>
References: <20210501144110.8784-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F_SEAL_FUTURE_WRITE is missing for hugetlb starting from the first day.
There is a test program for that and it fails constantly.

$ ./memfd_test hugetlbfs
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-WRITE
memfd-hugetlb: SEAL-FUTURE-WRITE
mmap() didn't fail as expected
Aborted (core dumped)

I think it's probably because no one is really running the hugetlbfs test.

Fix it by checking FUTURE_WRITE also in hugetlbfs_file_mmap() as what we do in
shmem_mmap().  Generalize a helper for that.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c |  5 +++++
 include/linux/mm.h   | 32 ++++++++++++++++++++++++++++++++
 mm/shmem.c           | 22 ++++------------------
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a2a42335e8fd2..39922c0f2fc8c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -131,10 +131,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
 
+	ret = seal_check_future_write(info->seals, vma);
+	if (ret)
+		return ret;
+
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
 	 * already been checked by prepare_hugepage_range.  If you add
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 84fb1697b20ff..c3fd7d504a60e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3200,5 +3200,37 @@ extern int sysctl_nr_trim_pages;
 
 void mem_dump_obj(void *object);
 
+/**
+ * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * @seals: the seals to check
+ * @vma: the vma to operate on
+ *
+ * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
+ * the vma flags.  Return 0 if check pass, or <0 for errors.
+ */
+static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+{
+	if (seals & F_SEAL_FUTURE_WRITE) {
+		/*
+		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+		 * "future write" seal active.
+		 */
+		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+			return -EPERM;
+
+		/*
+		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * MAP_SHARED and read-only, take care to not allow mprotect to
+		 * revert protections on such mappings. Do this only for shared
+		 * mappings. For private mappings, don't need to mask
+		 * VM_MAYWRITE as we still want them to be COW-writable.
+		 */
+		if (vma->vm_flags & VM_SHARED)
+			vma->vm_flags &= ~(VM_MAYWRITE);
+	}
+
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad233..e86a230735b60 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2258,25 +2258,11 @@ int shmem_lock(struct file *file, int lock, struct user_struct *user)
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
+	int ret;
 
-	if (info->seals & F_SEAL_FUTURE_WRITE) {
-		/*
-		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
-		 */
-		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-			return -EPERM;
-
-		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
-		 * MAP_SHARED and read-only, take care to not allow mprotect to
-		 * revert protections on such mappings. Do this only for shared
-		 * mappings. For private mappings, don't need to mask
-		 * VM_MAYWRITE as we still want them to be COW-writable.
-		 */
-		if (vma->vm_flags & VM_SHARED)
-			vma->vm_flags &= ~(VM_MAYWRITE);
-	}
+	ret = seal_check_future_write(info->seals, vma);
+	if (ret)
+		return ret;
 
 	/* arm64 - allow memory tagging on RAM-based files */
 	vma->vm_flags |= VM_MTE_ALLOWED;
-- 
2.31.1

